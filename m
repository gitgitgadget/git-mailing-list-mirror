Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186DEC07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 01:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE05C61CAA
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 01:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhGGBQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 21:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhGGBQj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 21:16:39 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27739C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 18:13:59 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id b2so1512048oiy.6
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 18:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=TsvylwqVGs1egXmeAcnq11RDA+Zh3w6xYlEaFnIK3do=;
        b=S2JTVOBd8eug5HlSsvwQd3yfjPQT0fnGTURzcxnK2ECd2K4b8XfR4hSmwxusRqbotJ
         Sx3fbLK2TUF/6smL9P7hepsFGm9HD62k2rv6Ylbhu6TaVnmExkn6Pw/ZkWN6dK97pmB/
         d0sANFA+26x+AVYa1mobaU+m6NX+N5ixarwLXB5H3K88xoFZvj5Il77YkTKwuIMU8Cg6
         QQ8Pd/2gMwJ+mpv8scv1FgTcskPbmDbdiag4/w8zlePEvKWlq2zW8XNFtH/swdrjK4+j
         Ewe6UJAmlrX0O1INlbEn6EQoArFIA+qnw5FwJw2R5/1xRyz/c3BKt/LnCEfpJp1EvCBZ
         OTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=TsvylwqVGs1egXmeAcnq11RDA+Zh3w6xYlEaFnIK3do=;
        b=p6W6ShbjtRYY1FiJ5CV2qbi0oOtBKC6ohJOBbLOsxByJjka2LnAsibQcwjxYAAATqi
         zDUs+orkl6rZ9isj0m+okwa0BxggVskfYT5JCgbgrNkl061MhqjOmPBvY5960ZnI2mGU
         TVG8jZY1ZWDQ+sRfee6pE1jeWoGsARoboJ/rhx4ezRwAWIXfYXrlehvy2J2cKSY67tiL
         JKXPoJdxjGUl2kC4wOOYM900h0JPepP5jrB9fHAfIrCSh299OTwirK6LrudjVNd6D7LI
         TZ3DC5/BLasRT++bENqhJKyNA6D9MjPBoT+5uWhULFwbE6NqG/bAeS3vORirFverG+Ui
         y0dQ==
X-Gm-Message-State: AOAM533eYl03uIzOMAgeRbOhVc9ADCB3MrH+h6nHIhrVyIEcw15HeHjk
        FoDUPF6o0RewFNMQHj3l08NVKhRtt3o=
X-Google-Smtp-Source: ABdhPJy1UHV3lXc5mZ9bJbwqf7Jbasdog1J4rw1H3ufMqkbLuNoWSXyDIPS0iyotOd1BXRUMkjIExg==
X-Received: by 2002:aca:ebc4:: with SMTP id j187mr16769348oih.15.1625620438561;
        Tue, 06 Jul 2021 18:13:58 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id z22sm3637355otk.16.2021.07.06.18.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 18:13:58 -0700 (PDT)
Date:   Tue, 06 Jul 2021 20:13:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        newren@gmail.com
Message-ID: <60e4ffd4d2a93_1c5ca52081a@natae.notmuch>
In-Reply-To: <xmqqpmvwn1qp.fsf@gitster.g>
References: <20210705044505.666977-1-alexhenrie24@gmail.com>
 <349748b4-3c48-7ca7-eb0f-e859a15cab0f@gmail.com>
 <7ee36923-0806-4316-729c-8418df5b6555@gmail.com>
 <xmqqpmvwn1qp.fsf@gitster.g>
Subject: Re: [PATCH RFC] rebase: respect --ff-only option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > Looking at origin/seen:builtin/pull.c we already check if we can
> > fast-forward and unconditionally merge in that case irrespective of
> > any '--rebase' option or pull.rebase config. It should be simple for
> > pull to error out if '--ff-only' is given and we cannot fast-forward.
> 
> Excellent.
> 
> Even though teaching even more special case on the "git pull" side
> makes me feel somewhat dirty,

It makes you feeld dirty for a reason.

Why don't you just actually try the proposal?

--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1052,6 +1052,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
                        show_advice_pull_non_ff();
        }
 
+       if (!can_ff && (!opt_ff || !strcmp(opt_ff, "--ff-only")))
+               die("unable to fast-forward");
+
        if (opt_rebase) {
                int ret = 0;
                int ran_ff = 0;

Then:

  ./git pull . topic
  ./git pull --no-rebase . topic
  ./git pull --rebase . topic

From 1 to 10 how broken would you say that is?

-------------------
t4013-diff-various.sh                            (Wstat: 256 Tests: 208 Failed: 91)
  Failed tests:  1, 49-63, 67-69, 71-91, 101-116, 120-124
                127-130, 138-141, 144-145, 147-150, 152-153
                171-175, 189-193, 201-204
  Non-zero exit status: 1
t5521-pull-options.sh                            (Wstat: 256 Tests: 20 Failed: 2)
  Failed tests:  12, 16
  Non-zero exit status: 1
t5524-pull-msg.sh                                (Wstat: 256 Tests: 3 Failed: 2)
  Failed tests:  2-3
  Non-zero exit status: 1
t5520-pull.sh                                    (Wstat: 256 Tests: 72 Failed: 39)
  Failed tests:  16, 19, 23-24, 26-29, 33-41, 43-46, 48-53
                55-57, 59-64, 69, 71-72
  Non-zero exit status: 1
t5533-push-cas.sh                                (Wstat: 256 Tests: 23 Failed: 2)
  Failed tests:  21-22
  Non-zero exit status: 1
t5553-set-upstream.sh                            (Wstat: 256 Tests: 19 Failed: 6)
  Failed tests:  11-14, 16-17
  Non-zero exit status: 1
t5604-clone-reference.sh                         (Wstat: 256 Tests: 33 Failed: 4)
  Failed tests:  13-16
  Non-zero exit status: 1
t5572-pull-submodule.sh                          (Wstat: 256 Tests: 64 Failed: 3)
  Failed tests:  62-64
  Non-zero exit status: 1
t6409-merge-subtree.sh                           (Wstat: 256 Tests: 12 Failed: 3)
  Failed tests:  9, 11-12
  Non-zero exit status: 1
t6402-merge-rename.sh                            (Wstat: 256 Tests: 46 Failed: 8)
  Failed tests:  2-8, 11
  Non-zero exit status: 1
t6417-merge-ours-theirs.sh                       (Wstat: 256 Tests: 7 Failed: 1)
  Failed test:  6
  Non-zero exit status: 1
t7601-merge-pull-config.sh                       (Wstat: 256 Tests: 32 Failed: 3)
  Failed tests:  11, 15-16
  Non-zero exit status: 1
t7603-merge-reduce-heads.sh                      (Wstat: 256 Tests: 13 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1

-- 
Felipe Contreras
