From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: Re: RCS keyword expansion
Date: Thu, 11 Oct 2007 16:59:56 +0100
Message-ID: <20071011155956.GC11693@cs-wsok.swansea.ac.uk>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se> <86fy0hvgbh.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 18:54:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig1IS-0005lk-63
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 18:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbXJKQxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 12:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbXJKQxx
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 12:53:53 -0400
Received: from mhs.swan.ac.uk ([137.44.1.33]:56303 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754686AbXJKQxw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 12:53:52 -0400
X-Greylist: delayed 3234 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2007 12:53:52 EDT
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.66)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1Ig0S4-0006r6-VX; Thu, 11 Oct 2007 16:59:57 +0100
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id B667FDAF5F;
	Thu, 11 Oct 2007 16:59:56 +0100 (BST)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id A3C8F741BB; Thu, 11 Oct 2007 16:59:56 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <86fy0hvgbh.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60614>

On Thu, Oct 11, 2007 at 08:09:22AM -0700, Randal L. Schwartz wrote:
> >>>>> "Peter" == Peter Karlsson <peter@softwolves.pp.se> writes:
> 
> Peter> I mainly want to have $Date$ expand in RCS/CVS manner, i.e to when the
> Peter> file was last changed. Possibly even have an $Id$ that gives me
> Peter> something useful (name and commit hash, perhaps?). Is it possible to do
> Peter> this? Can it be done through git-cvsserver?
> 
> That's not a job for a source code manager to do.  It's a job for your
> build/install tool.  See how "git --version" gets created in the core distro,
> and follow that example.
> 

This looks like a misunderstanding of what $Date$ is used for:
It has not much to do with a version number (such things are decisions
by the developers), but it is an identification stamp, typically
used to identify exactly which piece of code is involved in a
given executable.

Our group also needs a replacement for the keyword-expansion mechanism
(we are using a nice little system, which allows for each executable produced
to query it about the source-code-files involved in it, which is especially
useful for testing and development, where many versions of many files
float around (and perhaps some shouldn't)).

The principle solution seems quite clear to me: Adapt the pre-commit hook,
so that files are scanned for the keyword, and apply the keyword expansion
then before the actual commit.

Better than just the date, it would be greatest to be able to put also
the SHA1-ID of the commit into the file, alas this is a bit complicated,
since it's a pre-commit hook; However it seems necessary to have in
the repository really the actual file content, not "modulo some modification",
due to the distributed character of Git repositories (everybody should have
the same file-timestamp), and so a post-commit hook shouldn't be used.
So well, using the previous SHA1-ID should be a reasonable approximation.

Oliver
