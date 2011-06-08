From: ZAK Neronskiy <zakmagnus@google.com>
Subject: [PATCH 1/2] Fix documentation of fetch-pack that implies that the client can disconnect after sending wants.
Date: Wed,  8 Jun 2011 15:11:50 -0700
Message-ID: <1307571111-14219-1-git-send-email-zakmagnus@google.com>
Cc: Johannes.Schindelin@gmx.de, schacon@gmail.com,
	ZAK Neronskiy <zakmagnus@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 00:12:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUQyz-000608-0B
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 00:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365Ab1FHWMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 18:12:08 -0400
Received: from smtp-out.google.com ([216.239.44.51]:42415 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755640Ab1FHWMG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 18:12:06 -0400
Received: from hpaq1.eem.corp.google.com (hpaq1.eem.corp.google.com [172.25.149.1])
	by smtp-out.google.com with ESMTP id p58MC5L8029958
	for <git@vger.kernel.org>; Wed, 8 Jun 2011 15:12:05 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1307571126; bh=OjI0xXWrq66swAaWv+/AN6wnkyI=;
	h=From:To:Cc:Subject:Date:Message-Id;
	b=nFjwfvJnX22EaTJjDq3yai3AMij2Qnxf1GlxKNgPsmpHrYtPgpwhomvpq3hxtkboq
	 v2tyNaF6G8CbRa1FKfJeg==
Received: from pxi15 (pxi15.prod.google.com [10.243.27.15])
	by hpaq1.eem.corp.google.com with ESMTP id p58MBdfM017142
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 8 Jun 2011 15:12:04 -0700
Received: by pxi15 with SMTP id 15so665826pxi.33
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 15:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=cLy0yZXU1RCxau+Y7vHYa8zdNr/EdIzYIN44PaMS7EA=;
        b=acDlJzStb1amq8Y4fNzNOMbfGbDjBspPscgxjCqrsgoNfFvBct9PHT1xp7dVdnCPg0
         3giXvTmNC6lBu5HrYK/w==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sJaROXgS/2BjtD4lYjkhCftR43nB3O+N8O8par5xiGIvsx92wvMnRFAqKzM8ENUJQB
         z+ZUpRt11Ac4Xvrj7zpw==
Received: by 10.142.218.15 with SMTP id q15mr411419wfg.311.1307571123538;
        Wed, 08 Jun 2011 15:12:03 -0700 (PDT)
Received: from localhost.localdomain (outrider.mtv.corp.google.com [172.22.72.173])
        by mx.google.com with ESMTPS id k4sm828459pbl.27.2011.06.08.15.12.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 15:12:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175466>

Specify conditions under which the client can terminate the connection
early. Previously, an unintended behavior was possible which could
confuse servers.

Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Alex Neronskiy <zakmagnus@google.com>
---
 Documentation/technical/pack-protocol.txt |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 369f91d..ce69f57 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -179,18 +179,19 @@ and descriptions.
 
 Packfile Negotiation
 --------------------
-After reference and capabilities discovery, the client can decide
-to terminate the connection by sending a flush-pkt, telling the
-server it can now gracefully terminate (as happens with the ls-remote
-command) or it can enter the negotiation phase, where the client and
-server determine what the minimal packfile necessary for transport is.
-
-Once the client has the initial list of references that the server
-has, as well as the list of capabilities, it will begin telling the
-server what objects it wants and what objects it has, so the server
-can make a packfile that only contains the objects that the client needs.
-The client will also send a list of the capabilities it wants to be in
-effect, out of what the server said it could do with the first 'want' line.
+After reference and capabilities discovery, the client can decide to
+terminate the connection by sending a flush-pkt, telling the server it can
+now gracefully terminate, and disconnect, when it does not need any pack
+data. This can happen with the ls-remote command, and also can happen when
+the client already is up-to-date.
+
+Otherwise, it enters the negotiation phase, where the client and
+server determine what the minimal packfile necessary for transport is,
+by telling the server what objects it wants and what objects it has,
+so the server can make a packfile that only contains the objects that the
+client needs.  The client will also send a list of the capabilities it
+wants to be in effect, out of what the server said it could do with the
+first 'want' line.
 
 ----
   upload-request    =  want-list
@@ -219,8 +220,8 @@ If client is requesting a shallow clone, it will now send a 'deepen'
 line with the depth it is requesting.
 
 Once all the "want"s (and optional 'deepen') are transferred,
-clients MUST send a flush-pkt. If the client has all the references
-on the server, client flushes and disconnects.
+clients MUST send a flush-pkt, to tell the server side that it is
+done sending the list.
 
 TODO: shallow/unshallow response and document the deepen command in the ABNF.
 
-- 
1.7.3.1
