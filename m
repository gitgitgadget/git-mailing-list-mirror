From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Sat, 25 Jul 2009 14:13:13 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907251406390.3960@localhost.localdomain>
References: <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain> <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain>
 <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain> <20090724234648.GA4616@Pilar.aei.mpg.de> <20090725004122.GA28477@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907251046140.3960@localhost.localdomain>
 <20090725215739.d074e947.tihirvon@gmail.com> <20090725203130.GB1640@glandium.org> <alpine.LFD.2.01.0907251353410.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 23:13:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUoZ1-0006wE-R8
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 23:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbZGYVNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 17:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbZGYVNs
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 17:13:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35563 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752753AbZGYVNr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jul 2009 17:13:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6PLDEgB020030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 25 Jul 2009 14:13:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6PLDDsd024231;
	Sat, 25 Jul 2009 14:13:13 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907251353410.3960@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.459 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124074>



On Sat, 25 Jul 2009, Linus Torvalds wrote:
>
> The fact that apparently sometimes it's less bloated than other times 
> doesn't really change anything fundamental, does it?

Btw, does anybody know how/why libdl seems to get linked in too?

We're not doing -ldl, and I'm not seeing any need for it, but it's 
definitely there on fedora, at least.

It seems to come from libcrypto. I can get rid of it with NO_OPENSSL, and 
that cuts down on the number of system calls in my startup by 16 (getting 
rid of both libcrypto and libdl). I wonder if there is some way to get the 
optimized openssl sha1 routines _without_ that silly ldl thing.

		Linus
