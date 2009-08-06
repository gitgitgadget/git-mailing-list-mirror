From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Thu, 06 Aug 2009 06:28:18 +0200
Message-ID: <4A7A5BE2.5070401@gmail.com>
References: <20090805181755.22765.qmail@science.horizon.com> <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain> <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain> <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain> <alpine.LFD.2.00.0908052144430.16073@xanadu.home> <alpine.LFD.2.01.0908051902580.3390@localhost.localdomain> <4A7A4BC5.7010106@gmail.com> <alpine.LFD.2.01.0908052024081.3390@localhost.localdomain> <alpine.LFD.2.01.0908052043082.3390@localhost.localdomain> <alpine.LFD.2.01.0908052056500.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, George Spelvin <linux@horizon.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 06:28:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYuaj-0000oT-1t
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 06:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbZHFE2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 00:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbZHFE2X
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 00:28:23 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:38721 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbZHFE2W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 00:28:22 -0400
Received: by ewy10 with SMTP id 10so506635ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 21:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=5/yPLhCLJNMO2teYBJ2U5zOIgqvcXY4JIyCqI+LO4dM=;
        b=Rme6J7D8rfCIZTuwE7X2EzolAPYFkEglmHsvgTd7oL/8kx0UYeidkcCHVW77ui8tGp
         cJ//vI+FyoX/XDYWlpkRb9ycZE99v0l4uKjYCRMAO+BFNuz29KIZENhnlFwF5kDucija
         J9WHzngXDCWwoC49mA62+aYQimDfeSZRVoRlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=UOD7c5oSkKWh5e5gi0xuppE3KH8cifW9uF47ubixC4GA9Pf7i4cM5pw7w2InXjJmLf
         YwMyA5ANFzK2RQsIotDfoEoPUaaZPLZJ0WLe4uy3EbZ9LIzmfoEaYTo4SdY/TlPlppCn
         0Usp/mDi7fLuCN/raZRsWQtxUuASQHgRB9fnM=
Received: by 10.210.63.18 with SMTP id l18mr11556178eba.11.1249532902523;
        Wed, 05 Aug 2009 21:28:22 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-125-132.multimo.pl [89.174.125.132])
        by mx.google.com with ESMTPS id 10sm968188eyd.27.2009.08.05.21.28.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 21:28:21 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908052056500.3390@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125036>

Linus Torvalds wrote:
> 
> On Wed, 5 Aug 2009, Linus Torvalds wrote:
>> Here's the patch that gets me sub-28s git-fsck times. In fact, it gives me 
>> sub-27s times. In fact, it's really close to the OpenSSL times.
> 
> Just to back that up:
> 
>  - OpenSSL:
> 
> 	real	0m26.363s
> 	user	0m26.174s
> 	sys	0m0.188s
> 
>  - This C implementation:
> 
> 	real	0m26.594s
> 	user	0m26.310s
> 	sys	0m0.256s
> 
> so I'm still slower, but now you really have to look closely to see the 
> difference. In fact, you have to do multiple runs to make sure, because 
> the error bars are bigger thant he difference - but openssl definitely 
> edges my C code out by a small amount, and the above numbers are rairly 
> normal.

nice, the p4 microbenchmark #s:

#             TIME[s] SPEED[MB/s]
rfc3174         1.357       44.99
rfc3174         1.352       45.13
mozilla         1.509       40.44
mozillaas       1.133       53.87
linus          0.5818       104.9

so it's more than twice as fast as the mozilla implementation.

artur
