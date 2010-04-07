From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] remote-curl: ensure that URLs do not have a trailing slash
Date: Wed,  7 Apr 2010 22:51:32 +0800
Message-ID: <1270651892-5712-1-git-send-email-rctay89@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 07 16:51:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzWbk-0005og-Bj
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 16:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631Ab0DGOvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 10:51:51 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:49248 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932604Ab0DGOvu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 10:51:50 -0400
Received: by bwz1 with SMTP id 1so897224bwz.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=GZiXhIf5qLXGtkwnOIMfytc1c9wt15X1EGLZevpsIFE=;
        b=lPXaZc1J2rEs/WV010DZNgV9uMMc4f0Lbi99VQp0GyOY3HcK779kKtMBSXMrIEu2RF
         htV8ngw3hdukM4w9y2ygl+jR44+arJCIom2vnfDNzKCx3p5n5rkzHgKdPzsLyxfUU5UO
         CMfcvQP7FK5TNMsaZkf1LwBMhCUZjaELuBZwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BgMlQyD+sRa2HTvnU/Hi8XH9dkKe/1EPMDjOxR5WDDWftbE2627zY6dERvaQox8UzA
         qmU7TY9Xjq/5HMF2xqScmpi53xNfzGj6BmGHiPhXNmpfmZpF0Lt7lxsuUq8HVrmpd7sY
         24Rc2pktXnBUr57z/+NDnmAXIGilJq4otbcBc=
Received: by 10.204.127.70 with SMTP id f6mr54927bks.76.1270651908932;
        Wed, 07 Apr 2010 07:51:48 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id 13sm6935723bwz.3.2010.04.07.07.51.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 07:51:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144230>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 remote-curl.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 0782756..0f21f8a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -101,7 +101,8 @@ static struct discovery* discover_refs(const char *service)
 		return last;
 	free_discovery(last);
 
-	strbuf_addf(&buffer, "%s/info/refs", url);
+	end_url_with_slash(&buffer, url);
+	strbuf_addstr(&buffer, "info/refs");
 	if (!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) {
 		is_http = 1;
 		if (!strchr(url, '?'))
@@ -120,7 +121,8 @@ static struct discovery* discover_refs(const char *service)
 		strbuf_reset(&buffer);
 
 		proto_git_candidate = 0;
-		strbuf_addf(&buffer, "%s/info/refs", url);
+		end_url_with_slash(&buffer, url);
+		strbuf_addstr(&buffer, "info/refs");
 		refs_url = strbuf_detach(&buffer, NULL);
 
 		http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
@@ -511,7 +513,8 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	rpc->out = client.out;
 	strbuf_init(&rpc->result, 0);
 
-	strbuf_addf(&buf, "%s/%s", url, svc);
+	end_url_with_slash(&buf, url)
+	strbuf_addf(&buf, "%s", svc);
 	rpc->service_url = strbuf_detach(&buf, NULL);
 
 	strbuf_addf(&buf, "Content-Type: application/x-%s-request", svc);
-- 
1.7.0.20.gcb44ed
