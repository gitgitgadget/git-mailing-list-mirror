From: Mark Lodato <lodatom@gmail.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Mon, 3 Aug 2009 21:40:43 -0400
Message-ID: <ca433830908031840o11efc252r4db65f671deb4913@mail.gmail.com>
References: <20090731104602.15375.qmail@science.horizon.com>
	 <20090803034741.23415.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, appro@fy.chalmers.se, appro@openssl.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 03:41:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY91R-000471-QR
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 03:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbZHDBkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 21:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753704AbZHDBkp
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 21:40:45 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:58117 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbZHDBko (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 21:40:44 -0400
Received: by bwz19 with SMTP id 19so2799587bwz.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 18:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Glgbpqrfc9481xqN4HJbEfAGjDY/IJ73OWEnP9nxEG8=;
        b=OSnyyXN6rJ+4iZNKyds/JJ2YJUm1bznEHr7uKaW27QCOIBrDZderyVuoHmHdeMYrG8
         Uhrsfp5U9KiZj17+z8hDvFMuC39gXnD+rqXe5x+VUTRXzz4o+lkfueN9/5EASQcO3Bew
         0tglkDf1ln5MrP6XcpIhgVj90euxUvqTbesLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=l2dy7/mRYT/d2aGz9O0jxuJFaHQaF9M8HLHuyPA3MTTtPP1tYSEbAT2WDLhHXY8jEm
         Fs0Qv5TeF0+RU1wsG/zA10VAhh5972zzGaAfeFLLSvXMYX0oHriUHMgrWoK7ssF39zmZ
         kNxGKovpAP/N38LySt431yJqgPylh+uWGDs6I=
Received: by 10.103.5.2 with SMTP id h2mr3910763mui.132.1249350043915; Mon, 03 
	Aug 2009 18:40:43 -0700 (PDT)
In-Reply-To: <20090803034741.23415.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124739>

On Sun, Aug 2, 2009 at 11:47 PM, George Spelvin<linux@horizon.com> wrote:
> Before      After       Gain    Processor
> 1.585248    1.353314    +17%    2500 MHz Phenom
> 3.249614    3.295619    -1.4%   1594 MHz P4
> 1.414512    1.352843    +4.5%   2.66 GHz i7
> 3.460635    3.284221    +5.4%   1596 MHz Athlon XP
> 4.077993    3.891826    +4.8%   1144 MHz Athlon
> 1.912161    1.623212    +17%    2100 MHz Athlon 64 X2
> 2.956432    2.940210    +0.55%  1794 MHz Mobile Celeron (fam 15 model 2)
>
> (Seconds to hash 500x 1 MB, best of 10 runs in all cases.)
>
> This is based on Andy Polyakov's GPL/BSD licensed cryptogams code, and
> (for now) uses the same perl preprocessor.   To test it, do the following:
> - Download Andy's original code from
>  http://www.openssl.org/~appro/cryptogams/cryptogams-0.tar.gz
> - "tar xz cryptogams-0.tar.gz"
> - "cd cryptogams-0/x86"
> - "patch < this_email" to create "sha1test.c", "sha1-586.h", "Makefile",
>   and "sha1-x86.pl".
> - "make"
> - Run ./586test (before) and ./x86test (after) and note the timings.

Note, to compile this on Ubuntu x86-64, I had to:
$ sudo apt-get install libc6-dev-i386

$ ./586test
 1/10: 2.016621 s
 2/10: 2.030742 s
 3/10: 2.027333 s
 4/10: 2.024018 s
 5/10: 2.022306 s
 6/10: 2.022418 s
 7/10: 2.047103 s
 8/10: 2.035467 s
 9/10: 2.032237 s
10/10: 2.029231 s
Minimum time to hash 500000000 bytes: 2.016621
$ ./x86test
 1/10: 1.818661 s
 2/10: 1.814856 s
 3/10: 1.816232 s
 4/10: 1.815208 s
 5/10: 1.834047 s
 6/10: 1.843020 s
 7/10: 1.819564 s
 8/10: 1.815560 s
 9/10: 1.824232 s
10/10: 1.820943 s
Minimum time to hash 500000000 bytes: 1.814856
$ python -c 'print 2.016621 / 1.814856'
1.11117410968
$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz
stepping        : 2
cpu MHz         : 1861.825
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant
_tsc arch_perfmon pebs bts rep_good pni dtes64 monitor ds_cpl vmx est tm2 ssse3
cx16 xtpr pdcm lahf_lm tpr_shadow
bogomips        : 3723.65
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz
stepping        : 2
cpu MHz         : 1861.825
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant
_tsc arch_perfmon pebs bts rep_good pni dtes64 monitor ds_cpl vmx est tm2 ssse3
cx16 xtpr pdcm lahf_lm tpr_shadow
bogomips        : 3724.01
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:



I imagine that you can get a bigger speedup by making a 64-bit version
(but maybe not).  Either way, it would be nice if x86-64 users did not
have to install an additional package to compile.

Cheers,
Mark
