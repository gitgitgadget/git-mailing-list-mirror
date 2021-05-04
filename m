Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F0CC433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F92613AA
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhEDRVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 13:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhEDRVH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 13:21:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9906C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 10:20:12 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m37so7851374pgb.8
        for <git@vger.kernel.org>; Tue, 04 May 2021 10:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RzXGThgwVUziPQCBJrRiOr/TWeTY7hXHygpIFEFRvjI=;
        b=KUbECvS+gTalVDuz1N7F6bqNHye//taV86z5b/UNBqzuEaTLsEUNAvqr4pKh+uTlC0
         LSSIn3uuadPj/a68QFIjfzQ4gm1L0sIYyW71sdR8C7Yed8qcF0DzvGwZDvy2CnGf0adx
         s7F4wK8KZRYt+biuc4TwXAsGDrBYu5ZsmC64ZPxiFBoGaCNNl/qvy11d5/tc0BJOHfvM
         iZp8qIAQ7xeO62F+prKLV2RtPfDHtEgcDJwF7yImkzkvNU0/ITfPJnUDCmkdwwSMMnIr
         bCEDhgBeXKsy4zQ35r/JYSSa4D7E30+lgjfgpbo8eEqs7t3Aj5LbV+3HWhNBHF4aBUtF
         ThxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RzXGThgwVUziPQCBJrRiOr/TWeTY7hXHygpIFEFRvjI=;
        b=m80YHefA6neRFGgTZqFnzVELEdBk2vhyquWO/CehnxouN6sA626Sq0zLRgrU24zT+G
         iFgH+3bd03tqZAMN7h/0YWPMNoWsnrHw0QShA4J/w1FJe4u9V8mmsdXxwTdQr0YJlle+
         VXecf+vJ+tOFFGhuIFBP5wTHONtybWu8u3xmwMgyT3OOYEf7uD1tvDlOdS4Q1LTV2a73
         Q7LSpuBdcC7LGrhjRAvotr2HqRsSyUDfPFYpdBunvRVuIOB5rPvyIjTyF6iP/iQPPsOY
         SLyXpwB65CYrSJu+5HqZ0PJhntPhIBA+m3Kd/55KOLTAwgIRuBM+42ZCL/0nErfuT9n6
         if1A==
X-Gm-Message-State: AOAM533v8cMONiYMIsUBQ4uCI02ZFP8+iFp2wRP6glPohvRShQgQ3zaC
        Pjf9TsRSnTl0IkpgdOstRKHcuSnch+ttyg==
X-Google-Smtp-Source: ABdhPJzslHzK4poRurCM9gDRho9X90Gh6XprPLubKl8Avjk3uy7gfp5DDzHH95w4/DwgwAcHUPmhxw==
X-Received: by 2002:a17:90b:d92:: with SMTP id bg18mr23291582pjb.145.1620148812096;
        Tue, 04 May 2021 10:20:12 -0700 (PDT)
Received: from athena.localdomain ([27.75.102.31])
        by smtp.gmail.com with ESMTPSA id a18sm4019267pgg.51.2021.05.04.10.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 10:20:11 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/5] Teach am/mailinfo to process quoted CR
Date:   Wed,  5 May 2021 00:19:57 +0700
Message-Id: <cover.1620148732.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.500.gbc6bbdd36b
In-Reply-To: <20210421013404.17383-1-congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an SMTP server receives an 8-bit email message, possibly with only
LF as line ending, some of those servers decide to change said LF to
CRLF.

Some mailing list software, when receives an 8-bit email message,
decide to encoding such message in base64 or quoted-printable.

This series try to help users of such softwares deal with such patches.

This series is a complete rewrite of v1.
Hence, no {inter,range}-diff.

Sorry for the long delay, life carries me away from Git.

[1]:
https://nmbug.notmuchmail.org/nmweb/show/m2lf9ejegj.fsf%40guru.guru-group.fi

Đoàn Trần Công Danh (5):
  mailinfo: avoid magic number in option parsing
  mailinfo: warn if CR found in base64/quoted-printable email
  mailinfo: skip quoted CR on user's wish
  mailinfo: strip quoted CR on users' wish
  am: learn to process quoted lines that ends with CRLF

 Documentation/git-am.txt       |  4 +++
 Documentation/git-mailinfo.txt | 19 +++++++++++-
 builtin/am.c                   | 56 ++++++++++++++++++++++++++++++++++
 builtin/mailinfo.c             | 13 +++++---
 mailinfo.c                     | 47 ++++++++++++++++++++++++++--
 mailinfo.h                     | 10 ++++++
 t/t4258-am-quoted-cr.sh        | 37 ++++++++++++++++++++++
 t/t4258/mbox                   | 12 ++++++++
 t/t5100-mailinfo.sh            | 21 +++++++++++++
 t/t5100/quoted-cr-info         |  5 +++
 t/t5100/quoted-cr-msg          |  2 ++
 t/t5100/quoted-cr-patch        | 22 +++++++++++++
 t/t5100/quoted-cr.mbox         | 22 +++++++++++++
 13 files changed, 262 insertions(+), 8 deletions(-)
 create mode 100755 t/t4258-am-quoted-cr.sh
 create mode 100644 t/t4258/mbox
 create mode 100644 t/t5100/quoted-cr-info
 create mode 100644 t/t5100/quoted-cr-msg
 create mode 100644 t/t5100/quoted-cr-patch
 create mode 100644 t/t5100/quoted-cr.mbox

-- 
2.31.1.500.gbc6bbdd36b

