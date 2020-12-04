Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5192CC433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 17:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA9D22B40
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 17:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbgLDRX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 12:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731024AbgLDRX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 12:23:57 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55392C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 09:23:17 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id z21so8656083lfe.12
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 09:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UwkcjKaGwCxuT1BHPFLy03nC3qAIavXtJkRJXCdJi+w=;
        b=gAxStCikcHBvemeyMTZURDqkQsO9FVDwikcIxRXvJFOMljz49NujpCMkiLhg5SktmQ
         DFrvf/lUL7bv4GJ45d0z46GtGMShwujIYdyMYMr4K4ADmBSBdaYkuc7L6ivUfVmwniVt
         xIPZTAZ/EjYgptpvc9+dmrDTPrjlTHbhN/chTd7zQLMoXJHf5zs+d5ubFAGai1ekzpoU
         3cWvHbLNiZobI4F9hJFpU3AzXKj7Xa/3f91NNJM29Kxqyc92R51GzjZvlm/njaZ/FuNW
         TXE34q+FLpaS8vyoAIKZsS0DcEHbIL7Bt4xo+uPf8zfbp0BqRLSKFbcWUo17egc5+oZJ
         3krQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=UwkcjKaGwCxuT1BHPFLy03nC3qAIavXtJkRJXCdJi+w=;
        b=IpMooslzrQc6N82V1lEmzAiAQEYT5N8D+KulmDO7nqwWmpBe8bKVOotJH5Arsxq80q
         HO/PnV3yOkP8bI8SeNMX58vXqkyFkYlAXfSdTK77QeX7WmQrSOFDymEA2DNnUINJ/rpZ
         vpiOT8lwgyAachp+uR0n8eDq9z75sjEKBlcl1r0UcUrQEguopAR0IJZ1agdbhL8ktIj6
         xdVa5sFmjatFv+0UREoxSNEeDQBtpECQv80f2Q6QT418iwtrOPQ413TEwDs1N/tqW7gV
         EBqsDKU9qoJnG9YSJk7oMFuqgz7HNqokMHQMqrDtjEBjvEX97vIoSmo9VXcQ7X7gc91g
         XtWg==
X-Gm-Message-State: AOAM532p53ewlKx5xDDGfUiGKBuPXtRFjqbro2jR8iE394i/0mgXTcnh
        /55i8wzSih36kObMzSUgmz+jbvjnUoQ=
X-Google-Smtp-Source: ABdhPJxhnJYyieRTzKE8uqRAWARYw6QCsok33VyPD49ix+CyoGBBXmN0EXVT/69aesGeEW0qur9vvA==
X-Received: by 2002:a19:4a87:: with SMTP id x129mr3917319lfa.104.1607102595155;
        Fri, 04 Dec 2020 09:23:15 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u19sm1954367ljk.128.2020.12.04.09.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 09:23:11 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 10/26] diff-merges: new function diff_merges_suppress()
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201101193330.24775-11-sorganov@gmail.com>
        <CABPp-BGH0+M_6gYYfYsp54X9DjKM4mv8Vssoo3uZtDAY1_Zb1A@mail.gmail.com>
        <87ft4mfycq.fsf@osv.gnss.ru>
        <CABPp-BFW5ZLvEHFuiRC3rGqdGHWBZRjGHtTq=vVky9U5rZXsvA@mail.gmail.com>
Date:   Fri, 04 Dec 2020 20:23:10 +0300
In-Reply-To: <CABPp-BFW5ZLvEHFuiRC3rGqdGHWBZRjGHtTq=vVky9U5rZXsvA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 3 Dec 2020 12:28:01 -0800")
Message-ID: <87blf9pjsx.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Elijah Newren <newren@gmail.com> writes:

> Hi Sergey,
>
> On Thu, Dec 3, 2020 at 12:06 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Sun, Nov 1, 2020 at 11:36 AM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> This function sets all the relevant flags to disabled state, so that
>> >> no code that checks only one of them get it wrong.
>> >>
>> >> Then we call this new function everywhere where diff merges output
>> >> suppression is needed.
>> >>
>> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> >> ---
>> >>  builtin/merge.c |  3 ++-
>> >>  diff-merges.c   | 18 ++++++++++++++----
>> >>  diff-merges.h   |  2 ++
>> >>  fmt-merge-msg.c |  3 ++-
>> >>  4 files changed, 20 insertions(+), 6 deletions(-)
>> >>
>> >> diff --git a/builtin/merge.c b/builtin/merge.c
>> >> index 9d5359edc2f7..1f7b69982b40 100644
>> >> --- a/builtin/merge.c
>> >> +++ b/builtin/merge.c
>> >> @@ -14,6 +14,7 @@
>> >>  #include "lockfile.h"
>> >>  #include "run-command.h"
>> >>  #include "diff.h"
>> >> +#include "diff-merges.h"
>> >>  #include "refs.h"
>> >>  #include "refspec.h"
>> >>  #include "commit.h"
>> >> @@ -400,7 +401,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
>> >>         printf(_("Squash commit -- not updating HEAD\n"));
>> >>
>> >>         repo_init_revisions(the_repository, &rev, NULL);
>> >> -       rev.ignore_merges = 1;
>> >> +       diff_merges_suppress(&rev);
>> >>         rev.commit_format = CMIT_FMT_MEDIUM;
>> >>
>> >>         commit->object.flags |= UNINTERESTING;
>> >> diff --git a/diff-merges.c b/diff-merges.c
>> >> index 8536941e0b56..25bd9b12e667 100644
>> >> --- a/diff-merges.c
>> >> +++ b/diff-merges.c
>> >> @@ -2,6 +2,13 @@
>> >>
>> >>  #include "revision.h"
>> >>
>> >> +static void suppress(struct rev_info *revs) {
>> >> +       revs->ignore_merges = 1;
>> >> +       revs->first_parent_merges = 0;
>> >> +       revs->combine_merges = 0;
>> >> +       revs->dense_combined_merges = 0;
>> >> +}
>> >
>> > The function name is not so helpful;
>>
>> Do you have better suggestion? suppress_output()? supress_diff()?
>>
>> > why not put all this code directly in diff_merges_suppress()?
>>
>> I prefer the style where module implementation functions don't call its
>> interface functions, only vice versa.
>>
>> >
>> >> +
>> >>  /*
>> >>   * Public functions. They are in the order they are called.
>> >>   */
>> >> @@ -29,16 +36,15 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
>> >>                 revs->combine_merges = 1;
>> >>         } else if (!strcmp(arg, "--cc")) {
>> >>                 revs->diff = 1;
>> >> -               revs->dense_combined_merges = 1;
>> >> -               revs->combine_merges = 1;
>> >> +               set_dense_combined(revs);
>> >>         } else if (!strcmp(arg, "--no-diff-merges")) {
>> >> -               revs->ignore_merges = 1;
>> >> +               suppress(revs);
>> >>         } else if (!strcmp(arg, "--combined-all-paths")) {
>> >>                 revs->diff = 1;
>> >>                 revs->combined_all_paths = 1;
>> >>         } else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
>> >>                 if (!strcmp(optarg, "off")) {
>> >> -                       revs->ignore_merges = 1;
>> >> +                       suppress(revs);
>> >>                 } else {
>> >>                         die(_("unknown value for --diff-merges: %s"), optarg);
>> >>                 }
>> >> @@ -48,6 +54,10 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
>> >>         return 1;
>> >>  }
>> >>
>> >> +void diff_merges_suppress(struct rev_info *revs) {
>> >> +       suppress(revs);
>> >> +}
>> >
>> > ...especially since all this function does is call suppress()?
>>
>> Yes, it does, but it doesn't mean it will be that way forever. Interface
>> function might need to perform additional checks or actions, in general.
>
> Ah, I didn't catch the distinction and thus the reasoning in having
> the two different functions.
>
>> Besides, if diff_merges_suppress() is OK with you as interface function
>> name, why suppress() is not OK as local function name in diff-merges
>> module?
>
> Right, the fact that it's in the diff-merges module as opposed to more
> general diff-lib code is probably hint enough.  I was skimming over
> the patches looking for things that jumped out, and although I had
> read that you were adding it to the new module, I forgot that when I
> saw the "suppress()" function name.  Thanks for the reminder, and
> sorry for the noise.

Fine, thanks, and please don't mention it!

-- 
Sergey Organov
