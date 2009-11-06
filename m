From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 09/12] Allow helpers to report in "list" command that the ref is unchanged
Date: Fri,  6 Nov 2009 23:52:43 +0100
Message-ID: <1257547966-14603-10-git-send-email-srabbelier@gmail.com>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-2-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-3-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-4-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-5-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-6-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-7-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-8-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-9-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 23:55:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Xi8-00008E-VQ
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 23:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbZKFWxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 17:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbZKFWxp
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 17:53:45 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:16365 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbZKFWxl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 17:53:41 -0500
Received: by ey-out-2122.google.com with SMTP id 25so372971eya.19
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 14:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=A/NbuilOnZQET7r6uKWEQ73Vj1Piv8wZdtrnFESBctk=;
        b=oxuij1xMPwsRrvSMlvKXCBXEKT27PoPeW5heEmzCeb/1TLo7wGb8KrE2BVRmaslKQL
         4nUcjqKczJmx6KZUJe4UDEIhofl253jC0R0yjXRYiiY4QU0idJhG35WzNkj28mRwnPDe
         RTn98/eov7pegOUic13bCh6Z8Njo4f43A9pxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IKZm7NPhn4uSmWHuaXsr0o9zFbZoAAnS3acX7qYmizNba2vxUphLyfI6eWulMuBF/B
         VvrCk3zADWFPXQNBnTJXHTXNM4Wo2JwIsB4e3vpxYXF1lKo2y1x5WnA0vRF6Oro23cOU
         PmfPgMstaGv7enCIdPLw8T3xeWCvk8Av3h8+s=
Received: by 10.213.99.212 with SMTP id v20mr5897568ebn.87.1257548025037;
        Fri, 06 Nov 2009 14:53:45 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 7sm1501175eyb.40.2009.11.06.14.53.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 14:53:44 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.158.g6dacb
In-Reply-To: <1257547966-14603-9-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132339>

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
index e9aa67e..2c5130f 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -70,7 +70,9 @@ CAPABILITIES
 REF LIST ATTRIBUTES
 -------------------
 
-None are defined yet, but the caller must accept any which are supplied.
+'unchanged'::
+	This ref is unchanged since the last import or fetch, although
+	the helper cannot necessarily determine what value that produced.
 
 Documentation
 -------------
diff --git a/transport-helper.c b/transport-helper.c
index c4ab84a..d38dedf 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -194,6 +194,22 @@ static int fetch(struct transport *transport,
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
@@ -228,6 +244,12 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
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
1.6.5.2.158.g6dacb
