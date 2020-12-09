Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F79C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 13:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B51E23A6C
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 13:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbgLINfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 08:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732043AbgLINfS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 08:35:18 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757E2C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 05:34:38 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m25so3091222lfc.11
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 05:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TNFe1b81jxZ8P73g9LUrWhoKhSJv0m/PHJrSXUZuVdI=;
        b=QNuJd+J64WdguobLt2wwANaByL8QJcZGkrkos0hR9kfTlcsncrgD6MEfxZpf7UMMAx
         1AymXqXEci6nKgdm6oLxfeqyA8Vd+zlhY1q4r+14bVQ+/uuh51IvKTbjccsEdoZep9cH
         9qrqM3bf5lLJJGPpa/NCtqbKvS9x14yV8Y2NmOsU6AcIso6THoypxf4dCsOdBrCXDJyc
         fxI6LbzvnwbD3T6cR0V2xyYGfKSTzO53vyA4IS7bfKhFo+Y3c/V2tlaeIlZNxLzCFdr8
         /h58BHKj6WnJzkNpmq2gUw3LaIRPcvMo5K9f1hUeNm0Zu/S846nRFOgYAWO7KQ0RyBpF
         KOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=TNFe1b81jxZ8P73g9LUrWhoKhSJv0m/PHJrSXUZuVdI=;
        b=iz8K+yCNA7Q091H8bjHztrQIZTuQm98IPqjBX2tVK5848oTtAA4HdARx0XC2/T6JJ0
         +nSzOqupyUEdpR8bnrqoTRleztzZyDf+ZovbGE+I5EJgHafbB/7ifkOjDhrlAnYPt5zy
         D6YNMtMvh9hdW5HjNVTEHZ2cvpL2VukCCPByHudic7albroLj5azUFg+Oxlyzv1PCV3e
         qXY2Pq8FtqENlkJqDClciE5czVyVReXUOy2gTbVnDdvnx1rAI4/NvJJEthtVdd3HR4kR
         XF9oGu044DdrPRWq9jlfMFRI5uw5Imfmf+3pxE6AOMzSRpTWht/O6maPEz5PWre8AjYs
         OOmw==
X-Gm-Message-State: AOAM531qgoDYOj+BnZMOi7AJCTsO/YIr8X8Wlmu1xmxUz78wzgJvHwYD
        oh7VyTD5OsyxO8IltgO7Fy5NKZPLykY=
X-Google-Smtp-Source: ABdhPJx0NsGr7qHaNwqDfKSFfpUGjCZ/PK2o60ho2MlOi7OHC2DDILEkrLaOPA/m12UbGwTYAw/A6Q==
X-Received: by 2002:ac2:5689:: with SMTP id 9mr1038298lfr.175.1607520873130;
        Wed, 09 Dec 2020 05:34:33 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b25sm173443lfi.173.2020.12.09.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:34:30 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <87y2i8dptj.fsf@osv.gnss.ru>
        <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
        <87y2i8c4mr.fsf@osv.gnss.ru>
        <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
        <xmqqtusv4w2g.fsf@gitster.c.googlers.com>
        <CABPp-BHCtrKAWR1v3OrUgX8iSfxvDwN8p+yiJy=G1BFfnSopjw@mail.gmail.com>
        <xmqq7dpr4qa0.fsf@gitster.c.googlers.com>
        <CABPp-BHWhiUZ=wCSz1f0oxtHiRzAKCPVmoUYDf+mvvm63ykCEw@mail.gmail.com>
        <xmqq360f4npg.fsf@gitster.c.googlers.com>
        <CABPp-BEAmB9DA7RXrf6vJGbHfGU37V4sE0d1CW+2vRwp_uAudw@mail.gmail.com>
Date:   Wed, 09 Dec 2020 16:34:29 +0300
In-Reply-To: <CABPp-BEAmB9DA7RXrf6vJGbHfGU37V4sE0d1CW+2vRwp_uAudw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 8 Dec 2020 20:54:31 -0800")
Message-ID: <87360fgl22.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Dec 8, 2020 at 8:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> >> If I can run "git log --some-options master..next" (or more
>> >> realistically, over the range ko/next..next) to get individual
>> >> commits (without patch) and merges (only when --cc gives some
>> >> interesting nearby-changes), I would be very happy.  But is there a
>> >> set of options that lets me do so?
>> >
>> > So, you're saying you changed your mind since five years ago?[1]  Or
>> > that what you said five years ago is still valid, but you'd appreciate
>> > more/different options that allow this new thing?
>> >
>> > [1]
>> > https://lore.kernel.org/git/1440110591-12941-1-git-send-email-gitster@pobox.com/
>>
>> Sorry, but I am not seeing in [1] anything that relates to the above
>> "want to see --cc patch for merge but just log message for single
>> parent commit". 5 years is a long time even in Git timescale, so I
>> would not be surprised if I changed my mind over time, but I am not
>> sure what opinion on the matter you think I expressed back then.
>>
>> "git log --cc master..next" shows all commits' log messages, patch
>> for each single-parent commit, and combined-dense patch for each
>> merge.  There is no option to squelch the patch for only single
>> parent commits.  It may not be such a bad thing to have as an extra
>> option.
>>
>> So, I think what I am saying is that ...
>>
>> > > ...  As I said, I'm not sure why
>> > > anyone would ever want to see diffs for merges and not for normal
>> > > commits, the closest useful thing I can imagine is commit messages +
>> > > diffs for just merges, stripping the normal commits.
>>
>> ... I see use for such a feature (assuming that you didn't mean by
>> "diffs for merges" a regular "--first-parent -p" patch, but meant to
>> say "--cc" patch) in my workflow.  I'd review "log ko/next..next"
>> before deciding to push out the day's integration of 'next', and at
>> that point, I trust individual commits that came from contributors
>> well enough (otherwise I wouldn't be merging them to 'next'), but I
>> would appreciate the last chance to re-examine conflict resolutions
>> in merges.
>>
>> It does not mean that I do not like the current behaviour that
>> "--cc" always implies "-p"; it is convenient.  It's just I find the
>> lack of feature slightly less than ideal, but I do not care deeply
>> enough to design how to express such a feature from the command
>> line.
>
> Okay, thanks for clarifying.  It sounds like you were focusing on the
> tangentially related comment I made (diffs for merges and not for
> normal commits) while I was focusing on Sergey's question (should we
> revert --cc implies -p).  I was having a hard time understanding if
> you were answering his question or not.  This last paragraph of yours
> acknowledges the question, though you still avoid answering it.  :-)
>
> However, even my focus was on a secondary question.  His real original
> question is: -m and --cc are inconsistent -- one requires -p, while
> the other doesn't.  Should that be fixed...and which option(s) should
> change?  He gave two possibilities I didn't like.  I added a third
> that you didn't like.  So...

I believe you've misunderstood me slightly.

I didn't suggest bare reverting of the "-c/-cc imply -p" commit. I
rather suggested to modify current behavior to "-c/--cc enable diff
output for merge commits", then add "-m" to the mix, so that we finally
get:

  "-m/-c/--c enable diff output for merge commits".

And I should emphasize that what I mean differs from "-m/-c/--cc imply -p
for merge commits only" as Junio has put it in this discussion, even if
slightly, -- it won't imply -p, to avoid messing with --first-parent
that would imply -p through -m and enable diff for merges, that is not
what we want.

This is what I'd like to see, as it finally makes -m/-c/--cc (as well as
other --diff-merges options) focus on merge commits only and never
affect regular commits, -- the way it should be.

My alternative suggestion was to rather add "-m implies -p" to the
current state, resulting in:

  "-m/-c/--c imply -p".

However, the latter one has additional complication in handling of
"--first-parent" that currently implies -m that'd then imply -p and
suddenly give lengthy output on bare "git log --first-parent".

Fixing the latter is still possible by complicating of options handling
by specifying that implied options don't imply other options, only
explicit options do, but somehow I don't like this, -- too complex for
the job at hand. I'm still on position that option management in Git
could rather be done in much simpler manner, without need for such
complexities.

Thanks,
-- Sergey

