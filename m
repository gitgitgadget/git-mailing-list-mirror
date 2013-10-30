From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Oct 2013, #07; Mon, 28)
Date: Wed, 30 Oct 2013 17:51:58 +0100
Message-ID: <5271392E.8020003@web.de>
References: <xmqqr4b5dwke.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 30 17:52:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZ0E-00068W-Ag
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 17:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674Ab3J3QwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 12:52:14 -0400
Received: from mout.web.de ([212.227.17.11]:49730 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534Ab3J3QwL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 12:52:11 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LbJ4A-1W4oCZ3SQ6-00kvLF for <git@vger.kernel.org>;
 Wed, 30 Oct 2013 17:52:10 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqr4b5dwke.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:vCqDJeCFS63SMUUPX9sCRvztdSLLnfTUk29BP2jvUffeScJg9nx
 I2xDSUXLqMLSXsOZKlizi2C3I63gMm1Y70cROCoSbLdHrJRqsWs3OyEsvPElrSttGZaueR2
 xJtPChtcPk3L71V+BjJneh5YroaED4emJl018Pjw08aDXc1uvgPRyOG314QSqvStFFWaAGt
 kqwVqVKjqaBp7cOzWiDXA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237034>

On 2013-10-28 20.28, Junio C Hamano wrote:
> * jk/pack-bitmap (2013-10-28) 20 commits
There is a name clash under cygwin 1.7 (1.5 is OK)
The following "first aid hot fix" works for me:
/Torsten

$ git diff
diff --git a/compat/bswap.h b/compat/bswap.h
index ea1a9ed..8dc39be 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -64,7 +64,7 @@ static inline uint32_t git_bswap32(uint32_t x)
 #      if defined(__GNUC__) && defined(__GLIBC__)
 #              include <byteswap.h>
 #      else /* GNUC & GLIBC */
-static inline uint64_t bswap_64(uint64_t val)
+static inline uint64_t git_bswap_64(uint64_t val)
 {
        return ((val & (uint64_t)0x00000000000000ffULL) << 56)
                | ((val & (uint64_t)0x000000000000ff00ULL) << 40)
@@ -76,8 +76,8 @@ static inline uint64_t bswap_64(uint64_t val)
                | ((val & (uint64_t)0xff00000000000000ULL) >> 56);
 }
 #      endif /* GNUC & GLIBC */
-#      define ntohll(n) bswap_64(n)
-#      define htonll(n) bswap_64(n)
+#      define ntohll(n) git_bswap_64(n)
+#      define htonll(n) git_bswap_64(n)
 #else /* __BYTE_ORDER */
 #      error "Can't define htonll or ntohll!"
 #endif
