From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 4 Jun 2009 11:41:09 -0700
Message-ID: <20090604184109.GR3355@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <200906032320.23559.jnareb@gmail.com> <alpine.LSU.2.00.0906032240300.31588@hermes-2.csi.cam.ac.uk> <200906041045.11328.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tony Finch <dot@dotat.at>, Scott Chacon <schacon@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 20:41:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCHsO-0006Jh-6O
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 20:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbZFDSlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 14:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbZFDSlI
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 14:41:08 -0400
Received: from george.spearce.org ([209.20.77.23]:42033 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbZFDSlH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 14:41:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 806E7381D1; Thu,  4 Jun 2009 18:41:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906041045.11328.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120704>

Jakub Narebski <jnareb@gmail.com> wrote:
> Dnia ?roda 3. czerwca 2009 23:53, Tony Finch napisa?:
> > On Wed, 3 Jun 2009, Jakub Narebski wrote:
> > >
> > > Actually git accepts both lowercase and uppercase in HEXDIG (at least
> > > for pkt-length), but it prefers lowercase.
> > 
> > You should ensure that all hex digit strings follow the same rule.
> > Are SHA-1 object names case insensitive too?
> > 
> > Case insensitivity has a history of being awkward. SMTP has always had
> > case-insensitive commands, though the RFCs have always written them in
> > upper case and implementations have pretty much all emitted them in upper
> > case. See http://tools.ietf.org/html/rfc5321#section-2.4 especially the
> > caveat about broken case-sensitive implementations.
> 
> There should be no problem with pkt-length being case insensitive, as
> standard conversion routines (strtol, sprintf) accept 0-9a-fA-F for 
> base 16 / hexadecimal conversion.  The requirement here is that client
> and server SHOULD use lowercase, but MUST accept mixed case (do case
> insensitive parsing of hex4).

ACK.  This is what C Git does today.  JGit sends lower case, but
is wrong by only accepting lowercase.  I will patch it today to
accept mixed case.
 
> I think SHA-1 is lowercased, so mixed case should work there. Well, at
> least "git show 6096D7" (note the uppercase 'D' in shortened SHA-1 name)
> works as expected.

ACK.  Mixed case SHA-1 MUST be accepted, but lower case SHOULD
be output.
 
> But I do not know what are, or what should be protocol requirements.
> Should SHA-1 use lowercase, or be case insensitive?

SHA-1 SHOULD be lowercase (a-f), MUST accept a-f or A-F.

> Should commands such as "have", "want", "done" use lower case or
> be case insensitive?

These MUST be lowercase.

> Should status indicators "ACK" and "NAK" be upper case,

These MUST be uppercase.  Though "ACK %s continue" MUST be mixed
case, as I just wrote it.

> Should capabilities be case sensitive, and should they be
> compared case sensitive or not?

No, they are case sensitive.  

Why?  All of the above is the current C code implementation.
We have to follow what the code does today, and it does case
sensitive compares almost everywhere... except in the SHA-1 parsing.

-- 
Shawn.
