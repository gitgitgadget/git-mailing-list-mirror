Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C5AC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 04:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjAWESL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 23:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjAWESI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 23:18:08 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E5ACA29
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 20:18:07 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m3-20020a17090a414300b00229ef93c5b0so9244687pjg.2
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 20:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vy+tuArghifOJJ5CoNgEptnF9PeHKybCkO8Qg7MYfA=;
        b=kT9PzFtLr5zDcJ0a6wV7HRzASClcbp9aLClFLgqn+YM01EKwyPMkq63Bhzlqxu90DJ
         HHtNQYCjmpZhts1zUGbaUKFdgfEaT5HfuigrCzPPwOY1mcEOfyic/a2/F2ZuLgJZU93V
         uhNiP22YdZI+XYbCbpE5mIdeIVtkzgADtZQtQx51ITZQ/wZfG0M/Uzr5/lkrco4fY5iw
         ef9yy/BEj1bxaTK91uS5xxqiyey6fvkrS98k7R9PljxIdJFlpDR31RZbBbtK2SiaDjAw
         7s/1EYW48Pvjax3ebAQnu5sbxGSPOcGWA7j1T5A3mqREmOMkXBKoNgCTMtC94m2+KpVA
         JzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vy+tuArghifOJJ5CoNgEptnF9PeHKybCkO8Qg7MYfA=;
        b=Bd+t9DVB7Z8EEhd7IpEGUCuhSWyCEJxW0NNwPcaskfJY/B6DcgAbdsbDA3QJMxjDpi
         tRyJPRDyJ1eSys26zAzYbOTBPmjC1Bp0zy8tuXhr4pYARSRmBvQoD6j/FlcnuriEFGeK
         LjL4RttUyhZ41eFqe55mCpmRV7MYSfcwotxb933x51yINaSI23jg15HgV5EiSgQjeFj+
         LJY1Vv+3kLuSMFPG+LD7YWqNVoCeIyT+cgvqFSHJY1vB9mRo9GyiympKuGa/duJ4EtcX
         /+k8bOxu4Hm5uYBwOLrQuvCqCAqgcF4Dd3hTao2m1nhWHJou3TYcNLQH1k0B3TMw67qO
         7Kdw==
X-Gm-Message-State: AFqh2koTcCgFOUycN223Ux67D2zJ7Xicl8avxPFmnI2ZX386zxEh6wE4
        l9bpIKVrpdLlLRIAJJIkptyZO+5gCy8=
X-Google-Smtp-Source: AMrXdXt5wR8RbrJU5ZLQe5LixGBuCYgnokiqzslRpIAkM+LyFUjyrTyulh+qmg0Iz/+HkecCSmGl+w==
X-Received: by 2002:a17:903:54d:b0:193:a5b:ccf6 with SMTP id jo13-20020a170903054d00b001930a5bccf6mr20912902plb.0.1674447486421;
        Sun, 22 Jan 2023 20:18:06 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902868c00b00195e77c20a9sm5300066plo.163.2023.01.22.20.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 20:18:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2] MyFirstContribution: refrain from self-iterating too much
References: <xmqq3583uyk0.fsf@gitster.g>
        <20230122071156.367jwwt3d5txvkl4@tb-raspi4>
        <xmqqcz76tv6d.fsf@gitster.g>
Date:   Sun, 22 Jan 2023 20:18:05 -0800
Message-ID: <xmqqzga9opdu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Finding mistakes in and improving your own patches is a good idea,
but doing so too quickly is being inconsiderate to reviewers who
have just seen the initial iteration and taking their time to review
it.  Encourage new developers to perform such a self review before
they send out their patches, not after.

Helped-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/MyFirstContribution.txt | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index ccfd0cb5f3..3e4f1c7764 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1256,6 +1256,36 @@ index 88f126184c..38da593a60 100644
 [[now-what]]
 == My Patch Got Emailed - Now What?
 
+After you sent out your first patch, you may find mistakes in it, or
+a different and better way to achieve the goal of the patch.  But
+resist the temptation to send a new version immediately.
+
+ - If the mistakes you found are minor, send a reply to your patch as
+   if you were a reviewer and mention that you will fix them in an
+   updated version.
+
+ - On the other hand, if you think you want to change the course so
+   drastically that reviews on the initial patch would become
+   useless, send a reply to your patch to say so immediately to
+   avoid wasting others' time (e.g. "I am working on a better
+   approach, so please ignore this patch, and wait for the updated
+   version.")
+
+And give reviewers enough time to process your initial patch before
+sending an updated version.
+
+The above is a good practice if you sent your initial patch
+prematurely without polish.  But a better approach of course is to
+avoid sending your patch prematurely in the first place.
+
+Keep in mind that people in the development community do not have to
+see your patch immediately after you wrote it.  Instead of seeing
+the initial version right now, that you will follow up with several
+updated "oops, I like this version better than the previous one"
+versions over 2 days, reviewers would much appreciate if a single
+more polished version came 2 days late and that version, that
+contains fewer mistakes, were the only one they need to review.
+
 [[reviewing]]
 === Responding to Reviews
 
-- 
2.39.1-308-g56c8fb1e95

