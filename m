Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EF9C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 07:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 460842065C
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 07:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJmitBla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgFNHon (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 03:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgFNHom (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 03:44:42 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EC6C03E96F
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 00:44:42 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cv17so6349916qvb.13
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 00:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/tMoKMkKD/DVVo/ntCVBCQ+enXwGb0/JTpNaNp0rEJE=;
        b=YJmitBlast25d+JLQlbgGcJeZye56sYteSlf0YuxeFSAgN865tMaBXpKZl4PfqLtOc
         pngaMTBmktmT8S90Db3Qj0fgiZFqlM71K9q3Sl93yaA/s3Ij2sklta+gTFmiZG5QQwTz
         oCGcCS5ByTkPmmeJPoA5scZylNtNMoxIXU2cbNVmq8QLubFzDvVt7Up2CKj8xtS1CEpT
         KU1SEZ6uHziE/HjXnnwxlnFjysLC4WS+NzFSc/2s8YGXfjoXpBB7vr82Kdy0F1aSm2q2
         4dmPwgKB/eLHXM+mudVOUd8N55/waVgDnhp6lCrpz399SUxWyohARmjpW9EmMzPAjLDh
         mUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/tMoKMkKD/DVVo/ntCVBCQ+enXwGb0/JTpNaNp0rEJE=;
        b=CC3I9rz0cHUv0pGuhliYkvBY9CMsceOlNiTV8k1D5mwfeNiHaKPIXYLYcnONhV8d6u
         /yALvaiPaLgoAxA5TVC7bpXNHBeRdeSa9v3YVrpMkOnMtfvPghvfZxENXI8poO5vgs4P
         CsZ6O/rGMxDXhViS9IWHZ7X+dpJhn9dtTz/g3/SHQ30UevV9JPnTtT1shqSIuVR6V5sq
         7xYkWNIHdkWCZKD2KHeAKfcEttl2MqNqopMSAY3IV0LhOEmPA0Uj/NWqzVp2F0XiHeA8
         UV4gWN57SgkNaEDtUH/F/4hY4yJ6bK+vwamuBLFsZC03rtDCYQTRej72xJE2RPFX9d2S
         ZqKw==
X-Gm-Message-State: AOAM5330dykIYsgVoF3X4itxJ9E+ZACfHcNUITbhW9S7ywSB+bWfXjUS
        yq4jOzeoNHT5XW43OoItWu8zW+OPEgY=
X-Google-Smtp-Source: ABdhPJwtYq7f0xyld+dpIkwr1OJ/FivL6EGJTJTpQcoMmbik+AQH5tJUYaK4UYirIw49/h6LXIsjFQ==
X-Received: by 2002:a0c:e952:: with SMTP id n18mr19822293qvo.147.1592120681525;
        Sun, 14 Jun 2020 00:44:41 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id v69sm8208601qkb.96.2020.06.14.00.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 00:44:40 -0700 (PDT)
Date:   Sun, 14 Jun 2020 03:44:39 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] checkout: teach --worktree
Message-ID: <20200614074439.GA617439@generichostname>
References: <d10cb03dd8ce00cb6033c61ff9b9b30bbf5f9c89.1592058281.git.liu.denton@gmail.com>
 <CAPig+cQ_G+N=mYqO+=7UaAYft27MhZ2_3v8=QzYpDn5hQySp+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQ_G+N=mYqO+=7UaAYft27MhZ2_3v8=QzYpDn5hQySp+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sat, Jun 13, 2020 at 10:51:47PM -0400, Eric Sunshine wrote:
> On Sat, Jun 13, 2020 at 10:25 AM Denton Liu <liu.denton@gmail.com> wrote:
> > [...]
> > Teach `git checkout --worktree`, allowing users to checkout files
> > directly into the worktree without affecting the index.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> > diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> > @@ -264,6 +266,12 @@ When switching branches with `--merge`, staged changes may be lost.
> > +-W::
> > +--worktree::
> > +       When writing contents, only modify files in the worktree. Do not
> > +       modify the index. This option is essentially a no-op when used
> > +       without a `<tree-ish>`.
> 
> Why a no-op rather than actually diagnosing that --worktree makes no
> sense in that case and erroring out?

I decided on this behaviour because I assumed that an empty
`git checkout` has `git restore` behaviour but I guess I was mistaken.
I'll change it to error out.

> > diff --git a/t/t2028-checkout-worktree.sh b/t/t2028-checkout-worktree.sh
> > @@ -0,0 +1,51 @@
> > +test_expect_success 'checkout --worktree on a commit' '
> > +       test_when_finished "git reset --hard tip" &&
> > +       git diff HEAD HEAD~ >expect &&
> > +       git checkout --worktree HEAD~ file1 &&
> > +       git diff >actual &&
> > +       test_cmp expect actual &&
> > +       git diff --cached --exit-code &&
> 
> Would the intent be clearer if you used 'test_expect_code' here?
> 
>     test_expect_code 0 git diff --cached --exit-code &&
> 
> Same question for remaining tests.

I'm not really sure that this adds anything. When I read through the
tests, I already expect each command to be successful, i.e. return 0.
I don't see how explicitly documenting for this one command would make
that more clear.

Looking through the test suite, I only see 15 results of
`test_expect_code 0 git diff --exit-code` and all of those are in t4035.
Meanwhile, I see at least 234 instances without the `test_expect_code`.
I believe that we should leave this as-is.

Thanks,

Denton
