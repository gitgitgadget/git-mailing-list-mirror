From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 00/19] Introduce an internal API to interact with the
 fsck machinery
Date: Fri, 19 Jun 2015 15:32:01 +0200
Organization: gmx
Message-ID: <cover.1434720655.git.johannes.schindelin@gmx.de>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 15:32:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wP3-0006j8-9k
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbbFSNcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 09:32:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:49401 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659AbbFSNcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:32:09 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LeALI-1YlByi0LMK-00puUY; Fri, 19 Jun 2015 15:32:04
 +0200
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:1wxe3L71ABYufdANogeAbxoumRLQeyoJK1Z5yKqsk8jpgAhoBVJ
 HXZu7XTi0dCVI3IXzvdomPVmKNuIbBjlV01k4l+IVAfmMiZ0WWNwL/H7vdW1V6vwZ26gib1
 l3BGMoi6PxyDBqXpH/jJAvXE1rAAXBo7Zlk4H1hZ4jK+ceTJyF7emWBY+IPNTxzgVWvT41K
 vE3yiGQ4As5z2dvWa+3dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eFmrUiV4KAg=:G+5RAx/9J8P69qm4adDQJW
 xA+P+mC2quycrmlt8MSBnRcmuxlfD9uwG4V27P6oJH9iYhKABNnhttjwZu73tI7/SOl3CiIxd
 jOuBVwuYpGRVSQWl5VshndJW4RG3vjoYNhKbJuORJxNkLj7Z5x39HtYej9TDzSG64ElV/aKF8
 IBZFZynXX+KXJK/ekBFYAO1oMFdo4QP902FepaCF8aQE8YzcbnMmJ3NHiUVG7eFw810BaTRmp
 /FZ+a36huAn69kYc6Jpfkn5BBznpIB0fpyb9yI4vt8QaNRIpihlgiVT68fE827MzIXtkeH/Ih
 hAML2Z4MBCIOeDxG03qzeoOaAhA2bCJTGQzNnenEcPxgVoPQ3UnkS4wQxTFBza0iopciH3zLi
 wD9hYd4BQsWTVEaSwYKaNf9Gj+o5T8fsQZgHInUYgbB02BZ8FNxnnCgUpMIFkl+GQBg2Y8+Mu
 bPX0Q74oBqt7iZH9c4LV4OGEOUAZMFjH4YRwLsRKjqC12qxbBtiE3Qit+0KkL/SjLGMWZDEZk
 XsMd3YVGClgFEZOXe1ICX1ZDHjWWg12WPH4LZUxEnnchNQFE9UVx8X7EnMKf0mzcOxOlCfGgn
 5bG206UeMxQHqyDaVLwqVVcE7Y84FxlHOhXoczJ1Ym2N4vbu++F+nfUNbkuFeVdfkqHeIWyxF
 9r20pCykZf3Yyt3blRLfOEMV+LBtaDSR0ODgflRmov57zFZzHT22ZBWsMKLD+F+10oyQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272135>

At the moment, the git-fsck's integrity checks are targeted toward the
end user, i.e. the error messages are really just messages, intended for
human consumption.

Under certain circumstances, some of those errors should be allowed to
be turned into mere warnings, though, because the cost of fixing the
issues might well be larger than the cost of carrying those flawed
objects. For example, when an already-public repository contains a
commit object with two authors for years, it does not make sense to
force the maintainer to rewrite the history, affecting all contributors
negatively by forcing them to update.

This branch introduces an internal fsck API to be able to turn some of
the errors into warnings, and to make it easier to call the fsck
machinery from elsewhere in general.

I am proud to report that this work has been sponsored by GitHub.

Changes since v5:

- The BAD_* names have been renamed to INVALID_* names

Interdiff below the diffstat.

Johannes Schindelin (19):
  fsck: Introduce fsck options
  fsck: Introduce identifiers for fsck messages
  fsck: Provide a function to parse fsck message IDs
  fsck: Offer a function to demote fsck errors to warnings
  fsck (receive-pack): Allow demoting errors to warnings
  fsck: Report the ID of the error/warning
  fsck: Make fsck_ident() warn-friendly
  fsck: Make fsck_commit() warn-friendly
  fsck: Handle multiple authors in commits specially
  fsck: Make fsck_tag() warn-friendly
  fsck: Add a simple test for receive.fsck.<msg-id>
  fsck: Disallow demoting grave fsck errors to warnings
  fsck: Optionally ignore specific fsck issues completely
  fsck: Allow upgrading fsck warnings to errors
  fsck: Document the new receive.fsck.<msg-id> options
  fsck: Support demoting errors to warnings
  fsck: Introduce `git fsck --quick`
  fsck: git receive-pack: support excluding objects from fsck'ing
  fsck: support ignoring objects in `git fsck` via fsck.skiplist

 Documentation/config.txt        |  39 +++
 Documentation/git-fsck.txt      |   7 +-
 builtin/fsck.c                  |  75 ++++--
 builtin/index-pack.c            |  13 +-
 builtin/receive-pack.c          |  25 +-
 builtin/unpack-objects.c        |  16 +-
 fsck.c                          | 553 +++++++++++++++++++++++++++++++---------
 fsck.h                          |  31 ++-
 t/t1450-fsck.sh                 |  37 ++-
 t/t5302-pack-index.sh           |   2 +-
 t/t5504-fetch-receive-strict.sh |  51 ++++
 11 files changed, 686 insertions(+), 163 deletions(-)

diff --git a/fsck.c b/fsck.c
index 9b8981e..f80b508 100644
--- a/fsck.c
+++ b/fsck.c
@@ -19,17 +19,17 @@
 	FUNC(UNTERMINATED_HEADER, FATAL) \
 	/* errors */ \
 	FUNC(BAD_DATE, ERROR) \
+	FUNC(BAD_DATE_OVERFLOW, ERROR) \
 	FUNC(BAD_EMAIL, ERROR) \
 	FUNC(BAD_NAME, ERROR) \
+	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
+	FUNC(BAD_TAG_OBJECT, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
+	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
-	FUNC(DATE_OVERFLOW, ERROR) \
+	FUNC(BAD_TYPE, ERROR) \
 	FUNC(DUPLICATE_ENTRIES, ERROR) \
-	FUNC(INVALID_OBJECT_SHA1, ERROR) \
-	FUNC(INVALID_TAG_OBJECT, ERROR) \
-	FUNC(INVALID_TREE, ERROR) \
-	FUNC(INVALID_TYPE, ERROR) \
 	FUNC(MISSING_AUTHOR, ERROR) \
 	FUNC(MISSING_COMMITTER, ERROR) \
 	FUNC(MISSING_EMAIL, ERROR) \
@@ -46,8 +46,8 @@
 	FUNC(MISSING_TYPE, ERROR) \
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
 	FUNC(MULTIPLE_AUTHORS, ERROR) \
-	FUNC(NOT_SORTED, ERROR) \
 	FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
+	FUNC(TREE_NOT_SORTED, ERROR) \
 	FUNC(UNKNOWN_TYPE, ERROR) \
 	FUNC(ZERO_PADDED_DATE, ERROR) \
 	/* warnings */ \
@@ -60,7 +60,7 @@
 	FUNC(NULL_SHA1, WARN) \
 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
-	FUNC(INVALID_TAG_NAME, INFO) \
+	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO)
 
 #define MSG_ID(id, msg_type) FSCK_MSG_##id,
@@ -525,7 +525,7 @@ static int fsck_tree(struct tree *item, struct fsck_options *options)
 	if (has_dup_entries)
 		retval += report(options, &item->object, FSCK_MSG_DUPLICATE_ENTRIES, "contains duplicate file entries");
 	if (not_properly_sorted)
-		retval += report(options, &item->object, FSCK_MSG_NOT_SORTED, "not properly sorted");
+		retval += report(options, &item->object, FSCK_MSG_TREE_NOT_SORTED, "not properly sorted");
 	return retval;
 }
 
@@ -580,7 +580,7 @@ static int fsck_ident(const char **ident, struct object *obj, struct fsck_option
 	if (*p == '0' && p[1] != ' ')
 		return report(options, obj, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
 	if (date_overflows(strtoul(p, &end, 10)))
-		return report(options, obj, FSCK_MSG_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
+		return report(options, obj, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
 	if ((end == p || *end != ' '))
 		return report(options, obj, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
 	p = end + 1;
@@ -659,7 +659,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	if (err)
 		return err;
 	if (!commit->tree)
-		return report(options, &commit->object, FSCK_MSG_INVALID_TREE, "could not load commit's tree %s", sha1_to_hex(tree_sha1));
+		return report(options, &commit->object, FSCK_MSG_BAD_TREE, "could not load commit's tree %s", sha1_to_hex(tree_sha1));
 
 	return 0;
 }
@@ -712,7 +712,7 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		goto done;
 	}
 	if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n') {
-		ret = report(options, &tag->object, FSCK_MSG_INVALID_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
+		ret = report(options, &tag->object, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
 		if (ret)
 			goto done;
 	}
@@ -728,7 +728,7 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		goto done;
 	}
 	if (type_from_string_gently(buffer, eol - buffer, 1) < 0)
-		ret = report(options, &tag->object, FSCK_MSG_INVALID_TYPE, "invalid 'type' value");
+		ret = report(options, &tag->object, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
 	if (ret)
 		goto done;
 	buffer = eol + 1;
@@ -744,7 +744,7 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 	}
 	strbuf_addf(&sb, "refs/tags/%.*s", (int)(eol - buffer), buffer);
 	if (check_refname_format(sb.buf, 0)) {
-		ret = report(options, &tag->object, FSCK_MSG_INVALID_TAG_NAME,
+		ret = report(options, &tag->object, FSCK_MSG_BAD_TAG_NAME,
 			   "invalid 'tag' name: %.*s",
 			   (int)(eol - buffer), buffer);
 		if (ret)
@@ -773,7 +773,7 @@ static int fsck_tag(struct tag *tag, const char *data,
 	struct object *tagged = tag->tagged;
 
 	if (!tagged)
-		return report(options, &tag->object, FSCK_MSG_INVALID_TAG_OBJECT, "could not load tagged object");
+		return report(options, &tag->object, FSCK_MSG_BAD_TAG_OBJECT, "could not load tagged object");
 
 	return fsck_tag_buffer(tag, data, size, options);
 }
@@ -782,7 +782,7 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options)
 {
 	if (!obj)
-		return report(options, obj, FSCK_MSG_INVALID_OBJECT_SHA1, "no valid object to fsck");
+		return report(options, obj, FSCK_MSG_BAD_OBJECT_SHA1, "no valid object to fsck");
 
 	if (obj->type == OBJ_BLOB)
 		return 0;
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 471e2ea..2863a8a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -231,7 +231,7 @@ test_expect_success 'tag with incorrect tag name & missing tagger' '
 	git fsck --tags 2>out &&
 
 	cat >expect <<-EOF &&
-	warning in tag $tag: invalidtagname: invalid '\''tag'\'' name: wrong name format
+	warning in tag $tag: badtagname: invalid '\''tag'\'' name: wrong name format
 	warning in tag $tag: missingtaggerentry: invalid format - expected '\''tagger'\'' line
 	EOF
 	test_cmp expect out
-- 
2.3.1.windows.1.9.g8c01ab4
