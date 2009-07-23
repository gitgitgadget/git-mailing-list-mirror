From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 16:45:59 +0200
Message-ID: <20090723144559.GA20167@Pilar.aei.mpg.de>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <alpine.LFD.2.01.0907221742010.3352@localhost.localdomain> <alpine.LFD.2.01.0907221753290.3352@localhost.localdomain> <20090723020238.GA8948@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221925100.3352@localhost.localdomain> <m3prbr371l.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 16:47:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTzaH-0006cx-4F
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 16:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbZGWOrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 10:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbZGWOrZ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 10:47:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:64714 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbZGWOrY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 10:47:24 -0400
Received: by fg-out-1718.google.com with SMTP id e12so1118141fga.17
        for <git@vger.kernel.org>; Thu, 23 Jul 2009 07:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=o3I0RX2OcDfMzh0inMpLaHaQ0jAyCIbZ08BiAdjy8jc=;
        b=Gux8zHJr0/SH10rgh+4mZu2RVo4vsVSO9BYD+QRCwcm0u/CT8fOptWdgXZ+TWLItIr
         p6ddI5GvvN/HgRUA86nREpbwj+ja9nW2L46Wl7v5QvmfNF1/yWjALOHdpFs4heB+r7nt
         HEMvBuVpDqDg6Dwxmv1lAWSjVujD+xC0Oz4QI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ryico/h1L/cQg1kf8Fhce6himafTNTGQ0yjTWAKBQvskoEbIJXaEmSAg5jwaDc42tb
         QHn+OtcyP9dExvCqK3cERWGi3gv0v5ZYviQbkRqb4KxxnNjeLv+8V70Ww2LqnYu39xaP
         HjTsmsflamUdT5sLBz5YMEijz/Yo38VQndJcM=
Received: by 10.86.96.17 with SMTP id t17mr1995442fgb.20.1248360443698;
        Thu, 23 Jul 2009 07:47:23 -0700 (PDT)
Received: from Pilar.aei.mpg.de ([82.113.121.19])
        by mx.google.com with ESMTPS id 4sm4691839fgg.22.2009.07.23.07.47.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Jul 2009 07:47:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m3prbr371l.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123871>

On Thu 23.Jul'09 at  5:42:03 -0700, Jakub Narebski wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Thu, 23 Jul 2009, Carlos R. Mafra wrote:
> > > 
> > > Is there another way to check what is going on with that anomalous lstat()?
> > 
> > I really don't think it's the lstat any more. Your directories look small 
> > and simple, and clearly the indexing made no difference.
> > 
> > See earlier email about using "strace -T" instead of "-tt". Also, I sent 
> > you a patch to try out just a minute ago, I think that may be it.
> > 
> > > [ perhaps I will try 'perf' after I read how to use it ]
> > 
> > I really like 'perf' (it does what oprofile did for me, but without the 
> > headaches), but it doesn't help with IO profiling.
> > 
> > I've actually often wanted to have a 'strace' that shows page faults as 
> > special system calls, but it's sadly nontrivial ;(
> 
> BTW. Would SystemTap help there?  Among contributed scripts there is
> iotimes, so perhaps it would be possible to have iotrace...


I played a bit with 'blktrace' and 'btrace' and had two terminals
open side by side, one with 'strace git branch' and the other with
'blktrace'.

It was pretty obvious that exactly at the point where 'git branch'
was stalling (without Linus' patch) -- which I thought had to do
with lstat() -- there was a flurry of activity going on in 'btrace' 
output.

It would be nice if 'btrace' could be somehow unified with 'strace',
if that makes any sense.

Here are some numbers from my tests with blktrace (blkparse and btrace):

[root@Pilar mafra]# grep git blkparse-patch.txt |wc -l
811
[root@Pilar mafra]# grep git blkparse-nopatch.txt |wc -l
3479

where those lines with 'git' are something like

8,5    0      677     1.787350654 18591  I   R 204488479 + 40 [git]
8,0    0      678     1.787370489 18591  A   R 204488783 + 96 <- (8,5) 137529800
8,5    0      679     1.787371886 18591  Q   R 204488783 + 96 [git]
8,5    0      680     1.787375378 18591  G   R 204488783 + 96 [git]
8,5    0      681     1.787377613 18591  I   R 204488783 + 96 [git]

And the summary lines also indicate that the non-patched git makes
the disc work much harder:

*************** Without Linus' patch ******************************************

Total (8,5):
 Reads Queued:         764,   20,008KiB  Writes Queued:           0,        0KiB
 Read Dispatches:      764,   20,008KiB  Write Dispatches:        0,        0KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:      764,   20,008KiB  Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB  Write Merges:            0,        0KiB
 IO unplugs:           299               Timer unplugs:           2

Throughput (R/W): 4,003KiB/s / 0KiB/s
Events (8,5): 5,266 entries
Skips: 0 forward (0 -   0.0%)

************** With Linus' patch **********************************************

Total (sda5):
 Reads Queued:         171,    3,128KiB	 Writes Queued:           6,       24KiB
 Read Dispatches:      171,    3,128KiB	 Write Dispatches:        2,       24KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:      171,    3,128KiB	 Writes Completed:        2,       24KiB
 Read Merges:            0,        0KiB	 Write Merges:            4,       16KiB
 IO unplugs:            80        	 Timer unplugs:           0

Throughput (R/W): 1,632KiB/s / 12KiB/s
Events (sda5): 1,226 entries
Skips: 0 forward (0 -   0.0%)
