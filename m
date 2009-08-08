From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Sun, 09 Aug 2009 01:36:45 +0200
Message-ID: <4A7E0C0D.9060808@gmail.com>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain> <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain> <alpine.LFD.2.01.0908061909310.3390@localhost.localdomain> <alpine.LFD.2.01.0908071614310.3288@localhost.localdomain> <4A7CBD28.6070306@gmail.com> <4A7CBF47.9000903@gmail.com> <alpine.LFD.2.01.0908071700290.3288@localhost.localdomain> <4A7CC380.3070008@gmail.com> <alpine.LFD.2.01.0908072107170.3288@localhost.localdomain> <4A7D0E7B.3030601@gmail.com
 > <4A7E030E.2040301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 09 01:37:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZvTI-0002ty-1h
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 01:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbZHHXgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 19:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140AbZHHXgt
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 19:36:49 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:44577 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbZHHXgs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 19:36:48 -0400
Received: by fxm28 with SMTP id 28so372653fxm.17
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 16:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=GIgc0vzy9kIfidzJydu6CDa+OedDhCVozJwmkxCDXNo=;
        b=savifm4MguAEoA2pKpE7Go0mMjlb5HnYqBYa232UodlPArfAiNOoyNbUQF1xcqWykp
         BuxzbdvXWOUpLPuam2eDEZfCNBb5b3gPCMzcSxzaTPTj6fUfbT4FFdtTinyy1tvGclLB
         HJB0dOPfUxhCu4ckCD2xbzRIAf9tzA+eb8Y0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=GcHEF6DE4/4wpK8WqfObu8liT7e/X2OfsqxFWesaDhPyZURYVLx7bljsNXCzmE8aMT
         KVCXtj7jecuxW3r0AoNK38xJtpNBjt94XpCp1Kpyz2xwq9Trl5v4cG4yhHIvjrzzKo1b
         NzaUJAYlcG/rMvdKgTeXyiDOTYw9Kn5QcBD7A=
Received: by 10.204.66.17 with SMTP id l17mr3938842bki.108.1249774607963;
        Sat, 08 Aug 2009 16:36:47 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-40-22.multimo.pl [89.174.40.22])
        by mx.google.com with ESMTPS id z10sm4637501fka.5.2009.08.08.16.36.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Aug 2009 16:36:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <4A7E030E.2040301@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125311>

Artur Skawina wrote:
> Artur Skawina wrote:

> -#define setW(x, val) (*(volatile unsigned int *)&W(x) = (val))
> +#define setW(x, val) W(x) = (val); __asm__ volatile ("": "+m" (W(x)))

and w/ this on top:

diff --git a/block-sha1/sha1vol.c b/block-sha1/sha1vol.c
--- a/block-sha1/sha1vol.c
+++ b/block-sha1/sha1vol.c
@@ -103,9 +103,9 @@ void blk_SHA1_Finalv(unsigned char hashout[20], blk_SHA_CTX *ctx)
 #define SHA_MIX(t) SHA_ROL(W(t+13) ^ W(t+8) ^ W(t+2) ^ W(t), 1)
 
 #define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
-	unsigned int TEMP = input(t); setW(t, TEMP); \
-	E += TEMP + SHA_ROL(A,5) + (fn) + (constant); \
-	B = SHA_ROR(B, 2); } while (0)
+	unsigned int TEMP = SHA_ROL(A,5); E+= (fn); \
+	E += (constant) + TEMP; TEMP = input(t); setW(t, TEMP); \
+	B = SHA_ROR(B, 2); E += TEMP; } while (0)
 
 #define T_0_15(t, A, B, C, D, E)  SHA_ROUND(t, SHA_SRC, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
 #define T_16_19(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )

I see an improvement on atom and reach ~200M/s on P4 (i686).
.
When compiled w/ '-mtune=prescott':

rfc3174         1.459       41.84
linus          0.6574       92.85
linusph        0.6613       92.29
linusv         0.2682       227.6
linusvph       0.2681       227.7
linusasm       0.5868         104
linusp4        0.3586       170.2
linusas        0.3795       160.8
linusas2       0.3583       170.3
mozilla         1.171       52.11
mozillaas       1.381        44.2
openssl        0.2623       232.7
opensslb       0.2404       253.9
spelvin        0.2659       229.6
spelvina       0.2492       244.9
nettle         0.4362       139.9
nettle-ror      0.436         140
nettle-p4sch   0.4204       145.2

it's now just 2% slower than the openssl assembler version.

artur
