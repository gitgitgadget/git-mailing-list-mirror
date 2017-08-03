Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A422047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbdHCJVv (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:21:51 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34626 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751933AbdHCJUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:09 -0400
Received: by mail-wr0-f196.google.com with SMTP id o33so575817wrb.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i5pCE3/7MsK7P8SlyEgnwbzESgovnYft/GxvCjJ+4Ao=;
        b=ECIpbdgucglyfUFdO6BShCvA9byA1qeAsSIcSGGs9Oqsgk44iPBZxBpFcTmPtyaAvg
         zL6m+vgRKr2Br+wzw3I3qid/eNlSeu9KlqYEE+BaNHzK7OKIpzms+eF29DAJYsQdSOpK
         ephdWr48BRsMsNgRQx4R80poPrc6Vyh+Hc19gYxqHH2hkUWE5VP8I4VBRt7TCO6+49p5
         1ERX4w4BlS7lduklFx7ibamFqs787bw9MWqXXgwUKzPGZXsjyVAehvECC1y6G9COd2g8
         ML0UJjBF2TsAYJulePBSczSrDhNr935m42w4F517CLvY9c7ygjMKif+f2IEtjfP8xNE1
         9+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i5pCE3/7MsK7P8SlyEgnwbzESgovnYft/GxvCjJ+4Ao=;
        b=IcloeToESYt7xz3aSTWx0QRKxHxBY43DMJh5bTctV1oMqCN6b8BlX1ATFhjtVpfqbJ
         4WnltzoV2lPyXT06en2IVd6s0BlEAuwzyBFiqqXurrB6W5M5TYg0rIsrTe3DNsGotk70
         rqtuNxRiZRGYGBzrAaWyvGW4RrVe2SRdAlSpn/04YZXQVtGZwihR9MDJDpJ92HPqHbJj
         DbAvaf/777fc185X4qFHufk2F8TLu90OfktB+uf5nFnmUsimf4I4MmRjEntTVbCr1isS
         6Xi+XoCE8Z9tBPFMvXdpZTfHASmhMyTbi8hGD3d72a9lewTinB3E2BR62qE/ASOayBca
         3aew==
X-Gm-Message-State: AIVw113KqEHKhrKh6AJORrCYU+89ScxHRULwPI2lrRbnuIT/yadc7TKn
        MZ1ZDim99jSbD/vR
X-Received: by 10.223.161.200 with SMTP id v8mr777015wrv.135.1501752007795;
        Thu, 03 Aug 2017 02:20:07 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:07 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 25/40] external-odb: add 'get_direct' support
Date:   Thu,  3 Aug 2017 11:19:11 +0200
Message-Id: <20170803091926.1755-26-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This implements the 'get_direct' capability/instruction that makes
it possible for external odb helper scripts to pass blobs to Git
by directly writing them as loose objects files.

It is better to call this a "direct" mode rather than a "fault-in"
mode as we could have the same kind of mechanism to "put" objects
into an external odb, where the odb helper would access blobs it
wants to send to an external odb directly from files, but it
would be strange to call that a fault-in mode too.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 21 ++++++++++++++++++++-
 external-odb.h |  1 +
 odb-helper.c   | 27 +++++++++++++++++++++++++--
 odb-helper.h   |  1 +
 4 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 52cb448d01..31d21bfe04 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -96,7 +96,8 @@ int external_odb_get_object(const unsigned char *sha1)
 		int ret;
 		int fd;
 
-		if (!odb_helper_has_object(o, sha1))
+		if (!(o->supported_capabilities & ODB_HELPER_CAP_GET_RAW_OBJ) &&
+		    !(o->supported_capabilities & ODB_HELPER_CAP_GET_GIT_OBJ))
 			continue;
 
 		fd = create_object_tmpfile(&tmpfile, path);
@@ -122,6 +123,24 @@ int external_odb_get_object(const unsigned char *sha1)
 	return -1;
 }
 
+int external_odb_get_direct(const unsigned char *sha1)
+{
+	struct odb_helper *o;
+
+	if (!external_odb_has_object(sha1))
+		return -1;
+
+	for (o = helpers; o; o = o->next) {
+		if (!(o->supported_capabilities & ODB_HELPER_CAP_GET_DIRECT))
+			continue;
+		if (odb_helper_get_direct(o, sha1) < 0)
+			continue;
+		return 0;
+	}
+
+	return -1;
+}
+
 int external_odb_put_object(const void *buf, size_t len,
 			    const char *type, unsigned char *sha1)
 {
diff --git a/external-odb.h b/external-odb.h
index 3e0e6d0165..247b131fd5 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -4,6 +4,7 @@
 const char *external_odb_root(void);
 int external_odb_has_object(const unsigned char *sha1);
 int external_odb_get_object(const unsigned char *sha1);
+int external_odb_get_direct(const unsigned char *sha1);
 int external_odb_put_object(const void *buf, size_t len,
 			    const char *type, unsigned char *sha1);
 
diff --git a/odb-helper.c b/odb-helper.c
index 0603993057..b1f5464214 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -405,14 +405,37 @@ static int odb_helper_get_git_object(struct odb_helper *o,
 	return 0;
 }
 
+int odb_helper_get_direct(struct odb_helper *o,
+			  const unsigned char *sha1)
+{
+	struct odb_helper_object *obj;
+	struct odb_helper_cmd cmd;
+
+	obj = odb_helper_lookup(o, sha1);
+	if (!obj)
+		return -1;
+
+	if (odb_helper_start(o, &cmd, 0, "get_direct %s", sha1_to_hex(sha1)) < 0)
+		return -1;
+
+	if (odb_helper_finish(o, &cmd))
+		return -1;
+
+	return 0;
+}
+
 int odb_helper_get_object(struct odb_helper *o,
 			  const unsigned char *sha1,
 			  int fd)
 {
+	if (o->supported_capabilities & ODB_HELPER_CAP_GET_GIT_OBJ)
+		return odb_helper_get_git_object(o, sha1, fd);
 	if (o->supported_capabilities & ODB_HELPER_CAP_GET_RAW_OBJ)
 		return odb_helper_get_raw_object(o, sha1, fd);
-	else
-		return odb_helper_get_git_object(o, sha1, fd);
+	if (o->supported_capabilities & ODB_HELPER_CAP_GET_DIRECT)
+		return 0;
+
+	BUG("invalid get capability (capabilities: '%d')", o->supported_capabilities);
 }
 
 int odb_helper_put_object(struct odb_helper *o,
diff --git a/odb-helper.h b/odb-helper.h
index 318e0d48dc..f2fd2b7c9c 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -33,6 +33,7 @@ int odb_helper_init(struct odb_helper *o);
 int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1);
 int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
 			  int fd);
+int odb_helper_get_direct(struct odb_helper *o, const unsigned char *sha1);
 int odb_helper_put_object(struct odb_helper *o,
 			  const void *buf, size_t len,
 			  const char *type, unsigned char *sha1);
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

