From: santiago@nyu.edu
Subject: [PATCH v6 4/6] verify-tag: add sha1 argument to verify_tag()
Date: Sun, 17 Apr 2016 18:26:59 -0400
Message-ID: <1460932021-27633-5-git-send-email-santiago@nyu.edu>
References: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 00:27:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arvAB-00055l-IQ
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 00:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbcDQW13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 18:27:29 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34622 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbcDQW1P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 18:27:15 -0400
Received: by mail-qg0-f51.google.com with SMTP id c6so107580879qga.1
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 15:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d42js94V8BMgP9p5Dyj0knvqXBUTxfmpwtopM6KmjCs=;
        b=KhOoQ2t0Ls5IlHHRoLvoGto7wDmupQo/XJGSnfnG7IDw2aWcfMm1wwqLzBa3lqGdKT
         HbXL5Rl6r++vEwUt405dc2Ad/82kw8Q9+38vL4YeW1A0c9uU+xgP/ZJFRPKrExPMa7n8
         KasielOfdaw3PJK5o81V0QhgRO8r6dE6q3XDPMRPS4jnv4br+R6VIvifoeWyD30Jko7+
         L5caHujBc9e4KSFCJVIlcp7oPvDhl3gjSluUGdKSgY/ASEBqcaLyPEACaura8aMxhEHb
         9UcNNhxxogDHwlCuUI60lpaQkCBGYdPVYb5gGQbWy6mcLy+L8kwjsiBAcSzzwrylctbt
         jz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d42js94V8BMgP9p5Dyj0knvqXBUTxfmpwtopM6KmjCs=;
        b=Hc4ijtUxfsJ9iHgsYqN/H4DmANTB2mbjWr3OKuRx1w5p6OaehohpkT0bo/c3/A5yXT
         ZPHziOOR6if+ImzR5B1fzj/u95H5uKf62c2m7FNQ49baUSmBHPgNSY1uHp8KvHTmCMjo
         V116cpAWnrkjeNL5q95IQ4mRwuGaOxsZ2lUeB9JQph9irkW21+PEzjFRkx+dbO4Slazs
         I0wiIjRtIA23avq2BLa9o13UXcHco2CPptCkOgdONFhBXCcVC7RCz0c8YO8qJywAr0Kl
         hrRsk4G82qRLq6dh0eSHA79vvywHi4udhS1vj6qXwfiw3X7/cyy1IGnNCLjXJwFw0K0E
         BvAg==
X-Gm-Message-State: AOPr4FW44TzxHCNFnr5jPEezqwE96KKKx6GPqMlxB04iEM9P/wfEZc4yDDOl6LlHeH8J/mpI
X-Received: by 10.140.41.164 with SMTP id z33mr39267006qgz.78.1460932034431;
        Sun, 17 Apr 2016 15:27:14 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id j75sm5120767qgd.19.2016.04.17.15.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Apr 2016 15:27:13 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291782>

From: Santiago Torres <santiago@nyu.edu>

The current interface of verify_tag() resolves reference names to SHA1,
which might be redundant as future callers may resolve the refname to
SHA1 beforehand.

Add a SHA1 parameter to use instead of the name parameter. We also
replace the name argument to report_name and use it for error reporting
only.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/verify-tag.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 010353c..1d1c5c2 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -42,25 +42,24 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 	return ret;
 }
 
-static int verify_tag(const char *name, unsigned flags)
+static int verify_tag(const unsigned char *sha1, const char *report_name,
+			unsigned flags)
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
 		return error("%s: cannot verify a non-tag object of type %s.",
-				name, typename(type));
+				report_name ? report_name : find_unique_abbrev(sha1, DEFAULT_ABBREV),
+				typename(type));
 
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
-		return error("%s: unable to read file.", name);
+		return error("%s: unable to read file.",
+				report_name ? report_name : find_unique_abbrev(sha1, DEFAULT_ABBREV));
 
 	ret = run_gpg_verify(buf, size, flags);
 
@@ -80,6 +79,8 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
+	unsigned char sha1[20];
+	const char *name;
 	const struct option verify_tag_options[] = {
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
 		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
@@ -96,8 +97,14 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (verbose)
 		flags |= GPG_VERIFY_VERBOSE;
 
-	while (i < argc)
-		if (verify_tag(argv[i++], flags))
+	while (i < argc) {
+		name = argv[i++];
+		if (get_sha1(name, sha1)) {
+			error("tag '%s' not found.", name);
 			had_error = 1;
+		}
+		else if (verify_tag(sha1, name, flags))
+			had_error = 1;
+	}
 	return had_error;
 }
-- 
2.8.0
