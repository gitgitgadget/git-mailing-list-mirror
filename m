From: Jeff King <peff@peff.net>
Subject: Re: "git -c web.browser=w3m help -w help" still kicks firefox
Date: Tue, 24 Aug 2010 10:12:47 -0400
Message-ID: <20100824141247.GB6457@coredump.intra.peff.net>
References: <7viq3119yn.fsf@alter.siamese.dyndns.org>
 <AANLkTi=R6ZdD9GUO6T6uCUkF+KVPbG1FGrieOfeusKct@mail.gmail.com>
 <20100823203304.GB4458@coredump.intra.peff.net>
 <20100824050127.GC20037@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 16:13:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnuFG-00025b-AJ
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 16:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661Ab0HXOMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 10:12:53 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35417 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754885Ab0HXOMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 10:12:52 -0400
Received: (qmail 17692 invoked by uid 111); 24 Aug 2010 14:12:50 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Tue, 24 Aug 2010 14:12:50 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Aug 2010 10:12:47 -0400
Content-Disposition: inline
In-Reply-To: <20100824050127.GC20037@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154314>

On Tue, Aug 24, 2010 at 12:01:27AM -0500, Jonathan Nieder wrote:

> > Which does bring up one interesting boundary. If I run:
> > 
> >   git -c receive.denyDeletes=false git push
> > 
> > what should happen? Obviously with cross-server communication the
> > environment won't get passed. I am inclined to say that even for local
> > cases, receive-pack should clear the string.
> 
> Sticky.  I agree with you that that would follow the principle of
> least surprise.
> 
> On the other hand if I use
> 
> 	git push --receive-pack='git -c receive.denyDeletes=false receive-pack'
> 
> then I would expect it to work.  I don't think this is a security
> problem because I already could have set the remote $GIT_CONFIG just
> as easily.

Yeah, I think you are right. Anybody who was trying to cross a setuid
boundary with receive-pack is already screwed unless they are cleansing
the environment. And I would hope that any such cleansing would be
allow-known-good, so the new variable would be blocked along with
GIT_CONFIG.

So I doubt we are making anything worse, security-wise. I do think we
should still remove the variable in the local transport for the sake of
least surprise, and I agree that your example above should work.

-Peff
