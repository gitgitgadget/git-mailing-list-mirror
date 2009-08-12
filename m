From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git index: how does it work?
Date: Wed, 12 Aug 2009 21:39:43 +0200
Message-ID: <20090812193943.GA3718@atjola.homenet>
References: <loom.20090805T160528-69@post.gmane.org>
 <7v7hxi9m4k.fsf@alter.siamese.dyndns.org>
 <436D5ED1-2F0E-4227-AC4A-3A5FD16B2DCF@cuttshome.net>
 <fabb9a1e0908121047jf7e6cf1n757cde626c79830c@mail.gmail.com>
 <410DBF0B-80A2-4235-B566-B622CA976DA0@cuttshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Shaun Cutts <shaun@cuttshome.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:40:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbJg2-0007UH-NR
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 21:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbZHLTjs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2009 15:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbZHLTjs
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 15:39:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:47185 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752571AbZHLTjr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 15:39:47 -0400
Received: (qmail invoked by alias); 12 Aug 2009 19:39:47 -0000
Received: from i59F5472B.versanet.de (EHLO atjola.homenet) [89.245.71.43]
  by mail.gmx.net (mp065) with SMTP; 12 Aug 2009 21:39:47 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18l64kDfholDxWBWTPdyIbkLqW+UMBTWHOTi2ESoM
	bMv3yZRhsg1Ck7
Content-Disposition: inline
In-Reply-To: <410DBF0B-80A2-4235-B566-B622CA976DA0@cuttshome.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125728>

[Please don't top-post, fixed that for you...]

On 2009.08.12 20:45:48 +0200, Shaun Cutts wrote:
> On Aug 12, 2009, at 7:47 PM, Sverre Rabbelier wrote:
> >Heya,
> >
> >On Wed, Aug 12, 2009 at 04:52, Shaun Cutts<shaun@cuttshome.net> wrot=
e:
> >>Are renames being tracked by the index, and is there a more
> >>basic interface
> >>than "status" to query about them?
> >
> >Nope, git never explicitly tracks renames. Try this:
> >$ mv foo bar
> >$ git rm --cached foo
> >$ git add bar
> >$ git status
> >
> >It'll tell you that you renamed foo to bar, even if you never
> >executed 'git mv'.
> >
> >This is because git does rename _detection_, that is, it'll notice
> >that you have another file with (almost) the same contents, so it
> >assumes you did a rename.
>
> Aha ---
>=20
> that explains it, then.
>=20
> Is there a lower-level interface to rename detection than via
> "status"? And... um... hmmm.... how does it work? The hash codes
> don't help for "almost" the same. Is there an approximate string
> matching algorithm built in somewhere?

Roughly, it works like this:
The files are split into small chunks, those are hashed, and if there
are chunks with the same hash in both files, those chunks are treated a=
s
being common to both files. The more the files have in common, the
higher the similarity score. See estimate_similarity() for details.

As the splitting also happens at newlines this has some interesting
effects, for example, you can completely reorder the lines in a file
after renaming it, and git will still detect it as a rename.

Bj=F6rn
