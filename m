Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555441F576
	for <e@80x24.org>; Thu,  1 Mar 2018 09:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966787AbeCAJLg (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 04:11:36 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36788 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966782AbeCAJLd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 04:11:33 -0500
Received: by mail-pl0-f68.google.com with SMTP id 61-v6so3299085plf.3
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 01:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1Yox+2ulb6tK6RsNM+WwaC9pvJ22h7VgyP8YfjQrhU=;
        b=lgopUpBqsjvfWFO41P8FwTzfdygutl/O2AsGYxS82eGQhjAAA5TuYqvvIh0aLEOWmg
         yWQu1HOZPsWBIVydsLZkzeGIrgiDXOvTDwifEyMBFeQtOGmTNzEYPSvnKNnT3B8/0jrU
         F7nuPLtLDsoJ4bp3Myugc/kyI+k+SXsE+8Auw1V1S9gcEFIMqq2QzOKoQXkMmagCrWC/
         7GyHUJuJDNppcZF5SmX2tZFnBq3f+GWqB0UZASUqdi69g+gWqniCIBboCBuA/EJeYsBe
         4iXHV8PjiMq2DzO/f8OrPsRWHL9wvkiCA/u5FIFnfnIsF5i6T018uNjecEKyLdzpHhdL
         MoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1Yox+2ulb6tK6RsNM+WwaC9pvJ22h7VgyP8YfjQrhU=;
        b=Xnw9BxN/Qx90k6yqjs2cUxXHzG+JBAqxaaMsWxzttKkMSzDPBVztiuzdD1xKecv+I1
         9a+MekpCDEsBJnNE9KHC1eOsOEdb0ZJ/AtCXjnrI+epUucCMxzSqXNnbNXtUxWDr05cY
         tTrsswRWrOyujlpWUMgXTIfPEVrJvEeFwQMBctVOUBFowlFYjUY8pOSgJvleWV+pyEaq
         WuXyt+eAvSOB8twJoDzaKCTkafKAM0eoo+JHkeqc6TcWq0xCCamF3Ozz9jk0SfzeI4QQ
         NjzAPygPamHSExc+5BydkMRE6FzGC4buDI5vsFFbldf4/UoT3N9PkZNA8VONEwvqveAM
         uY2Q==
X-Gm-Message-State: APf1xPC75YayIx3hdcXYXi17cz9cskNTxYger3AzMB/QRPcTxzc0tjDe
        GHrkjf4QZ2p/58wwV6ZYwyAMtQ==
X-Google-Smtp-Source: AG47ELv5Q5rQBtUXNPX4x/bWPpqdQX/O0pYQiunHaHrBt3t43PA3922Apfk4IIVSR9IhSmGhl9KcQw==
X-Received: by 2002:a17:902:71c9:: with SMTP id t9-v6mr1265985plm.107.1519895489751;
        Thu, 01 Mar 2018 01:11:29 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id z127sm7596541pfb.130.2018.03.01.01.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 01:11:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Mar 2018 16:11:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/11] pack-objects: use bitfield for object_entry::depth
Date:   Thu,  1 Mar 2018 16:10:45 +0700
Message-Id: <20180301091052.32267-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180301091052.32267-1-pclouds@gmail.com>
References: <20180228092722.GA25627@ash>
 <20180301091052.32267-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This does not give us any saving due to padding. But we will be able
to save once we cut 4 bytes out of this struct in a subsequent patch.

Because of struct packing from now on we can only handle max depth
4095 (or even lower when new booleans are added in this struct). This
should be ok since long delta chain will cause significant slow down
anyway.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 4 ++++
 pack-objects.h         | 6 ++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a4dbb40824..cfd97da7db 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3068,6 +3068,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout != !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
 
+	if (depth > (1 << OE_DEPTH_BITS))
+		die(_("delta chain depth %d is greater than maximum limit %d"),
+		    depth, (1 << OE_DEPTH_BITS));
+
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
 		use_internal_rev_list = 1;
diff --git a/pack-objects.h b/pack-objects.h
index fca334ab4d..3941e6c9a6 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -2,6 +2,7 @@
 #define PACK_OBJECTS_H
 
 #define OE_DFS_STATE_BITS 2
+#define OE_DEPTH_BITS 12
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -43,10 +44,7 @@ struct object_entry {
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
-
-	/* XXX 20 bits hole, try to pack */
-
-	int depth;
+	unsigned depth:OE_DEPTH_BITS;
 
 	/* size: 120, padding: 4 */
 };
-- 
2.16.1.435.g8f24da2e1a

