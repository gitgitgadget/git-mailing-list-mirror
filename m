Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5B1C433EF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 06:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF9C60ED7
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 06:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbhKMG5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 01:57:11 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53481 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhKMG5C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 01:57:02 -0500
Received: (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7A4F91C0002;
        Sat, 13 Nov 2021 06:54:08 +0000 (UTC)
Date:   Sat, 13 Nov 2021 12:24:06 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, angavrilov@gmail.com
Subject: Re: [RFC PATCH 2/4] rename all *_sha1 variables and make null_oid
 hash aware
Message-ID: <20211113065406.z2lqhvh24jjaqty6@yadavpratyush.com>
References: <20211011121757.627-1-carenas@gmail.com>
 <20211011121757.627-3-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211011121757.627-3-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/21 05:17AM, Carlo Marcelo Arenas Belón wrote:
> Before this change, creating a branch in an SHA-256 repository would
> fail because the null_sha1 used was of the wrong size.
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  git-gui.sh          | 26 +++++++++++++++-----------
>  lib/blame.tcl       | 10 +++++-----
>  lib/checkout_op.tcl |  4 ++--
>  3 files changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index a69b0fe..c0dc8ce 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1820,10 +1820,14 @@ proc short_path {path} {
>  }
>  
>  set next_icon_id 0
> -set null_sha1 [string repeat 0 40]
> +if { [get_config extensions.objectformat] eq "sha256" } {

From the docs I see that this feature is experimental as of now and 
might change in the future. Can we expect this config option to stay 
stable over time? If not I think this might be too early to introduce it 
into git-gui.

Anyway, nitpick: don't add spaces after opening brace and before closing 
brace.

> +	set null_oid [string repeat 0 64]
> +} else {
> +	set null_oid [string repeat 0 40]
> +}
>  
>  proc merge_state {path new_state {head_info {}} {index_info {}}} {
> -	global file_states next_icon_id null_sha1
> +	global file_states next_icon_id null_oid
>  
>  	set s0 [string index $new_state 0]
>  	set s1 [string index $new_state 1]

Rest of the patch looks good to me. Thanks.

-- 
Regards,
Pratyush Yadav
