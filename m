Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B63C47094
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE766124C
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhFHB2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 21:28:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50323 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFHB2A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 21:28:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 738CBC3415;
        Mon,  7 Jun 2021 21:26:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=61RSDcfLs4WcsEnnFZUauUF3E7k/emumFquOIb
        Xv1MI=; b=eO62Wm35JYd8mPFuV3lWrM5QgcCkr41CaYME93g6XP74W/Qu3MzjYB
        pJ/1Vmjz6y179y82aKIGUMygcydx77kE3wLiVUl+MUwDXt/qMwRPL7yMRSa/ZWRq
        wR79qsqTu3mfn3rl1PlzbxCn+thEcknA7JBspDL08IqextBqAE5ww=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AAF8C3413;
        Mon,  7 Jun 2021 21:26:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE4D3C3412;
        Mon,  7 Jun 2021 21:26:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Michael Schindler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Michael Schindler <michael@compressconsult.com>
Subject: Re: [PATCH] mergetools/kdiff3: make kdiff3 work on windows too
References: <pull.952.git.git.1623097114277.gitgitgadget@gmail.com>
Date:   Tue, 08 Jun 2021 10:26:05 +0900
In-Reply-To: <pull.952.git.git.1623097114277.gitgitgadget@gmail.com> (Michael
        Schindler via GitGitGadget's message of "Mon, 07 Jun 2021 20:18:33
        +0000")
Message-ID: <xmqqbl8hrvte.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F774930-C7F8-11EB-8079-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Michael Schindler via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Michael Schindler <michael@compressconsult.com>

Thanks.  The proposed log message is overly long and looks unusual
to have "Bug cause:" and "Fix:" markers in it.  It would be nice if
it fit well when found in say "git log --no-merges" output with
other commits.

> Currently the native kdiff3 mergetool is not found by git mergetool on windows.
> The message "The merge tool kdiff3 is not available as 'kdiff3'" is displayed.

Very well explained.  You can lose "Currently", though.  Also wrap
the line at around 70 columns and it would be perfect.

> But it is important especially for GUI to use this native version on windows.
> Kdiff3 for various systems can be downloaded from https://download.kde.org/stable/kdiff3/

I am not sure how these two lines help.  We've established with the
first two lines that the native kdiff3 is not found, even though
kdiff3 is available on windows, so it is clear that we'd want to
make it available.  If I were writing this, I'd drop these two lines.

So, after the first two lines to describe what is wrong, we can just
say something like

    Just like we translate the name of the binary and look for the
    program on search path for winmerge, do the same for kdiff3.

and all the remainder, up to but not including your sign-off, can be
removed, I think.

> Bug cause:
> On Windows the executable name has to be translated (kdiff3.exe instead of kdiff) and the windows path has to be searched - similar to winmerge.
>
> Fix:
> This change is using mergetool_find_win32_cmd from the library in the translate_merge_tool_path().
> This is done the same way as in winmerge.
>
> However this translation must not be made on linux/unix, so a "type kdiff3" test is made on kdiff3 and only if not found the windows search is tried.
>
> Signed-off-by: Michael Schindler michael@compressconsult.com
> ---
>     mergetools/kdiff3: make kdiff3 work on windows too
>     
>     mergetools/kdiff3: make kdiff3 work on windows too
>     
>     Currently the native kdiff3 mergetool is not found by git mergetool on
>     windows. The message "The merge tool kdiff3 is not available as
>     'kdiff3'" is displayed.
>     
>     But it is important especially for GUI to use this native version on
>     windows. Kdiff3 for various systems can be downloaded from
>     https://download.kde.org/stable/kdiff3/
>     
>     Bug cause: On Windows the executable name has to be translated
>     (kdiff3.exe instead of kdiff) and the windows path has to be searched -
>     similar to winmerge.
>     
>     Fix: This change is using mergetool_find_win32_cmd from the library in
>     the translate_merge_tool_path(). This is done the same way as in
>     winmerge.
>     
>     However this translation must not be made on linux/unix, so a "type
>     kdiff3" test is made on kdiff3 and only if not found the windows search
>     is tried.
>     
>     Signed-off-by: Michael Schindler michael@compressconsult.com

This is redundant---it says the same thing as your proposed commit
log message.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-952%2Fmichaelcompressconsult%2Fkdiff3_win-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-952/michaelcompressconsult/kdiff3_win-v1
> Pull-Request: https://github.com/git/git/pull/952
>
>  mergetools/kdiff3 | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mergetools/kdiff3 b/mergetools/kdiff3
> index 0264ed5b20b2..520cb914a18b 100644
> --- a/mergetools/kdiff3
> +++ b/mergetools/kdiff3
> @@ -25,3 +25,12 @@ merge_cmd () {
>  exit_code_trustable () {
>  	true
>  }
> +
> +translate_merge_tool_path() {
> +	if type kdiff3 >/dev/null 2>/dev/null
> +	then
> +		echo kdiff3
> +	else
> +		mergetool_find_win32_cmd "kdiff3.exe" "Kdiff3"
> +	fi
> +}

The change looks good.  Thanks.
