From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] Remove perl dependency from git-submodule.sh
Date: Thu, 31 May 2012 12:40:36 +0200
Message-ID: <20120531104036.GB30500@paksenarrion.iveqy.com>
References: <1338454126-30441-1-git-send-email-iveqy@iveqy.com>
 <4FC73788.6070805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 31 12:41:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa2oc-0005Z1-Ie
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 12:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779Ab2EaKlJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 06:41:09 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:47760 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab2EaKlH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 06:41:07 -0400
Received: by lbbgm6 with SMTP id gm6so717599lbb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 03:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kQUYpuFQVDx1eBNkaFyNL531VN9PHCKITTZstutlv2o=;
        b=RzhIkuRqe9pEFsf4MGIFi0JnjwHb9jcz70qHqlMqrsg489LrQ/IzbH4ey+o/jV854Q
         uj5RZGgp3tMTx/rP/ydbUAhJ8TbJ+X2NohW5b/aVguffXaQIqcXZ1ZOiiajXHwsc1Mik
         OZxV5K3ZCbkbMXYSJUYgPwZU56xiKj1xI7QhfFRt0c7ulZHzhiFZy17VOj9yvBUBXTBw
         fapvXWezIgCtIuPQUJi5KLPrKLQ+VtSOjhoL/nSzRuv1toKyKpyKOuXFOo4I3mvdwp0I
         OJXT6slk4kk7Fh+Ks8PdQABokywuwDaSbpmFUzs9STlkRI0t898F1dmmnLNDsnkaFiq8
         881Q==
Received: by 10.152.144.138 with SMTP id sm10mr11081699lab.22.1338460865779;
        Thu, 31 May 2012 03:41:05 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-184-249.a189.priv.bahnhof.se. [85.24.184.249])
        by mx.google.com with ESMTPS id q8sm1880055lbj.2.2012.05.31.03.41.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 03:41:05 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Sa2o0-00081m-FF; Thu, 31 May 2012 12:40:36 +0200
Content-Disposition: inline
In-Reply-To: <4FC73788.6070805@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198880>

On Thu, May 31, 2012 at 11:19:04AM +0200, Johannes Sixt wrote:
> Am 5/31/2012 10:48, schrieb Fredrik Gustafsson:
> > Rewrote a perl section in sh.
>=20
> > The code may be a bit slower (doing grep on strings instead of usin=
g
> > perl-lists).
>=20
> "A lot" would be more correct on Windows :-) But it can be avoided, I=
 think.
>=20
> >  module_list()
> >  {
> > +	unmerged=3D
> > +	null_sha1=3D0000000000000000000000000000000000000000
> >  	git ls-files --error-unmatch --stage -- "$@" |
> > -	perl -e '
> > -	my %unmerged =3D ();
> > -	my ($null_sha1) =3D ("0" x 40);
> > -	while (<STDIN>) {
> > -		chomp;
> > -		my ($mode, $sha1, $stage, $path) =3D
> > -			/^([0-7]+) ([0-9a-f]{40}) ([0-3])\t(.*)$/;
> > -		next unless $mode eq "160000";
> > -		if ($stage ne "0") {
> > -			if (!$unmerged{$path}++) {
> > -				print "$mode $null_sha1 U\t$path\n";
> > -			}
> > -			next;
> > -		}
> > -		print "$_\n";
> > -	}
> > -	'
> > +	while read mode sha1 stage path
>=20
> Be prepared for backslashes in the path name:
>=20
> 	while read -r mode sha1 stage path

We are not using -r on any place in git-submodule.sh. Maybe we should? =
I
can provide a patch if needed.

>=20
> > +	do
> > +		if test $mode -eq 160000
>=20
> $mode is not a number, but a string: test "$mode" =3D 160000

okay, fixed in next iteration.

>=20
> > +		then
> > +			if test $stage -ne 0
>=20
> That $stage looks like a number is of no importance, either.

Actually I don't know what stage does and if it's important here. This
part is just to mimic the perl code. Should it be removed?

>=20
> > +			then
> > +				if test -z "$(echo $unmerged | grep "|$path|")"
> > +					then
> > +					echo "$mode $null_sha1 U\t$path"
> > +				fi
> > +				unmerged=3D"$unmerged|$path|"
>=20
> IIUC, the purpose of $unmerged and this check is to avoid that an unm=
erged
> path is dumped for each stage that is listed by ls-files. Therefore i=
t
> should be sufficient to just check that the current path is different=
 from
> the last path.

That requires that submodules always is in the same order, right? That
would not work for:
sub1
sub2
sub1

case. But is that order really a possibility or is it always
sub1
sub1
sub2

?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
