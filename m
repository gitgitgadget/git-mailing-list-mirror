Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8974CC5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 19:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADDA22263
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 19:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKNTOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 14:14:55 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:52920 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgKNTOz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 14:14:55 -0500
Received: from client3368.fritz.box (i5C7464CC.versanet.de [92.116.100.204])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 2DD1A3C4463;
        Sat, 14 Nov 2020 20:14:53 +0100 (CET)
Subject: Re: [PATCH v2 1/1] git-gui: Auto-rescan on activate
From:   Stefan Haller <stefan@haller-berlin.de>
To:     me@yadavpratyush.com
Cc:     git@vger.kernel.org, mlevedahl@gmail.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com
References: <fe2f24e8-52f2-81fe-0ebd-ecd90b1acfb4@haller-berlin.de>
 <20201103161631.89971-1-stefan@haller-berlin.de>
 <20201103161631.89971-2-stefan@haller-berlin.de>
Message-ID: <14be00ae-c2b6-87eb-2f4b-964a6df7b230@haller-berlin.de>
Date:   Sat, 14 Nov 2020 20:14:52 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201103161631.89971-2-stefan@haller-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.11.20 17:16, Stefan Haller wrote:
> Do an automatic rescan whenever the git-gui window receives focus. Most other
> GUI tools do this, and it's very convenient; no more pressing F5 manually.
> 
> People who don't like this behavior can turn it off in the Options dialog.

Ping - any thoughts? I have been running with this patch for a few weeks
now, and I already don't want to miss it any more.

Cc:-ing a few people who were involved in the discussion on Pratyush's
similar patch last summer. [0]


[0] <https://lore.kernel.org/git/20190728151726.9188-1-
     me@yadavpratyush.com/>


> 
> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
> ---
>  git-gui.sh     | 5 +++++
>  lib/option.tcl | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 867b8ce..14735a3 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -906,6 +906,7 @@ set font_descs {
>  }
>  set default_config(gui.stageuntracked) ask
>  set default_config(gui.displayuntracked) true
> +set default_config(gui.autorescan) true
> 
>  ######################################################################
>  ##
> @@ -4007,6 +4008,10 @@ bind .   <Alt-Key-2> {focus_widget $::ui_index}
>  bind .   <Alt-Key-3> {focus $::ui_diff}
>  bind .   <Alt-Key-4> {focus $::ui_comm}
> 
> +if {[is_config_true gui.autorescan]} {
> +	bind .   <FocusIn>  { if {"%W" eq "."} do_rescan }
> +}
> +
>  set file_lists_last_clicked($ui_index) {}
>  set file_lists_last_clicked($ui_workdir) {}
> 
> diff --git a/lib/option.tcl b/lib/option.tcl
> index e43971b..9e83db7 100644
> --- a/lib/option.tcl
> +++ b/lib/option.tcl
> @@ -145,6 +145,7 @@ proc do_options {} {
>  		{b merge.diffstat {mc "Show Diffstat After Merge"}}
>  		{t merge.tool {mc "Use Merge Tool"}}
> 
> +		{b gui.autorescan  {mc "Auto-Rescan On Activate"}}
>  		{b gui.trustmtime  {mc "Trust File Modification Timestamps"}}
>  		{b gui.pruneduringfetch {mc "Prune Tracking Branches During Fetch"}}
>  		{b gui.matchtrackingbranch {mc "Match Tracking Branches"}}
> --
> 2.29.2
> 
