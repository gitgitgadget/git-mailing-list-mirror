From: santiago@nyu.edu
Subject: [PATCH v8 5/6] verify-tag: move tag verification code to tag.c
Date: Fri, 22 Apr 2016 10:52:04 -0400
Message-ID: <1461336725-29915-6-git-send-email-santiago@nyu.edu>
References: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:52:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atcRY-0005C3-Dc
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbcDVOwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 10:52:23 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:32818 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878AbcDVOwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:52:16 -0400
Received: by mail-qk0-f169.google.com with SMTP id n63so39137941qkf.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 07:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r5IIuXESBXaFhVGkHVIGpAshnmFS+1YS78Z0vYsdWBg=;
        b=0v+KyoJVQ7iQ5XvcZF03zSXziZzYJQWo7UHsyN1UgpTNM48qXPdUFvepNNk6lrI8jZ
         QQVp4Suxo5l4tjRz00aG7K6pLPoimHvlzTQjV+eTvSDxJqvKjCrhK3ZA2+zDADgUlR8K
         Dfrk+KJwm4uxS59HKBSAfAr/9rQnf870weLBC4OAgGj8Tbm6bZ5rui6RP0abq7fRx6vc
         nGOkvYjiKrtUNwlZSuJvMIMBhrXiMsy5Jyqzox/ZtayKRE5nvVaTG21Ik83ubmJ+0Z1s
         LH0hDI0moO7oHrS/2SwWZb5tf4DQ6fp0fB/fSzWGOZLqfZYpvNA4M072Rd3wPosWUTyF
         s4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r5IIuXESBXaFhVGkHVIGpAshnmFS+1YS78Z0vYsdWBg=;
        b=W20kz0xXDY8kIXl89Easm8QfrWnigqBzT1zK93as99EbfxvK9lDvIB78tj69/Z+j71
         1StpI/6Njb3HbQx6eKTuKPA3BmHpuCoEi8Q9DEQsV6Y8UEJDaPd81DxCW7BpVvBO9H3g
         Pw6EaRZYm19S6jKPfj/HlGYj/NepKjpzl90ii3pjNDM3tb66/TVXi675F3LDRh2FurcE
         ler9e0cUAYB02X6m+I54ZGv50N41FmcFCYglL+q/vQGsTMqYZD2WodogGGHTjDLIcVgd
         jS+LTk/4xBDBdXfuy6R+nF87+yr3ot4JtJ6F0j/eO84dUx6qv9m87YhhxCIYb9NBZMmH
         RAig==
X-Gm-Message-State: AOPr4FUPyXQ/9x46vKZ2iKDV0GEHnrWBtnpx2jzvWGraXH6XCzpRIF70Po3c63QFjd3QCLts
X-Received: by 10.55.16.204 with SMTP id 73mr4955103qkq.155.1461336734901;
        Fri, 22 Apr 2016 07:52:14 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-18.NATPOOL.NYU.EDU. [216.165.95.7])
        by smtp.gmail.com with ESMTPSA id s67sm2583005qgs.48.2016.04.22.07.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 07:52:14 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292226>

From: Santiago Torres <santiago@nyu.edu>

The PGP verification routine for tags could be accessed by other modules
that require to do so.

Publish the verify_tag function in tag.c and rename it to gpg_verify_tag
so it does not conflict with builtin/mktag's static function.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/verify-tag.c | 55 +---------------------------------------------------
 tag.c                | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tag.h                |  2 ++
 3 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index a3d3a43..99f8148 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -18,59 +18,6 @@ static const char * const verify_tag_usage[] = {
 		NULL
 };
 
-static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
-{
-	struct signature_check sigc;
-	size_t payload_size;
-	int ret;
-
-	memset(&sigc, 0, sizeof(sigc));
-
-	payload_size = parse_signature(buf, size);
-
-	if (size == payload_size) {
-		if (flags & GPG_VERIFY_VERBOSE)
-			write_in_full(1, buf, payload_size);
-		return error("no signature found");
-	}
-
-	ret = check_signature(buf, payload_size, buf + payload_size,
-				size - payload_size, &sigc);
-	print_signature_buffer(&sigc, flags);
-
-	signature_check_clear(&sigc);
-	return ret;
-}
-
-static int verify_tag(const unsigned char *sha1, const char *name_to_report,
-			unsigned flags)
-{
-	enum object_type type;
-	char *buf;
-	unsigned long size;
-	int ret;
-
-	type = sha1_object_info(sha1, NULL);
-	if (type != OBJ_TAG)
-		return error("%s: cannot verify a non-tag object of type %s.",
-				name_to_report ?
-				name_to_report :
-				find_unique_abbrev(sha1, DEFAULT_ABBREV),
-				typename(type));
-
-	buf = read_sha1_file(sha1, &type, &size);
-	if (!buf)
-		return error("%s: unable to read file.",
-				name_to_report ?
-				name_to_report :
-				find_unique_abbrev(sha1, DEFAULT_ABBREV));
-
-	ret = run_gpg_verify(buf, size, flags);
-
-	free(buf);
-	return ret;
-}
-
 static int git_verify_tag_config(const char *var, const char *value, void *cb)
 {
 	int status = git_gpg_config(var, value, cb);
@@ -104,7 +51,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		const char *name = argv[i++];
 		if (get_sha1(name, sha1))
 			had_error = !!error("tag '%s' not found.", name);
-		else if (verify_tag(sha1, name, flags))
+		else if (gpg_verify_tag(sha1, name, flags))
 			had_error = 1;
 	}
 	return had_error;
diff --git a/tag.c b/tag.c
index d72f742..8363a0e 100644
--- a/tag.c
+++ b/tag.c
@@ -6,6 +6,59 @@
 
 const char *tag_type = "tag";
 
+static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
+{
+	struct signature_check sigc;
+	size_t payload_size;
+	int ret;
+
+	memset(&sigc, 0, sizeof(sigc));
+
+	payload_size = parse_signature(buf, size);
+
+	if (size == payload_size) {
+		if (flags & GPG_VERIFY_VERBOSE)
+			write_in_full(1, buf, payload_size);
+		return error("no signature found");
+	}
+
+	ret = check_signature(buf, payload_size, buf + payload_size,
+				size - payload_size, &sigc);
+	print_signature_buffer(&sigc, flags);
+
+	signature_check_clear(&sigc);
+	return ret;
+}
+
+int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report, 
+		unsigned flags)
+{
+	enum object_type type;
+	char *buf;
+	unsigned long size;
+	int ret;
+
+	type = sha1_object_info(sha1, NULL);
+	if (type != OBJ_TAG)
+		return error("%s: cannot verify a non-tag object of type %s.",
+				name_to_report ?
+				name_to_report :
+				find_unique_abbrev(sha1, DEFAULT_ABBREV),
+				typename(type));
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error("%s: unable to read file.",
+				name_to_report ?
+				name_to_report :
+				find_unique_abbrev(sha1, DEFAULT_ABBREV));
+
+	ret = run_gpg_verify(buf, size, flags);
+
+	free(buf);
+	return ret;
+}
+
 struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 {
 	while (o && o->type == OBJ_TAG)
diff --git a/tag.h b/tag.h
index f4580ae..a5721b6 100644
--- a/tag.h
+++ b/tag.h
@@ -17,5 +17,7 @@ extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long si
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
+extern int gpg_verify_tag(const unsigned char *sha1,
+		const char *name_to_report, unsigned flags);
 
 #endif /* TAG_H */
-- 
2.8.0
