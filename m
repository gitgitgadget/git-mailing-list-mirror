Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9966C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A692520708
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="tXG+BGt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfKVUXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:23:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40316 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVUXX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 15:23:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id e17so3832886pgd.7
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 12:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m1ZdR1HvbCaSXVg+IZG5Yw+95LD9eZHHzmyu3VorlFc=;
        b=tXG+BGt7mPwnSDZU+AcTdZR0gSjaity8Ou4aUQtkHxW1M3TYNO1aTsTLlU6N8nWCFO
         AozZkF39bR20upVLN+8O+7940DDeQxx4ls0ywgwAsDS9OxI7I9DAA5HTvbX/hbzv3dDp
         mFEP8sdCR1zfkuoSHDzSFbiDRKPFNC8ExiW66TWSlbRFWJRg/P/RbpfgMXPQyWQllDrO
         /h/i9sRu9KQNTOcTvlIJXjoEK7RdmgYFRJulsYIgybnSdUJ65qgTUNM0arj+uNLdKb12
         DlcMuzjMfiqAi8twR+dC3qtypXu9GzZ1AiyYMUjlztm4WK9xoUiPfe5MQtycwqM+A9yo
         ngvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m1ZdR1HvbCaSXVg+IZG5Yw+95LD9eZHHzmyu3VorlFc=;
        b=NkrS2uCPIVdwLl+rrv1FaMxCMes758PHd7tQ1u34bkt0rBpbYb4MQjJ7me5VffWbtA
         ILggNYKN5/T4w9NZtxwxldAwd5lc35LKK5wjKTzDBkPi+RZQ5BaGfoueupxX1mx1u8kS
         Xjbru4mNBMfVwZXw2ogE3Li2x8XNzo4nSSISYv6pNY2I9J+E78wLhHziAArKsivsa2jk
         g3cBpuvy2XuT6+I0EchgTxAs0E5/K+vVseeJR1Wxe96NBE8huuJ+P2WeJFNG3+r5s3TJ
         IZ3lvpbg2jux6334utHkOXAjgjDAR3heDo6X/yp3qi1oJEfvOJyjKWfofE3JMcNfa2Bp
         w+PA==
X-Gm-Message-State: APjAAAXoL/rEUFBVpfTW6z82Q0TkwGt2kyRiOnZ2pDnzrDfz5nHv79Ke
        nN1ClISv2zOfJHPd68C+anK1YPMORQU=
X-Google-Smtp-Source: APXvYqxVjQOqb4tu2eYRAidM5Ofl/S/9eHct5q2cLSSyn/nPEaJFN+7LH81iLGRp+1Up1OaiZCq28Q==
X-Received: by 2002:a63:4f41:: with SMTP id p1mr17884549pgl.138.1574454201821;
        Fri, 22 Nov 2019 12:23:21 -0800 (PST)
Received: from localhost ([182.232.178.105])
        by smtp.gmail.com with ESMTPSA id h185sm7686657pgc.87.2019.11.22.12.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 12:23:21 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH v4 1/2] gpg-interface: refactor the free-and-xmemdupz pattern
Date:   Fri, 22 Nov 2019 20:23:11 +0000
Message-Id: <20191122202312.10120-2-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122202312.10120-1-hji@dyntopia.com>
References: <20191121234336.26300-1-hji@dyntopia.com>
 <20191122202312.10120-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit introduces a static replace_cstring() function.  This
function simplifies the continuous pattern of free-and-xmemdupz() for
GPG status line parsing.

The benefit of having it in a single helper function is that it helps
avoid the need for duplicate code that does the same thing.  It also
helps avoid potential memleaks if parsing of new status lines are
introduced in the future.

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 gpg-interface.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index d60115ca40..37162c9a43 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -105,6 +105,16 @@ static struct {
 	{ 0, "VALIDSIG ", GPG_STATUS_FINGERPRINT },
 };
 
+static void replace_cstring(char **field, const char *line, const char *next)
+{
+	free(*field);
+
+	if (line && next)
+		*field = xmemdupz(line, next - line);
+	else
+		*field = NULL;
+}
+
 static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
@@ -136,21 +146,18 @@ static void parse_gpg_output(struct signature_check *sigc)
 				/* Do we have key information? */
 				if (sigcheck_gpg_status[i].flags & GPG_STATUS_KEYID) {
 					next = strchrnul(line, ' ');
-					free(sigc->key);
-					sigc->key = xmemdupz(line, next - line);
+					replace_cstring(&sigc->key, line, next);
 					/* Do we have signer information? */
 					if (*next && (sigcheck_gpg_status[i].flags & GPG_STATUS_UID)) {
 						line = next + 1;
 						next = strchrnul(line, '\n');
-						free(sigc->signer);
-						sigc->signer = xmemdupz(line, next - line);
+						replace_cstring(&sigc->signer, line, next);
 					}
 				}
 				/* Do we have fingerprint? */
 				if (sigcheck_gpg_status[i].flags & GPG_STATUS_FINGERPRINT) {
 					next = strchrnul(line, ' ');
-					free(sigc->fingerprint);
-					sigc->fingerprint = xmemdupz(line, next - line);
+					replace_cstring(&sigc->fingerprint, line, next);
 
 					/* Skip interim fields */
 					for (j = 9; j > 0; j--) {
@@ -162,7 +169,8 @@ static void parse_gpg_output(struct signature_check *sigc)
 
 					next = strchrnul(line, '\n');
 					free(sigc->primary_key_fingerprint);
-					sigc->primary_key_fingerprint = xmemdupz(line, next - line);
+					replace_cstring(&sigc->primary_key_fingerprint,
+							line, next);
 				}
 
 				break;
-- 
2.24.GIT

