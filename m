From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/8] submodule-config: introduce parse_generic_submodule_config
Date: Tue,  2 Feb 2016 09:51:33 -0800
Message-ID: <1454435497-26429-5-git-send-email-sbeller@google.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 02 18:52:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQf7T-00023T-1R
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 18:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbcBBRvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 12:51:55 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35687 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756495AbcBBRvv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 12:51:51 -0500
Received: by mail-pa0-f41.google.com with SMTP id ho8so102594878pac.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 09:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mU0208QKYO6sfY5DBM7ZeM1iMJYIdWqnrsARfTvlmYY=;
        b=i5DtksR4n4Udg9hFr3Xj6Ve083TdvuSO/a/N29eSwpC+3zf2X5eHCugt5fKBunVfux
         241aRtQJ848FZyAmYKf8nuy3S/7N8U69xGaSnr2OUzUm3dg9sDuDROCSDd5+sZByCLAP
         NJRM4A7MWucQ54+RgsLRrHBL3IB5w5OK4d1AAAs4lZiVfUTkTUgLj7qx4i+uQPXp0ruY
         toTs1bTDwNdqp9LbGw43VR3kGFBnjhkl+KwBHDfSpLKT2kPm8Cs78ZG6Vkpx0oea0t/R
         wBCt2OFa78Nly5uBPS3/9+xkItIUiWAuXZIwuOkH8Q7p2CgaKDifUrTcOVD/t7vrrJyz
         VpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mU0208QKYO6sfY5DBM7ZeM1iMJYIdWqnrsARfTvlmYY=;
        b=Hz35bHNVi5Uz4OFY361eSoPQAPAjOPIs17iV9VQr85atIm0dgWLdJQHhdCLtPddxWu
         X90UXrsIXn7CfzKKr4ZeehnAvi97Y+nxUwN6SvqmNoGT81NIalz1dkj2YAybd72UD6cn
         XA4PGPNp3JcayoX7SZsLmmHED4dse9CwgDwZ4QR2KxWAiN+KfcrBEmEhgZopC6QYg5IQ
         ufJid6mHMtoGHTRIXOFDsSLXF8Q9DtS/IShgpiWoSPbIPhHVxL8vd7VItiG09L/ATbNH
         43noJU6xtcehkugQFWK+FYNl4rrkNlpM5CE45bbOKnN66AD8S/RiLHODAlVB3zvsjgJh
         VDuw==
X-Gm-Message-State: AG10YOREND5uSwdJGXI0L8i40BlQsGFLyG1i7I7qTatTXMhfksJOnhE4G74s61rMJjGjfNaN
X-Received: by 10.66.220.170 with SMTP id px10mr48788419pac.145.1454435510733;
        Tue, 02 Feb 2016 09:51:50 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:11e1:ff63:6d72:465a])
        by smtp.gmail.com with ESMTPSA id lq10sm4036970pab.36.2016.02.02.09.51.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 Feb 2016 09:51:50 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.42.ge5f5e2d
In-Reply-To: <1454435497-26429-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285286>

This rewrites parse_config to distinguish between configs specific to
one submodule and configs which apply generically to all submodules.
We do not have generic submodule configs yet, but the next patch will
introduce "submodule.fetchJobs".

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.7.0.rc0.42.ge5f5e2d
