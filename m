From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v5 1/5] http.c: fix parsing of http.sslCertPasswordProtected variable
Date: Mon, 15 Jul 2013 02:50:58 -0700
Message-ID: <49c213ce55978a1a655d8ea0d851974@f74d39fa044aa309eaea14b9f57fe79>
References: <506e5f642a838b95e0dd5b1f0fa1cfe@f74d39fa044aa309eaea14b9f57fe79>
Cc: David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 11:51:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyfRA-0006Vx-54
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 11:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab3GOJvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 05:51:16 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:61385 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725Ab3GOJvO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 05:51:14 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so11022215pbc.25
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 02:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kg88L0doX7BT0cgoZSnfF0eoQz5IfeckEispQwK4j2Y=;
        b=X2dxSdXhe+Mr/NbwxvAAkSWPbo3Dvwg+fG9QnyWpe/S/nh6NYNpC64RHA1z8OV0aR/
         mDxEnc/cbr6jSxc/pXzLsWRq+EL1+nUm9CgleJoCQDvTdlaBlpLrg+I5WfZ4HqRKp+cv
         ljtEMtNgxeuTiv9QkcSNUDjTouzO7gI4OdQbdpXT83iDZ2TNuPgK5iudL5qm81XGsxu0
         Pd+Y1KTD48t0j84TaDYC1BGVAjUsKeG8AvCeYoDim0nustOrAjwjULfYJ8kWJUa91dOS
         lAnrAQr41nzqvsw2slkRoIcdYJoXf/DZIfXZcEh8nsorc1teC6HIrAY2o3YmVTY9ZST1
         eXOQ==
X-Received: by 10.68.103.228 with SMTP id fz4mr52986937pbb.101.1373881873871;
        Mon, 15 Jul 2013 02:51:13 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id wr9sm60041274pbc.7.2013.07.15.02.51.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 02:51:12 -0700 (PDT)
In-Reply-To: <506e5f642a838b95e0dd5b1f0fa1cfe@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230450>

From: Junio C Hamano <gitster@pobox.com>

The existing code triggers only when the configuration variable is
set to true.  Once the variable is set to true in a more generic
configuration file (e.g. ~/.gitconfig), it cannot be overriden to
false in the repository specific one (e.g. .git/config).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 2d086ae..e65661e 100644
--- a/http.c
+++ b/http.c
@@ -160,8 +160,7 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.sslcainfo", var))
 		return git_config_string(&ssl_cainfo, var, value);
 	if (!strcmp("http.sslcertpasswordprotected", var)) {
-		if (git_config_bool(var, value))
-			ssl_cert_password_required = 1;
+		ssl_cert_password_required = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp("http.ssltry", var)) {
-- 
1.8.3
