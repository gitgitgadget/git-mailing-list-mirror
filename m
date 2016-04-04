From: santiago@nyu.edu
Subject: [PATCH v4 6/6] tag.c: Change gpg_verify_tag argument to sha1
Date: Mon,  4 Apr 2016 18:22:15 -0400
Message-ID: <1459808535-8895-7-git-send-email-santiago@nyu.edu>
References: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 00:22:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anCtT-0007kR-Ir
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 00:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756610AbcDDWWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 18:22:37 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36704 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756303AbcDDWW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 18:22:29 -0400
Received: by mail-qk0-f176.google.com with SMTP id i4so68504112qkc.3
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 15:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j4lSaQwysbY760bYbW9mPyzYJ0Tm15f3sgIp/Zq3EIM=;
        b=cNn8sX87QFUuWMXuol0JpcptyyN32oZEXWEzh6nc+cFrZMwSk0PtJREfBiLv+WYz6+
         r0Ut6F6B5srdatMRbnfyv79VbSfNJy9uzI//esRYY1ERRqFHFxRjcAnq9BeXJ2eh5M9Q
         ChyNS786tZYj953ueerJt0XsGZVGy4OiElAMSRkyj6ydJstOtZVmq30NGkQka9/yxo9l
         9cQMy/LjiyHDxp1eIaHvVLc+/EajuUhYjzMxluAlz0XUsAGtlYPFqNQ/AA7NfSZEPa3N
         ABWlJD8shsoFItBg3kXmgMvBDJzYHm504m9OF4IUk+d74BoBhO2LF708TntVq+//6Hc7
         /EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j4lSaQwysbY760bYbW9mPyzYJ0Tm15f3sgIp/Zq3EIM=;
        b=Aqo07CY3zmOTQjFIpNSeRD50QrTQ/0nWbNBHC3a65o69qz1bmIx1oIG+JNlWH0+7oK
         43EAqY+OP39T/y5BCIlrufYLNABWIp1lFPN0lcoLTu5cLPL5C++DZchdP/On1IpNejAJ
         0P+SLJdNumikHh2IyM9CD7IpBiXNjb+B5KU1wWm/fZXqzsd3JTH3dj0dwynWp7KmOevG
         7FCkdCOlvk2lx1Oy2HP6J2W0e+bh3cp2mJNklSxjHyseDkpgmlk7zh9Wa3xaJ2cuG4y8
         D4ER4uWAUtGkIU6yvZa4p8ApNMflgAFPx1hB6m6jt5JEEqK0D2UBZ7WUPrelpn4vTmzO
         hvuQ==
X-Gm-Message-State: AD7BkJIyOJEoQOsjYolZYQyuXc5WAsWlTew8QU7wTLOda95d5i8N1wgkoJhn6E2M9RFeb760
X-Received: by 10.55.27.199 with SMTP id m68mr37342764qkh.109.1459808548696;
        Mon, 04 Apr 2016 15:22:28 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id h9sm13180670qhh.29.2016.04.04.15.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 15:22:28 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290734>

From: Santiago Torres <santiago@nyu.edu>

The gpg_verify_tag function resolves the ref for any existing object.
However, git tag -v resolves to only tag-refs. We can provide support
for sha1 by moving the refname resolution code out of gpg_verify_tag and
allow for the object's sha1 as an argument.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/tag.c        |  2 +-
 builtin/verify-tag.c |  9 +++++++--
 tag.c                | 12 ++++--------
 tag.h                |  2 +-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index f4450f8..398c892 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -104,7 +104,7 @@ static int delete_tag(const char *name, const char *ref,
 static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	return gpg_verify_tag(name, GPG_VERIFY_VERBOSE);
+	return gpg_verify_tag(sha1, GPG_VERIFY_VERBOSE);
 }
 
 static int do_sign(struct strbuf *buffer)
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 7e36d53..2ff01d8 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -30,6 +30,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
+	unsigned char sha1[20];
 	const struct option verify_tag_options[] = {
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
 		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
@@ -46,8 +47,12 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (verbose)
 		flags |= GPG_VERIFY_VERBOSE;
 
-	while (i < argc)
-		if (gpg_verify_tag(argv[i++], flags))
+	while (i < argc) {
+		if (get_sha1(argv[i++], sha1))
+			return error("tag '%s' not found.", argv[i]);
+
+		if (gpg_verify_tag(sha1, flags))
 			had_error = 1;
+	}
 	return had_error;
 }
diff --git a/tag.c b/tag.c
index f6443db..8ac9de5 100644
--- a/tag.c
+++ b/tag.c
@@ -30,25 +30,21 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 	return ret;
 }
 
-int gpg_verify_tag(const char *name, unsigned flags)
+int gpg_verify_tag(const unsigned char *sha1, unsigned flags)
 {
 	enum object_type type;
-	unsigned char sha1[20];
 	char *buf;
 	unsigned long size;
 	int ret;
 
-	if (get_sha1(name, sha1))
-		return error("tag '%s' not found.", name);
-
 	type = sha1_object_info(sha1, NULL);
 	if (type != OBJ_TAG)
-		return error("%s: cannot verify a non-tag object of type %s.",
-				name, typename(type));
+		return error("cannot verify a non-tag object of type %s.",
+				typename(type));
 
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
-		return error("%s: unable to read file.", name);
+		return error("unable to read file.");
 
 	ret = run_gpg_verify(buf, size, flags);
 
diff --git a/tag.h b/tag.h
index 877f180..cb643b9 100644
--- a/tag.h
+++ b/tag.h
@@ -17,6 +17,6 @@ extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long si
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
-extern int gpg_verify_tag(const char *name, unsigned flags);
+extern int gpg_verify_tag(const unsigned char *sha1, unsigned flags);
 
 #endif /* TAG_H */
-- 
2.8.0
