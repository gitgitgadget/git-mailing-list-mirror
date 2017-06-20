Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22BD820401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbdFTH5i (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:57:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32832 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbdFTH42 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id f90so21270179wmh.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ILju6zokfHwwCzvdX/xgphSO3tQVecRB31ZWh1l2lkk=;
        b=Rtd4zI1RBFClJfxFOKLIADm1HdAhYVFKoEPu5r24pZEKYbXDYmtetrTx2LDnyn7Wyd
         nixbIbw0z5SlDc7ikBn2Yv7TVnKaQikQDVJoBG9EiWIz7xxV8136hSAZ5/SIFrK5Lbko
         RLR9aT+suIYp9LympXF+ZBX0EcFCbaV4gqzUoiLrmPTfvkbGnAkr1Hizs6zQ+3KgvzCr
         0zhRzbomM9kOptl/DFBe8DnjLbaNJJlAEQIT+Tbg5Xe5j7nViLS9EgCPH3sit56g0SDD
         rVTcxsT6vz8c1wbT9j6wxGnmGVT2wlao3/vru7CzVXN2USurw9Wfnup/jzJmbKlj0Pzb
         ZODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ILju6zokfHwwCzvdX/xgphSO3tQVecRB31ZWh1l2lkk=;
        b=UU+0sRuTpC4YIqFxMrRvSDpI66UCR6co7HU7mjmuI4o83UEmQmcZh/tTzz42hZasmj
         ZNKR4nAXvdHEpBIkrDf/19hdlp75naxgH7ZxWX9gQke8Up69mnIakVJ7w7WuhYz28hWs
         TOi9lt8AYnU36YX6m20vSW+7Nz8uYTaG760nSOWObJKfFWgSblA7q8CJWovDDv2UUkDo
         aALMnWAl4jeCOHMhtqW/OxUL1dlG6okuoUSUvTJuFIoU5AYHfTf/bajfablyYTi8nvfJ
         kbxdcxVu8a9Is2589Bk2HVMhGi/7Jfu+p4iiX8UXzFNPYSWcxwBMEsK6IxlIyIbX+agV
         NCkg==
X-Gm-Message-State: AKS2vOxw3rWwTJdujdcPkBWgpK7LG7X5NO9x90MvaV8ogIlxvbyKqNfS
        o7z58ms9a7HqDb2l
X-Received: by 10.28.144.20 with SMTP id s20mr1756154wmd.35.1497945382273;
        Tue, 20 Jun 2017 00:56:22 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:21 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 25/49] external-odb: add external_odb_fault_in_object()
Date:   Tue, 20 Jun 2017 09:54:59 +0200
Message-Id: <20170620075523.26961-26-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 21 ++++++++++++++++++++-
 external-odb.h |  1 +
 odb-helper.c   |  7 +++----
 odb-helper.h   |  1 +
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 0b6e443372..502380cac2 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -113,7 +113,8 @@ int external_odb_fetch_object(const unsigned char *sha1)
 		int ret;
 		int fd;
 
-		if (!odb_helper_has_object(o, sha1))
+		if (o->fetch_kind != ODB_FETCH_KIND_PLAIN_OBJECT &&
+		    o->fetch_kind != ODB_FETCH_KIND_GIT_OBJECT)
 			continue;
 
 		fd = create_object_tmpfile(&tmpfile, path);
@@ -139,6 +140,24 @@ int external_odb_fetch_object(const unsigned char *sha1)
 	return -1;
 }
 
+int external_odb_fault_in_object(const unsigned char *sha1)
+{
+	struct odb_helper *o;
+
+	if (!external_odb_has_object(sha1))
+		return -1;
+
+	for (o = helpers; o; o = o->next) {
+		if (o->fetch_kind != ODB_FETCH_KIND_FAULT_IN)
+			continue;
+		if (odb_helper_fault_in_object(o, sha1) < 0)
+			continue;
+		return 0;
+	}
+
+	return -1;
+}
+
 int external_odb_for_each_object(each_external_object_fn fn, void *data)
 {
 	struct odb_helper *o;
diff --git a/external-odb.h b/external-odb.h
index 53879e900d..1b46c49e25 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -4,6 +4,7 @@
 const char *external_odb_root(void);
 int external_odb_has_object(const unsigned char *sha1);
 int external_odb_fetch_object(const unsigned char *sha1);
+int external_odb_fault_in_object(const unsigned char *sha1);
 
 typedef int (*each_external_object_fn)(const unsigned char *sha1,
 				       enum object_type type,
diff --git a/odb-helper.c b/odb-helper.c
index 24dc5375cb..5fb56c6135 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -347,9 +347,8 @@ static int odb_helper_fetch_git_object(struct odb_helper *o,
 	return 0;
 }
 
-static int odb_helper_fetch_fault_in(struct odb_helper *o,
-				     const unsigned char *sha1,
-				     int fd)
+int odb_helper_fault_in_object(struct odb_helper *o,
+			       const unsigned char *sha1)
 {
 	struct odb_helper_object *obj;
 	struct odb_helper_cmd cmd;
@@ -377,7 +376,7 @@ int odb_helper_fetch_object(struct odb_helper *o,
 	case ODB_FETCH_KIND_GIT_OBJECT:
 		return odb_helper_fetch_git_object(o, sha1, fd);
 	case ODB_FETCH_KIND_FAULT_IN:
-		return odb_helper_fetch_fault_in(o, sha1, fd);
+		return 0;
 	default:
 		BUG("invalid fetch kind '%d'", o->fetch_kind);
 	}
diff --git a/odb-helper.h b/odb-helper.h
index e3ad8e3316..2dc6d96c40 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -30,6 +30,7 @@ struct odb_helper *odb_helper_new(const char *name, int namelen);
 int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1);
 int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
 			    int fd);
+int odb_helper_fault_in_object(struct odb_helper *o, const unsigned char *sha1);
 int odb_helper_for_each_object(struct odb_helper *o,
 			       each_external_object_fn, void *);
 int odb_helper_write_object(struct odb_helper *o,
-- 
2.13.1.565.gbfcd7a9048

