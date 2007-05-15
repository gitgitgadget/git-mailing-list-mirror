From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT RFC PATCH] Activate rename detection by default.
Date: Tue, 15 May 2007 23:37:17 +0200
Message-ID: <20070515213717.GP19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070504235413.29479.13640.stgit@gandelf.nowhere.earth> <b0943d9e0705150841l6fe05baajab67a16eb78e411d@mail.gmail.com> <20070515184759.GC17851@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue May 15 23:38:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho4jA-0000Q9-R0
	for gcvg-git@gmane.org; Tue, 15 May 2007 23:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbXEOVig convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 17:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755222AbXEOVig
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 17:38:36 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:34612 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbXEOVif (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 17:38:35 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A77B45E0D1;
	Tue, 15 May 2007 23:38:34 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 7AEAA1F161; Tue, 15 May 2007 23:37:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070515184759.GC17851@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47376>

On Tue, May 15, 2007 at 08:47:59PM +0200, Karl Hasselstr=F6m wrote:
> On 2007-05-15 16:41:47 +0100, Catalin Marinas wrote:
>=20
> > On 05/05/07, Yann Dirson <ydirson@altern.org> wrote:
> >
> > > This patch uses -M when generating diffs, which then looks fine,
> > > just like any other git-generated diff.
> >
> > I think we should only use -M for "files", "status", "show", "diff"
> > but not for "export" and "mail", maybe by adding an extra parameter
> > to git.diff() (or we could have this configurable or with an cmd
> > line option). The reason is that I send patches that might not be
> > applied with GIT.
>=20
> Seems like a good idea to me: default to -M whenever the consumer is
> guaranteed to understand it, and have it as an option defaulting to
> off when we export data.

This option should probably be available through a config setting as
well: we want to use it everytime we send a git or StGIT patch to the
list :)

OTOH, using different conventions for different commands is guaranted
to confuse more than one user.  Eg, I customarily use "stg show >
=2E./file.diff", assuming it will be readable by patch(1) - I even
issued today more than one "stg diff -r //bottom.old | (cd ../other &&
patch -p1)" - luckily, no rename there ;)

It makes sense to have it my default on for "files" and "status", but
it breaks the output format, and thus probably some user scripts.

Maybe we should add this behaviour as off by default, tunable from
config, and overridable from command-line (roughly what I suggested in
https://gna.org/task/?4773, with everything off by default).  Now the
question would be what command-line syntax to use to be usable.

-M/--renames <> --no-renames ?  -M would become useles when the
default, and --no-renames is cumbersome.  Also, adds 2 flags per
option, we have 3 of them (-M -C --find-copies-harder), and we may
want to allow other useful ones like -w and -b.

--diff-flags=3D'-M -C' ?  Can't find a non-brain-damaging way of
negating that: --no-diff-flags=3D'-C' to negate part of a
stgit.diff.defaultflags=3D'-M -C' is likely to be confusing.

Better ideas anyone ?
--=20
Yann.
