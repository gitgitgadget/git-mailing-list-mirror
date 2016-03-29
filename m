From: Sven Strickroth <sven@cs-ware.de>
Subject: [PATCH 1/2] MSVC: vsnprintf in Visual Studio 2015 doesn't need
 SNPRINTF_SIZE_CORR any more
Date: Tue, 29 Mar 2016 18:25:28 +0200
Message-ID: <56FAAC78.2040304@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>, blees@dcon.de
X-From: git-owner@vger.kernel.org Tue Mar 29 18:25:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akwSe-0005uU-Hx
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 18:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757557AbcC2QZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 12:25:40 -0400
Received: from srv1.79p.de ([213.239.234.118]:50229 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757543AbcC2QZj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 12:25:39 -0400
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:88:6f26:c00:d0ba:9b5:8751:68b6] (p200300886F260C00D0BA09B5875168B6.dip0.t-ipconnect.de [IPv6:2003:88:6f26:c00:d0ba:9b5:8751:68b6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id F30352249F2;
	Tue, 29 Mar 2016 18:25:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2015b; t=1459268734;
	bh=lCsIDDTSGF23qA2L2qY7rEgb5SwuS2w6n+LUaD2cpnk=;
	h=To:From:Subject:Date;
	b=dbELbWBW6TXZQTGa5JB22fO9WUbxE2gjqur2w+Qv8hAqJgrG6jnlE93GWutq1gD69
	 tX5FD7jn5lNplZxIyCZERNUa7oqFN9viQCSp5lTN6xXAVm4PQjgz3d+YeUS8p7IfuM
	 RKIgqZgVlwjIPWOyD2EwnO/tHY3zpn30N2pzHIk1I3OhIQpzTYhUnqMOLmQ/d2l53+
	 UbBYoK4HdwlFCaji2pAqIMPQEavLm6O5psKwPHckoYa1wdDvIw1XoQjRB0cPNwPjpk
	 BsgH+AqDUP3sxitD+1nT7hbF04eMjGSJw7Pohsu4gCl6DtvCKUFhkAGSOY6GpL9Lr/
	 5yfhqrwK45fOg==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290143>

In MSVC2015 the behavior of vsnprintf was changed.
W/o this fix there is one character missing at the end.

Signed-off-by: Sven Strickroth <sven@cs-ware.de>
---
 compat/snprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/snprintf.c b/compat/snprintf.c
index 42ea1ac..0b11688 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -9,7 +9,7 @@
  * always have room for a trailing NUL byte.
  */
 #ifndef SNPRINTF_SIZE_CORR
-#if defined(WIN32) && (!defined(__GNUC__) || __GNUC__ < 4)
+#if defined(WIN32) && (!defined(__GNUC__) || __GNUC__ < 4) && (!defined(_MSC_VER) || _MSC_VER < 1900)
 #define SNPRINTF_SIZE_CORR 1
 #else
 #define SNPRINTF_SIZE_CORR 0
-- 
2.7.4.windows.1
