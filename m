From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/8] git_attr(): fix function signature
Date: Sun, 17 Jan 2010 01:38:57 -0800
Message-ID: <1263721144-18605-2-git-send-email-gitster@pobox.com>
References: <1263721144-18605-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 17 10:39:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWRbP-0003nL-9P
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 10:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab0AQJjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 04:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753640Ab0AQJjM
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 04:39:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab0AQJjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 04:39:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C2B991400
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=A5VX
	vfZAwSJei9YR71OQziRAoWQ=; b=ZWqwycUJ8B/bXe9Cqd9eSJXCVrcf3xnNBZAV
	NpkhSJvAW3msDNtuwA2JUakqT8CgaicqDt6pJ/BtOFeTEiqAHgdmMaxFygC1lpgO
	qt0JygDw1+tUdpKzNzp+RFMPFZDt9vZwaaNXJIecabhjGjRzs8L2CtjL7pyEWuzZ
	irYqC7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=PEgk5V
	sr+C6uHAyj1hv0aMmofmpQteFITlMArhM1mT4XK+2OK1vHR2SaY2kbk+H+MJFuGS
	Fs5u1mE56v6xBcPrdujaRYXndqSLfv20OCLQctPW1XZlkCX4qS8rFxNBtDbeDHei
	gI7H81KxfDGbBEgOkiGVTB+UqNTZ9nj0vXv+A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 68EDF913FE
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 978DE913FD for
 <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:07 -0500 (EST)
X-Mailer: git-send-email 1.6.6.405.g80ed6.dirty
In-Reply-To: <1263721144-18605-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 28DDBE1A-034C-11DF-906B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137282>

The function took (name, namelen) as its arguments, but all the public
callers wanted to pass a full string.

Demote the counted-string interface to an internal API status, and allow
public callers to just pass the string to the function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 archive.c              |    4 ++--
 attr.c                 |   11 ++++++++---
 attr.h                 |    2 +-
 builtin-check-attr.c   |    2 +-
 builtin-pack-objects.c |    2 +-
 convert.c              |    6 +++---
 ll-merge.c             |    2 +-
 userdiff.c             |    2 +-
 ws.c                   |    2 +-
 9 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/archive.c b/archive.c
index 55b2732..a9ebdc5 100644
--- a/archive.c
+++ b/archive.c
@@ -87,8 +87,8 @@ static void setup_archive_check(struct git_attr_check *check)
 	static struct git_attr *attr_export_subst;
 
 	if (!attr_export_ignore) {
-		attr_export_ignore = git_attr("export-ignore", 13);
-		attr_export_subst = git_attr("export-subst", 12);
+		attr_export_ignore = git_attr("export-ignore");
+		attr_export_subst = git_attr("export-subst");
 	}
 	check[0].attr = attr_export_ignore;
 	check[1].attr = attr_export_subst;
diff --git a/attr.c b/attr.c
index 55bdb7c..f5346ed 100644
--- a/attr.c
+++ b/attr.c
@@ -65,7 +65,7 @@ static int invalid_attr_name(const char *name, int namelen)
 	return 0;
 }
 
-struct git_attr *git_attr(const char *name, int len)
+static struct git_attr *git_attr_internal(const char *name, int len)
 {
 	unsigned hval = hash_name(name, len);
 	unsigned pos = hval % HASHSIZE;
@@ -95,6 +95,11 @@ struct git_attr *git_attr(const char *name, int len)
 	return a;
 }
 
+struct git_attr *git_attr(const char *name)
+{
+	return git_attr_internal(name, strlen(name));
+}
+
 /*
  * .gitattributes file is one line per record, each of which is
  *
@@ -162,7 +167,7 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 		else {
 			e->setto = xmemdupz(equals + 1, ep - equals - 1);
 		}
-		e->attr = git_attr(cp, len);
+		e->attr = git_attr_internal(cp, len);
 	}
 	(*num_attr)++;
 	return ep + strspn(ep, blank);
@@ -221,7 +226,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 			      sizeof(struct attr_state) * num_attr +
 			      (is_macro ? 0 : namelen + 1));
 		if (is_macro)
-			res->u.attr = git_attr(name, namelen);
+			res->u.attr = git_attr_internal(name, namelen);
 		else {
 			res->u.pattern = (char *)&(res->state[num_attr]);
 			memcpy(res->u.pattern, name, namelen);
diff --git a/attr.h b/attr.h
index 69b5767..450f49d 100644
--- a/attr.h
+++ b/attr.h
@@ -8,7 +8,7 @@ struct git_attr;
  * Given a string, return the gitattribute object that
  * corresponds to it.
  */
-struct git_attr *git_attr(const char *, int);
+struct git_attr *git_attr(const char *);
 
 /* Internal use */
 extern const char git_attr__true[];
diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index 8bd0430..3016d29 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -106,7 +106,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 		const char *name;
 		struct git_attr *a;
 		name = argv[i];
-		a = git_attr(name, strlen(name));
+		a = git_attr(name);
 		if (!a)
 			return error("%s: not a valid attribute name", name);
 		check[i].attr = a;
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 4429d53..9beff35 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -673,7 +673,7 @@ static void setup_delta_attr_check(struct git_attr_check *check)
 	static struct git_attr *attr_delta;
 
 	if (!attr_delta)
-		attr_delta = git_attr("delta", 5);
+		attr_delta = git_attr("delta");
 
 	check[0].attr = attr_delta;
 }
diff --git a/convert.c b/convert.c
index 491e714..852fd64 100644
--- a/convert.c
+++ b/convert.c
@@ -377,9 +377,9 @@ static void setup_convert_check(struct git_attr_check *check)
 	static struct git_attr *attr_filter;
 
 	if (!attr_crlf) {
-		attr_crlf = git_attr("crlf", 4);
-		attr_ident = git_attr("ident", 5);
-		attr_filter = git_attr("filter", 6);
+		attr_crlf = git_attr("crlf");
+		attr_ident = git_attr("ident");
+		attr_filter = git_attr("filter");
 		user_convert_tail = &user_convert;
 		git_config(read_convert_config, NULL);
 	}
diff --git a/ll-merge.c b/ll-merge.c
index 2d6b6d6..f4b0a07 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -344,7 +344,7 @@ static const char *git_path_check_merge(const char *path)
 	static struct git_attr_check attr_merge_check;
 
 	if (!attr_merge_check.attr)
-		attr_merge_check.attr = git_attr("merge", 5);
+		attr_merge_check.attr = git_attr("merge");
 
 	if (git_checkattr(path, 1, &attr_merge_check))
 		return NULL;
diff --git a/userdiff.c b/userdiff.c
index 57529ae..df99249 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -198,7 +198,7 @@ struct userdiff_driver *userdiff_find_by_path(const char *path)
 	struct git_attr_check check;
 
 	if (!attr)
-		attr = git_attr("diff", 4);
+		attr = git_attr("diff");
 	check.attr = attr;
 
 	if (!path)
diff --git a/ws.c b/ws.c
index 760b574..c089338 100644
--- a/ws.c
+++ b/ws.c
@@ -64,7 +64,7 @@ static void setup_whitespace_attr_check(struct git_attr_check *check)
 	static struct git_attr *attr_whitespace;
 
 	if (!attr_whitespace)
-		attr_whitespace = git_attr("whitespace", 10);
+		attr_whitespace = git_attr("whitespace");
 	check[0].attr = attr_whitespace;
 }
 
-- 
1.6.6.405.g80ed6.dirty
