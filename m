From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 21:03:20 +0200
Message-ID: <20090723190320.GA5556@Pilar.aei.mpg.de>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain> <alpine.DEB.1.10.0907231244020.10001@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Jul 23 21:04:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU3ap-0001ci-De
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 21:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbZGWTEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 15:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbZGWTEa
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 15:04:30 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:57592 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbZGWTE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 15:04:29 -0400
Received: by bwz28 with SMTP id 28so1017296bwz.37
        for <git@vger.kernel.org>; Thu, 23 Jul 2009 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+6x5R3IUurno+npB5zO1ANTiAP3mXeV/jBHhvxA8WfE=;
        b=rBMZsMjFRHy9ODKuqAb+xffUAtH7OXkily2ASIS/B2mvmJ+ee8U5Ulc7trLT/TsWH+
         yOWAhVt83JVYmpgeom2KhlYBqQCO8xds+w+d1uH58Nx8Ug214zFAtw9lUXZdd9DHVg1n
         uDfhqU0j0FUVRsAjK235zqgf2Z4QiAKbVsKIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=At3cLNO3crSt1hN2UPFh4s+wEoz24YufYsJTQi4Uj1z3oQw/qEoZoS4bsrX/C11buk
         XflkuiUlY8CHNeSvxkEnKS7ZsfrdQ1TwldRDGbnqAsaGZw1GiqQvJMddzixXFrYyXEW6
         z/PTJ/Ehv4K2f8wnxMCC2gd8iSDs5y+BKx/Uo=
Received: by 10.103.225.11 with SMTP id c11mr1326330mur.57.1248375868167;
        Thu, 23 Jul 2009 12:04:28 -0700 (PDT)
Received: from Pilar.aei.mpg.de (dynamic.aei.mpg.de [194.94.224.254])
        by mx.google.com with ESMTPS id j10sm9126831muh.45.2009.07.23.12.04.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Jul 2009 12:04:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0907231244020.10001@vinegar-pot.mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123887>

On Thu 23.Jul'09 at 12:48:20 -0400, Anders Kaseorg wrote:
> 
> I submitted essentially the same patch in May:
>   http://article.gmane.org/gmane.comp.version-control.git/120097
> with the additional optimization that we don't need to lookup commits at
> all unless we're using -v, --merged, --no-merged, or --contains.  In my 
> tests, it makes `git branch` 5 times faster on an uncached linux-2.6 
> repository.

I also tested your patch even if you said that it was "essentially the same". 

But after repeating the tests 6 times for both your and Linus' patch
(taking care to let the system rest a bit after clearing the cache), your
patch is faster,

0.62 +/- 0.24 (Anders)
1.35 +/- 0.23 (Linus)

And this is the raw data for your patch,

0.00user 0.01system 0:00.54elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (7major+727minor)pagefaults 0swaps

0.00user 0.00system 0:00.18elapsed 5%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1major+733minor)pagefaults 0swaps

0.00user 0.00system 0:00.66elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (9major+723minor)pagefaults 0swaps

0.00user 0.01system 0:00.74elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (14major+720minor)pagefaults 0swaps

0.00user 0.00system 0:00.80elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (16major+718minor)pagefaults 0swaps

0.00user 0.00system 0:00.83elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (16major+718minor)pagefaults 0swaps


and for Linus'

0.00user 0.01system 0:01.56elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (43major+755minor)pagefaults 0swaps

0.00user 0.01system 0:01.09elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (24major+775minor)pagefaults 0swaps

0.00user 0.01system 0:01.33elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (32major+767minor)pagefaults 0swaps

0.00user 0.00system 0:01.53elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (39major+760minor)pagefaults 0swaps

0.00user 0.01system 0:01.06elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (24major+775minor)pagefaults 0swaps

0.00user 0.00system 0:01.54elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (39major+760minor)pagefaults 0swaps
