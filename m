From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] gitweb: support filename prefix in git_patchset_body
Date: Mon, 26 Mar 2007 22:55:08 +0200
Message-ID: <20070326205508.GC1128@auto.tuwien.ac.at>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548623841-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548622060-git-send-email-mkoegler@auto.tuwien.ac.at> <200703261912.18549.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 22:56:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVwEY-0000et-N3
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 22:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbXCZUzO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 26 Mar 2007 16:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbXCZUzN
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 16:55:13 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:59066 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbXCZUzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 16:55:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id A932B71D8F2E;
	Mon, 26 Mar 2007 22:55:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ntijz81uYjZO; Mon, 26 Mar 2007 22:55:08 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 4C1FC73839BA; Mon, 26 Mar 2007 22:55:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200703261912.18549.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43186>

On Mon, Mar 26, 2007 at 06:12:18PM +0100, Jakub Narebski wrote:
> On Sun, Mar 25, 2007, Martin Koegler wrote:
> > git_treediff supports comparing subdirectories. As the output of
> > git-difftree is missing the path to the compared directories,
> > the links in the output would be wrong.
> >=20
> > The patch adds two new parameters to add the missing path prefix.
>=20
> Wouldn't it be better to concatenate the two "path prefix" patches
> together? They are about the same thing.

I thought, each patch would be more readable, I split them in logical
seperate units. Anyway, I'll combine them.

> >  sub git_patchset_body {
> > -	my ($fd, $difftree, $hash, $hash_parent) =3D @_;
> > +	my ($fd, $difftree, $hash, $hash_parent, $file_name, $file_parent=
) =3D @_;
> > =20
> >  	my $patch_idx =3D 0;
> >  	my $patch_line;
>=20
> I'd rather use $from_prefix, $to_prefix here, or $basedif_name,
> $basedir_parent, or $dir_name, $dir_parent (my preference is to
> $from_prefix, $to_prefix variables).

I'll switch to $to_prefix and $from_prefix.

> +	$from_prefix =3D !defined $from_prefix ? '' : $from_prefix.'/';
> +	$to_prefix   =3D !defined $to_prefix   ? '' : $to_prefix . '/';
> +	$to_prefix ||=3D $from_prefix;  # to allow to pass common prefix on=
ce

OK. But is not the 3 line useless, as $to_prefix is alway defined
after the second line and you probable want $from_prefix ||=3D
$to_prefix. This will cause problems, as I currently pass the root
tree (=3Dtree in commit object) as an missing file name parameter, as
gitweb does not allow an empty file name.

With an propagation logic, comparing a root tree with an sub tree will =
only
work in one direction.

So I prefer to do not implement any automatic propagation between the t=
wo prefixes.

> or something like that, or just modify $from{'file'} and $to{'file'}
>=20
> 	$from{'file'} =3D (!defined $from_prefix ? '' : $from_prefix.'/') . =
$from{'file'};
> 	$to{'file'}   =3D (!defined $to_prefix   ? '' : $to_prefix . '/') . =
$to{'file'};
>=20
> just after setting $from{'file'} and $to{'file'}, although the second
> solution would additionally add prefix to the shown patch body itself=
=2E

Modifing the paths before generating the links is a good idea. I'll
look, where its useful.

mfg Martin K=F6gler
