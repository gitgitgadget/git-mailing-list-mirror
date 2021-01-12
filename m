Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45338C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20C723121
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438143AbhALVhc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436885AbhALUTp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:45 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A436C061794
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:19:02 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r4so3306212wmh.5
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rbg8n89Lbafup0iBredgS8KADE8Pnpe5fipX60ShT18=;
        b=GPkvUvKg2FHMWJ9cYAtxqFESLyqFLcFIoYEE/9iHOf6+oJrewMgTmb1nDjUrm8IYHC
         QMRiPZfP5AlLSVQXCGwMSsBOjw+xPJ5M35qR2/8L5GQf9vIIJepAIdHsqsiXhCtPMMh2
         CKaxFG2jDJQDkzRqU13/qoDpNev7RpMAGq1JBltX3A7CY3mlC8+sJ+vVDSbBIbN4kwZP
         IGIGcPwk8vXtIHyED+xWNrNM3B88TwV+tJTCHek/6qRCpJ2qSXrDaDlSlbnvepr25kYl
         a5fbYhWQ1l/HhVQIEeXdHmxQkr6FXW1ExVn+IH31S1DtIhcFG2CXnSaYkQi9nkuEMVwo
         BpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rbg8n89Lbafup0iBredgS8KADE8Pnpe5fipX60ShT18=;
        b=uiM3wGyjmgZ71PCJ/fOP2J/Z1NeiiPX3e12DICruVpTQNpXYTECFUUQ71s12Gg84/y
         zXQVrxKCTl5uGHGmB2vCOnOUHJZ1Yeg0MBLEuwh331csrbZFCY9lnt2G3Cc3q7BaKmde
         /aicCwLN7M/sH6JpLLpE2HwH8SWShPrqSlzP9Wr+Gx3NckYeg8+MFu6sOduR19tq/cMK
         9ks/kHN2+qd8luHXHobcks34n58gTabBxZ5JnMr7B/L3FbV2tiBYMYNSkb5JSLeL15Mc
         utX09CMtzrPuYaySgusmzoymHTM5Y8CgZ/DhxvnTixSQtHLX7CkSoM4Z/sbfj8LCXPCh
         TitQ==
X-Gm-Message-State: AOAM531Bh+vGkGvPbl5tfJ25htp30U6F/nSG0FC7Boywxllp/ByaAV0H
        oRR7Og4VNcpLe3vKf6Q/xrg4VrjBb+WGKg==
X-Google-Smtp-Source: ABdhPJz8lmuJIwyi0bZl+ZPvih+9+8XTYqxAoS9+Hcd9YwEHOYC+wt9xmljC7I66LsEnRACHZUPOIg==
X-Received: by 2002:a1c:2646:: with SMTP id m67mr862416wmm.81.1610482740615;
        Tue, 12 Jan 2021 12:19:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 21/22] mailmap doc + tests: document and test for case-insensitivity
Date:   Tue, 12 Jan 2021 21:18:05 +0100
Message-Id: <20210112201806.13284-22-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add documentation and more tests for case-insensitivity. The existing
test only matched on the E-Mail part, but as shown here we also match
the name with strcasecmp().

This behavior was last discussed on the mailing list in the thread
starting at [1]. It seems we're keeping it like this, so let's
document it.

1. https://lore.kernel.org/git/87czykvg19.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/gitmailmap.txt |  5 +++++
 t/t4203-mailmap.sh           | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/gitmailmap.txt b/Documentation/gitmailmap.txt
index 55dfebd1b1..7f1089786d 100644
--- a/Documentation/gitmailmap.txt
+++ b/Documentation/gitmailmap.txt
@@ -49,6 +49,11 @@ commit matching the specified commit email address, and:
 which allows mailmap to replace both the name and the email of a
 commit matching both the specified commit name and email address.
 
+Both E-Mails and names are matched case-insensitively. For example
+this would also match the 'Commit Name <commit@email.xx>' above:
+--
+Proper Name <proper@email.xx> CoMmIt NaMe <CoMmIt@EmAiL.xX>
+--
 
 EXAMPLES
 --------
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index f19736fef1..89cb300f28 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -220,7 +220,21 @@ test_expect_success 'name entry after email entry, case-insensitive' '
 	      initial
 
 	EOF
+	git shortlog HEAD >actual &&
+	test_cmp expect actual &&
+
+	cat >internal.map <<-\EOF &&
+	NiCk <BuGs@CoMpAnY.Xy> NICK1 <BUGS@COMPANY.XX>
+	EOF
+
+	cat >expect <<-\EOF &&
+	NiCk (1):
+	      second
+
+	Repo Guy (1):
+	      initial
 
+	EOF
 	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
-- 
2.29.2.222.g5d2a92d10f8

