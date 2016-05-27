From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v8 1/9] connect: document why we sometimes call get_port after get_host_and_port
Date: Fri, 27 May 2016 11:27:48 +0900
Message-ID: <20160527022756.22904-2-mh@glandium.org>
References: <20160527022756.22904-1-mh@glandium.org>
Cc: git@vger.kernel.org, tboegi@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 27 04:28:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b67VS-0005BS-SI
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 04:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbcE0C2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 22:28:05 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40430 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932272AbcE0C2C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 22:28:02 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b67VE-0005yH-JE; Fri, 27 May 2016 11:27:56 +0900
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160527022756.22904-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295710>

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/connect.c b/connect.c
index c53f3f1..6e520c3 100644
--- a/connect.c
+++ b/connect.c
@@ -742,6 +742,13 @@ struct child_process *git_connect(int fd[2], const char *url,
 			transport_check_allowed("ssh");
 			get_host_and_port(&ssh_host, &port);
 
+			/*
+			 * get_host_and_port does not return a port in the
+			 * [host:port]:path case. In that case, it is called
+			 * with "[host:port]" and returns "host:port" and NULL.
+			 * To support this undocumented legacy we still need
+			 * to split the port.
+			 */
 			if (!port)
 				port = get_port(ssh_host);
 
-- 
2.8.3
