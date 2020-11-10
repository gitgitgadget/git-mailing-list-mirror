Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAAAC56202
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 11:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A9B20795
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 11:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbgKJLVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 06:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731945AbgKJLVT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 06:21:19 -0500
Received: from black.spass-am-geraet.de (black.spass-am-geraet.de [IPv6:2a01:4f8:210:2018::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F7CC0613CF
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 03:21:18 -0800 (PST)
Received: by black.spass-am-geraet.de (Postfix, from userid 602)
        id 54B9D2390C; Tue, 10 Nov 2020 12:21:14 +0100 (CET)
Date:   Tue, 10 Nov 2020 12:21:14 +0100
From:   Daniel =?iso-8859-1?Q?H=F6pfl?= <daniel@hoepfl.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Suppressing filter-branch warning
Message-ID: <20201110112114.GA28702@black.spass-am-geraet.de>
References: <20201106090443.GA20407@black.spass-am-geraet.de>
 <xmqqo8kafjgt.fsf@gitster.c.googlers.com>
 <CABPp-BGv9goqrYBwgSkmhPYOmwcXeRCzGT2sQbL+xD2xWeT5gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGv9goqrYBwgSkmhPYOmwcXeRCzGT2sQbL+xD2xWeT5gQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hallo Elijah,

On Fri, Nov 06, 2020 at 12:12:55PM -0800, Elijah Newren wrote:
>On Fri, Nov 6, 2020 at 10:06 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Daniel Höpfl <daniel@hoepfl.de> writes:
>>
>> > Hello there,
>> >
>> > What did you do before the bug happened? (Steps to reproduce your issue)
>> > git filter-branch -f --env-filter '' --tag-name-filter cat -- HEAD
>> >
>> > What did you expect to happen? (Expected behavior)
>> > See below (difference).
>> >
>> > What happened instead? (Actual behavior)
>> > When using git filter-branch, the following message is shown:
>> >
>> > ----------8<-----------------------------------------------------
>> > WARNING: git-filter-branch has a glut of gotchas generating mangled history
>> >         rewrites.  Hit Ctrl-C before proceeding to abort, then use an
>> >         alternative filtering tool such as 'git filter-repo'
>> >         (https://github.com/newren/git-filter-repo/) instead.  See the
>> >         filter-branch manual page for more details; to squelch this warning,
>> >         set FILTER_BRANCH_SQUELCH_WARNING=1.
>> > ----------8<-----------------------------------------------------
>> >
>> > You can suppress this by setting the environment variable shown.
>> >
>> > What's different between what you expected and what actually happened?
>> >
>> > Normally, when git introduces this kind of change, there is a
>> > git config variable that one can set to suppress it.
>> > That way one has fine grade control when to suppress it (one repo only...globally).
>>
>> I think this comes from 9df53c5d (Recommend git-filter-repo instead
>> of git-filter-branch, 2019-09-04).
>>
>> FWIW, I personally do not think an environment is a worse choice
>> over configuration variable in this particular case.  The large
>> scale rewriting of the entire history in the repository by its
>> nature is an one-off operation that ought to happen only rarely,
>> so a one-shot
>>
>>         $ FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch ...
>>
>> that reminds the user every time would be more appropriate than a
>> configuration variable that has a more permanent squelching effect.
>>
>> If it were a new command line option may have been even better, as
>> an environment variable can be defined in .*rc and forgotten, but a
>> command line option needs to be typed every time and would serve as
>> a better reminder (yes, I know it can also be aliased away, so it
>> may not make much practical difference either way).
>>
>> But I'll let the author of the feature to comment.
>>
>> Thanks.
>
>I agree with Junio that filter-branch's one-off nature means that not
>providing a configuration variable seems reasonable in this case.  If
>someone else were to go to the effort of implementing some
>configuration option here, I wouldn't be that strongly against it,
>though I'd rather just let filter-branch lie dormant and stable.
>
>A new command line option might have been better, but it didn't occur
>to me at the time this change was made and I hesitate to needlessly
>force people to adapt again.

I implemented the change and sent a pull request on github (#912) but failed at GitGitGadget. Anyways, here’s the patch:

---
 git-filter-branch.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index fea7964617..fb55afcc86 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -83,15 +83,21 @@ set_ident () {
        finish_ident COMMITTER
 }

-if test -z "$FILTER_BRANCH_SQUELCH_WARNING$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS"
+if test -z "$FILTER_BRANCH_SQUELCH_WARNING$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" && \
+   test "$(git config --bool filter-branch.squelchWarning)" != true
 then
        cat <<EOF
 WARNING: git-filter-branch has a glut of gotchas generating mangled history
-        rewrites.  Hit Ctrl-C before proceeding to abort, then use an
+        rewrites. Hit Ctrl-C before proceeding to abort, then use an
         alternative filtering tool such as 'git filter-repo'
-        (https://github.com/newren/git-filter-repo/) instead.  See the
+        (https://github.com/newren/git-filter-repo/) instead. See the
         filter-branch manual page for more details; to squelch this warning,
-        set FILTER_BRANCH_SQUELCH_WARNING=1.
+         set FILTER_BRANCH_SQUELCH_WARNING=1 or run the following command:
+
+           git config filter-branch.squelchWarning true
+
+         You can replace "git config" with "git config --global" to disable
+         the warning for all repositories.
 EOF
        sleep 10
        printf "Proceeding with filter-branch...\n\n"
--
2.29.0


