From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC PATCH v5a 3/6] fast-import: add feature command
Date: Thu, 27 Aug 2009 11:40:28 -0700
Message-ID: <1251398431-12461-4-git-send-email-srabbelier@gmail.com>
References: <1251398431-12461-1-git-send-email-srabbelier@gmail.com>
 <1251398431-12461-2-git-send-email-srabbelier@gmail.com>
 <1251398431-12461-3-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Thu Aug 27 20:41:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgjup-0007FJ-9M
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 20:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbZH0SlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 14:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbZH0SlM
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 14:41:12 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:56292 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbZH0SlL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 14:41:11 -0400
Received: by mail-ew0-f206.google.com with SMTP id 2so1486483ewy.17
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 11:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YktisYQMc9t8SJ7QqDcLKKSgvuP8Trl0aS8aO1axFxs=;
        b=IAXg2ZWbIXvZQUeHqeJst+wwvLdbggqigC2P+0CGuQAFI5Focw0fqKXF0Vxp7N63Lc
         o+7TH6F8FV507yzBTv+mz4IApC3TB8SBQRHl9hpWMlNlCv2Yz7Sp9IXxDgxCFPC1Mk/7
         HtuY3LtiSC0De21+rNV3BsEVLo6P8wS4dfJgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=H0p8zeGWJCY9uQq55iyX4LJ2Yb6dvte7R1mt4CdOKC8/GMfQqQ4OHtgiK2SFmLCrXs
         ogExFgpqAXpvjvYP0VX5poJgdy+/gb0W/8xRQJJAvdB/QJ3fr7qzUDv0zOS6ySDQ9ou6
         UvvDzwZfmNVzZFMxDCYYInDO+m1mENZI/g5Po=
Received: by 10.216.52.76 with SMTP id d54mr20572wec.119.1251398471671;
        Thu, 27 Aug 2009 11:41:11 -0700 (PDT)
Received: from localhost.localdomain (kaayla.mtv.corp.google.com [172.22.72.177])
        by mx.google.com with ESMTPS id i35sm1687558gve.26.2009.08.27.11.41.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Aug 2009 11:41:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <1251398431-12461-3-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127192>

This allows the fronted to require a specific feature to be supported
by the frontend, or abort.

Also add support for the first feature, date-format=.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	New in this series, currently RFC. This should make it easier
	for frontends to specify their needs.

	Also fixed from line.

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
