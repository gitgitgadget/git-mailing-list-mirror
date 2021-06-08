Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F98C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 02:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E52F60FEE
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 02:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhFHCCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 22:02:10 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:40901 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFHCCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 22:02:09 -0400
Received: by mail-pj1-f50.google.com with SMTP id mp5-20020a17090b1905b029016dd057935fso4911909pjb.5
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 19:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EPhhOi/fu94KLyGoR0Tv5xpUKx0k2+xmzgCu2dd88Ag=;
        b=oUbIE49bobmo3q0LyCdNQqGira5U5H9gPeeooPPnCRzJlFzO09qYabA7eyS4ibKEfl
         69OkiZGe+zn3HI/v0oPMPF+DmEGZEq0S2V7lT3UxCM/R5HL25YckiZTnMsJ0V5XgfmWa
         /eoO8wvegwQEynQgnZMvJPHgBd2Ef4cydkm/S0g0jY0IhozMRE2pxHhn65fnJpJltHP+
         pvvgaNUtGLZ74I+DKM1mzr6SgG69MIIDFeBjhCx+9ncoXaO53N+sjLHq2wg6v8MAp66/
         NyCiMIkRRM/nYlmEUw1MbouE5BXycdPyLRrEb66udvebwDObbpdNl8iQbJ2DOpS8JCAH
         cVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EPhhOi/fu94KLyGoR0Tv5xpUKx0k2+xmzgCu2dd88Ag=;
        b=Lp70WN5J3T5QcJ8f51bnN4XoW13RzMJNpVM7i5m+DneTvejWo+6YD6sBBB0/cQ+I0f
         Nro0LV9lXEjn1tIVtZa7ZqRyEhAgw0+vMXlZk4zbeqlCk080UmGM5mtA+LxMooEyepN2
         jE+A4czvJ41CjpL3wXJHPqP4GEZ4tgafpMJPJ/YH1AA8mh4rITPfZWzQtWsZQ4OTYV8g
         phcMEhDYD+kYPURIrhOQz7y6vuCreyLizgvO4LeQcI9C/vLal/Ia/IJ22ieN8BqVIm4O
         K4NXExFOYlmcPUj9pLv6DdQW6BHZyocjmF9JLwMOlWq488kyRq+90wiH0UwsbRRBy3rC
         mAFQ==
X-Gm-Message-State: AOAM531eVZzMdNI1EvML+MF1E/pTpU7S61xvdV3QE/bvIdZXJhQCcIuB
        AOf5tBKGYdypklltlz2b+tnB7M4+U0AbOA==
X-Google-Smtp-Source: ABdhPJztTaWvdGcaOG0130AvGWF7eFfHJtgzoe3u2OpKB9vxtWYW0ZMx6Z4OcwXjX6LQLbZ0zKwdRA==
X-Received: by 2002:a17:902:9348:b029:f0:d51a:7a4c with SMTP id g8-20020a1709029348b02900f0d51a7a4cmr20947343plp.60.1623117544375;
        Mon, 07 Jun 2021 18:59:04 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id z18sm6798680pfn.37.2021.06.07.18.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:59:04 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andy AO <zen96285@gmail.com>
Subject: [PATCH] doc/log: correct default for --decorate
Date:   Tue,  8 Jun 2021 08:58:40 +0700
Message-Id: <20210608015840.24532-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.5.gc7fdd17fde
In-Reply-To: <pull.1030.git.git.1622440856607.gitgitgadget@gmail.com>
References: <pull.1030.git.git.1622440856607.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There're two different default options for log --decorate:
* Should `--decorate` be given without any arguments, it's default to
  `short`
* Should neither `--decorate` nor `--no-decorate` be given, it's default
  to the `log.decorate` or `auto`.

We documented the former, but not the latter.

Let's document them, too.

Reported-by: Andy AO <zen96285@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

 I'm reluctant to send this out since I would like to see Andy get familiar
 with the list.  However, it's a while since the original patch.

 Documentation/git-log.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 1bbf865a1b..0498e7bacb 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -39,7 +39,9 @@ OPTIONS
 	full ref name (including prefix) will be printed. If 'auto' is
 	specified, then if the output is going to a terminal, the ref names
 	are shown as if 'short' were given, otherwise no ref names are
-	shown. The default option is 'short'.
+	shown. The option `--decorate` is short-hand for `--decorate=short`.
+	Default to configuration value of `log.decorate` if configured,
+	otherwise, `auto`.
 
 --decorate-refs=<pattern>::
 --decorate-refs-exclude=<pattern>::
-- 
2.32.0.5.gc7fdd17fde

