From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Thu, 06 Aug 2009 07:19:01 +0200
Message-ID: <4A7A67C5.8060109@gmail.com>
References: <20090805181755.22765.qmail@science.horizon.com> <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain> <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain> <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain> <alpine.LFD.2.00.0908052144430.16073@xanadu.home> <alpine.LFD.2.01.0908051902580.3390@localhost.localdomain> <4A7A4BC5.7010106@gmail.com> <alpine.LFD.2.01.0908052024081.3390@localhost.localdomain> <alpine.LFD.2.01.0908052043082.3390@localhost.localdomain> <alpine.LFD.2.01.0908052056500.3390@localhost.localdomain> <4A7A5BE2.5070401@gmail.com> <alpine.LFD.2.01.0908052137400.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, George Spelvin <linux@horizon.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 07:19:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYvNi-0004Gn-RF
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 07:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbZHFFTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 01:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbZHFFTG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 01:19:06 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:42703 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbZHFFTE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 01:19:04 -0400
Received: by ewy10 with SMTP id 10so521080ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 22:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=4XyXsvcyTt6l/udINthakGHzQg3zkNy6FscJ9FXsBIA=;
        b=bZdF0WaVl6WoHDrAZNKDMAwjfX0kMbHSpmoPwkMKGyNx8rN+mhr37NBLU6Oxp1ECG4
         6145YUmLRsM2mkIR/Z2CKb6Sbf4TGMSzeHAiwMHK1GHtfKYMXRd8RYWr7ZEy+jntWMIg
         mMDwILgBJZBSbs+A2Bn+V02Eu4/i5ACKz8wp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=UHhDyF5L2UyrBGoFUg6EgCjrw6jkzch/7HHC3KPOJBz7S25A8IN5VAmKtoC/+w096i
         mgT55WE5LutmqoaUKn1xCbs84jjs9VbeT653eJ0wAZvIhkbwoSocj0mhtBtlW+JbsTC7
         QUZ+PXF587IzI111tYP8SMfqNAnPAHKjKGuZc=
Received: by 10.210.56.3 with SMTP id e3mr587838eba.99.1249535943754;
        Wed, 05 Aug 2009 22:19:03 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-122-128.multimo.pl [89.174.122.128])
        by mx.google.com with ESMTPS id 7sm3387770eyb.10.2009.08.05.22.19.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 22:19:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908052137400.3390@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125042>

Linus Torvalds wrote:
> 
> On Thu, 6 Aug 2009, Artur Skawina wrote:
>> #             TIME[s] SPEED[MB/s]
>> rfc3174         1.357       44.99
>> rfc3174         1.352       45.13
>> mozilla         1.509       40.44
>> mozillaas       1.133       53.87
>> linus          0.5818       104.9
>>
>> so it's more than twice as fast as the mozilla implementation.
> 
> So that's some general SHA1 benchmark you have?
> 
> I hope it tests correctness too. 

yep, sort of, i just check that all versions return the same result
when hashing some pseudorandom data.

> As to my atom testing: my poor little atom is a sad little thing, and 
> it's almost painful to benchmark that thing. But it's worth it to look at 
> how the 32-bit code compares to the openssl asm code too:
> 
>  - BLK_SHA1:
> 	real	2m27.160s
>  - OpenSSL:
> 	real	2m12.580s
>  - Mozilla-SHA1:
> 	real	3m21.836s
> 
> As expected, the hand-tuned assembly does better (and by a bigger margin). 
> Probably partly because scheduling is important when in-order, and partly 
> because gcc will have a harder time with the small register set.
> 
> But it's still a big improvement over mozilla one.
> 
> (This is, as always, 'git fsck --full'. It spends about 50% on that SHA1 
> calculation, so the SHA1 speedup is larger than you see from just th 
> enumbers)

I'll start looking at other cpus once i integrate the asm versions into
my benchmark. 

P4s really are "special". Even something as simple as this on top of your
version:

@@ -129,8 +133,8 @@
 
 #define T_20_39(t) \
        SHA_XOR(t); \
-       TEMP += SHA_ROL(A,5) + (B^C^D) + E + 0x6ed9eba1; \
-       E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
+       TEMP += SHA_ROL(A,5) + (B^C^D) + E; \
+       E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP + 0x6ed9eba1;
 
        T_20_39(20); T_20_39(21); T_20_39(22); T_20_39(23); T_20_39(24);
        T_20_39(25); T_20_39(26); T_20_39(27); T_20_39(28); T_20_39(29);
@@ -139,8 +143,8 @@
 
 #define T_40_59(t) \
        SHA_XOR(t); \
-       TEMP += SHA_ROL(A,5) + ((B&C)|(D&(B|C))) + E + 0x8f1bbcdc; \
-       E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
+       TEMP += SHA_ROL(A,5) + ((B&C)|(D&(B|C))) + E; \
+       E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP + 0x8f1bbcdc;
 
        T_40_59(40); T_40_59(41); T_40_59(42); T_40_59(43); T_40_59(44);
        T_40_59(45); T_40_59(46); T_40_59(47); T_40_59(48); T_40_59(49);

saves another 10% or so:

#Initializing... Rounds: 1000000, size: 62500K, time: 1.421s, speed: 42.97MB/s
#             TIME[s] SPEED[MB/s]
rfc3174         1.403        43.5
# New hash result: b747042d9f4f1fdabd2ac53076f8f830dea7fe0f
rfc3174         1.403       43.51
linus          0.5891       103.6
linusas        0.5337       114.4
mozilla         1.535       39.76
mozillaas       1.128       54.13


artur
