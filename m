From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v6 3/6] fast-import: add feature command
Date: Wed,  2 Sep 2009 19:57:00 +0200
Message-ID: <1251914223-31435-4-git-send-email-srabbelier@gmail.com>
References: <1251914223-31435-1-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-2-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-3-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Wed Sep 02 19:58:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Miu6B-0007Zr-U0
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 19:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbZIBR5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 13:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbZIBR5f
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 13:57:35 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:48496 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbZIBR5e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 13:57:34 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so909246bwz.37
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wsp31gtehHJ+9bDob+l2dWx9lz98kO/Qibs/OEKO44U=;
        b=cxnR9ietfEi1O919rBW2ILhkzPivL06dAnFfCAYbVuI1KLXZFoIUXvOxU9iuNtaCO8
         FPhUxo/Sbn3KokZyrPtkWuJIs0dkg37/r9z9PyTgUU4VgAwfOadNEBfx0heUrsgDyhKx
         +L0VYjacOc+mxTiqbNQsr7l5h0fxthWUJsCVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XF+XPCwVxycpewlqVum2L9o8ABqpNAjYTb4GgGOyJARNOFvBbhGnz6jbKetXV/J64F
         WvlBuA6+NPMd2AcF7w052Qs7QgyuNciVy/jZzAWndIQSCWThm4uBO1Z+LWaToKRSdTlX
         MtNgVZUcEHYVN3V4LPLyOVyly30GplFi/tpzg=
Received: by 10.204.143.141 with SMTP id v13mr6950620bku.133.1251914256262;
        Wed, 02 Sep 2009 10:57:36 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 21sm325505fks.9.2009.09.02.10.57.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Sep 2009 10:57:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1251914223-31435-3-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127616>

This allows the fronted to require a specific feature to be supported
by the frontend, or abort.

Also add support for the first feature, date-format=.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  No longer RFC.

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
1.6.4.16.g72c66.dirty
