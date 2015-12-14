From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/8] submodule-config: introduce parse_generic_submodule_config
Date: Mon, 14 Dec 2015 14:54:21 -0800
Message-ID: <1450133665-3783-5-git-send-email-sbeller@google.com>
References: <1450133665-3783-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 14 23:55:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8c1t-0001H0-PH
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 23:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbbLNWzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 17:55:37 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34336 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbbLNWzC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 17:55:02 -0500
Received: by pacwq6 with SMTP id wq6so110996113pac.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 14:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YI3mnM9LJMW1yv1tjGiyGp9EZibQRXMHRiO4MB7dl/A=;
        b=QGuZwoRCZqLjlQLf2eby/+35MKczL0aTqLAXWpUuOO5Yt8fRMo6ixsm9rpkI1y/F+S
         1gkxs78M7TPqvNTrgNdQvSoINouogR+0zOXp/M2OwpbJ/CMNHvUlXEg8GO/GXusJj/m0
         rh5JS75MAS3c6QZtSuMpm3xBRJavZ/ofOPpLXTOB4MkKg60RI0xt1z7JID4lhyLEtuOP
         vKuecUIDdj+vAqTslQldJp/c4zttlsUATDIldHWgIncPt/wKFXEx7ftsQ9C+Oe98d44V
         uDOKL6QmuoTVl8sImyztIZMJWB7PTr8Evbm51Sq/wxYT86a0VTwJNPjMiY1CAEFf7bXq
         wfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YI3mnM9LJMW1yv1tjGiyGp9EZibQRXMHRiO4MB7dl/A=;
        b=j0xnUklPBen42yX308X+A3nyGbh3mB+H9pxpcFD0Y1DKUMo+klb50UW55SBPUEQR48
         ga+m4ZaWalVOBozoLUopLy9cSo/cA62JEVZIN42ij2KjJjM757OS3GBBn7AMv6i7mxme
         gB9GubdcMdPEh6nnZXPXtRdZpzIJRF1K3fRi+5KtUFTvcvv7EaHi4CjW1WYEJ3yfOafb
         UdWqCLvSPMP0UUwZEpsUuUbLwhOPvtAwaoFuNRdgqyUX6FytfEyD27tMXlzJ6BZqR1ot
         KZdmp8Lbqv7ptXANK6PfSAv55yuT8JDTYBCCvG635YQyQWjJ359MFGuVfe1Xh1Uaxj64
         jVGg==
X-Gm-Message-State: ALoCoQllxjzRJBBm8KeOBQPG0Ie0HZfA9oYzZwddqs7BnZ7Vv602CmCf3Gqq4OoZSJJ3VBnHbn3AS4hgw5MizGgTcErYFLSPoQ==
X-Received: by 10.66.141.142 with SMTP id ro14mr24003931pab.112.1450133701685;
        Mon, 14 Dec 2015 14:55:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e502:49aa:9791:cefa])
        by smtp.gmail.com with ESMTPSA id fc8sm45009376pab.21.2015.12.14.14.55.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 14:55:00 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450133665-3783-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282436>

This rewrites parse_config to distinguish between configs specific to
one submodule and configs which apply generically to all submodules.
We do not have generic submodule configs yet, but the next patch will
introduce "submodule.jobs".

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index b826841..29e21b2 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -234,17 +234,22 @@ struct parse_config_parameter {
 	int overwrite;
 };
 
-static int parse_config(const char *var, const char *value, void *data)
+static int parse_generic_submodule_config(const char *key,
+					  const char *var,
+					  const char *value,
+					  struct parse_config_parameter *me)
 {
-	struct parse_config_parameter *me = data;
-	struct submodule *submodule;
-	int subsection_len, ret = 0;
-	const char *subsection, *key;
-
-	if (parse_config_key(var, "submodule", &subsection,
-			     &subsection_len, &key) < 0 || !subsection_len)
-		return 0;
+	return 0;
+}
 
+static int parse_specific_submodule_config(const char *subsection, int subsection_len,
+					   const char *key,
+					   const char *var,
+					   const char *value,
+					   struct parse_config_parameter *me)
+{
+	int ret = 0;
+	struct submodule *submodule;
 	submodule = lookup_or_create_by_name(me->cache,
 					     me->gitmodules_sha1,
 					     subsection, subsection_len);
@@ -314,6 +319,24 @@ static int parse_config(const char *var, const char *value, void *data)
 	return ret;
 }
 
+static int parse_config(const char *var, const char *value, void *data)
+{
+	struct parse_config_parameter *me = data;
+	int subsection_len;
+	const char *subsection, *key;
+
+	if (parse_config_key(var, "submodule", &subsection,
+			     &subsection_len, &key) < 0)
+		return 0;
+
+	if (!subsection_len)
+		return parse_generic_submodule_config(key, var, value, me);
+	else
+		return parse_specific_submodule_config(subsection,
+						       subsection_len, key,
+						       var, value, me);
+}
+
 static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
 				      unsigned char *gitmodules_sha1)
 {
-- 
2.6.4.443.ge094245.dirty
