From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Fri, 07 Aug 2009 01:19:13 +0200
Message-ID: <4A7B64F1.2000309@gmail.com>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain> <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain> <alpine.LFD.2.01.0908061531310.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 07 01:19:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZCF0-0003iC-2p
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 01:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbZHFXTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 19:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbZHFXTR
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 19:19:17 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:57201 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214AbZHFXTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 19:19:16 -0400
Received: by fxm28 with SMTP id 28so1049528fxm.17
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 16:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=PqN4jdpmENwab8j7+UZzq3roO0PZFnRMRKxmOtijmHI=;
        b=maQ32q2IulRWhNWXKXhOFcybCMrFxWgMiQUmr0pqOjinBVg3hxAhjxnbRWJQAQ90K2
         YS5kce7uBoxWLx9BnXoiZGC/kcA44O7xX3edcq0QY9EeNXTlFBeYLCtjDVqy7bKep3n0
         2Ws4DOAV/bG0OtsRqIP7Ii0OCGyJjDjTQozms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=tR1XGlyRAIR8JFg3UINHtxqsfUSpdeWCKsC/Qc7wdiiBdX/Nzt8UK4pjar8tmsUSLZ
         W7hh6vVqdDabjQVVITTKa27BQOjFiD84yOos790cM1ZvNko9hNotHCbZYMEJHo5lUfba
         M1sYv2TUlIOZadiL6pRMmb5jNd5eqzA5yRt8s=
Received: by 10.103.191.4 with SMTP id t4mr180704mup.123.1249600754951;
        Thu, 06 Aug 2009 16:19:14 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-40-101.multimo.pl [89.174.40.101])
        by mx.google.com with ESMTPS id w5sm2266463mue.34.2009.08.06.16.19.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 16:19:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908061531310.3390@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125138>

Linus Torvalds wrote:
> 
> Yeah, verified. Google for
> 
> 	northwood "barrel shifter"
> 
> and you'll find a lot of it.
> 
> Basically, older P4's will I think shift one bit at a time. So while even 
> Prescott is relatively weak in the shifter department, pre-prescott 
> (Willamette and Northwood) are _really_ weak. If your P4 is one of those, 
> you really shouldn't use it to decide on optimizations.

Actually that's even more of a reason to make sure the code doesn't suck :)
The difference on less perverse cpus will usually be small, but on P4 it
can be huge.

A few years back I found my old ip checksum microbenchmark, and when I ran
it on a P4 (prescott iirc) i didn't believe my eyes. The straightforward 
32-bit C implementation was running circles around the in-kernel one...
And a few tweaks to the assembler version got me another ~100% speedup.[1]

After that the P4 became the very first cpu to test any code on... :)

artur

[1] just reran the benchmark on this p4; true on northwood too:

IACCK 0.9.30  Artur Skawina <...>
[ exec time; lower is better  ] [speed ] [ time ]  [ok?]
TIME-N+S TIME32 TIME33 TIME1480 MBYTES/S TIMEXXXX  CSUM FUNCTION ( rdtsc_overhead=0  null=0 )
   17901    510    557     3010   393.36    59772  56dd csum_partial_cdumb16
    3019    154    156      431  2747.10    43106  56dd csum_partial_c32
    2413    170    177      328  3609.76    37501  56dd csum_partial_c32l
    2437    170    170      328  3609.76    37488  56dd csum_partial_c32i
    5078    205    254      767  1543.68    48117  56dd csum_partial_std
    5612    299    291      851  1391.30    53673  56dd csum_partial_686
    1584     99    127      227  5215.86    14495  56dd csum_partial_586f
    1738    107    121      229  5170.31    14785  56dd csum_partial_586fs
    4893    175    171      759  1559.95    52347  56dd csum_partial_copy_generic_std
    4949    151    189      756  1566.14    67847  56dd csum_partial_copy_generic_686
    2072    110    134      302  3920.53    39061  56dd csum_partial_copy_generic_p4as1
