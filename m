From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH v0] sha1_name: grok <revision>:./<relative-path>
Date: Wed, 19 Dec 2007 09:40:04 -0800
Message-ID: <56b7f5510712190940g2a377f4tfe3ca897561ed446@mail.gmail.com>
References: <20071218173321.GB2875@steel.home>
	 <20071218204623.GC2875@steel.home>
	 <200712182224.28152.jnareb@gmail.com>
	 <20071218222032.GH2875@steel.home>
	 <Pine.LNX.4.64.0712182239500.23902@racer.site>
	 <56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com>
	 <alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org>
	 <56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com>
	 <Pine.LNX.4.64.0712191334460.23902@racer.site>
	 <20071219150510.GB13942@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	danahow@gmail.com
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 19 18:40:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J52uG-0000zM-Kd
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 18:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbXLSRkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 12:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802AbXLSRkI
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 12:40:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:60186 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbXLSRkG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 12:40:06 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1603518nfb.21
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 09:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pbYwut8oCd/7sxc4CXpaX0nnf6zcbsaNFT7CqYKo20Y=;
        b=KFWfmnXyxV1StotWOxoP36MHXWIaR0Y2nLtHr8pO4X/KNHXem65Z23caIVQnc3A6uXSWLQuUQscbqZHIQUxrCR8rZVYyb4CndDeA/b+lg2LYwDCrjdWrdga16FWDId5Xdtt53nz5iTeVSp3reC1giTlpYo3zsQw2te/OOZOa6V4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ar2kCJeGOoAeeZf/RG9T/eNLXUx6qEaaJUaPHtXyNRadqJCtNC5C4w5edNLj+s/8bpjt0gdVMVBSUXDzlVY+tT8hOFezI1Vz9Vzk3xHt0KIopvLAsAETyrsL3XC1eHYEgxJg7p2WNWUIZkU+KULP8sbM+PbcsUDLu3n5STSJmOc=
Received: by 10.78.167.12 with SMTP id p12mr12584302hue.20.1198086004340;
        Wed, 19 Dec 2007 09:40:04 -0800 (PST)
Received: by 10.78.130.1 with HTTP; Wed, 19 Dec 2007 09:40:04 -0800 (PST)
In-Reply-To: <20071219150510.GB13942@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68924>

On Dec 19, 2007 7:05 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Dec 19, 2007 at 01:40:27PM +0000, Johannes Schindelin wrote:
> > When you are in a deeply-nested directory structure, and just want
> > to reference a blob in a past revision, it can be pretty slow to
> > type out "HEAD~29:/bla/blub/.../that-file".
> >
> > This patch makes "HEAD~29:./that-file" substitute the current prefix
> > for "./".  If there is not working directory, the prefix is empty.
>
> I think this is definitely the right approach. Here's a (possibly
> insane) alternative. Revert the change in get_sha1_with_mode and detect
> "./" in get_tree_entry:
>
> [..]
>
> This means that the directory '.' becomes a token replacement for "my
> current path" in tree paths. So if you are in "foo/bar", and you are
> looking at a distance commit where the same content was in
> "baz/foo/bar", you can do:
>
>   git show distant:baz/./file
>
> This is probably insane because:
>   - this is a fairly unlikely use case
>   - get_tree_entry gets called in a lot of places, and I have no idea if
>     there will be some crazy fallouts.
>
> So it is probably not worth pursuing, but maybe somebody else can think
> of a good use.

For me,  I was only interested in the recognition of ./ at the beginning
of a path just after : (causing a cwd suffix to be inserted there).

If there were additional /./ or /../ patterns in the result,  I think it
would be more useful (e.g. for script writers who forgot to run
their file arguments thru something like "readlink -f") for them
to be squashed out (e.g. in Perl:
  s#/(\./)+#/#g;
  s#/([^/]*[^./][^/]*/\.\./)+#/#g;
).  But this is something that could be added later if desired to
the interpretation of all paths,  and so seems like a different issue.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
