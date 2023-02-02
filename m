Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B90C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjBBJcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjBBJcq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:32:46 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FC95AA70
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:32:44 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o36so891962wms.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6Z4S3JBJLdX+kCju7Fvvw8qYOVc1/ogfhUYTn6PSZY=;
        b=LtZc+GWsMI0tszErV8xnggDPkJdCDXbdR8eRCCSucZkGgPzidUGbhNKITK65jRa/BT
         wlVQ2wN/XpQtOz+4QfzUILwjq3kEp9DlbUakGxWrfc+arAM8Bq/r1+Fm+3izqL3mt3JT
         e4St8ge/064R5ynwJ4N0o2s+NzZijnYvKepZihxzDPFkQ2zjy7n5lH2wWQGmmybmCjSE
         pHTPjnlYsB15N6d2hf8ENCvQuJT5UsGq6uF7PlEt+8w4uC4qSA2fhrQExKMtetm8pycU
         ReDbxs2qu2/q7X8oafT3U/Uwrc29u/61XCBmbh5SonOj2LDQvf93R3FEhNVxhO8wd5nX
         1O5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6Z4S3JBJLdX+kCju7Fvvw8qYOVc1/ogfhUYTn6PSZY=;
        b=D+rcgljRSbDc2b/rsFe7xQfRvP1yAWmISr+Opo7VUfbM81f9jzmRORm5G/La2iPmkk
         TQIrZM8c9YvnWD9Wm0qxkgwA582QntJuYByF1Ked8I//WitIAiezXxZQLNnrnttLVzSn
         YupwdAdS7kEOMswl1JjkORD/VdnEg3I/l0h81VlztbdbhIgaiP9LvvLP44NcL4+TVaOp
         bTowiGtBqHMZJf6vuMp/lC2h3dmW1WeNTmH//A3vuyXA/h9R9HFy9POqiWUG7qpRx5id
         DBc15UPcoVJdvd+6XIa//wa8Zr4ZZtTLTkPXytBdM/qUH6XRp9n89S6aReZnN0mZAaV7
         H2VA==
X-Gm-Message-State: AO0yUKXlD/JKxx7naxvMV9XPd2EejVkzu9pcQwjN1HFbPxgX5syxxJY4
        TbCPvVLZzaJxLWHyhUsZTSiDjtiSNzvY6zuN
X-Google-Smtp-Source: AK7set/iYMX2IVQn/2R/5bi3aoaq8TyUka2m8ta19F7Cnh6BUGFeJNgspHiJAgISsZpukxiRSgcJRg==
X-Received: by 2002:a05:600c:524d:b0:3cf:7197:e68a with SMTP id fc13-20020a05600c524d00b003cf7197e68amr5192486wmb.18.1675330362386;
        Thu, 02 Feb 2023 01:32:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003cf71b1f66csm4238753wmc.0.2023.02.02.01.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:32:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/9] archiver API: make the "flags" in "struct archiver" an enum
Date:   Thu,  2 Feb 2023 10:32:23 +0100
Message-Id: <patch-3.9-9d1a68b5282-20230202T093212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com> <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the "#define" pattern in the archiver.h to use a new "enum
archiver_flags". This isn't a functional change, but will make adding
new flags in a subsequent commit easier to reason about.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/archive.h b/archive.h
index 08bed3ed3af..6b51288c2ed 100644
--- a/archive.h
+++ b/archive.h
@@ -36,13 +36,15 @@ const char *archive_format_from_filename(const char *filename);
 
 /* archive backend stuff */
 
-#define ARCHIVER_WANT_COMPRESSION_LEVELS 1
-#define ARCHIVER_REMOTE 2
-#define ARCHIVER_HIGH_COMPRESSION_LEVELS 4
+enum archiver_flags {
+	ARCHIVER_WANT_COMPRESSION_LEVELS = 1<<0,
+	ARCHIVER_REMOTE = 1<<1,
+	ARCHIVER_HIGH_COMPRESSION_LEVELS = 1<<2,
+};
 struct archiver {
 	const char *name;
 	int (*write_archive)(const struct archiver *, struct archiver_args *);
-	unsigned flags;
+	enum archiver_flags flags;
 	char *filter_command;
 };
 void register_archiver(struct archiver *);
-- 
2.39.1.1392.g63e6d408230

