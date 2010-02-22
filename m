From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Mon, 22 Feb 2010 06:35:54 +0300
Message-ID: <20100222033553.GA10191@dpotapov.dyndns.org>
References: <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100219082813.GB17952@dpotapov.dyndns.org>
 <7v635tkta7.fsf@alter.siamese.dyndns.org>
 <7v8waniue8.fsf@alter.siamese.dyndns.org>
 <20100221072142.GA5829@dpotapov.dyndns.org>
 <7vhbpas7ut.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 05:28:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjP5k-0003QJ-7s
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 04:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543Ab0BVDf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 22:35:59 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:64410 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab0BVDf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 22:35:59 -0500
Received: by fxm5 with SMTP id 5so2231636fxm.29
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 19:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IyXwbXSClyy0+UxXl0nC1YUz7BCigiLYF6nFsmMT/jM=;
        b=v2MYDjMN61ocDorAv2r/cYywdeozqYnxIjNTr48oz+jIevJZn3kMx48Ml8iir3o2yL
         APd4jm86rTAyNQnRdAUuk27lFmfADyMpJDx33KmFR1K7B2a/Iad/VkKlSXV4GpE8DC45
         UjBUq3eUeIv0qMpqMtSMz4oUSnFrbNzJ/9WYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=abejTY7PLR2o+iQTZ4mNbLzC7JsHGWgdzokzsGDPQa4+ApEZ3Vu1Liu+4Z4Y7Dnucn
         0JPwaKmKEaFDgfWdri9h/pMHdGrdiJTsE1y2F+04p0OJWTHAHvl+NXvUWaL7165fqcLT
         M+ljuFjW679TOrpOVsGKvSsSlHQiP3xIcAnKk=
Received: by 10.102.169.39 with SMTP id r39mr10412330mue.126.1266809757056;
        Sun, 21 Feb 2010 19:35:57 -0800 (PST)
Received: from localhost (ppp91-77-227-64.pppoe.mtu-net.ru [91.77.227.64])
        by mx.google.com with ESMTPS id 25sm13158232mul.20.2010.02.21.19.35.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 19:35:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vhbpas7ut.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140577>

On Sun, Feb 21, 2010 at 11:32:10AM -0800, Junio C Hamano wrote:
> 
> 32*1024 sounds like a better cut-off to me.  After that, doubling the size
> does not get comparable gain, and numbers get unstable (notice the glitch
> around 256kB).

The reduction of speed-up after 32Kb is most likely due to L1 cache
size, which is 32Kb data per core on Core 2, and L2 cache is shared
among cores and is considerably slow. I have run my test a few more
times, and here are results:

   1 - 39.25%
   2 - 30.00%
   4 - 17.79%
   8 - 11.76%
  16 - 7.58%
  32 - 5.38%
  64 - 3.89%
 128 - 2.87%
 256 - 2.31%
 512 - 2.92%
1024 - 1.14%

and here is one more re-run starting with 32Kb:

  32 - 5.38%
  64 - 3.89%
 128 - 2.29%
 256 - 2.91%
 512 - 2.92%
1024 - 1.14%

If you look at speed-up numbers, you can think that the numbers are
unstable, but in fact, the best time in 5 runs does not differ more
than 0.01s between those trials. But because difference for >=128Kb
is 0.05s or less, the accuracy of the above numbers is less than 25%.
But overall the outcome is clear -- read() is always a winner.

It would be interesting to see what difference Nehalem, which has a
smaller but much faster L2 cache than Core 2. It may perform better
at larger sizes up to 256Kb.

Anyway, based on above data, I believe that the proper cut-off should be
at least 64Kb, because additional 32Kb (from 32Kb to 64Kb) is about of
2.5% of total memory that git consumes anyway, and it gives you speed-up
around 3.5%...



Dmitry
