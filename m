From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 10/12] Allow helpers to report in "list" command that the ref is unchanged
Date: Wed, 18 Nov 2009 02:42:30 +0100
Message-ID: <1258508552-20752-11-git-send-email-srabbelier@gmail.com>
References: <1258508552-20752-1-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-2-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-3-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-4-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-5-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-6-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-7-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-8-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-9-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-10-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 02:44:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAZas-0000vW-8m
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 02:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851AbZKRBnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 20:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756845AbZKRBnm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 20:43:42 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:40644 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756828AbZKRBnh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 20:43:37 -0500
Received: by fxm21 with SMTP id 21so682791fxm.21
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 17:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Y82WA1viIFReMV5umIW3g4AshWvtCNclVHDYB3VpfKI=;
        b=KCr9hSwIQ8JMkYK4JZ1zRoGOZvdU2th+w1S3E9t7JrMfIdIr96huS0rTIDEUWLNBfc
         d0Q8bf7X8m5EZ8mGndTwPFFSTUhamBFm1LmNPDdjhypjoZ+ZPBulMjMSeWumhC73X30y
         86NvOgx6sfHkQm6uVz/TwQenQYho9CI+qVKcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=d1Yt29PnWKu2a14oWXu5lD7/usrv0LQw5gMxhNFGbhbvogTB13m+PBVCQkBCxukLYv
         j4yqJTsItzzbYRmFUNZCXEjJW55hTyc4aRDM277w6NlRzBvGHhlbNMuVzdNRP6z96GW2
         BksWaA0JrDxJDYdihAn1PeTzMKgjWXDLKjwrc=
Received: by 10.216.85.136 with SMTP id u8mr112508wee.79.1258508622467;
        Tue, 17 Nov 2009 17:43:42 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 28sm2372670eye.3.2009.11.17.17.43.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 17:43:41 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1258508552-20752-10-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133131>

From: Daniel Barkalow <barkalow@iabervon.org>

Helpers may use a line like "? name unchanged" to specify that there
is nothing new at that name, without any git-specific code to
determine the correct response.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

	Unchanged.

 Documentation/git-remote-helpers.txt |    4 +++-
 transport-helper.c                   |   22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index d6c5268..f4b6a5a 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -84,7 +84,9 @@ CAPABILITIES
 REF LIST ATTRIBUTES
 -------------------
 
-None are defined yet, but the caller must accept any which are supplied.
+'unchanged'::
+	This ref is unchanged since the last import or fetch, although
+	the helper cannot necessarily determine what value that produced.
 
 Documentation
 -------------
diff --git a/transport-helper.c b/transport-helper.c
index 628a5ca..c87530e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -206,6 +206,22 @@ static int fetch(struct transport *transport,
 	return -1;
 }
 
+static int has_attribute(const char *attrs, const char *attr) {
+	int len;
+	if (!attrs)
+		return 0;
+
+	len = strlen(attr);
+	for (;;) {
+		const char *space = strchrnul(attrs, ' ');
+		if (len == space - attrs && !strncmp(attrs, attr, len))
+			return 1;
+		if (!*space)
+			return 0;
+		attrs = space + 1;
+	}
+}
+
 static struct ref *get_refs_list(struct transport *transport, int for_push)
 {
 	struct child_process *helper;
@@ -240,6 +256,12 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 			(*tail)->symref = xstrdup(buf.buf + 1);
 		else if (buf.buf[0] != '?')
 			get_sha1_hex(buf.buf, (*tail)->old_sha1);
+		if (eon) {
+			if (has_attribute(eon + 1, "unchanged")) {
+				(*tail)->status |= REF_STATUS_UPTODATE;
+				read_ref((*tail)->name, (*tail)->old_sha1);
+			}
+		}
 		tail = &((*tail)->next);
 	}
 	strbuf_release(&buf);
-- 
1.6.5.3.164.g07b0c
