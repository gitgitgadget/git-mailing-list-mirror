From: santiago@nyu.edu
Subject: [PATCH v5 4/6] builtin/verify-tag: replace name argument with sha1
Date: Tue,  5 Apr 2016 12:07:27 -0400
Message-ID: <1459872449-7537-5-git-send-email-santiago@nyu.edu>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 18:07:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anTWE-0000aC-9Y
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 18:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759454AbcDEQHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 12:07:41 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:32856 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbcDEQHj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 12:07:39 -0400
Received: by mail-qg0-f66.google.com with SMTP id y89so1620119qge.0
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 09:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AAZ+J9XDk0MEUJdiLPaFXlOoc2l0/j7LDnsfaSAzaA8=;
        b=BUh93WC+EEuJBEa1SRvHZbZo/cxTxY+d8UEpX1UAEl0w2ZOntcLQYogc/aE3q0gPDH
         WWZfZQ9QBDvvhV2Rt7Yw+AmhOj4pPCjBkkHVIA5Ae2Hgj8jRpO3/PZ4j0whPB8mM7YLG
         nJgGryhC2GUtmijTamA+WrMnz1u1LNdZRMsBfl1Uz2TeBlVF4aPOzcySGbDe16dNzOXx
         ctXs/QpRiHFw/h52gcoMtdFzMyk2jvYJcwxkkbaNNd/RikGJbTAE4nF3zRPI5YBBjxua
         J/8kTVmY3jKh+3DohtBnwTKe9um3FOWxzHxDOX3P5m2pEuLo8RRj7LZAkvc2HFpDEPcK
         kU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AAZ+J9XDk0MEUJdiLPaFXlOoc2l0/j7LDnsfaSAzaA8=;
        b=lstCVy68lizyde6uEc6MkQo3OSNTmhKrS+NJjIb1McRc3tM/buPvJ/d/KcT8bnRXsD
         bvRYgChG4tdEVhs+0zwR287YHwYkHQFwd1w1kVIDrZIGx+jOIp1VHTdx/PmYCANv3KdH
         Wa7efIhzc2kyIM+qfXExJsMCUzKZoAZiYOYchFy4zYjePd6tvpXb3LhPhHin5C2pGTTl
         UTT5YHUS0JmSmNoqvtaO+IGlJaaHVY1T9K7+cLFcMwV4ZyaQuSvH5c0wrVtzsCnnyvDj
         2l0toZWMWbP4pdwsX1O5pUQD1pxOWa/xvmpd8mX97REfMpY1TOjlT3BV92ytI+Q68TRU
         YNtQ==
X-Gm-Message-State: AD7BkJLRiuVrlexO0WD7bUW6fJRoqnlUUU4GptHQX+fRqNwangzwOvvKR/hs3No0DHQuD8iO
X-Received: by 10.140.101.145 with SMTP id u17mr15675463qge.59.1459872458748;
        Tue, 05 Apr 2016 09:07:38 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-20.NATPOOL.NYU.EDU. [216.165.95.9])
        by smtp.gmail.com with ESMTPSA id b66sm14671343qhb.48.2016.04.05.09.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Apr 2016 09:07:38 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290792>

From: Santiago Torres <santiago@nyu.edu>

This change is meant to prepare verify_tag for libification. Many
existing modules/commands already do the refname to sha1 resolution, so
should avoid resolving the refname twice. To avoid breaking
builtin/verify-tag, we move the refname resolution outside of the
verify_tag() call.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/verify-tag.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 1ca9a05..7a7c376 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -42,25 +42,23 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 	return ret;
 }
 
-static int verify_tag(const char *name, unsigned flags)
+static int verify_tag(const unsigned char *sha1, unsigned flags)
 {
 	enum object_type type;
-	unsigned char sha1[20];
 	char *buf;
+	char *hex_sha1;
 	unsigned long size;
 	int ret;
 
-	if (get_sha1(name, sha1))
-		return error("tag '%s' not found.", name);
-
+	hex_sha1 = sha1_to_hex(sha1);
 	type = sha1_object_info(sha1, NULL);
 	if (type != OBJ_TAG)
 		return error("%s: cannot verify a non-tag object of type %s.",
-				name, typename(type));
+				hex_sha1, typename(type));
 
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
-		return error("%s: unable to read file.", name);
+		return error("%s: unable to read file.", hex_sha1);
 
 	ret = run_gpg_verify(buf, size, flags);
 
@@ -80,6 +78,8 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
+	unsigned char sha1[20];
+	const char *name;
 	const struct option verify_tag_options[] = {
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
 		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
@@ -96,8 +96,15 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (verbose)
 		flags |= GPG_VERIFY_VERBOSE;
 
-	while (i < argc)
-		if (verify_tag(argv[i++], flags))
+	while (i < argc) {
+		name = argv[i++];
+		if (get_sha1(name, sha1)) {
+			error("tag '%s' not found.", name);
 			had_error = 1;
+			continue;
+		}
+		if (verify_tag(sha1, flags))
+			had_error = 1;
+	}
 	return had_error;
 }
-- 
2.8.0
