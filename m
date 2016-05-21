From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v7 1/9] connect: document why we sometimes call get_port after get_host_and_port
Date: Sun, 22 May 2016 08:17:24 +0900
Message-ID: <20160521231732.4888-2-mh@glandium.org>
References: <20160521231732.4888-1-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 01:18:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4G9k-0005ls-G3
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 01:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbcEUXRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 19:17:39 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:55510 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbcEUXRj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 19:17:39 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b4G9E-0001Hh-R4; Sun, 22 May 2016 08:17:32 +0900
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160521231732.4888-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295247>

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/connect.c b/connect.c
index c53f3f1..caa2a3c 100644
--- a/connect.c
+++ b/connect.c
@@ -742,6 +742,12 @@ struct child_process *git_connect(int fd[2], const char *url,
 			transport_check_allowed("ssh");
 			get_host_and_port(&ssh_host, &port);
 
+			/* get_host_and_port may not return a port even when
+			 * there is one: In the [host:port]:path case,
+			 * get_host_and_port is called with "[host:port]" and
+			 * returns "host:port" and NULL.
+			 * In that specific case, we still need to split the
+			 * port. */
 			if (!port)
 				port = get_port(ssh_host);
 
-- 
2.8.3.401.ga81c606.dirty
