Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407DDC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 15:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28356613E1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 15:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhFKPfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 11:35:39 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:45684 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhFKPfi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 11:35:38 -0400
Received: by mail-oi1-f176.google.com with SMTP id w127so6178804oig.12
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=WBgJ4X0JMXDf6l26C1AQoUKA0lpBAkD4WIjcD30gSv4=;
        b=XY1UfQWFoasEAuZ23VcIlVMOci1J+XpAhroDLQW7c6cC+YCvcscN84cpIujgB+6X5D
         qmmMB7+Dcc9Cj4pgV+ySSV613ANjKU9RCeopShKSfiTguylRF3ak8JywtI2JyyQHqQbR
         ihB97Hjv5WKWeFP43GR9SKNCrV6n/4lRvEI4HtFz8XJeXwwsfsJ1+uk9ovJLaMAB+VUh
         1kTJKkD9fZ6VhS2Ju/p+fx6noDa0Ly/WuO0v88MqJRb0+Srf6JOuQtwHenl/y5u2lN2E
         xQXpz3tu7CzE9YDFtOzT1D0sqcpEtarzC7lsFgNJd78LySzYeypdLjlTRNhWmSJ9bIhV
         76CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=WBgJ4X0JMXDf6l26C1AQoUKA0lpBAkD4WIjcD30gSv4=;
        b=YYI5U/jhRC8hZr80aQYnlpiIL+YPWBFgobIrn7pVAtq45U5ClWhcbgVuQcwkb3dXg3
         52dmI/cBcw5PyoQenKN55K5+ywMfvlsszXyHSqAR7/PFy4a/Axkx0/6UFge3wAw4Jilk
         RYI/SbYfSecardgkoOrwPmIoSUYEGPrrI2/gd11ajEsBYhj6Ol/rtl3jqCFDqEO1ZCXQ
         gMKtjB8mlSm21BjKEYmAsgHukyrOt1R1+U9QzsWl8k6dUPytpXSIWTV4od58hKLrZj1D
         RqUhTTu9gwnRIIFncQy6lNBJc6Z0vQuK271OV/z7Jg4o0NcynvG/6RvW08su5yL3dqf7
         dORg==
X-Gm-Message-State: AOAM5327JHwM6b8sVjEz7Pvr9mml1buKV/nxpcu6nkWdxsHE0E1bDRY/
        XCYOVKXewfvDTTG5JZfpPLQ=
X-Google-Smtp-Source: ABdhPJx8HrSFfSS+srYwQEmnA0Yo2tmb0eHr8uHQ6le13FAy2g8FHHkpRB1hl3mOZnkE1gFTZg65Jw==
X-Received: by 2002:a54:4f99:: with SMTP id g25mr14213523oiy.132.1623425548682;
        Fri, 11 Jun 2021 08:32:28 -0700 (PDT)
Received: from localhost ([187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p25sm1221071ood.4.2021.06.11.08.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 08:32:28 -0700 (PDT)
Date:   Fri, 11 Jun 2021 10:32:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Message-ID: <60c38205cdbf8_3ad92084@natae.notmuch>
In-Reply-To: <875yykipq2.fsf@osv.gnss.ru>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
 <xmqqh7i5ci3t.fsf@gitster.g>
 <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
 <xmqqy2bg3nqw.fsf@gitster.g>
 <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
 <xmqqo8cc3maq.fsf@gitster.g>
 <875yykipq2.fsf@osv.gnss.ru>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Junio C Hamano <gitster@pobox.com> writes:

> > I notice that "git merge --help" tells what each part separated by
> > conflict markers mean in both output styles, but does not make a
> > specific recommendation as to which one to use in what situation,
> > and it might benefit a few additional sentences to help readers
> > based on what you said, i.e. the "RCS merge" style that hides the
> > original is succinct and easier to work with when you are familiar
> > with what both sides did, while a more verbose "diff3" style helps
> > when you are unfamiliar with what one side (or both sides) did.
> 
> I don't get it. Once you have diff3 output, and you want something
> simpler, you just kill the inner section, right? RCS merge output style
> is simply inferior.

The issue here is not a mere inner section, it's a nested inner section
due to a recursive merge.

Personally I've never encountered these in real life, but you can
trigger them with the following synthetic example, and the output with
diff3 is:

--- a/content
+++ b/content
@@@ -1,1 -1,1 +1,13 @@@
++<<<<<<< HEAD
 +D
++||||||| merged common ancestors
++<<<<<<<<< Temporary merge branch 1
++B
++||||||||| 2c9519d
++1
++=========
++A
++>>>>>>>>> Temporary merge branch 2
++=======
+ C
++>>>>>>> C

While with merge is:

--- a/content
+++ b/content
@@@ -1,1 -1,1 +1,5 @@@
++<<<<<<< HEAD
 +D
++=======
+ C
++>>>>>>> C

I don't see why diff3 triggers the output of this temporary merge, that
is a bug in my book.

I would expect the output to simply be:

--- a/content
+++ b/content
@@@ -1,1 -1,1 +1,13 @@@
++<<<<<<< HEAD
 +D
++||||||| 2c9519d
++1
++=======
+ C
++>>>>>>> C

Cheers.

  git init repo &&
  cd repo &&

  echo 1 > content &&
  git add content &&
  git commit -m 1 content &&

  git checkout -b A master &&
  echo A > content &&
  git commit -m A content &&

  git checkout -b B master &&
  echo B > content &&
  git commit -m B content &&

  git checkout -b C A &&
  git rev-parse B >.git/MERGE_HEAD &&
  echo C > content &&
  git commit -m C -a &&

  git checkout -b D A &&
  git rev-parse B >.git/MERGE_HEAD &&
  echo D > content &&
  git commit -m D -a &&

  git -c merge.conflictstyle=diff3 merge -m final C &&
  cat content

-- 
Felipe Contreras
