From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Thu, 06 Aug 2009 22:08:44 +0200
Message-ID: <4A7B384C.2020407@gmail.com>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 22:08:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ9Gj-0000gy-6M
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 22:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756217AbZHFUIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 16:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756185AbZHFUIs
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 16:08:48 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:57432 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbZHFUIr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 16:08:47 -0400
Received: by bwz9 with SMTP id 9so998932bwz.41
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 13:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=BuJcm7CSfgXloxZvKvCQTfGD7381KT+mvS7gEr2nZog=;
        b=F6xaOEZ9+I0rqnFOkt6kZT5VgPshcsLaEYuIwoECOQ036LNq98WvUBgxNgmWQVZZ33
         m4RloWSCMenwbtG0Yoo7bTQW+ziHesAmg67lmkehLUTC1PhhG4M3SEiTQq/ewQLVEnrb
         a46XKplgmGrELAuHs+2rq3ua6xT9xBNbTDtkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=lgFfiRHtTnrJ128dj5X7XTvihBRG5ycTYpVmvFtUtM260NDcy6DBp335fbncXJ1eO/
         I1Hw5gWX60mElfKcCxyVcIjyq1+Wg4J5KMxvVAFSWOdYb9XFeIACsGvhPtuBl3H7VUIN
         TCtygd30cV6qyJiPgySKedh/W/mVxsvUn8VpA=
Received: by 10.204.52.2 with SMTP id f2mr2438028bkg.90.1249589326738;
        Thu, 06 Aug 2009 13:08:46 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-123-173.multimo.pl [89.174.123.173])
        by mx.google.com with ESMTPS id k29sm1073008fkk.56.2009.08.06.13.08.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 13:08:46 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125120>

Linus Torvalds wrote:
> 
> On Thu, 6 Aug 2009, Artur Skawina wrote:
>> Oh, i noticed that '-mtune' makes quite a difference, it can change
>> the relative performance of the functions significantly, in unobvious
>> ways; depending on which cpu gcc tunes for (build config or -mtune);
>> some implementations slow down, others become a bit faster.
> 
> That probably is mainly true for P4, although it's quite possible that it 
> has an effect for just what the register allocator does, and then for 
> spilling.
> 
> And it looks like _all_ the tweakability is in the spilling. Nothing else 
> matters.
> 
> How does this patch work for you? It avoids doing that C-level register 
> rotation, and instead rotates the register names with the preprocessor.
> 
> I realize it's ugly as hell, but it does make it easier for gcc to see 
> what's going on.
> 
> The patch is against my git patches, but I think it should apply pretty 
> much as-is to your sha1bench sources too. Does it make any difference for 
> you?

it's a bit slower (P4):

before: linus          0.6288       97.06
after:  linus          0.6604       92.42

i was trying similar things, like the example below, too, but it wasn't a
win on 32 bit...

artur

[the iteration below is functionally correct, but scheduling is most likely
 fubared as it wasn't a win and i was checking how much a difference it made
 on P4 -- ~-20..~0%, but never faster (relative to linusas2; it _is_ faster
 than 'linus'. Dropped this version when merging your new preprocessor macros.]

@@ -125,6 +127,8 @@
 #define W(x) (array[(x)&15])
 #define SHA_XOR(t) \
        TEMP = SHA_ROL(W(t+13) ^ W(t+8) ^ W(t+2) ^ W(t), 1); W(t) = TEMP;
+#define SHA_XOR2(t) \
+       SHA_ROL(W(t+13) ^ W(t+8) ^ W(t+2) ^ W(t), 1)
 
 #define T_16_19(t) \
         { unsigned TEMP;\
@@ -139,10 +143,27 @@
 #endif
 
 #define T_20_39(t) \
-        { unsigned TEMP;\
-       SHA_XOR(t); \
-       TEMP += (B^C^D) + E + 0x6ed9eba1; \
-       E = D; D = C; C = SHA_ROR(B, 2); B = A; TEMP += SHA_ROL(A,5); A = TEMP; }
+        if (t%2==0) {\
+               unsigned TEMP;\
+               unsigned TEMP2;\
+               \
+               TEMP   = SHA_XOR2(t); \
+               TEMP2  = SHA_XOR2(t+1); \
+               W(t)   = TEMP;\
+               W(t+1) = TEMP2;\
+               TEMP   += E + 0x6ed9eba1; \
+               E      = C;\
+               TEMP   += (B^E^D); \
+               TEMP2  += D + 0x6ed9eba1; \
+               D      = SHA_ROR(B, 2);\
+               B      = SHA_ROL(A, 5);\
+               B      += TEMP;\
+               C      = SHA_ROR(A, 2);\
+               A      ^= E; \
+               A      ^= D; \
+               A      += TEMP2;\
+               A      += SHA_ROL(B, 5);\
+       }
 
 #if UNROLL
        T_20_39(20); T_20_39(21); T_20_39(22); T_20_39(23); T_20_39(24);
