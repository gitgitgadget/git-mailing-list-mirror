From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 06/12] connect: Fix custom ports with plink (Putty's
 ssh)
Date: Wed,  2 Jul 2008 10:32:06 +0200
Message-ID: <1214987532-23640-6-git-send-email-prohaska@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de>
Reply-To: prohaska@zib.de
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>, "Edward Z. Yang" <edwardzyang@thewritingpot.com>, Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 10:33:37 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxmH-0001FL-3u
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 10:33:25 +0200
Received: by yw-out-2122.google.com with SMTP id 8so2058156yws.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 01:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=1NsY7nPRgQy1T9fFlA+n+A+novVNTGaP2c3YN03sb7w=;
        b=2VTYSjz+/xCJhQKQZGNsLLVDUNx4SiOJxjShM/yQNZv6wRfP3kolEtapLX80G+RxhR
         KGGKwel8B5ik3NUPhbGe1yNCffBc8TQmM4t1BG00c3KbkIpf4FQIZqLWNb+KQUC5p9ON
         DWPFWoAHKFQW8FyymystD06modRk4mvCgDJr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere;
        b=U7JqKTDQalrkITOM3aqfT1amLC/Va9v9jBPadBQI2+MrwdmwAt3Gz3Uydywu4mrVS4
         hNg6eXqRRRRbf7e18g1AkHuSJ6KYgbmz2d2l55V5vkbkr3MpPZXxSsgKBKk13D2MKQkU
         c3SZj1HmdFSm1xbdT6TfbWzw19Ns/771+8o00=
Received: by 10.141.27.16 with SMTP id e16mr483584rvj.6.1214987545431;
        Wed, 02 Jul 2008 01:32:25 -0700 (PDT)
Received: by 10.106.239.31 with SMTP id m31gr2555prh.0;
	Wed, 02 Jul 2008 01:32:25 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.92.10 with SMTP id p10mr8846342agb.5.1214987544714; Wed, 02 Jul 2008 01:32:24 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 22si7829203yxr.2.2008.07.02.01.32.24; Wed, 02 Jul 2008 01:32:24 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m628WEVT019116; Wed, 2 Jul 2008 10:32:23 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7]) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m628WC0N017527; Wed, 2 Jul 2008 10:32:13 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1214987532-23640-5-git-send-email-prohaska@zib.de>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87114>


From: Edward Z. Yang <edwardzyang@thewritingpot.com>

PuTTY requires -P while OpenSSH requires -p; if plink is detected
as GIT_SSH, use the alternate flag.

Signed-off-by: Edward Z. Yang <edwardzyang@thewritingpot.com>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 connect.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/connect.c b/connect.c
index 574f42f..0d007f3 100644
--- a/connect.c
+++ b/connect.c
@@ -599,11 +599,13 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 	conn->argv = arg = xcalloc(6, sizeof(*arg));
 	if (protocol == PROTO_SSH) {
 		const char *ssh = getenv("GIT_SSH");
+		int putty = ssh && strstr(ssh, "plink");
 		if (!ssh) ssh = "ssh";
 
 		*arg++ = ssh;
 		if (port) {
-			*arg++ = "-p";
+			/* P is for PuTTY, p is for OpenSSH */
+			*arg++ = putty ? "-P" : "-p";
 			*arg++ = port;
 		}
 		*arg++ = host;
-- 
1.5.6.1.255.g32571
