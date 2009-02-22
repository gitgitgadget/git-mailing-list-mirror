From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] 'tig branch' opens tig in branch view
Date: Sun, 22 Feb 2009 12:40:20 +0100
Message-ID: <1235302820-32526-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1235302820-32526-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 12:41:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbCic-00055S-LT
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 12:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbZBVLke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 06:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753819AbZBVLkc
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 06:40:32 -0500
Received: from mail-fx0-f167.google.com ([209.85.220.167]:63632 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711AbZBVLka (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 06:40:30 -0500
Received: by fxm11 with SMTP id 11so928551fxm.13
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 03:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=P6PMF213Va9VVynTuIajLSw7+RQkkTG8VQ0u/htJS6A=;
        b=HX65lH3iBkZw9pxORPvf3ZqUUV3JRs+vhgAHIv0vJgmXbYkbtEYq15jtzEGmNQLPup
         tNpNrICfcUWY5m8Vca6M81earV4MPPy21oe/38K8oEZYcEjpnR5E4yjG9vcdAtr8DwaW
         gesgSlmmS+9t8fIDxsqGYehMQ6yufb4Wuw7/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mOC7ratxoisSn4o8r9AH/CMDRKFiGx0T3hIvoSQMUPDM7JObsvCh1GNivV1/9PymgM
         9m8KEAfgyRBP6rt2tNCxrfjw3H6EFnbUuzZyyT551qrS3KZ0xOtByVoyDInaB0PLq6JA
         hWa/pTdIWiV+4oeQazpd9cqyj5HTSq1HXIEg0=
Received: by 10.103.241.15 with SMTP id t15mr2764353mur.85.1235302827488;
        Sun, 22 Feb 2009 03:40:27 -0800 (PST)
Received: from localhost ([94.37.0.89])
        by mx.google.com with ESMTPS id b9sm314906mug.32.2009.02.22.03.40.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 03:40:26 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.258.g1d592.dirty
In-Reply-To: <1235302820-32526-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110999>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 tig.1.txt |    4 ++++
 tig.c     |    6 ++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/tig.1.txt b/tig.1.txt
index db8a4d7..abcd9f3 100644
--- a/tig.1.txt
+++ b/tig.1.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 tig        [options] [revisions] [--] [paths]
 tig show   [options] [revisions] [--] [paths]
 tig blame  [rev] path
+tig branch
 tig status
 tig <      [git command output]
 
@@ -43,6 +44,9 @@ blame::
 	Show given file annotated or blamed by commits.
 	Optionally limited from given revision.
 
+branch::
+	Start up in branch view.
+
 status::
 	Start up in status view.
 
diff --git a/tig.c b/tig.c
index 60d73d5..20a40b9 100644
--- a/tig.c
+++ b/tig.c
@@ -7249,6 +7249,7 @@ static const char usage[] =
 "Usage: tig        [options] [revs] [--] [paths]\n"
 "   or: tig show   [options] [revs] [--] [paths]\n"
 "   or: tig blame  [rev] path\n"
+"   or: tig branch\n"
 "   or: tig status\n"
 "   or: tig <      [git command output]\n"
 "\n"
@@ -7321,6 +7322,11 @@ parse_options(int argc, const char *argv[])
 			warn("ignoring arguments after `%s'", subcommand);
 		return REQ_VIEW_STATUS;
 
+	} else if (!strcmp(subcommand, "branch")) {
+		if (argc > 2)
+			warn("ignoring arguments after `%s'", subcommand);
+		return REQ_VIEW_BRANCH;
+
 	} else if (!strcmp(subcommand, "blame")) {
 		if (argc <= 2 || argc > 4)
 			die("invalid number of options to blame\n\n%s", usage);
-- 
1.6.2.rc1.258.g1d592.dirty
