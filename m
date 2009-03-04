From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 1/2] improve missing repository error message
Date: Wed, 4 Mar 2009 05:35:56 -0500
Message-ID: <20090304103556.GB16123@coredump.intra.peff.net>
References: <20090303184106.GH14365@spearce.org> <20090304083229.GA31798@coredump.intra.peff.net> <vpqtz69lk6a.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:37:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeoTn-0006l7-Eb
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 11:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbZCDKgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 05:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbZCDKgG
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 05:36:06 -0500
Received: from peff.net ([208.65.91.99]:46872 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbZCDKgF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 05:36:05 -0500
Received: (qmail 23337 invoked by uid 107); 4 Mar 2009 10:36:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 04 Mar 2009 05:36:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2009 05:35:56 -0500
Content-Disposition: inline
In-Reply-To: <vpqtz69lk6a.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112200>

On Wed, Mar 04, 2009 at 10:19:25AM +0100, Matthieu Moy wrote:

> > +		die("'%s' does not appear to be a git repository", dir);
> 
> It may be sensible to distinguish the case where dir exists as a
> directory but isn't a repository, and the case where it does not exist
> at all, like "directory exists but does not appear to be a git
> repository" Vs "no such directory".
> 
> Just in case someone does a "mkdir" on the server and doesn't know he
> has to "git init" there too.

I agree it would be nice to be more descriptive; however, it's not quite
as simple as checking if the chdir failed. For "non-strict" repo lookup,
we check a number of variants. For $foo, we check:

  $foo.git/.git
  $foo/.git
  $foo.git
  $foo

If $foo exists but isn't a git directory, but $foo/.git does not exist,
then what is the correct response?  I guess we can say "no such
directory" only if $foo and $foo.git don't exist, and "not a git
repository" for the others.

I also don't know if we care about information leakage; with such a
patch can I now start probing the existence of arbitrary directories via
git-daemon (I haven't checked to see if there are other path
restrictions in place)?

-Peff
