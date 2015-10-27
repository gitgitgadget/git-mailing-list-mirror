From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 8/9] submodule-config: parse_config
Date: Tue, 27 Oct 2015 11:15:52 -0700
Message-ID: <1445969753-418-9-git-send-email-sbeller@google.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 19:16:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr8nl-0003ch-IZ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 19:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbbJ0SQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 14:16:43 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36159 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964910AbbJ0SQL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 14:16:11 -0400
Received: by pacfv9 with SMTP id fv9so239723931pac.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 11:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=izIn352SAwaE3o2oACxhb1oWbKstl2j9naK8P9VlDjY=;
        b=Zt2U1jILNudFD9vD3i4Rku0kSYO80KRHVNIHgplZRfN/NQDBgjaqhSeY6QFQgdzEB4
         OwissmXa1YRG2/x393DdSo0nQKupGxNIYwAnV/SzIsXT0s+lMTM4rBS+Kr4ejXPXDZqN
         3Ta2nI7vtzM8A0vOa7I2NrZqm4nBDvu3SgykQ27nXIjCPzcsnIrdUM/fcUdkTsunlNpn
         3Smxk1TC958BW/pNoDeBK9sSIynl5QbOqeFGIkjKFuk4v0l7t0gKUEnwjPGN0kfgud5H
         NXSWr/kala1zDNDz1Xkw+7BGX6bLrmbLKjnyM90z2408I1VnK86vVbm5o66B4U2cPvOk
         tJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=izIn352SAwaE3o2oACxhb1oWbKstl2j9naK8P9VlDjY=;
        b=i5JPTy1FZwkCJ1GI8gdbsmfTxtkOFmXqg7ZRV3KnVPWWEMZfcAOHBuMjtLsJMHM1jh
         s28/pMzkjYqkYPXl5ew/D8v8KGq06iVE5to59NZhSe0I8R44w3ACAeNRVMdFm1Si93B9
         dtMo2xy3yRrj39RrXiXDbV+o+YsyiSlblpAceZ40T0+5rAwDb/1VAHByLj0laNvSFeK+
         S9/l3kiRXZk/LAh8fNYboLZ9ShK97P4ZpRplK4aj7QufvU7FV8OI8yMx968oNvYKhwln
         PfQZloImqKmUPx1yvPHZYCqcPk0AKcALiZkDfEYnURR431tWZzEKPqCGwfWus/6Sopq2
         8dlA==
X-Gm-Message-State: ALoCoQmSVLL1p0uRprLjCglFEGsBNID5t/ZEhKlWAQhKFBofOmlxlQLaD6KIcxGZxTURvWOQ48wJ
X-Received: by 10.67.4.65 with SMTP id cc1mr29260204pad.141.1445969770842;
        Tue, 27 Oct 2015 11:16:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:582c:77b:3135:2d26])
        by smtp.gmail.com with ESMTPSA id cn4sm40869769pbc.94.2015.10.27.11.16.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 11:16:10 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.283.g1a79c94.dirty
In-Reply-To: <1445969753-418-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280282>

This rewrites parse_config to distinguish between configs specific to
one submodule and configs which apply generically to all submodules.
We do not have generic submodule configs yet, but the next patch will
introduce "submodule.jobs".

Signed-off-by: Stefan Beller <sbeller@google.com>

# Conflicts:
#	submodule-config.c

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 58 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 4d0563c..1cea404 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -231,27 +231,23 @@ struct parse_config_parameter {
 	int overwrite;
 };
 
-static int parse_config(const char *var, const char *value, void *data)
+static int parse_generic_submodule_config(const char *var,
+					  const char *key,
+					  const char *value)
 {
-	struct parse_config_parameter *me = data;
-	struct submodule *submodule;
-	int subsection_len, ret = 0;
-	const char *subsection, *key;
-	char *name;
-
-	if (parse_config_key(var, "submodule", &subsection,
-			     &subsection_len, &key) < 0)
-		return 0;
-
-	if (!subsection_len)
-		return 0;
+	return 0;
+}
 
-	/* subsection is not null terminated */
-	name = xmemdupz(subsection, subsection_len);
-	submodule = lookup_or_create_by_name(me->cache,
-					     me->gitmodules_sha1,
-					     name);
-	free(name);
+static int parse_specific_submodule_config(struct parse_config_parameter *me,
+					   const char *name,
+					   const char *key,
+					   const char *value,
+					   const char *var)
+{
+	int ret = 0;
+	struct submodule *submodule = lookup_or_create_by_name(me->cache,
+							       me->gitmodules_sha1,
+							       name);
 
 	if (!strcmp(key, "path")) {
 		if (!value)
@@ -318,6 +314,30 @@ static int parse_config(const char *var, const char *value, void *data)
 	return ret;
 }
 
+static int parse_config(const char *var, const char *value, void *data)
+{
+	struct parse_config_parameter *me = data;
+
+	int subsection_len;
+	const char *subsection, *key;
+	char *name;
+
+	if (parse_config_key(var, "submodule", &subsection,
+			     &subsection_len, &key) < 0)
+		return 0;
+
+	if (!subsection_len)
+		return parse_generic_submodule_config(var, key, value);
+	else {
+		int ret;
+		/* subsection is not null terminated */
+		name = xmemdupz(subsection, subsection_len);
+		ret = parse_specific_submodule_config(me, name, key, value, var);
+		free(name);
+		return ret;
+	}
+}
+
 static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
 				      unsigned char *gitmodules_sha1)
 {
-- 
2.5.0.283.g1a79c94.dirty
