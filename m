From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 07/11] submodule-config: introduce parse_generic_submodule_config
Date: Tue,  3 Nov 2015 16:37:10 -0800
Message-ID: <1446597434-1740-8-git-send-email-sbeller@google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 01:37:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztm4y-0002iH-LQ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 01:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135AbbKDAh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 19:37:29 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36281 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756120AbbKDAh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 19:37:27 -0500
Received: by pacdm15 with SMTP id dm15so9425820pac.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 16:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HY8OJjB9KzXRIpga3HYe3BIZij+wA12HjSQmYd+XzUA=;
        b=GyKiqyoLJuzFI5csI0f1zvSVQe7vzYklLYNU+q4C4r4oXlKoC2ERKMVWnStgIN1HDO
         QrSxlU9K2NKos4zKbZUX+jUkNGotpnJPDavuXQnOcqlNzc32Y1Ab5GFT9e0su6wPfiat
         QvaHOVNbylPeCX9ij9KKVmDzIAtx9wKSstBrAnulFKyaTKGvCwrz2xbxPOB8qavqh+lb
         6MsGCrMVioOxDD09on0PaSw6EQRHCduOozuii+iQET5CrmKBRjueZ6v/u5DlxzU5Hd2k
         HzSWHPSYJCK381wOTqeydsha5fqGGN85YmWC3kGB0ajcKPkF3WG8UWjDaKDifyHWRIBo
         MZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HY8OJjB9KzXRIpga3HYe3BIZij+wA12HjSQmYd+XzUA=;
        b=FR0eBw8UqxVcLyiP5r3c2VXpwVrTMVmJOxLqPWaJpOfEalqBIILjoxRkTDPUduJJRt
         yUyFjruiA9oUH8v5j1lrqrxst0MLzS6/oHhZEaBN1nqWV0YMBYLfdOeyNhUDaf3eFk2p
         Sr2/ub0SJs5OqVsONzWAiGWAb6YzY9IyprNKK3P97U++MgL0UbSgeU5SuOw96hjhNVX+
         s8nMGsbexc9lE8gRoYmIU43nNGZ29UYBs9GtPdXR3rQcERu2gk7wbVV+H8chOrZ17IsB
         2lEQyMFukTO+/GX0CBQPhIpyvhqj8iZgbdrNgPW3HMHqtwGDQL0H6dwIGIiKUxFbfpJM
         FbgA==
X-Gm-Message-State: ALoCoQngqc8kMAam0GPtEGf6zmkwJGtDEI9URV8f3U1jrnwu9IabXMzGux6JnVtq7f95ON0yzqmH
X-Received: by 10.66.147.136 with SMTP id tk8mr36764790pab.37.1446597446601;
        Tue, 03 Nov 2015 16:37:26 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:799e:c67e:2702:f55])
        by smtp.gmail.com with ESMTPSA id cs5sm31691385pbc.15.2015.11.03.16.37.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Nov 2015 16:37:26 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
In-Reply-To: <1446597434-1740-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280832>

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
2.6.1.247.ge8f2a41.dirty
