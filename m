From: James Pickens <jepicken@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Thu, 24 Jul 2008 08:24:30 +0000 (UTC)
Message-ID: <loom.20080724T065737-580@post.gmane.org>
References: <20080723145518.GA29035@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 10:31:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLwEG-0004Aw-6N
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 10:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbYGXIaN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 04:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbYGXIaM
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 04:30:12 -0400
Received: from main.gmane.org ([80.91.229.2]:56357 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbYGXIaL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 04:30:11 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KLwD5-0003hC-1m
	for git@vger.kernel.org; Thu, 24 Jul 2008 08:30:03 +0000
Received: from ip72-201-10-203.ph.ph.cox.net ([72.201.10.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 08:30:03 +0000
Received: from jepicken by ip72-201-10-203.ph.ph.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 08:30:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 72.201.10.203 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9) Gecko/2008052906 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89852>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds <at> gmail.com> writ=
es:

> I have not looked at non-builtin commands yet, but I think it's not
> a big deal. We have several rounds before this series is good enough =
;)
> So in short, sparse prefix will be stored in config, core.sparsecheck=
out.
> you have three new commands to enter/update/leave sparse checkout:
>=20
> git clone --path=3Dprefix       # clone with sparse checkout
> git checkout --path=3Dprefix    # limit/update checkout paths
> git checkout --full           # stop sparse checkout
>

=46irst things first, thanks a lot for working on this feature.  I have=
 an
enormous project in CVS (144GB repo, containing 65000 directories and
463000 files) that I've been wanting to convert to git for a while now,
and the lack of sparse checkouts was the only thing about git that was
standing in the way.  The project is so big that checking out the whole
tree all the time is unworkable, and I think my coworkers would hang me
if I tried to make them use submodules.  We already use sparse checkout=
s
in CVS to make it manageable, so sparse checkout support in git would
vastly simplify the transition.

I played around with the patch briefly, and I have a couple of comments
on the interface.

=46irst, I would want a capability to checkout a directory non-recursiv=
ely.
I.e., checkout directory A/B, without also checking out directory A/B/C=
=2E
Perhaps a modifier could be added to a path element to make it
non-recursive.

Second, I would want a capability to checkout and release directories
incrementally, similar to how we do it in cvs.  For example, I might do
the following in cvs:

$ cvs co -l A         # Checkout dir A non-recursively
$ cd A
$ cvs up -l -d B1 B2  # Checkout dirs A/B1 and A/B2 non-recursively
$ cd B1
$ cvs up -d C1 C2     # Checkout dirs A/B1/C1 and A/B1/C2 recursively
(Oops, didn't need C2)
$ cvs release -d C2

At this point I would have the following directory tree, assuming the C=
1
directory in the repo contained a D1 directory:

A/
A/B1/
A/B1/C1/
A/B1/C1/D1/
A/B2/

A similar capability in git would be much appreciated.

=46inally, I noticed what I think is a bug: if you do a partial checkou=
t of
a non-existing directory, you just get an empty tree.  I would expect t=
o
get an error message in that case.

I hope this is helpful, and thanks again for working on this.

James
