From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 08/10] remote-hg: update bookmarks when pulling
Date: Mon, 13 May 2013 18:11:58 -0500
Message-ID: <1368486720-2716-9-git-send-email-felipe.contreras@gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 01:15:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc1xO-0007bL-Fk
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 01:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517Ab3EMXO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 19:14:57 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:51653 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab3EMXOz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 19:14:55 -0400
Received: by mail-ob0-f180.google.com with SMTP id xk17so5163912obc.11
        for <git@vger.kernel.org>; Mon, 13 May 2013 16:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=SrIhD/ZpPRFfuy31IvlDXqg1HRqjYQ9PT8EhMm/09uA=;
        b=YLBrJNlUAjD1WQFCYeM/BZNRQbrHnQbijwuGNhiTC86+g4oF90cZD/9HOJlwm9D6wR
         xyEw8r3edzaznZOhCrRolK/LdlYK3fADiHro/UFHA5QqqQoXXIwb/d7xVevV+qVS9Z99
         ZdUGwRHohiHDkX/7UxKQt/lN3J/4swZcfDrSP1b8vPFbrng6nr2ACfH7WbMzAeQgnIgD
         A8/TOtSAgV53PbuAyzlbq952DrxldHN2pOOkgmZRQDRnPS+fvVeqTo+4b2RteU8WTrhG
         5F48lke0woVKDV2JZ2864LumgW0WF6H7+jKTaUhl4DQJK7GQ7+1BeON9jM4uwgra5bRV
         7D4Q==
X-Received: by 10.60.93.37 with SMTP id cr5mr14649992oeb.112.1368486895240;
        Mon, 13 May 2013 16:14:55 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm19277133oep.1.2013.05.13.16.14.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 16:14:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224226>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index beb864b..dc276af 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -363,6 +363,9 @@ def get_repo(url, alias):
                 die('Repository error')
             repo.pull(peer, heads=None, force=True)
 
+        rb = peer.listkeys('bookmarks')
+        bookmarks.updatefromremote(myui, repo, rb, url)
+
     return repo
 
 def rev_to_mark(rev):
-- 
1.8.3.rc1.579.g184e698
