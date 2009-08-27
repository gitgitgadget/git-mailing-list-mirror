From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC PATCH v5 3/6] fast-import: add feature command
Date: Thu, 27 Aug 2009 11:12:13 -0700
Message-ID: <1251396736-928-3-git-send-email-srabbelier@gmail.com>
References: <1251396736-928-1-git-send-email-srabbelier@gmail.com>
 <1251396736-928-2-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Thu Aug 27 20:12:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgjSn-00077M-HF
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 20:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbZH0SMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 14:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbZH0SMi
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 14:12:38 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:57306 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZH0SMg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 14:12:36 -0400
Received: by mail-ew0-f206.google.com with SMTP id 2so1461338ewy.17
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4ZioZgXM8+EzflwadAkJn07Xa0i2+wU9ooG8nemIMQ0=;
        b=xVIZolgfyo3q5jDDLIVHSzt3/EqzTDoAVmHQm+IDf0Y2Z510dWJ0vsniCpkcr43/wE
         O340Mrkco8FV+sA7+QVzO9pyOXrY4vOAiMz/0Ukz56e+kapMS2aWe+bMdIhVsNHH0B9r
         CuUtDfOFGEnRI8azu2hflDAdNUL6nkgn9Hfv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tzH4jPHSfJTgVKiFZygqFhlXyeK9GrjzY3rrHoOkCkaf45y99JPeQZsL+bVn/1zRZr
         fvd9wT2+4ORhoVA0ok3larNCzYO5S2hy0kx/VxyuMer31dj/ScoCThRGRsgZ6Y0M+Tgv
         A30KFwoAQH3zQkmxBpcKAxiyOy7/Ap7Zqd8Qg=
Received: by 10.211.159.15 with SMTP id l15mr598027ebo.96.1251396756405;
        Thu, 27 Aug 2009 11:12:36 -0700 (PDT)
Received: from localhost.localdomain (kaayla.mtv.corp.google.com [172.22.72.177])
        by mx.google.com with ESMTPS id 10sm62710eyz.25.2009.08.27.11.12.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Aug 2009 11:12:36 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <1251396736-928-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127185>

From: Sverre Rabbelier <srabbelier@google.com>

This allows the fronted to require a specific feature to be supported
by the frontend, or abort.

Also add support for the first feature, date-format=.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	New in this series, currently RFC. This should make it easier
	for frontends to specify their needs.

 Documentation/git-fast-import.txt |   16 ++++++++++++++++
 fast-import.c                     |   13 +++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index c2f483a..1e293f2 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -303,6 +303,10 @@ and control the current import process.  More detailed discussion
 	standard output.  This command is optional and is not needed
 	to perform an import.
 
+`feature`::
+	Require that fast-import supports the specified feature, or
+	abort if it does not.
+
 `commit`
 ~~~~~~~~
 Create or update a branch with a new commit, recording one logical
@@ -813,6 +817,18 @@ Placing a `progress` command immediately after a `checkpoint` will
 inform the reader when the `checkpoint` has been completed and it
 can safely access the refs that fast-import updated.
 
+`feature`
+~~~~~~~~~
+Require that fast-import supports the specified feature, or abort if
+it does not.
+
+....
+	'feature' SP <feature> LF
+....
+
+The <feature> part of the command may be any string matching
+[a-zA-Z-] and should be understood by a version of fast-import.
+
 Crash Reports
 -------------
 If fast-import is supplied invalid input it will terminate with a
diff --git a/fast-import.c b/fast-import.c
index 812fcf0..9bf06a4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2450,6 +2450,17 @@ static void parse_one_option(const char *option)
 	}
 }
 
+static void parse_feature(void)
+{
+	char *feature = command_buf.buf + 8;
+
+	if (!prefixcmp(feature, "date-format=")) {
+		option_date_format(feature + 12);
+	} else {
+		die("This version of fast-import does not support feature %s.", feature);
+	}
+}
+
 static int git_pack_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "pack.depth")) {
@@ -2526,6 +2537,8 @@ int main(int argc, const char **argv)
 			parse_checkpoint();
 		else if (!prefixcmp(command_buf.buf, "progress "))
 			parse_progress();
+		else if (!prefixcmp(command_buf.buf, "feature "))
+			parse_feature();
 		else
 			die("Unsupported command: %s", command_buf.buf);
 	}
-- 
1.6.4.122.g6ffd7
