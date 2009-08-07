From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Fri, 07 Aug 2009 03:30:36 +0200
Message-ID: <4A7B83BC.1040606@gmail.com>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain> <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain> <4A7B5F4C.30102@gmail.com> <alpine.LFD.2.01.0908061559120.3390@localhost.localdomain> <alpine.LFD.2.01.0908061609340.3390@localhost.localdomain> <alpine.LFD.2.01.0908061709400.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 07 03:30:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZEIF-0001Ua-2x
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 03:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756499AbZHGBaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 21:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756133AbZHGBaj
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 21:30:39 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:58595 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbZHGBai (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 21:30:38 -0400
Received: by bwz9 with SMTP id 9so1120784bwz.41
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 18:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=RHMB7L6tblxj99dyd+rEmcpunD7ris/BY6ADeDEgfUU=;
        b=DbvlxoB754UeJuXKuC8Hz2QW/r+VRhlHjp34rZJItmKFxbj8Sm7znfSt5Wm5X0cyDG
         uqSlSi7We9vxksb/2jatj+i8hjCU/hmxzq0T3s3+t+wBhBox2BQZUy2sgGEd/loz1TCr
         k0zE1CKqrGHihOYHZEEnaJyIc2/Uvfb3NQRQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=IFp0MiYOl+pkI2jaLMi+cPBo/+k78RcOChjObgYPqr98TkFOSq7KorfsNVuaNUbJtz
         T4UdEPXUDjcXrdBW5iAKgriTJaBY87uQLITUruo3xv2QT77CCwh/D63b8HIctbcryXKe
         jQnyhTofrbgToaHBwnGRqLInTZtKZDYQdbKKY=
Received: by 10.204.70.9 with SMTP id b9mr852374bkj.135.1249608637837;
        Thu, 06 Aug 2009 18:30:37 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-83-224.multimo.pl [89.174.83.224])
        by mx.google.com with ESMTPS id d13sm1612474fka.32.2009.08.06.18.30.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 18:30:37 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908061709400.3390@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125155>

Linus Torvalds wrote:
> 
> On Thu, 6 Aug 2009, Linus Torvalds wrote:
>> In particular, I'm thinking about the warnign in the intel optimization 
>> manual:
>>
>> 	The rotate by immediate and rotate by register instructions are 
>> 	more expensive than a shift. The rotate by 1 instruction has the 
>> 	same latency as a shift.
>>
>> so it's very possible that "rotate by 1" is much better than other 
>> rotates.
> 
> Hmm. Probably not. Googling more seems to indicate that rotates and shifts 
> have a fixed 4-cycle latency on Northwood. I'm not seeing anything that 
> indicates that a single-bit rotate/shift would be any faster.
> 
> (And remember, if 4 cycles doesn't sound so bad: that's enough of a 
> latency to do _16_ "simple" ALU's, since they can be double-pumped in the 
> two regular ALU's).

looking at the generated code, there is a lot of ro[rl] movement, so it's
likely that contributes to the problem.

I also see 44 extra lea instructions, 44 less adds and changes like:
        [...]
        mov    XX(%eRX),%eRX
        xor    XX(%eRX),%eRX
-       and    %eRX,%eRX
+       and    XX(%eRX),%eRX
        xor    XX(%eRX),%eRX
-       add    %eRX,%eRX
-       ror    $0x2,%eRX
-       mov    %eRX,XX(%eRX)
+       lea    (%eRX,%eRX,1),%eRX
        mov    XX(%eRX),%eRX
        bswap  %eRX
        mov    %eRX,XX(%eRX)
        mov    %eRX,%eRX
+       ror    $0x2,%eRX
+       mov    %eRX,XX(%eRX)
+       mov    %eRX,%eRX
        rol    $0x5,%eRX
        mov    XX(%eRX),%eRX
-       mov    XX(%eRX),%eRX
        [...]
which could mean that gcc did a better job of register allocation
(where "better job" might be just luck).

artur
