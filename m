From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v4 14/15] daemon: use socklen_t
Date: Mon, 11 Oct 2010 23:50:28 +0200
Message-ID: <1286833829-5116-15-git-send-email-kusmabite@gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 11 23:53:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5QIz-0006uy-3o
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 23:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648Ab0JKVxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 17:53:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36668 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565Ab0JKVxI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 17:53:08 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so833577ewy.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 14:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Q1ThQ8kKoFJlV9GROE1Z5OaQ+wG30j7ju29StZavxzQ=;
        b=s20TxxkK9l1RFwvyTLa1i4mn4xw7kcxrjwDqfqolDZzs6PRx5K1fNY0M9Jv3YhrHMy
         cYcKGYn94iaD9bQP3ukkQwjjEj+rNbocthjh6dt3Z7P8RTaZqFx4di0X86qcMP7/BhF6
         Lq7xyVVRF0lE/1uv1WOR2/SiLy4Jh1I2WH7I4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=M43uGnDAFk2AVuoVbcOl3uGeZm57kNj5+rPzUy+PSZq/OeGVDbNpKmXQx5PIJJDtt6
         DXZbFULhljLu9EddYCjAB3rI3tHFyCLR2y9lS2D6oJePioapj+K9Spu8pIgb7ruRwpgU
         UMFavzOBWkD6p9iwdIB7tGb2vRMHyHv9Za8Eg=
Received: by 10.213.56.6 with SMTP id w6mr2018631ebg.32.1286833988069;
        Mon, 11 Oct 2010 14:53:08 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id z55sm11652725eeh.15.2010.10.11.14.53.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 14:53:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158806>

---
 daemon.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/daemon.c b/daemon.c
index 1574f75..9b97b58 100644
--- a/daemon.c
+++ b/daemon.c
@@ -593,7 +593,7 @@ static struct child {
 	struct sockaddr_storage address;
 } *firstborn;
 
-static void add_child(struct child_process *cld, struct sockaddr *addr, int addrlen)
+static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child *newborn, **cradle;
 
@@ -672,7 +672,7 @@ static char *get_addrstr(int *port, struct sockaddr *addr)
 }
 
 static char **cld_argv;
-static void handle(int incoming, struct sockaddr *addr, int addrlen)
+static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child_process cld = { 0 };
 	char *addrstr, envbuf[300] = "REMOTE_ADDR=";
@@ -908,7 +908,7 @@ static int service_loop(struct socketlist *socklist)
 		for (i = 0; i < socklist->nr; i++) {
 			if (pfd[i].revents & POLLIN) {
 				struct sockaddr_storage ss;
-				unsigned int sslen = sizeof(ss);
+				socklen_t sslen = sizeof(ss);
 				int incoming = accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
-- 
1.7.3.1.199.g72340
