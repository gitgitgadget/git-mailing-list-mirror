From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: URL-decode the left-hand side of an svn
	refspec
Date: Thu, 5 Aug 2010 06:40:55 +0000
Message-ID: <20100805064055.GA4319@dcvr.yhbt.net>
References: <1280877685-4928-1-git-send-email-stevenrwalter@gmail.com> <20100804083840.GA19367@dcvr.yhbt.net> <AANLkTi=5qEhYABJv8CBxXwOY-UKkRc05bO=kKYkborKq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Steven Walter <stevenrwalter@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 08:41:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogu8V-0002cO-2h
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 08:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758808Ab0HEGk6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 02:40:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48463 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756669Ab0HEGk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 02:40:57 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8D71F4E1;
	Thu,  5 Aug 2010 06:40:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTi=5qEhYABJv8CBxXwOY-UKkRc05bO=kKYkborKq@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152617>

Steven Walter <stevenrwalter@gmail.com> wrote:
> On Wed, Aug 4, 2010 at 4:38 AM, Eric Wong <normalperson@yhbt.net> wro=
te:
> > Thanks Steven.
> >
> > Since git-svn already has a uri_decode() function, we should use th=
at.
> > The decoding should apply to the local portion of branches/tags glo=
bs,
> > too. =A0Does the following work for you?
<snip>
> Yes, this works.  Thanks!

Thanks Steven, I've pushed the following out for Junio at
git://git.bogomips.org/git-svn

=46rom 46cb16fb599451f417e7cd668e77866f5aa03fc0 Mon Sep 17 00:00:00 200=
1
=46rom: Steven Walter <swalter@lpdev.prtdev.lexmark.com>
Date: Tue, 3 Aug 2010 19:21:25 -0400
Subject: [PATCH] git svn: URL-decode left-hand side of svn refspec

This change allows git-svn to handle an URL with colons in the path

[ew: rewritten to use uri_decode() function]

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 8d2ef3d..34884b8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1820,6 +1820,7 @@ sub read_all_remotes {
 			die("svn-remote.$remote: remote ref '$remote_ref' "
 			    . "must start with 'refs/'\n")
 				unless $remote_ref =3D~ m{^refs/};
+			$local_ref =3D uri_decode($local_ref);
 			$r->{$remote}->{fetch}->{$local_ref} =3D $remote_ref;
 			$r->{$remote}->{svm} =3D {} if $use_svm_props;
 		} elsif (m!^(.+)\.usesvmprops=3D\s*(.*)\s*$!) {
@@ -1832,6 +1833,7 @@ sub read_all_remotes {
 			die("svn-remote.$remote: remote ref '$remote_ref' ($t) "
 			    . "must start with 'refs/'\n")
 				unless $remote_ref =3D~ m{^refs/};
+			$local_ref =3D uri_decode($local_ref);
 			my $rs =3D {
 			    t =3D> $t,
 			    remote =3D> $remote,
--=20
Eric Wong
