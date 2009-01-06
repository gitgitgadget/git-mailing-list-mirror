From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Tue, 06 Jan 2009 12:39:43 +0100
Message-ID: <20090106113943.GA28659@artemis.corp>
References: <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <20090106111712.GB30766@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="XOIedfhf+7KOe/yw";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: davidel@xmailserver.org, Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 12:41:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKAJ1-0004b7-Jo
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 12:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbZAFLjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 06:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbZAFLjr
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 06:39:47 -0500
Received: from pan.madism.org ([88.191.52.104]:33892 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbZAFLjq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 06:39:46 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id AA8D93BC26;
	Tue,  6 Jan 2009 12:39:44 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 84347374D0; Tue,  6 Jan 2009 12:39:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090106111712.GB30766@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104678>


--XOIedfhf+7KOe/yw
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2009 at 11:17:12AM +0000, Pierre Habouzit wrote:
> On jeu, jan 01, 2009 at 04:38:09 +0000, Johannes Schindelin wrote:
> >=20
> > Nothing fancy, really, just a straight-forward implementation of the
> > heavily under-documented and under-analyzed paience diff algorithm.
>=20
> Btw, what is the status of this series ? I see it neither in pu nor in
> next. And I would gladly see it included in git.

Johannes: I've not had time to investigate, but when finding what I
present in the end of this mail, I ran:

    git log -p > log-normal
    git log -p --patience > log-patience

in git.git.

I saw that patience diff is slower than normal diff, which is expected,
but I had to kill the latter command because it leaks like hell. I've
not investigated yet (And yes I'm running your latest posted series).

> On jeu, jan 01, 2009 at 07:45:21 +0000, Linus Torvalds wrote:
> > On Thu, 1 Jan 2009, Johannes Schindelin wrote:
> > >=20
> > > Nothing fancy, really, just a straight-forward implementation of the
> > > heavily under-documented and under-analyzed paience diff algorithm.
> >=20
> > Exactly because the patience diff is so under-documented, could you=20
> > perhaps give a few examples of how it differs in the result, and why it=
's=20
> > so wonderful? Yes, yes, I can google, and no, no, nothing useful shows =
up=20
> > except for *totally* content-free fanboisms.=20
> >=20
> > So could we have some actual real data on it?

> I've checked in many projects I have under git, the differences between
> git log -p and git log -p --patience. The patience algorithm is really
> really more readable with it involves code moves with changes in the
> moved sections. If the section you move across is smaller than the moved
> ones, the patience algorithm will show the moved code as removed where
> it was and added where it now is, changes included. The current diff
> will rather move the smaller invariend section you move across and
> present mangled diffs involving the function prototypes making it less
> than readable.

Actually git.git has a canonical example of this in 214a34d22.

For those not having the --patience diff applied locally, attached are
the two patches git show / git show --patience give. It's of course a
matter of taste, but I like the patience version a lot more.

I'm also curious to see what a merge conflict with such a move would
look like (e.g. inverting some of the added arguments to the factorized
function of 214a34d22 or something similar). I'm somehow convinced that
it would generate a nicer conflict somehow.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="214a34d22.normal"
Content-Transfer-Encoding: quoted-printable

commit 214a34d22ec59ec7e1166772f06ecf8799f96c96
Author: Florian Weimer <fw@deneb.enyo.de>
Date:   Sun Aug 31 17:45:04 2008 +0200

    git-svn: Introduce SVN::Git::Editor::_chg_file_get_blob
   =20
    Signed-off-by: Florian Weimer <fw@deneb.enyo.de>
    Acked-by: Eric Wong <normalperson@yhbt.net>

diff --git a/git-svn.perl b/git-svn.perl
index 0479f41..2c3e13f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3663,28 +3663,35 @@ sub change_file_prop {
 	$self->SUPER::change_file_prop($fbat, $pname, $pval, $self->{pool});
 }
=20
-sub chg_file {
-	my ($self, $fbat, $m) =3D @_;
-	if ($m->{mode_b} =3D~ /755$/ && $m->{mode_a} !~ /755$/) {
-		$self->change_file_prop($fbat,'svn:executable','*');
-	} elsif ($m->{mode_b} !~ /755$/ && $m->{mode_a} =3D~ /755$/) {
-		$self->change_file_prop($fbat,'svn:executable',undef);
-	}
-	my $fh =3D Git::temp_acquire('git_blob');
-	if ($m->{mode_b} =3D~ /^120/) {
+sub _chg_file_get_blob ($$$$) {
+	my ($self, $fbat, $m, $which) =3D @_;
+	my $fh =3D Git::temp_acquire("git_blob_$which");
+	if ($m->{"mode_$which"} =3D~ /^120/) {
 		print $fh 'link ' or croak $!;
 		$self->change_file_prop($fbat,'svn:special','*');
-	} elsif ($m->{mode_a} =3D~ /^120/ && $m->{mode_b} !~ /^120/) {
+	} elsif ($m->{mode_a} =3D~ /^120/ && $m->{"mode_$which"} !~ /^120/) {
 		$self->change_file_prop($fbat,'svn:special',undef);
 	}
-	my $size =3D $::_repository->cat_blob($m->{sha1_b}, $fh);
-	croak "Failed to read object $m->{sha1_b}" if ($size < 0);
+	my $blob =3D $m->{"sha1_$which"};
+	return ($fh,) if ($blob =3D~ /^0{40}$/);
+	my $size =3D $::_repository->cat_blob($blob, $fh);
+	croak "Failed to read object $blob" if ($size < 0);
 	$fh->flush =3D=3D 0 or croak $!;
 	seek $fh, 0, 0 or croak $!;
=20
 	my $exp =3D ::md5sum($fh);
 	seek $fh, 0, 0 or croak $!;
+	return ($fh, $exp);
+}
=20
+sub chg_file {
+	my ($self, $fbat, $m) =3D @_;
+	if ($m->{mode_b} =3D~ /755$/ && $m->{mode_a} !~ /755$/) {
+		$self->change_file_prop($fbat,'svn:executable','*');
+	} elsif ($m->{mode_b} !~ /755$/ && $m->{mode_a} =3D~ /755$/) {
+		$self->change_file_prop($fbat,'svn:executable',undef);
+	}
+	my ($fh, $exp) =3D _chg_file_get_blob $self, $fbat, $m, 'b';
 	my $pool =3D SVN::Pool->new;
 	my $atd =3D $self->apply_textdelta($fbat, undef, $pool);
 	my $got =3D SVN::TxDelta::send_stream($fh, @$atd, $pool);

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="214a34d22.patience"
Content-Transfer-Encoding: quoted-printable

commit 214a34d22ec59ec7e1166772f06ecf8799f96c96
Author: Florian Weimer <fw@deneb.enyo.de>
Date:   Sun Aug 31 17:45:04 2008 +0200

    git-svn: Introduce SVN::Git::Editor::_chg_file_get_blob
   =20
    Signed-off-by: Florian Weimer <fw@deneb.enyo.de>
    Acked-by: Eric Wong <normalperson@yhbt.net>

diff --git a/git-svn.perl b/git-svn.perl
index 0479f41..2c3e13f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3663,6 +3663,27 @@ sub change_file_prop {
 	$self->SUPER::change_file_prop($fbat, $pname, $pval, $self->{pool});
 }
=20
+sub _chg_file_get_blob ($$$$) {
+	my ($self, $fbat, $m, $which) =3D @_;
+	my $fh =3D Git::temp_acquire("git_blob_$which");
+	if ($m->{"mode_$which"} =3D~ /^120/) {
+		print $fh 'link ' or croak $!;
+		$self->change_file_prop($fbat,'svn:special','*');
+	} elsif ($m->{mode_a} =3D~ /^120/ && $m->{"mode_$which"} !~ /^120/) {
+		$self->change_file_prop($fbat,'svn:special',undef);
+	}
+	my $blob =3D $m->{"sha1_$which"};
+	return ($fh,) if ($blob =3D~ /^0{40}$/);
+	my $size =3D $::_repository->cat_blob($blob, $fh);
+	croak "Failed to read object $blob" if ($size < 0);
+	$fh->flush =3D=3D 0 or croak $!;
+	seek $fh, 0, 0 or croak $!;
+
+	my $exp =3D ::md5sum($fh);
+	seek $fh, 0, 0 or croak $!;
+	return ($fh, $exp);
+}
+
 sub chg_file {
 	my ($self, $fbat, $m) =3D @_;
 	if ($m->{mode_b} =3D~ /755$/ && $m->{mode_a} !~ /755$/) {
@@ -3670,21 +3691,7 @@ sub chg_file {
 	} elsif ($m->{mode_b} !~ /755$/ && $m->{mode_a} =3D~ /755$/) {
 		$self->change_file_prop($fbat,'svn:executable',undef);
 	}
-	my $fh =3D Git::temp_acquire('git_blob');
-	if ($m->{mode_b} =3D~ /^120/) {
-		print $fh 'link ' or croak $!;
-		$self->change_file_prop($fbat,'svn:special','*');
-	} elsif ($m->{mode_a} =3D~ /^120/ && $m->{mode_b} !~ /^120/) {
-		$self->change_file_prop($fbat,'svn:special',undef);
-	}
-	my $size =3D $::_repository->cat_blob($m->{sha1_b}, $fh);
-	croak "Failed to read object $m->{sha1_b}" if ($size < 0);
-	$fh->flush =3D=3D 0 or croak $!;
-	seek $fh, 0, 0 or croak $!;
-
-	my $exp =3D ::md5sum($fh);
-	seek $fh, 0, 0 or croak $!;
-
+	my ($fh, $exp) =3D _chg_file_get_blob $self, $fbat, $m, 'b';
 	my $pool =3D SVN::Pool->new;
 	my $atd =3D $self->apply_textdelta($fbat, undef, $pool);
 	my $got =3D SVN::TxDelta::send_stream($fh, @$atd, $pool);

--huq684BweRXVnRxX--

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkljQv8ACgkQvGr7W6HudhylIACgi4YR8Onh4GS9zD24ov1DUtMJ
wO8An1+Go3q6UFGllmhWUoazj5DxnZC7
=rKtO
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
