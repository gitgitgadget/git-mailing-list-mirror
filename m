Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B38C4361B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 20:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E402220F
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 20:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgLCUHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 15:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLCUHa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 15:07:30 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944A8C061A53
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 12:06:49 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id r24so4540147lfm.8
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 12:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fcw4YD0+XTxmFRwAqEdvOkahYRIJbIYNNZD4YJW1HgI=;
        b=g/0u857LINfeV5RPuk42Sm5I30xacWyt6B9yOOLkbhvDP9vFRdoS/isTFJ4PXAPhAo
         E8nARchsFfYtxFr2G9wzKmcykZ3eYFOyed8CQ96wfawpfG8EXA7MhEcPp63ihPCWWeei
         A9q/UJNArfmplfGv3e9C98ZzlpHwh6TD8bt5ZlJbVE0YFtKmQ0mRWAYO58C9dIesieQb
         cBB2dKmXK7+O7OX7p5gANxlyFo0YeEkGoV02Jw3dRan1mQJnnWoaeeBk00ncY28Qw9cz
         y4AIPAkpCz9pRAI8fCKOgGxFwIc9KW0sFkK5IOdVxOo0it7Adl939iRDDNQwaFxC6M7o
         lviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=fcw4YD0+XTxmFRwAqEdvOkahYRIJbIYNNZD4YJW1HgI=;
        b=QHhG0AA2bmgN0HO5hTq31YSSy09JwrT1g6UE4kgC+xBElvtXnADbi8eVJHkWbX4QfN
         LkV1UREK0ByfIJJI66H7KicuknYuVPCycC/9QIVi6YxOm4c7u68C7ExMUHaKjq8D/32b
         56y/i5ZJXqDcda+KebID+O6pyUAJCOohVTK3lqdzDa+VccM4T+xUWPC5UF4VcMoFBHoY
         2/VQlQ1m+J7/FWaKlifYbsqoPY1s0Uhgm082agi8VV4s95V0bD10dN6BSavCtHN52srH
         colcuzBdwlgK18KNtGiL4160tM0/uId7Jis93FqNoVCgU2mJeJD0YiXDFlZVQ501RJxe
         iOIg==
X-Gm-Message-State: AOAM530wqWB2Wrg50eMnZh7Ugmuy1MAZmGfwhQlR3Jp4usoGMs5/rDPK
        hTlKwBblhE65FsI/KN15cQGHm/c/bjo=
X-Google-Smtp-Source: ABdhPJztVP42owS2CFWMNrE7quQtn6MWOztVWl9x6PAlye9cjJjgCEB+R8kwAyyluMKAdthZ75VWrA==
X-Received: by 2002:a19:2d45:: with SMTP id t5mr2001122lft.445.1607026007723;
        Thu, 03 Dec 2020 12:06:47 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z22sm848475lfb.97.2020.12.03.12.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 12:06:46 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 10/26] diff-merges: new function diff_merges_suppress()
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201101193330.24775-11-sorganov@gmail.com>
        <CABPp-BGH0+M_6gYYfYsp54X9DjKM4mv8Vssoo3uZtDAY1_Zb1A@mail.gmail.com>
Date:   Thu, 03 Dec 2020 23:06:45 +0300
In-Reply-To: <CABPp-BGH0+M_6gYYfYsp54X9DjKM4mv8Vssoo3uZtDAY1_Zb1A@mail.gmail.com>
        (Elijah Newren's message of "Wed, 2 Dec 2020 21:52:36 -0800")
Message-ID: <87ft4mfycq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Sun, Nov 1, 2020 at 11:36 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> This function sets all the relevant flags to disabled state, so that
>> no code that checks only one of them get it wrong.
>>
>> Then we call this new function everywhere where diff merges output
>> suppression is needed.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  builtin/merge.c |  3 ++-
>>  diff-merges.c   | 18 ++++++++++++++----
>>  diff-merges.h   |  2 ++
>>  fmt-merge-msg.c |  3 ++-
>>  4 files changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/merge.c b/builtin/merge.c
>> index 9d5359edc2f7..1f7b69982b40 100644
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -14,6 +14,7 @@
>>  #include "lockfile.h"
>>  #include "run-command.h"
>>  #include "diff.h"
>> +#include "diff-merges.h"
>>  #include "refs.h"
>>  #include "refspec.h"
>>  #include "commit.h"
>> @@ -400,7 +401,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
>>         printf(_("Squash commit -- not updating HEAD\n"));
>>
>>         repo_init_revisions(the_repository, &rev, NULL);
>> -       rev.ignore_merges = 1;
>> +       diff_merges_suppress(&rev);
>>         rev.commit_format = CMIT_FMT_MEDIUM;
>>
>>         commit->object.flags |= UNINTERESTING;
>> diff --git a/diff-merges.c b/diff-merges.c
>> index 8536941e0b56..25bd9b12e667 100644
>> --- a/diff-merges.c
>> +++ b/diff-merges.c
>> @@ -2,6 +2,13 @@
>>
>>  #include "revision.h"
>>
>> +static void suppress(struct rev_info *revs) {
>> +       revs->ignore_merges = 1;
>> +       revs->first_parent_merges = 0;
>> +       revs->combine_merges = 0;
>> +       revs->dense_combined_merges = 0;
>> +}
>
> The function name is not so helpful;

Do you have better suggestion? suppress_output()? supress_diff()?

> why not put all this code directly in diff_merges_suppress()?

I prefer the style where module implementation functions don't call its
interface functions, only vice versa.

>
>> +
>>  /*
>>   * Public functions. They are in the order they are called.
>>   */
>> @@ -29,16 +36,15 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
>>                 revs->combine_merges = 1;
>>         } else if (!strcmp(arg, "--cc")) {
>>                 revs->diff = 1;
>> -               revs->dense_combined_merges = 1;
>> -               revs->combine_merges = 1;
>> +               set_dense_combined(revs);
>>         } else if (!strcmp(arg, "--no-diff-merges")) {
>> -               revs->ignore_merges = 1;
>> +               suppress(revs);
>>         } else if (!strcmp(arg, "--combined-all-paths")) {
>>                 revs->diff = 1;
>>                 revs->combined_all_paths = 1;
>>         } else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
>>                 if (!strcmp(optarg, "off")) {
>> -                       revs->ignore_merges = 1;
>> +                       suppress(revs);
>>                 } else {
>>                         die(_("unknown value for --diff-merges: %s"), optarg);
>>                 }
>> @@ -48,6 +54,10 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
>>         return 1;
>>  }
>>
>> +void diff_merges_suppress(struct rev_info *revs) {
>> +       suppress(revs);
>> +}
>
> ...especially since all this function does is call suppress()?

Yes, it does, but it doesn't mean it will be that way forever. Interface
function might need to perform additional checks or actions, in general.

Besides, if diff_merges_suppress() is OK with you as interface function
name, why suppress() is not OK as local function name in diff-merges
module?

Thanks,
-- Sergey Organov
