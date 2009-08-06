From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Thu, 06 Aug 2009 23:39:16 +0200
Message-ID: <4A7B4D84.80906@gmail.com>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain> <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 23:39:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZAgJ-0003J7-Nw
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 23:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756792AbZHFVjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 17:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756791AbZHFVjT
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 17:39:19 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:33209 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755728AbZHFVjS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 17:39:18 -0400
Received: by ewy10 with SMTP id 10so1139278ewy.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 14:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=C/wNCWPzhUTsctC44nxEYnKZFy5ANwX4ziC3y86rpFo=;
        b=lxT3F889GEXdfXfWxY3B/ze0J4Xc003UYqSg7AJWrU1xitFAAvKfq21bHLWx8bCeW0
         yExnDWQ2QDQ/MAtiBHznMXOnkCUWloUUY2pIygyliDhbA7Nh+duGCdCDqrYhMzHsp++U
         s6lGKBHeeoECk4E05GeSIxeI9zcVLJdpo8ELI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=L0dtHycucqzVgKDmV6YwkEfNJxn9pRF+IX/TqszXYpEKYMvAzubzzry7EO3KCpfIVu
         EAQN8Hz0w6SvhdtiJPEjecX2LguO0MDKcTnYNYcR0OTrO3UPHTR5r6q6BMpoBTRuDJAd
         a/r8JPQ6vGS75Jc0O5lC5/cwN4RssexAqQo+I=
Received: by 10.210.52.15 with SMTP id z15mr17134ebz.36.1249594758403;
        Thu, 06 Aug 2009 14:39:18 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-40-143.multimo.pl [89.174.40.143])
        by mx.google.com with ESMTPS id 28sm1061379eye.34.2009.08.06.14.39.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 14:39:18 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125130>

Linus Torvalds wrote:
> 
> with it, so it is faster for me. So your slowdown seems to be yet another 
> P4 thing. Dang crazy micro-architecture.
> 
> Of course, it might be a compiler version difference too. I'm using 
> gcc-4.4.0.

gcc version 4.4.1 20090603 (prerelease)

> Oh, I did make a small change, but I doubt it matters. Instead of doing
> 
> 	TEMP += E + SHA_ROL(A,5) + (fn) + (constant); \
> 	B = SHA_ROR(B, 2); E = TEMP; } while (0)
> 
> I now do
> 
> 	E += TEMP + SHA_ROL(A,5) + (fn) + (constant); \
> 	B = SHA_ROR(B, 2); } while (0)
> 
> which is a bit more logical (the old TEMP usage was just due to a fairly 
> mindless conversion). That _might_ have lower register pressure if the 
> compiler is silly enough to not notice that it can do it. Maybe that 
> matters.

before: linus          0.6622       92.17
after:  linus          0.6631       92.05
after:  linus          0.6601       92.46
after:  linus          0.6624       92.14

IOW, no difference, just noise.
