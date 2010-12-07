From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] logging branch deletion to help recovering from
 mistakes
Date: Tue, 7 Dec 2010 10:41:43 -0800
Message-ID: <20101207184143.GC3725@spearce.org>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
 <7vmxoiqeoq.fsf@alter.siamese.dyndns.org>
 <20101207170623.GB21749@sigill.intra.peff.net>
 <AANLkTimnp3xCHp_3E7ry-5OQL3PFnYh=H8PhfzMN307C@mail.gmail.com>
 <20101207182040.GA26770@sigill.intra.peff.net>
 <20101207182342.GA3725@spearce.org>
 <20101207183507.GA27277@sigill.intra.peff.net>
 <20101207183739.GB3725@spearce.org>
 <20101207183930.GA27340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 07 19:41:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ2U3-0006Su-WD
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 19:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910Ab0LGSlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 13:41:46 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57489 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab0LGSlq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 13:41:46 -0500
Received: by pwj3 with SMTP id 3so85254pwj.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 10:41:45 -0800 (PST)
Received: by 10.142.158.2 with SMTP id g2mr1284983wfe.331.1291747305551;
        Tue, 07 Dec 2010 10:41:45 -0800 (PST)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.74.25])
        by mx.google.com with ESMTPS id w14sm9289776wfd.18.2010.12.07.10.41.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 10:41:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101207183930.GA27340@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163111>

Jeff King <peff@peff.net> wrote:
> On Tue, Dec 07, 2010 at 10:37:39AM -0800, Shawn O. Pearce wrote:
> 
> > Yes, you are right.  We should instead let the normal reflog expire
> > action do its work here, and delete the empty log file when it is
> > finally empty.
> > 
> > I guess we also need repack and prune to enumerate these deleted
> > reflogs and retain the objects their records point to.
> 
> Definitely. I sort of assumed all of those things just traversed
> .git/logs blindly without regard to whether there was a ref, which would
> handle this automagically. But maybe that is not the case.

I think those enumerate the logs of refs that are also being
traversed.  Which means we would need to add new logic to enumerate
the deleted reflogs.
 
> Is there a reason to require that each log is specifically tied to a
> ref?

Historical bad assumptions?

I mean, no, there really isn't a good reason that each log is
tied to a ref.  Its probably reasonable to just enumerate the logs
directory separate from the refs directory enumeration.  Its just
some more code.  Right now we discover logs by just relying on the
ref directory traversal code.

-- 
Shawn.
