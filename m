Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC051F404
	for <e@80x24.org>; Fri, 16 Mar 2018 19:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753237AbeCPT20 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 15:28:26 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40805 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752988AbeCPT2N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 15:28:13 -0400
Received: by mail-lf0-f66.google.com with SMTP id e5-v6so12923086lfb.7
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Btpy7eW3TAkjTDl5Dqz60pSaGMqKEt/Vwc38xSweCC4=;
        b=MbT10Dl8IjMp56cpAm/HGPoW+6qm3xZIZGPmYPeqIia+87HbmB6HQzX8es0HEsqymf
         4Zv9HMXgwhMe4xcbFP9nAwc9qC+QWCP5i1D8hIIGnTeWcPbhDCuA3+p//GL28QkZYJEg
         PZcmrcZbAoXFJK2lLay99AV7NBrPLK1u/XXc6b+PL4+XHgH0wa1/Hka4+PtLs4WYpN+4
         01OA3E6gdyqmCFSV8dFXGEfqw9WYwUi4O81thuLBgVtBPV1ddRePCDmqoHmqeE44OSGz
         sRyuCXpjyfsjICKiI5v/zbAMV0hnclVvhtdFDUi6DNly1li8RcJ4zfzLGTOmcchscwlP
         lB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Btpy7eW3TAkjTDl5Dqz60pSaGMqKEt/Vwc38xSweCC4=;
        b=DO2Nrk2eFpd5GS5gaEPEcfQgZIzHk/gqyGf5CrJRW2RmZpcyJuVX25Utnu3deNEIeP
         cNfVMGE4CpMnpqPZbat11TyGk5nnln1w6Gon1sVJCPq5q1+rvD29QcGr6Jzpu5c7UDT+
         xveM0yM7dpZL9h6GG38goEZPplIKCDrGiBPypQm/yPLluZQQsuTJZdHUbPmSHggvEFA9
         U0GXC4XY6bkIyoPlfvVnU1gTAhSMCAyW9PeYOcJ5ZBr3iHPnqwfjYH7nNNCwT1kUPSUo
         AS8nFUvuHw1QJCZlj+UcncW16G62RTF6DFThjFyTvGEg9EuKGsRqRzuTkvABdZWTpVX4
         lA9Q==
X-Gm-Message-State: AElRT7Hcr+iMvBbi6jpUKSXBt4K2d2Va1X/+/Kwzn7ukDDCjDBmhxT4a
        1aNwaB/OHgEnbR/sFTga1kc=
X-Google-Smtp-Source: AG47ELvTms7+6mi+Q65Ll2tGHd7R+pmssI0jCG6uIdQesQrCYwjvCekdWQVE1G8wOMWAYxxWK4jnNA==
X-Received: by 2002:a19:136a:: with SMTP id j103-v6mr2152476lfi.19.1521228492262;
        Fri, 16 Mar 2018 12:28:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm1766085lja.41.2018.03.16.12.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 12:28:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 5/7] gc: handle a corner case in gc.bigPackThreshold
Date:   Fri, 16 Mar 2018 20:27:43 +0100
Message-Id: <20180316192745.19557-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180316192745.19557-1-pclouds@gmail.com>
References: <20180306104158.6541-1-pclouds@gmail.com>
 <20180316192745.19557-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This config allows us to keep <N> packs back if their size is larger
than a limit. But if this N >= gc.autoPackLimit, we may have a
problem. We are supposed to reduce the number of packs after a
threshold because it affects performance.

We could tell the user that they have incompatible gc.bigPackThreshold
and gc.autoPackLimit, but it's kinda hard when 'git gc --auto' runs in
background. Instead let's fall back to the next best stategy: try to
reduce the number of packs anyway, but keep the base pack out. This
reduces the number of packs to two and hopefully won't take up too
much resources to repack (the assumption still is the base pack takes
most resources to handle).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt | 5 +++++
 builtin/gc.c             | 9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c12c58813c..ce40112e31 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1554,6 +1554,11 @@ gc.bigPackThreshold::
 	`git gc` is run. This is very similar to `--keep-base-pack`
 	except that all packs that meet the threshold are kept, not
 	just the base pack. Defaults to zero.
++
+Note that if the number of kept packs is more than gc.autoPackLimit,
+this configuration variable is ignored, all packs except the base pack
+will be repacked. After this the number of packs should go below
+gc.autoPackLimit and gc.bigPackThreshold should be respected again.
 
 gc.logExpiry::
 	If the file gc.log exists, then `git gc --auto` won't run
diff --git a/builtin/gc.c b/builtin/gc.c
index c0f1922c24..140c1bb7dd 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -336,9 +336,14 @@ static int need_to_gc(void)
 	if (too_many_packs()) {
 		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
 
-		if (big_pack_threshold)
+		if (big_pack_threshold) {
 			find_base_packs(&keep_pack, big_pack_threshold);
-		else {
+			if (keep_pack.nr >= gc_auto_pack_limit) {
+				big_pack_threshold = 0;
+				string_list_clear(&keep_pack, 0);
+				find_base_packs(&keep_pack, 0);
+			}
+		} else {
 			struct packed_git * p = find_base_packs(&keep_pack, 0);
 			uint64_t mem_have, mem_want;
 
-- 
2.16.2.903.gd04caf5039

