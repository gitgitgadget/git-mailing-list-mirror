From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to unpack recent objects?
Date: Thu, 16 Dec 2010 14:18:50 -0800 (PST)
Message-ID: <m339r0ncai.fsf@localhost.localdomain>
References: <4D0A77A7.9080702@cfl.rr.com>
	<alpine.LFD.2.00.1012161616170.10437@xanadu.home>
	<4D0A8D83.9080705@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 23:18:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMA5-0001VI-VI
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185Ab0LPWSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:18:53 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:51288 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab0LPWSw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 17:18:52 -0500
Received: by fxm18 with SMTP id 18so54508fxm.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 14:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=1Uzmfs8DkL++yDPkDetAN6L/dZBgXhVcdFzBjYd3BW8=;
        b=Klc+xTdtKM9G56h14+BCAi7+ik75pMbH9og7o62kIgBuX/pe4QvVsMWDeuIu8vm2Hr
         nO2iaJFQZU5LrqsCFQ5cAiWZ7p4kql9cRuZ3aFNgt74X9kciE60syHZ0Jd22Kz/sMnGI
         DlYikSz8qnv6dMnEhdkeoOGVLPsboPpTjEiUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=JppoWir9ehpsQuTNqYIWe0TU5BGlfPIQNgwMQR4k+MxU/gUxLGJ2OaxPXwhHHd9PqG
         PDxS0BXtTTWdRjE8hGPsQ6ByijTqpQk6/P94UtWgM2opuZxTLmweNPucsR2Fk3UmMtNH
         qhonFhoBXVcgSVFKYLMs6dpUEJBZNoQ2VX/C4=
Received: by 10.223.72.14 with SMTP id k14mr356206faj.45.1292537931561;
        Thu, 16 Dec 2010 14:18:51 -0800 (PST)
Received: from localhost.localdomain (abvg92.neoplus.adsl.tpnet.pl [83.8.204.92])
        by mx.google.com with ESMTPS id n2sm215117fam.28.2010.12.16.14.18.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 14:18:50 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oAGMI40H015723;
	Tue, 16 Nov 2010 23:18:14 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oAGMHffI015719;
	Tue, 16 Nov 2010 23:17:41 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4D0A8D83.9080705@cfl.rr.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163822>

Phillip Susi <psusi@cfl.rr.com> writes:
> On 12/16/2010 4:19 PM, Nicolas Pitre wrote:

> > What makes you think that unpacking them will actually make the access 
> > to them faster?  Instead, you should consider _repacking_ them, 
> > ultimately using the --aggressive parameter with the gc command, if you 
> > want faster accesses.
> 
> Because decompressing and undeltifying the objects in the pack file
> takes a fair amount of cpu time.  It seems a waste to do this for the
> same set of objects repeatedly rather than just keeping them loose.

Loose objects are also compressed.  

Besides git has some kind of delta cache, so when you are accessing a
few objects (like e.g. when doing 'git log -p' - log + diff) you don't
need to undeltify and uncompress the same objects repeatedly.

Also in practice it is IO that is bottleneck, not CPU.  And having
many files is bad for filesystem cache.  Originally packfiles were for
the network transfer, but it turned out that they are better also as
on-disk format.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
