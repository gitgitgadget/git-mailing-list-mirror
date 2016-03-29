From: Sven Strickroth <sven@cs-ware.de>
Subject: Re: [PATCH 2/2 V2] MSVC: VS2013 comes with inttypes.h
Date: Tue, 29 Mar 2016 19:23:09 +0200
Message-ID: <56FAB9FD.7080409@cs-ware.de>
References: <56FAACD4.9080504@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>, blees@dcon.de
X-From: git-owner@vger.kernel.org Tue Mar 29 19:23:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akxMT-0007b1-5e
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 19:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbcC2RXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 13:23:21 -0400
Received: from srv1.79p.de ([213.239.234.118]:51339 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752781AbcC2RXU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 13:23:20 -0400
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:88:6f26:c00:d0ba:9b5:8751:68b6] (p200300886F260C00D0BA09B5875168B6.dip0.t-ipconnect.de [IPv6:2003:88:6f26:c00:d0ba:9b5:8751:68b6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 00940224477;
	Tue, 29 Mar 2016 19:23:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2015b; t=1459272195;
	bh=vHSKyoCqqP9lf8WDdf8I+TBgATpDQya8S2GaqrbbMuE=;
	h=Subject:To:References:From:Date:In-Reply-To;
	b=UGY6T5FMwEaPnfAtWB+idlz6aWPz7OiTqFqOxmjLJsjYGpsijuY0fzwDdU+tbCaOj
	 NVHX+eKY70FlgliIVSL+EPjcxMpcxmSvFePFgRrSjIA3wICWpersy55NhKVybXmeE9
	 aJJ1k6Hvm6mdJzSDyJdbUb/NvQjC5TTOXxYxzcukIqIZ54A322a63f49Ibxvtb7Afm
	 XRtXLh08slOhZquBqWTlxu6/j2BBYVYWX0IVvN75x56ViDGf3Nosd4BOTVh536QKNN
	 SM0LU9N1TbU6stSMfQnmqCaMZ39dIA3Dv21Ec5T+ko7cjZMGMyIQiIrdn6+DmEFD1E
	 1jfxQOSwZzLiw==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <56FAACD4.9080504@cs-ware.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290149>

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 compat/mingw.h                  | 2 +-
 compat/vcbuild/include/unistd.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 6b6d695..137f42e 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -415,7 +415,7 @@ int mingw_offset_1st_component(const char *path);
 extern void build_libgit_environment(void);
 extern const char *program_data_config(void);
 #define git_program_data_config program_data_config
-#ifndef __MINGW64_VERSION_MAJOR
+#if !defined(__MINGW64_VERSION_MAJOR) && (!defined(_MSC_VER) || _MSC_VER < 1800)
 #define PRIuMAX "I64u"
 #define PRId64 "I64d"
 #else
diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
index c65c2cd..b7cc48c 100644
--- a/compat/vcbuild/include/unistd.h
+++ b/compat/vcbuild/include/unistd.h
@@ -45,11 +45,15 @@ typedef unsigned long long uintmax_t;
 
 typedef int64_t off64_t;
 
+#if !defined(_MSC_VER) || _MSC_VER < 1800
 #define INTMAX_MIN  _I64_MIN
 #define INTMAX_MAX  _I64_MAX
 #define UINTMAX_MAX _UI64_MAX
 
 #define UINT32_MAX 0xffffffff  /* 4294967295U */
+#else
+#include<inttypes.h>
+#endif
 
 #define STDIN_FILENO  0
 #define STDOUT_FILENO 1
-- 
2.7.4.windows.1
