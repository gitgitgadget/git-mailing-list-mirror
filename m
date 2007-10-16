From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: .gitignore and svn:ignore [WAS: git-svn and submodules]
Date: Tue, 16 Oct 2007 11:43:30 +0200
Message-ID: <20071016094330.GA5945@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0710141901450.25221@racer.site> <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma> <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled> <Pine.LNX.4.64.0710142359020.25221@racer.site> <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr> <20071015144513.GB7351@diana.vm.bytemark.co.uk> <20071015151405.GA1655@pe.Belkin> <20071016075827.GB32348@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Shoemaker <c.shoemaker@cox.net>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>,
	git list <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 11:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihixq-0000MU-QQ
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 11:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758931AbXJPJnj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2007 05:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758915AbXJPJnj
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 05:43:39 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2218 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758181AbXJPJni (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 05:43:38 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IhixW-0001uT-00; Tue, 16 Oct 2007 10:43:30 +0100
Content-Disposition: inline
In-Reply-To: <20071016075827.GB32348@soma>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61130>

On 2007-10-16 00:58:27 -0700, Eric Wong wrote:

> If we support .gitignore <-> svn:ignore in git-svn; bidirectional,
> transparent mapping is the only way I want to go.

=46air enough.

> This means that *all* .gitignore files will be translated to
> svn:ignore files and vice versa; and the .gitignore files will be
> NOT be committed to SVN itself, but present in the git-svn created
> mirrors.

OK.

> Recursive .gitignore definitions will be mapped to svn:ignore
> recursively on the client side; and non-recursive ones will only map
> to one directory.
>
> Sound good?
>
> I may be sleepy at the moment, but the thought of implementing this
> is sounding complicated now...

I think this is a mistake. If a user adds *.foo to the top-level
=2Egitignore, this will add *.foo to svn:ignore of _every_ directory in
the whole tree. And coming up with semantics that are sane for e.g.
git -> svn -> git roundtrips seems difficult.

It would be better and far simpler to either

  1. Move the contents of svn:ignore and .gitignore back and forth
     untouched, disregarding the slight semantic mismatch.
     git-svnignore does this (albeit only in one direction), and it
     works surprisingly well in my experience.

  2. Do as in (1), but call the file .svnignore instead of .gitignore.
     And have a git-svn command that translates all the .svnignore
     files in the tree to corresponding .gitignore files.

> One goal of git-svn is that other users shouldn't be able to tell if
> a user is using git-svn or plain svn; even.

Agreed.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
