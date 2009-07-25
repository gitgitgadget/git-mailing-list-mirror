From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Sat, 25 Jul 2009 23:04:07 +0200
Message-ID: <20090725210407.GA3556@Pilar.aei.mpg.de>
References: <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain> <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain> <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain> <20090724234648.GA4616@Pilar.aei.mpg.de> <20090725004122.GA28477@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907251046140.3960@localhost.localdomain> <20090725215739.d074e947.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Timo Hirvonen <tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 23:07:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUoSS-0004eC-M0
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 23:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbZGYVFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 17:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbZGYVFR
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 17:05:17 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:36128 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbZGYVFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 17:05:16 -0400
Received: by fxm18 with SMTP id 18so1984111fxm.37
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 14:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wDo44hFsedTxo/gs9KR1yPfFV9cbvRFJb9WGnMnYc1k=;
        b=HSg2c3wq9ddcNc3eVQTXLCLdv1sGPECEnQjopo+YezKWpNK1SLTdYBuN526hAq3MsF
         MbE+mVDHiCEgWQM3N9zzfpdyIsv/YHoRBYrBn7LghKSV24TvOA3mM/81Yp+tHohpeBNf
         y9qJ2ArPZK4MLzGhFX7IE1va6EW0TSw6pQIcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pB0v2tdIhBliYLyMpTJVJ6I2/UWE7UyJMeafzfDnj/6LXcWi000HP7MjAR9iB9GdaC
         F+XLyskM5Bk67T00/OVsFCzQkKOfc2xzKAsNIABhSRAqoA2PYOCf2fkR5zIE1f+DwlYB
         QeM8H+plfMzzMvrumtMzbXPKuJ9nx2OPD9Vck=
Received: by 10.103.177.18 with SMTP id e18mr2460431mup.63.1248555914766;
        Sat, 25 Jul 2009 14:05:14 -0700 (PDT)
Received: from Pilar.aei.mpg.de (dynamic.aei.mpg.de [194.94.224.254])
        by mx.google.com with ESMTPS id s10sm19695827mue.38.2009.07.25.14.05.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Jul 2009 14:05:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090725215739.d074e947.tihirvon@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124072>

On Sat 25.Jul'09 at 21:57:39 +0300, Timo Hirvonen wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > So curl really must die. It may not matter for the expensive operations, 
> > but a lot of scripting is about running all those "cheap" things that just 
> > add up over time.
> 
> SELinux is the problem, not curl.

I don't have SELinux, and without curl it takes ~50% less time (on
top of Linus' previous optimizations!).

The time to open() all the libs really sums up to a considerable 
fraction (when the total time is low, not when compared to the 
huge 6 secs of before)

Without curl:
[mafra@Pilar:linux-2.6]$ grep open strace-nocurl.log |grep lib \
> | awk -F "<" '{print $2}' | sed s/\>// | awk '{s += $1} END {print s}'
0.070104

With curl:
[mafra@Pilar:linux-2.6]$ grep open strace-curl.log |grep lib \
> | awk -F "<" '{print $2}' | sed s/\>// | awk '{s += $1} END {print s}'
0.249764

PS: It is interesting that in my laptop the time required
to open libcurl alone is 20x the total time of 'git branch' for Linus'
in his supercomputer:
open("/usr/lib64/libcurl.so.4", O_RDONLY) = 3 <0.066239>
