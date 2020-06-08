Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F41C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 09:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD2CC20760
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 09:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgFHJb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:31:26 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51971 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgFHJbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 05:31:25 -0400
X-Originating-IP: 157.36.94.170
Received: from localhost (unknown [157.36.94.170])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 234431C0006;
        Mon,  8 Jun 2020 09:31:21 +0000 (UTC)
Date:   Mon, 8 Jun 2020 15:01:18 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Mikhail Terekhov via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Mikhail Terekhov <termim@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] git-gui: allow opening work trees from the startup
 dialog
Message-ID: <20200608093118.ppwpydlkd5bmsjh5@yadavpratyush.com>
References: <pull.644.git.1590507201474.gitgitgadget@gmail.com>
 <pull.644.v2.git.1591418019023.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.644.v2.git.1591418019023.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+Cc Eric.

On 06/06/20 04:33AM, Mikhail Terekhov via GitGitGadget wrote:
> From: Mikhail Terekhov <termim@gmail.com>
> 
> In proc _is_git check that supplied path is a valid work tree path.
> This allows the choose_repository::pick dialog to accept path to a
> work tree directory.
> 
> Signed-off-by: Mikhail Terekhov <termim@gmail.com>
> ---
>  lib/choose_repository.tcl | 29 +++++------------------------
>  1 file changed, 5 insertions(+), 24 deletions(-)
> 
> diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
> index e54f3e66d8f..07f29b0b13b 100644
> --- a/lib/choose_repository.tcl
> +++ b/lib/choose_repository.tcl
> @@ -357,31 +357,12 @@ proc _is_git {path {outdir_var ""}} {
>  	if {$outdir_var ne ""} {
>  		upvar 1 $outdir_var outdir
>  	}
> -	if {[file isfile $path]} {
> -		set fp [open $path r]
> -		gets $fp line
> -		close $fp
> -		if {[regexp "^gitdir: (.+)$" $line line link_target]} {
> -			set path [file join [file dirname $path] $link_target]
> -			set path [file normalize $path]
> -		}
> -	}
> -
> -	if {[file exists [file join $path HEAD]]
> -	 && [file exists [file join $path objects]]
> -	 && [file exists [file join $path config]]} {
> -		set outdir $path
> -		return 1
> -	}
> -	if {[is_Cygwin]} {
> -		if {[file exists [file join $path HEAD]]
> -		 && [file exists [file join $path objects.lnk]]
> -		 && [file exists [file join $path config.lnk]]} {
> -			set outdir $path
> -			return 1
> -		}
> +	if {[catch { 
> +		set outdir [git rev-parse --resolve-git-dir $path] 
> +		} ]} {
> +			return 0

I fixed trailing whitespace in a couple lines and a small style nitpick. You 
can check them here [0]. Will merge. Thanks both.

[0] https://github.com/prati0100/git-gui/commit/79089e52643ce1ba7d8494f32b2fb1891c926079

-- 
Regards,
Pratyush Yadav
