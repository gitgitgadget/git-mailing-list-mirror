Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8BC4207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 10:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1429031AbdDYKel (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 06:34:41 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:58473 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1171036AbdDYKej (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 06:34:39 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 2xnpdf285gKst2xnpdYN5L; Tue, 25 Apr 2017 11:34:37 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=4L8kUQNiov5EdTsJoe8A:9 a=wPNLvfGTeEIA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <D1F52B690614472486B661D6D563DA85@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Liam Beguin" <liambeguin@gmail.com>, <git@vger.kernel.org>
Cc:     <Jhannes.Schindelin@gmx.de>, <peff@peff.net>,
        "Liam Beguin" <liambeguin@gmail.com>
References: <20170424032347.10878-1-liambeguin@gmail.com> <20170425043742.15529-1-liambeguin@gmail.com>
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
Date:   Tue, 25 Apr 2017 11:34:38 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfOodNyWk6hwArtsWtufhCdo5x1zuXxuwGGVOokrih9q6Iw0xiddOJUmpGI7ykjrvn8NvtHiL4amEsc4s42xacpJL2fhbFP2YjWCK7YZkrEd2woMWEqAQ
 IUPf+J0KEQlbVIpPbwj9lcigdbPM/uiUtahTK8wAPNokUECk3VRrQHlWm06sZ9yt6lCgm34XkAV+A1m0Otj9d/3bUYjtmg8/OvGIZoyTxaYFMEQ5MLfaovYA
 +RKZUM6pCI3my8s5JG5LhIsVVz7/ODaedicIQ+REZiKL1jx6M9cGxLbgEoqpFKvJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Liam Beguin" <liambeguin@gmail.com>
> Add the 'rebase.abbrevCmd' boolean config option to allow `git rebase -i`
> to abbreviate the command-names in the instruction list.
>
> This means that `git rebase -i` would print:
>    p deadbee The oneline of this commit
>    ...
>
> instead of:
>    pick deadbee The oneline of this commit
>    ...
>
> Using a single character command-name allows the lines to remain
> aligned, making the whole set more readable.
>
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> ---
> Changes since v1:
> - Improve Documentation and commit message
>
> Documentation/config.txt     | 19 +++++++++++++++++++
> Documentation/git-rebase.txt | 19 +++++++++++++++++++
> git-rebase--interactive.sh   |  8 ++++++--
> 3 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d5155..8b1877f2df91 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2614,6 +2614,25 @@ rebase.instructionFormat::
>  the instruction list during an interactive rebase.  The format will 
> automatically
>  have the long commit hash prepended to the format.
>
> +rebase.abbrevCmd::
> + If set to true, `git rebase -i` will abbreviate the command-names in the
> + instruction list. This means that instead of looking like this,
> +
> +-------------------------------------------
> + pick deadbee The oneline of this commit
> + pick fa1afe1 The oneline of the next commit
> + ...
> +-------------------------------------------
> +
> + the list would use the short version of the command resulting in
> + something like this.

Perhaps use an example which does have rebase commands of different lengths, 
such as 'pick', 'squash', 'reword' to more clearly show the intent of 
alignment and subsequent ease of editing?

--
Philip


> +
> +-------------------------------------------
> + p deadbee The oneline of this commit
> + p fa1afe1 The oneline of the next commit
> + ...
> +-------------------------------------------
> +
> receive.advertiseAtomic::
>  By default, git-receive-pack will advertise the atomic push
>  capability to its clients. If you don't want to advertise this
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 67d48e688315..7d97c0483241 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -222,6 +222,25 @@ rebase.missingCommitsCheck::
> rebase.instructionFormat::
>  Custom commit list format to use during an `--interactive` rebase.
>
> +rebase.abbrevCmd::
> + If set to true, `git rebase -i` will abbreviate the command-names in the
> + instruction list. This means that instead of looking like this,
> +
> +-------------------------------------------
> + pick deadbee The oneline of this commit
> + pick fa1afe1 The oneline of the next commit
> + ...
> +-------------------------------------------
> +
> + the list would use the short version of the command resulting in
> + something like this.
> +
> +-------------------------------------------
> + p deadbee The oneline of this commit
> + p fa1afe1 The oneline of the next commit
> + ...
> +-------------------------------------------
> +
> OPTIONS
> -------
> --onto <newbase>::
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 2c9c0165b5ab..9f3e82b79615 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1210,6 +1210,10 @@ else
>  revisions=$onto...$orig_head
>  shortrevisions=$shorthead
> fi
> +
> +rebasecmd=pick
> +test "$(git config --bool --get rebase.abbrevCmd)" = true && rebasecmd=p
> +
> format=$(git config --get rebase.instructionFormat)
> # the 'rev-list .. | sed' requires %m to parse; the instruction requires 
> %H to parse
> git rev-list $merges_option --format="%m%H ${format:-%s}" \
> @@ -1228,7 +1232,7 @@ do
>
>  if test t != "$preserve_merges"
>  then
> - printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
> + printf '%s\n' "${comment_out}${rebasecmd} $sha1 $rest" >>"$todo"
>  else
>  if test -z "$rebase_root"
>  then
> @@ -1246,7 +1250,7 @@ do
>  if test f = "$preserve"
>  then
>  touch "$rewritten"/$sha1
> - printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
> + printf '%s\n' "${comment_out}${rebasecmd} $sha1 $rest" >>"$todo"
>  fi
>  fi
> done
> -- 
> 2.9.3
>
> 

