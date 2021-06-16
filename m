Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83315C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 08:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5949C610A1
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 08:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFPJAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 05:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFPJAA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 05:00:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BF2C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 01:57:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so1279620wma.0
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 01:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dp2nJcQxOK5gl+3pbENhdLhhpXT5BUImA//vXpUU9x8=;
        b=rtU7tj6OcdnjKeaCXnoKoz0ENpCCpoahrxNmjcIyDbSMga3AMoBqKUo4OJJ8AeYkCZ
         oWJY/CdOGLkZ1+WFuafDOdrGR0qMiX+SwuOF2wbYvgjZ5CkkjVkr8RVgzTB7ozNw+QaT
         Nju8PaOYilmDTrc0WiuIzGL+0dvzHm0m4HhYdtIZZEjtLDZjy/DH1Tv7Y2xiIaAXpOYV
         N6OgQnKv63EsIC82rgF0CZCcqPBd8yI7//1o0ZQGDJbwpo8SViDNAqGo6heWvUy6WdVX
         P1fz5yjn8CExIm73pjUqnNt7C2TwLSckwIcjKhzYtZZvXZGctCzYUf4RSDvXhdFMVfsV
         IEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dp2nJcQxOK5gl+3pbENhdLhhpXT5BUImA//vXpUU9x8=;
        b=e5Hb2TaUbzKSgJPwQJBI5IdevxoZe0wMnIsEKd66dUnxDUMJjAM6qniS5MkN3XQrKn
         sOgzGh9GOgeaeZiDRAXQRhNsLG4gw6mgBQshRPNLPQQj5qq2/r5CYU00slyXnsV7vssZ
         acK1zyAWHtKykKa1Vc3ztAZ6P+aGd6wxN2yOSZIqpuOBUI/XcQzOwWhyP64v62K63L1m
         wjoj22vkjnaccvvefxyzflH5IE14cLQ62wDtnuNb7knBRWrjQurJ8/Kjf/BftenQ/gsY
         VuprwO9fim8aA1BQoekZDYpAEECf9Jk5GH3l8x88PvmP2/H86pSgS8PpBTkHZMPSCExC
         7PQw==
X-Gm-Message-State: AOAM531Imr6refKiYEVX+3U4mdPq+7oJre1y5KjQpnvMuxTv2rRdapvx
        95CRjVLFh0sZNlx/i9JC99YgPi9eRRc=
X-Google-Smtp-Source: ABdhPJyKmMLgf4Ni9YdG48Lq71zqFPfpNo+DpggTGzqnqTQZUUda0MUcBzGhyNQBPaXtoG0WGMuEyQ==
X-Received: by 2002:a05:600c:4f87:: with SMTP id n7mr4101725wmq.9.1623833872136;
        Wed, 16 Jun 2021 01:57:52 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id t11sm1442400wrz.7.2021.06.16.01.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 01:57:51 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] RFC: implement new zdiff3 conflict style
To:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
 <YMh2M8Ek/RUVjKkL@coredump.intra.peff.net>
 <CABPp-BE7-E03+x38EK-=AE5mwwdST+d50hiiud2eY2Nsf3rM5g@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <255df678-9a31-bba2-f023-c7d98e5ffc15@gmail.com>
Date:   Wed, 16 Jun 2021 09:57:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BE7-E03+x38EK-=AE5mwwdST+d50hiiud2eY2Nsf3rM5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/06/2021 20:35, Elijah Newren wrote:
> On Tue, Jun 15, 2021 at 2:43 AM Jeff King <peff@peff.net> wrote:
>>
>> On Tue, Jun 15, 2021 at 05:16:08AM +0000, Elijah Newren via GitGitGadget wrote:
>>
>>> Implement a zealous diff3, or "zdiff3". This new mode is identical to
>>> ordinary diff3 except that it allows compaction of common lines between the
>>> two sides of history, if those common lines occur at the beginning or end of
>>> a conflict hunk.
>>>
>>> This is just RFC, because I need to add tests. Also, while I've remerged
>>> every merge, revert, or duly marked cherry-pick from both git.git and
>>> linux.git with this patch using the new zdiff3 mode, that only shows it
>>> doesn't segfault. (Though I also reran 10% of the linux remerges with zdiff3
>>> under valgrind without issues.) I looked through some differences between
>>> --remerge-diff with diff3 and --remerge-diff with zdiff3, but those are
>>> essentially diffs of a diff of a diff, which I found hard to read. I'd like
>>> to look through more examples, and use it for a while before submitting the
>>> patches without the RFC tag.
>>
>> I did something similar (but I wasn't smart enough to try your
>> remerge-diff, and just re-ran a bunch of merges).
> 
> What I did was great for testing if there were funny merges that might
> cause segfaults or such with zdiff3, but not so clever for viewing the
> direct output from zdiff3.  Using remerge-diff in this way does not
> show the [z]diff3 output directly, but a diff of that output against
> what was ultimately recorded in the merge, forcing me to attempt to
> recreate the original in my head.
> 
> (And, of course, I made it even worse by taking the remerge-diff
> output with diff3, and the remerge-diff output with zdiff3, and then
> diffing those, resulting in yet another layer of diffs that I'd have
> to undo in my head to attempt to construct the original.)
> 
>> Skimming over the results, I didn't see anything that looked incorrect.
>> Many of them are pretty non-exciting, though. A common case seems to be
>> ones like 01a2a03c56 (Merge branch 'jc/diff-filter-negation',
>> 2013-09-09), where two sides both add functions in the same place, and
>> the common lines are just the closing "}" followed by a blank line.
>>
>> Removing those shared lines actually makes things less readable, IMHO,
>> but I don't think it's the wrong thing to do. The usual "merge" zealous
>> minimization likewise produces the same unreadability. If we want to
>> address that, I think the best way would be by teaching the minimization
>> some heuristics about which lines are trivial.
>>
>> Here's another interesting one. In 0c52457b7c (Merge branch
>> 'nd/daemon-informative-errors-typofix', 2014-01-10), the diff3 looks
>> like:
>>
>>    <<<<<<< ours
>>                    if (starts_with(arg, "--informative-errors")) {
>>    ||||||| base
>>                    if (!prefixcmp(arg, "--informative-errors")) {
>>    =======
>>                    if (!strcmp(arg, "--informative-errors")) {
>>    >>>>>>> theirs
>>                            informative_errors = 1;
>>                            continue;
>>                    }
>>    <<<<<<< ours
>>                    if (starts_with(arg, "--no-informative-errors")) {
>>    ||||||| base
>>                    if (!prefixcmp(arg, "--no-informative-errors")) {
>>    =======
>>                    if (!strcmp(arg, "--no-informative-errors")) {
>>    >>>>>>> theirs
>>
>> A little clunky, but it's easy-ish to see what's going on. With zdiff3,
>> the context between the two hunks is rolled into a single hunk:
>>
>>    <<<<<<< ours
>>                    if (starts_with(arg, "--informative-errors")) {
>>                            informative_errors = 1;
>>                            continue;
>>                    }
>>                    if (starts_with(arg, "--no-informative-errors")) {
>>    ||||||| base
>>                    if (!prefixcmp(arg, "--informative-errors")) {
>>    =======
>>                    if (!strcmp(arg, "--informative-errors")) {
>>                            informative_errors = 1;
>>                            continue;
>>                    }
>>                    if (!strcmp(arg, "--no-informative-errors")) {
>>    >>>>>>> theirs
>>
>> which seems worse. I haven't dug/thought carefully enough into your
>> change yet to know if this is expected, or if there's a bug.

XDL_MERGE_ZEALOUS coalesces adjacent conflicts that are separated by 
fewer than four lines. Unfortunately the existing code in 
xdl_merge_two_conflicts() only coalesces 'ours' and 'theirs', not 
'base'. Applying

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index b1dc9df7ea..5f76957169 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -455,6 +455,7 @@ static int lines_contain_alnum(xdfenv_t *xe, int i, 
int chg)
  static void xdl_merge_two_conflicts(xdmerge_t *m)
  {
         xdmerge_t *next_m = m->next;
+       m->chg0 = next_m->i0 + next_m->chg0 - m->i0;
         m->chg1 = next_m->i1 + next_m->chg1 - m->i1;
         m->chg2 = next_m->i2 + next_m->chg2 - m->i2;
         m->next = next_m->next;

and running
     git checkout 0c52457b7c^ &&
     bin-wrappers/git -c merge.conflictstyle=zdiff3 merge 0c52457b7c^2
gives

<<<<<<< HEAD
		if (starts_with(arg, "--informative-errors")) {
			informative_errors = 1;
			continue;
		}
		if (starts_with(arg, "--no-informative-errors")) {
||||||| 2f93541d88
		if (!prefixcmp(arg, "--informative-errors")) {
			informative_errors = 1;
			continue;
		}
		if (!prefixcmp(arg, "--no-informative-errors")) {
=======
		if (!strcmp(arg, "--informative-errors")) {
			informative_errors = 1;
			continue;
		}
		if (!strcmp(arg, "--no-informative-errors")) {
 >>>>>>> 0c52457b7c^2

Which I think is correct. Whether combining single line conflicts in 
this way is useful is a different question (and is independent of your 
patch). I can see that with larger conflicts it is worth it but here we 
end up with conflicts where 60% of the lines are from the base version. 
One the other hand there are fewer conflicts to resolve - I'm not sure 
which I prefer.

Best Wishes

Phillip

> Yeah, I don't know for sure either but that does look buggy to me.
> Thanks for digging up these examples.  I'm a bit overdrawn on time for
> this, so I'll pick it back up in a week or two and investigate this
> case further.
> 
