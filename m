Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD67C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0197C2151B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404269AbgLAUHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 15:07:19 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34799 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLAUHT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 15:07:19 -0500
X-Originating-IP: 103.82.80.86
Received: from localhost (unknown [103.82.80.86])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0A422E0009;
        Tue,  1 Dec 2020 20:06:36 +0000 (UTC)
Date:   Wed, 2 Dec 2020 01:36:34 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] git-gui: fix colored label backgrounds when using
 themed widgets
Message-ID: <20201201200634.bazwncj7yyp7vksn@yadavpratyush.com>
References: <20201122194537.41870-1-stefan@haller-berlin.de>
 <20201122194537.41870-2-stefan@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122194537.41870-2-stefan@haller-berlin.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

Thanks for the patch.

On 22/11/20 08:45PM, Stefan Haller wrote:
> The aqua theme on Mac doesn't support changing the background color for labels
> and frames [1]. Since the red, green, and yellow backgrounds of the labels for
> unstaged and staged files and the diff pane are so important design elements of
> git gui's main window, it's not acceptable for them to have grey backgrounds on
> Mac.

I unfortunately don't have access to a Mac machine to I can't test this 
patch.

Were the colors fine before c02efc1 (git-gui: improve dark mode support, 
2020-09-26)? From what I understand that patch should not affect the 
colors of the "Staged Changes" or the "Unstaged Changes" parts.

If the colors were fine earlier then we need to figure out why colors 
from the theme are being used even when we hard-code green or red when 
creating those labels.

Can you give it a try on a commit before c02efc1 and see what happens?
 
> To work around this, simply use non-themed widgets for all labels on Mac. This
> is not a big problem because labels don't look extremely different between the
> themed and non-themed versions. There are subtle differences, but they are not
> as bad as having the wrong background color.

Agreed. Though I certainly wish we didn't have to do this.
 
> [1] https://stackoverflow.com/a/6723911
> 
> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
> ---
>  lib/themed.tcl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/themed.tcl b/lib/themed.tcl
> index 83e3ac7..02aae90 100644
> --- a/lib/themed.tcl
> +++ b/lib/themed.tcl
> @@ -174,7 +174,7 @@ proc InitEntryFrame {} {
> 
>  proc gold_frame {w args} {
>  	global use_ttk
> -	if {$use_ttk} {
> +	if {$use_ttk && ![is_MacOSX]} {
>  		eval [linsert $args 0 ttk::frame $w -style Gold.TFrame]
>  	} else {
>  		eval [linsert $args 0 frame $w -background gold]
> @@ -183,7 +183,7 @@ proc gold_frame {w args} {
> 
>  proc tlabel {w args} {
>  	global use_ttk
> -	if {$use_ttk} {
> +	if {$use_ttk && ![is_MacOSX]} {
>  		set cmd [list ttk::label $w -style Color.TLabel]
>  		foreach {k v} $args {
>  			switch -glob -- $k {

-- 
Regards,
Pratyush Yadav
