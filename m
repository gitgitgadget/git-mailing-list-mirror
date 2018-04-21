Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 679A11F404
	for <e@80x24.org>; Sat, 21 Apr 2018 15:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752814AbeDUPmR (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 11:42:17 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:3588 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751476AbeDUPmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 11:42:16 -0400
Received: from [192.168.2.240] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 9ueSfvzPdC0Wb9ueSfAtDw; Sat, 21 Apr 2018 16:42:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1524325334;
        bh=dp9hujggu8wAuEDTsesvNY2UpEIPGLFHWUuv2I2VFwc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RozV9iu1gjqTBkjeZuK5mfZsKqku3aLT3EAziZxpFJdnXpbyOyTkVQnNNLCwheuvO
         C3u/NdnFBZ3S6hfN69VtiAOHzOUYYZIPe2zqifOzX6sgP7igbrXeR43kOj5afdTsrk
         lYSnyeAgh/kYGy/g03dklPKHR9xZ0mAIGkqErAUk=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=Q+T8Hb+a c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=XAvJNIN0JOCOFWxeGV8A:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] rebase --skip: clean up commit message after a
 failedfixup/squash
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1524226637.git.johannes.schindelin@gmx.de>
 <6d9f6ba1e73d2297cef3619a89ce69122438368d.1524226637.git.johannes.schindelin@gmx.de>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <b6512eae-e214-9699-4d69-77117a0daec3@talktalk.net>
Date:   Sat, 21 Apr 2018 16:42:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6d9f6ba1e73d2297cef3619a89ce69122438368d.1524226637.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC3jpQpUn8XK5j9irsavshG0rIMAXCk+hZGqqQBS6iL1f6I92Zdi5m5w6ywgF4/HrX4ZBuYB2LHSMM+4hqQP6vU6Ed3Zsjfv1qAwMtm29hDCWTuj2/Ia
 t5QVXTnKfkQTRFOmx0X4LjFjwtmurhXVhwPElbkAZgsT1T0mgh4XBlCuuzScZ5YpDFVLozWhje7lOF4RacmjtPKqpUG2qF+kf4GNfcrecVQk1C24Blv6zHRb
 +WBxmsi4ncHHI/OfVF7Jd8RAphhZbfHfBYzFDN6Poxrv37GclUDyakgKpeEpWaNr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/04/18 13:18, Johannes Schindelin wrote:
> 
> During a series of fixup/squash commands, the interactive rebase builds
> up a commit message with comments. This will be presented to the user in
> the editor if at least one of those commands was a `squash`.
> 
> However, if the last of these fixup/squash commands fails with merge
> conflicts, and if the user then decides to skip it (or resolve it to a
> clean worktree and then continue the rebase), the current code fails to
> clean up the commit message.

Thanks for taking the time to track this down and fix it.

> 
> This commit fixes that behavior.
> 
> The diff is best viewed with --color-moved.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   sequencer.c                | 36 ++++++++++++++++++++++++++++--------
>   t/t3418-rebase-continue.sh |  2 +-
>   2 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index a9c3bc26f84..f067b7b24c5 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2781,17 +2781,12 @@ static int continue_single_pick(void)
>   
>   static int commit_staged_changes(struct replay_opts *opts)
>   {
> -	unsigned int flags = ALLOW_EMPTY | EDIT_MSG;
> +	unsigned int flags = ALLOW_EMPTY | EDIT_MSG, is_fixup = 0, is_clean;
>   
>   	if (has_unstaged_changes(1))
>   		return error(_("cannot rebase: You have unstaged changes."));
> -	if (!has_uncommitted_changes(0)) {
> -		const char *cherry_pick_head = git_path_cherry_pick_head();
>   
> -		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
> -			return error(_("could not remove CHERRY_PICK_HEAD"));
> -		return 0;
> -	}
> +	is_clean = !has_uncommitted_changes(0);
>   
>   	if (file_exists(rebase_path_amend())) {
>   		struct strbuf rev = STRBUF_INIT;
> @@ -2804,16 +2799,41 @@ static int commit_staged_changes(struct replay_opts *opts)
>   		if (get_oid_hex(rev.buf, &to_amend))
>   			return error(_("invalid contents: '%s'"),
>   				rebase_path_amend());
> -		if (oidcmp(&head, &to_amend))
> +		if (!is_clean && oidcmp(&head, &to_amend))
>   			return error(_("\nYou have uncommitted changes in your "
>   				       "working tree. Please, commit them\n"
>   				       "first and then run 'git rebase "
>   				       "--continue' again."));
> +		if (is_clean && !oidcmp(&head, &to_amend)) {

Looking at pick_commits() it only writes to rebase_path_amend() if there 
are conflicts, not if the command has been rescheduled so this is safe.

> +			strbuf_reset(&rev);
> +			/*
> +			 * Clean tree, but we may need to finalize a
> +			 * fixup/squash chain. A failed fixup/squash leaves the
> +			 * file amend-type in rebase-merge/; It is okay if that
> +			 * file is missing, in which case there is no such
> +			 * chain to finalize.
> +			 */
> +			read_oneliner(&rev, rebase_path_amend_type(), 0);
> +			if (!strcmp("squash", rev.buf))
> +				is_fixup = TODO_SQUASH;
> +			else if (!strcmp("fixup", rev.buf)) {
> +				is_fixup = TODO_FIXUP;
> +				flags = (flags & ~EDIT_MSG) | CLEANUP_MSG;

I was going to say this should probably be (flags & ~(EDIT_MSG | 
VERIFY_MSG)) but for some reason VERIFY_MSG isn't set here - I wonder if 
it should be as I think it's set elsewhere when we edit the message.

> +			}
> +		}
>   
>   		strbuf_release(&rev);
>   		flags |= AMEND_MSG;
>   	}
>   
> +	if (is_clean && !is_fixup) {
> +		const char *cherry_pick_head = git_path_cherry_pick_head();
> +
> +		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
> +			return error(_("could not remove CHERRY_PICK_HEAD"));
> +		return 0;
> +	}
> +
>   	if (run_git_commit(rebase_path_message(), opts, flags))

If a squash command has been skipped, then rebase_path_message() still 
contains the message of the skipped commit. If it passed NULL instead 
then the user would get to edit the previous version of the squash 
message without the skipped commit message in it.

Also I think we only want to re-commit if the skipped squash/fixup was 
preceded by another squash/fixup. If the user skips the first 
squash/fixup in a chain then HEAD has the commit message from the 
original pick so does not need amending. The first patch could perhaps 
avoid writing rebase_path_amend_type() in that case by reading the 
squash message and checking the message count is greater than two.

Best Wishes

Phillip

>   		return error(_("could not commit staged changes."));
>   	unlink(rebase_path_amend());
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index b177baee322..4880bff82ff 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -88,7 +88,7 @@ test_expect_success 'rebase passes merge strategy options correctly' '
>   	git rebase --continue
>   '
>   
> -test_expect_failure '--continue after failed fixup cleans commit message' '
> +test_expect_success '--continue after failed fixup cleans commit message' '
>   	git checkout -b with-conflicting-fixup &&
>   	test_commit wants-fixup &&
>   	test_commit "fixup! wants-fixup" wants-fixup.t 1 wants-fixup-1 &&
> 

