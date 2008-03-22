From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Cygwin: problem with renaming and case
Date: Sat, 22 Mar 2008 13:18:10 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803221312010.3020@woody.linux-foundation.org>
References: <47E3DD28.4030302@tiscali.it> <37fcd2780803211157n15cec620gb5ab1d3e57ccd37b@mail.gmail.com> <47E564F5.6010005@iksz.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>, Frank <streamlake@tiscali.it>,
	git@vger.kernel.org
To: Nagy Bal?zs <js@iksz.hu>
X-From: git-owner@vger.kernel.org Sat Mar 22 21:19:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdABI-0004vu-BG
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 21:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbYCVUSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 16:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbYCVUSY
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 16:18:24 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47215 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751388AbYCVUSY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 16:18:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MKIBKG013535
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 13:18:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MKIARZ025086;
	Sat, 22 Mar 2008 13:18:11 -0700
In-Reply-To: <47E564F5.6010005@iksz.hu>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.257 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77849>



On Sat, 22 Mar 2008, Nagy Bal?zs wrote:
> 
> qmail-1.03 is one of the rare species which has two files which differ only in
> their case, namely INSTALL and install.  The first one contains the
> documentation, the latter one is compiled from source.  Apart from that I
> don't know any other affected projects.

The kernel has lots of them. Well, not "lots" (considering that it has 
23000+ filenames), but something like 20+ names that exists in two forms 
with just different case.

Do

	git ls-files | tr '[A-Z]' '[a-z]' | sort | uniq -d

and you'll get

	include/linux/netfilter_ipv4/ipt_connmark.h
	include/linux/netfilter_ipv4/ipt_dscp.h
	include/linux/netfilter_ipv4/ipt_ecn.h
	include/linux/netfilter_ipv4/ipt_mark.h
	include/linux/netfilter_ipv4/ipt_tcpmss.h
	include/linux/netfilter_ipv4/ipt_tos.h
	include/linux/netfilter_ipv4/ipt_ttl.h
	include/linux/netfilter_ipv6/ip6t_hl.h
	include/linux/netfilter_ipv6/ip6t_mark.h
	include/linux/netfilter/xt_connmark.h
	include/linux/netfilter/xt_dscp.h
	include/linux/netfilter/xt_mark.h
	include/linux/netfilter/xt_rateest.h
	include/linux/netfilter/xt_tcpmss.h
	net/ipv4/netfilter/ipt_ecn.c
	net/ipv4/netfilter/ipt_ttl.c
	net/ipv6/netfilter/ip6t_hl.c
	net/netfilter/xt_connmark.c
	net/netfilter/xt_dscp.c
	net/netfilter/xt_mark.c
	net/netfilter/xt_rateest.c
	net/netfilter/xt_tcpmss.c

where you basically have the netfilter people using lower-case version for 
netfilter matching rules and the uppercase vesion for rewriting rules. Or 
something.

Admittedly the netfilter people _are_ strange, and we need to make sure 
that they take all their medication regularly or they do stupid things, 
but it does happen. The kernel people obviously expect people to use sane 
filesystems for kernel development..

			Linus
