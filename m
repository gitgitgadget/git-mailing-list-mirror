From: Sven Strickroth <sven@cs-ware.de>
Subject: Re: [PATCH 1/2] MSVC: vsnprintf in Visual Studio 2015 doesn't need
 SNPRINTF_SIZE_CORR any more
Date: Tue, 29 Mar 2016 21:13:33 +0200
Message-ID: <56FAD3DD.4060009@cs-ware.de>
References: <56FAAC78.2040304@cs-ware.de>
 <CAHGBnuP1Y1F-CrQJx9zNKSv1KP7gH86WSKo7tbmcYT3Vf2cQ_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	blees@dcon.de
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:13:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akz5J-0005Om-4t
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbcC2TNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 15:13:45 -0400
Received: from srv1.79p.de ([213.239.234.118]:53572 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553AbcC2TNo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 15:13:44 -0400
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:88:6f26:c00:d0ba:9b5:8751:68b6] (p200300886F260C00D0BA09B5875168B6.dip0.t-ipconnect.de [IPv6:2003:88:6f26:c00:d0ba:9b5:8751:68b6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id E3DF8224474;
	Tue, 29 Mar 2016 21:13:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2015b; t=1459278820;
	bh=Pp1drHqLhsbFAKt866ueYNWiFEQH93Ax0n5UbnWCPRM=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To;
	b=u8YnBhcrHOY1LEMomXQX/u0YlL+y2cTNLBkq5OxKvTEV3qB8xL7lbC1BJUZLOB+aH
	 PxRlBXM0pWrK8LI+qrf3CxFo6iVhDLqKcEf+mwk6PhQSNd/PUMbFhO3OdWYMXUMPqy
	 20uOgO1EMUfmAkzbn08+IeIj9zINMaGx/sgZkvqE23MoCh7HIupXWJvqS8iyeV2ZoF
	 ZVUkk0FPeC2uWlCqW5IVenEThLoxe9+p9M2BJdHFVQZuC2UZIMlnzLOoTqnyz+mo2Z
	 tvBRIKkW3thm8mazJXwjMXJakFN5TvTj73nESANaxcojQFyLNrhsaMKqzFu03d+bkK
	 IpzeKj/UK51kA==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CAHGBnuP1Y1F-CrQJx9zNKSv1KP7gH86WSKo7tbmcYT3Vf2cQ_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290164>

"Beginning with the UCRT in Visual Studio 2015 and Windows 10,
vsnprintf is no longer identical to _vsnprintf. The vsnprintf function
complies with the C99 standard; _vnsprintf is retained for backward
compatibility" [1]

W/o this fix there is one character missing at the end.

[1] https://msdn.microsoft.com/en-us/library/1kt27hek.aspx

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
