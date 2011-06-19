From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 08/20] remote-curl: accept empty line as terminator
Date: Sun, 19 Jun 2011 17:18:33 +0200
Message-ID: <1308496725-22329-9-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:20:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJnX-00042G-58
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421Ab1FSPUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:20:00 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44389 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358Ab1FSPTp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:19:45 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so981213ewy.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Y7Me1THizUDbEz+EHf95fUHdL5cTnlQPZWYGJa2Clu4=;
        b=Pu8cbC1FhCGAPPSh7WaiyZoSIvcdyfRUJE6jqgMCffThwTO3Gxe+2Qjv0v9sWQnsRh
         ZkEIo3AyzR5Zp2LJefuOC32KykAGmjkRiyPsBnqiAIIHefqoUSjMxFl/+8Q8ccilJ3WI
         2pyCj/OWs79MRV+ZTUTtyu60pP6WgDNj8Dlkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WqV7lTslMgau1+gCOSfkwSW+dYKIUsPeJLjPW/idJwdKS6uZLtFHNqEDOOuKrOYSwc
         BvWYEwoYBm+MIofYET0BKg3A1NTijXdbRsWSfIvmtyQw6q1+VNguO8U9tk718MffV6Ow
         ioXBptQH0pocass2yndibB38S8V0ECrqfykwk=
Received: by 10.213.28.194 with SMTP id n2mr400219ebc.2.1308496785005;
        Sun, 19 Jun 2011 08:19:45 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.19.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:19:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176013>

This went unnoticed because the transport helper infrastructore did
not check the return value of the helper, nor did the helper print
anything before exiting.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged.

 remote-curl.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 17d8a9b..7e8d50f 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -857,6 +857,8 @@ int main(int argc, const char **argv)
 	do {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF)
 			break;
+		if (buf.len == 0)
+			break;
 		if (!prefixcmp(buf.buf, "fetch ")) {
 			if (nongit)
 				die("Fetch attempted without a local repo");
@@ -895,6 +897,7 @@ int main(int argc, const char **argv)
 			printf("\n");
 			fflush(stdout);
 		} else {
+			fprintf(stderr, "Unknown command '%s'\n", buf.buf);
 			return 1;
 		}
 		strbuf_reset(&buf);
-- 
1.7.5.1.292.g728120
