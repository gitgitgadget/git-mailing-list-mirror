From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v4 6/6] transport-helper.c::push_refs(): emit "no refs" error message
Date: Fri,  8 Jan 2010 10:12:45 +0800
Message-ID: <1262916765-3728-7-git-send-email-rctay89@gmail.com>
References: <1262916765-3728-1-git-send-email-rctay89@gmail.com>
 <1262916765-3728-2-git-send-email-rctay89@gmail.com>
 <1262916765-3728-3-git-send-email-rctay89@gmail.com>
 <1262916765-3728-4-git-send-email-rctay89@gmail.com>
 <1262916765-3728-5-git-send-email-rctay89@gmail.com>
 <1262916765-3728-6-git-send-email-rctay89@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 03:14:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT4Mm-0005XW-4u
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 03:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352Ab0AHCOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 21:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364Ab0AHCN6
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 21:13:58 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:35828 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302Ab0AHCNz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 21:13:55 -0500
Received: by mail-yx0-f188.google.com with SMTP id 26so18313338yxe.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 18:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hr9GEKpiELzUfJgIDdQ0T09MxRCbBdSQuyVBhEx3tnA=;
        b=F063rc8DhnaOQkp23z7SDeib1hPxNOCeCjriTTpgfoTnAv8pR4sdmIVrezDebLKTZ6
         Odqh9D+SNg5AfAHZSKuIRuOZ0DNGNTU50/OZJI0Igd0kR2jNhT5VUmTuzWnE5bZ5S1f9
         GNgG++VyQckMrW1qDNcET6wJUcl5cXoQEpo9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jVYxeSSGwa8JEg8KNhk9ipZu1cJELxoMX7za1/Qy7ZLxpjL2w547YOYPb27DwSpyQu
         gAYMa5LYWqlPpXB+/1RHJrF74dFVLeZcE70xmu0GDMm2upRAwhhfEIf0VogvpjyoVjze
         8vJDCb7VVsymI5xYjuJkWLeh7hRt6phjzPVuA=
Received: by 10.101.160.12 with SMTP id m12mr19893909ano.69.1262916835023;
        Thu, 07 Jan 2010 18:13:55 -0800 (PST)
Received: from localhost.localdomain (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 14sm10999449gxk.10.2010.01.07.18.13.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 18:13:54 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1262916765-3728-6-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136411>

Emit an error message when remote_refs is not set.

This behaviour is consistent with that of builtin-send-pack.c and
http-push.c.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 transport-helper.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 71a1e50..8c0b575 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -321,8 +321,11 @@ static int push_refs(struct transport *transport,
 	struct child_process *helper;
 	struct ref *ref;
 
-	if (!remote_refs)
+	if (!remote_refs) {
+		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
+			"Perhaps you should specify a branch such as 'master'.\n");
 		return 0;
+	}
 
 	helper = get_helper(transport);
 	if (!data->push)
-- 
1.6.6.341.ga7aec
