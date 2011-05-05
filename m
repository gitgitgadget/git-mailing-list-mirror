From: Kacper Kornet <kornet@camk.edu.pl>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Thu, 5 May 2011 16:29:10 +0200
Message-ID: <20110505142910.GA31229@camk.edu.pl>
References: <20110428022922.GC4833@camk.edu.pl>
 <7v62py5nbp.fsf@alter.siamese.dyndns.org>
 <20110428192751.GE4833@camk.edu.pl>
 <4DBFA3C6.8060209@viscovery.net>
 <7vzkn3itb5.fsf@alter.siamese.dyndns.org>
 <4DC0E99E.6090402@viscovery.net>
 <20110504135827.GC18585@camk.edu.pl>
 <4DC1653A.7000000@viscovery.net>
 <7v4o5afht7.fsf@alter.siamese.dyndns.org>
 <7vwri5c27e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 16:29:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHzYQ-0007vq-U4
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 16:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab1EEO3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 10:29:17 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:39991 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889Ab1EEO3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 10:29:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 587A35F004B;
	Thu,  5 May 2011 16:29:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id tiU+eb5xvQzm; Thu,  5 May 2011 16:29:10 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 9308D5F0046;
	Thu,  5 May 2011 16:29:10 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 8622B80AF5; Thu,  5 May 2011 16:29:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwri5c27e.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172834>

On Wed, May 04, 2011 at 07:26:29PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:

> > So I think it would probably be a less-impact and useful solution to keep
> > sysconfdir and add "sysconfdir = @sysconfdir@" to config.mak.in as well.

> > Is Kacper's latest patch with an obvious one-liner to config.mak.in
> > sufficient to achieve that?

> >   From: Kacper Kornet <kornet@camk.edu.pl>
> >   Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defin...
> >   Date: Wed, 4 May 2011 16:29:21 +0200
> >   Message-ID: <20110504142921.GE18585@camk.edu.pl>

> In other words, this one on top of the above (which defaults sysconfdir
> to /etc when $(prefix) is /usr and then sets git_etcdir to $(sysconfdir)).

There is one more problem with this. If you call:

 ./configure --prefix=/usr --sysconfdir=/<dir>

sysconfdir and git_etcdir are set to /etc not /<dir>. I admit that it is
a rather unusual set of options ./configure, but maybe it should be
supported. So maybe I will first describe how it should all work in my
opinion and I will wait for comments before I will try to implement it.

1. ./configure --prefix=dir1  and dir1 != /usr

    git_etcdir = etc

2. ./configure --prefix=/usr

    git_etcdir = /etc

3. ./configure --prefix=dir1 --syscondir=dir2 (here dir2 has to be an
absolute path)

    git_etcdir =  dir2

4. make prefix=dir1 and dir1 != /usr

    git_etcdir = etc

5. make prefix=/usr

    git_etcdir = /etc

6. make prefix=dir1 sysconfdir=dir2 (here dir2 can be an absolute or
a relative path)

    git_etcdir = dir2


-- 
  Kacper Kornet
