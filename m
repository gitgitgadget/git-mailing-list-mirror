From: Johan Herland <johan@herland.net>
Subject: [PATCH 11/21] Rewrite error messages; fix up line lengths
Date: Sat, 09 Jun 2007 02:17:17 +0200
Message-ID: <200706090217.17795.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:17:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwody-0004Lr-2h
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032547AbXFIARY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032533AbXFIARY
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:17:24 -0400
Received: from smtp.getmail.no ([84.208.20.33]:34304 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032507AbXFIARX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:17:23 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00903E4YUC00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:17:22 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000OIE4UCO20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:17:18 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC0091EE4TAH10@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:17:18 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49538>

Also update selftests to reflect new error messages.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3800-mktag.sh |   22 +++++++++++-----------
 tag.c            |   44 +++++++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 0e87d2a..3bce5e0 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -49,7 +49,7 @@ tag mytag
 EOF
 
 cat >expect.pat <<EOF
-^error: char0: .*"object "$
+^error: .*char 0.*"object ".*$
 EOF
 
 check_verify_failure '"object" line label check'
@@ -64,7 +64,7 @@ tag mytag
 EOF
 
 cat >expect.pat <<EOF
-^error: char7: .*SHA1 hash$
+^error: .*char 7.*SHA1 hash.*$
 EOF
 
 check_verify_failure '"object" line SHA1 check'
@@ -79,7 +79,7 @@ tag mytag
 EOF
 
 cat >expect.pat <<EOF
-^error: char47: .*"[\]ntype "$
+^error: .*char 47.*"[\]ntype ".*$
 EOF
 
 check_verify_failure '"type" line label check'
@@ -91,7 +91,7 @@ echo "object 779e9b33986b1c2670fff52c5067603117b3e895" >tag.sig
 printf "type tagsssssssssssssssssssssssssssssss" >>tag.sig
 
 cat >expect.pat <<EOF
-^error: char48: .*"[\]n"$
+^error: .*char 48.*"[\]n".*$
 EOF
 
 check_verify_failure '"type" line eol check'
@@ -106,7 +106,7 @@ xxx mytag
 EOF
 
 cat >expect.pat <<EOF
-^error: char57: no "tag " found$
+^error: .*char 57.*"tag ".*$
 EOF
 
 check_verify_failure '"tag" line label check #1'
@@ -121,7 +121,7 @@ tag
 EOF
 
 cat >expect.pat <<EOF
-^error: char87: no "tag " found$
+^error: .*char 87.*"tag ".*$
 EOF
 
 check_verify_failure '"tag" line label check #2'
@@ -137,7 +137,7 @@ tagger a
 EOF
 
 cat >expect.pat <<EOF
-^error: char53: type too long$
+^error: .*char 53.*Type too long.*$
 EOF
 
 check_verify_failure '"type" line type-name length check'
@@ -153,7 +153,7 @@ tagger a
 EOF
 
 cat >expect.pat <<EOF
-^error: char7: could not verify object.*$
+^error: .*char 7.*Could not verify tagged object.*$
 EOF
 
 check_verify_failure 'verify object (SHA1/type) check'
@@ -169,7 +169,7 @@ tagger a
 EOF
 
 cat >expect.pat <<EOF
-^error: char67: could not verify tag name$
+^error: .*char 67.*Could not verify tag name.*$
 EOF
 
 check_verify_failure 'verify tag-name check'
@@ -184,7 +184,7 @@ tag mytag
 EOF
 
 cat >expect.pat <<EOF
-^error: char70: could not find "tagger"$
+^error: .*char 70.*Could not find "tagger ".*$
 EOF
 
 check_verify_failure '"tagger" line label check #1'
@@ -200,7 +200,7 @@ tagger
 EOF
 
 cat >expect.pat <<EOF
-^error: char70: could not find "tagger"$
+^error: .*char 70.*Could not find "tagger ".*$
 EOF
 
 check_verify_failure '"tagger" line label check #2'
diff --git a/tag.c b/tag.c
index e12b9fc..c7c75b3 100644
--- a/tag.c
+++ b/tag.c
@@ -72,41 +72,50 @@ int parse_and_verify_tag_buffer(struct tag *item,
 	}
 
 	if (size < 64)
-		return error("failed preliminary size check");
+		return error("Tag object failed preliminary size check");
 
 	/* Verify object line */
 	if (memcmp(data, "object ", 7))
-		return error("char%d: does not start with \"object \"", 0);
+		return error("Tag object (@ char 0): "
+			"Does not start with \"object \"");
 
 	if (get_sha1_hex(data + 7, sha1))
-		return error("char%d: could not get SHA1 hash", 7);
+		return error("Tag object (@ char 7): Could not get SHA1 hash");
 
 	/* Verify type line */
 	type_line = data + 48;
 	if (memcmp(type_line - 1, "\ntype ", 6))
-		return error("char%d: could not find \"\\ntype \"", 47);
+		return error("Tag object (@ char 47): "
+			"Could not find \"\\ntype \"");
 
 	/* Verify tag-line */
 	tag_line = strchr(type_line, '\n');
-	if (!tag_line)
-		return error("char" PD_FMT ": could not find next \"\\n\"", type_line - data);
-	tag_line++;
+	if (!tag_line++)
+		return error("Tag object (@ char " PD_FMT "): "
+			"Could not find \"\\n\" after \"type\"",
+			type_line - data);
 	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
-		return error("char" PD_FMT ": no \"tag \" found", tag_line - data);
+		return error("Tag object (@ char " PD_FMT "): "
+			"Could not find \"tag \"", tag_line - data);
 
 	/* Verify the tagger line */
 	tagger_line = strchr(tag_line, '\n');
 	if (!tagger_line++)
-		return error("char" PD_FMT ": could not find next \"\\n\"", tag_line - data);
+		return error("Tag object (@ char " PD_FMT "): "
+			"Could not find \"\\n\" after \"tag\"",
+			tag_line - data);
 	if (thorough_verify) {
 		if (memcmp(tagger_line, "tagger ", 7) || (tagger_line[7] == '\n'))
-			return error("char" PD_FMT ": could not find \"tagger\"", tagger_line - data);
+			return error("Tag object (@ char " PD_FMT "): "
+				"Could not find \"tagger \"",
+				tagger_line - data);
 	}
 
 	/* Get the actual type */
 	type_len = tag_line - type_line - strlen("type \n");
 	if (type_len >= sizeof(type))
-		return error("char" PD_FMT ": type too long", type_line + 5 - data);
+		return error("Tag object (@ char " PD_FMT "): "
+			"Type too long", type_line + 5 - data);
 	memcpy(type, type_line + 5, type_len);
 	type[type_len] = '\0';
 
@@ -115,16 +124,20 @@ int parse_and_verify_tag_buffer(struct tag *item,
 
 		/* Verify that the object matches */
 		if (verify_object(sha1, type))
-			return error("char%d: could not verify object %s", 7, sha1_to_hex(sha1));
+			return error("Tag object (@ char 7): "
+				"Could not verify tagged object %s",
+				sha1_to_hex(sha1));
 
-		/* Verify the tag-name: we don't allow control characters or spaces in it */
+		/* Verify tag name: disallow control characters or spaces */
 		for (i = 4;;) {
 			unsigned char c = tag_line[i++];
 			if (c == '\n')
 				break;
 			if (c > ' ')
 				continue;
-			return error("char" PD_FMT ": could not verify tag name", tag_line + i - data);
+			return error("Tag object (@ char " PD_FMT "): "
+				"Could not verify tag name",
+				tag_line + i - data);
 		}
 
 		/* Verify the tagger line */
@@ -148,7 +161,8 @@ int parse_and_verify_tag_buffer(struct tag *item,
 		} else if (!strcmp(type, tag_type)) {
 			item->tagged = &lookup_tag(sha1)->object;
 		} else {
-			error("Unknown type %s", type);
+			error("Tag object (@ char " PD_FMT "): "
+				"Unknown type '%s'", type_line + 5 - data, type);
 			item->tagged = NULL;
 		}
 
-- 
1.5.2
