From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Sat, 25 Jul 2009 01:46:49 +0200
Message-ID: <20090724234648.GA4616@Pilar.aei.mpg.de>
References: <7vtz146mgr.fsf@alter.siamese.dyndns.org> <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain> <20090723165335.GA15598@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain> <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain> <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 01:48:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUUUv-0001hr-2i
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 01:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265AbZGXXsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 19:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755262AbZGXXsN
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 19:48:13 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:39362 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249AbZGXXsM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 19:48:12 -0400
Received: by ewy26 with SMTP id 26so2092465ewy.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 16:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gOrXouZjTu6Ycs+1W8JSuG2XlF/FbqwZtoIfa2tppi4=;
        b=Tb128jH7oSQ9wz2OY5aQl/OOK3URKFT7zkK7ZtvNwQlbY9JrPoegfOKmSSS5OjC2gH
         GzCmU7iFm+fe6CBtBWeUpCNPDRF3397JNbaB5p8aLgFawVd+pdMLghS3FQQh55LDvw9C
         QyqJ1doREqFr/lA/PlMj18izTcMv7p8BxG6iM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CQNCjVfJXzYn6xjITepj3qXEyD52kjbjf5uC/rTIbzpKP9MOA9aqQXXyB6/pDZ/MEu
         M0zKSuxHX4wXMfj+XCfJCiSL+Zw3s6NIMRSIuoRmud5epcV1VfSWinV0ZkhEZ31jyNVD
         /Ox117ZRpO9k7yuvor5FWtMVsUZBN/rS28C60=
Received: by 10.210.57.15 with SMTP id f15mr4997607eba.14.1248479290458;
        Fri, 24 Jul 2009 16:48:10 -0700 (PDT)
Received: from Pilar.aei.mpg.de ([82.113.106.17])
        by mx.google.com with ESMTPS id 5sm2099561eyh.58.2009.07.24.16.48.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 16:48:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123981>

Sorry for the delay and missing the "strace -ttT" request,
but today was a "Physics" day and took me longer to 
notice your email.

On Fri 24.Jul'09 at 14:21:20 -0700, Linus Torvalds wrote:
> 
> What a huge difference!
> 
> And the NO_CURL version really does load a lot faster in cold-cache. We're 
> not talking small differences:

With NO_CURL=1 the strace log contained 242 lines (vs 404), but
the time difference was not as great as you got. But it was
better:

0.55 +- 0.06 (for 8 runs)

So I repeated the tests with curl enabled and this time
I got:

0.77 +- 0.03 (for 6 runs)

(yesterday I got 0.61 +- 0.08, so there is lot of noise)

So it is better, but not by the same factor as you saw.
But I may have an explanation for this.

After I clear the cache I wait a few seconds to stabilize,
and I do the 'time git branch' test when I see that
there is no activity in the disk by looking at
the 'btrace' output in another xterm. 

I noticed that after dropping the cache and before
I do the test there is lot of activity of something
called 'preload', with lines which look like these:

8,0  0  42881   495.067655112 17777  Q   R 51244367 + 552 [preload]
8,0  0  42882   495.067659931 17777  G   R 51244367 + 552 [preload]
8,0  0  42883   495.067664401 17777  I   R 51244367 + 552 [preload]

I hadn't noticed this before and now I checked that,

"preload is an adaptive readahead daemon that prefetches files mapped by
applications from the disk to reduce application startup time."

So I guess that my tests here for your NO_CURL=1 idea is inconclusive,
as I am not sure what preload is prefetching.
