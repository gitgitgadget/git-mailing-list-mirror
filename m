From: Sven Strickroth <sven@cs-ware.de>
Subject: [PATCH 2/3] mingw.h: Define only if necessary
Date: Thu, 09 May 2013 03:13:00 +0200
Message-ID: <518AF81C.10302@cs-ware.de>
References: <518AF79A.5000408@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 03:20:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFXC-0002wd-8N
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285Ab3EIBUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:20:06 -0400
Received: from srv1.79p.de ([213.239.234.118]:33164 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755012Ab3EIBUE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:20:04 -0400
Received: from [192.168.0.20] (p5B03ACDA.dip0.t-ipconnect.de [91.3.172.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 8A08C44104E;
	Thu,  9 May 2013 03:12:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
	s=mail2013; t=1368061979;
	bh=hG+TS1MJlSFmJHsElMWNzP/Tji7+0AiPY14xLdT94vg=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=LMSe2bJ02TfokAdzGSUaWpt6IOgQu2TgkMavlLhtKyeuONUKk/Ubi4GqJfw2DNcNX
	 7tqyBFF4LPLYww52GA9HcOkCXPXJcX4t51Um9mrjHvAgHhMkxqHOqVcqzzcucoGwpR
	 EskvdRfYFP5btspYyGVoJZFVJ8MbV9w9yaKZ8Mts=
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <518AF79A.5000408@cs-ware.de>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223702>

Since the latest version of MSVC EWOULDBLOCK, EAFNOSUPPORT and
ECONNABORTED are defined in errno.h. When used with MSVC mingw.h
is included from msvc.h and causes warnings about redefinitions.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 compat/mingw.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index 685cd2c..c424333 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -32,7 +32,9 @@ typedef int socklen_t;
 #define WEXITSTATUS(x) ((x) & 0xff)
 #define WTERMSIG(x) SIGTERM
 
+#ifndef EWOULDBLOCK
 #define EWOULDBLOCK EAGAIN
+#endif
 #define SHUT_WR SD_SEND
 
 #define SIGHUP 1
@@ -46,8 +48,12 @@ typedef int socklen_t;
 #define F_SETFD 2
 #define FD_CLOEXEC 0x1
 
+#ifndef EAFNOSUPPORT
 #define EAFNOSUPPORT WSAEAFNOSUPPORT
+#endif
+#ifndef ECONNABORTED
 #define ECONNABORTED WSAECONNABORTED
+#endif
 
 struct passwd {
 	char *pw_name;
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
