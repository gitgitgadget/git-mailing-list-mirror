From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: choose appropriate view for file type if a= parameter missing
Date: Sun, 13 May 2007 02:32:36 +0200
Organization: At home
Message-ID: <f25m2b$1b1$1@sea.gmane.org>
References: <20070509221928.17244.qmail@f9729cdcdf57d1.315fe32.mid.smarden.org> <7vvef1o2ni.fsf@assigned-by-dhcp.cox.net> <20070510073207.21562.qmail@25d0c789693af2.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 13 02:28:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn1wp-00035Q-Nf
	for gcvg-git@gmane.org; Sun, 13 May 2007 02:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbXEMA2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 May 2007 20:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755877AbXEMA2U
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 20:28:20 -0400
Received: from main.gmane.org ([80.91.229.2]:54166 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998AbXEMA2T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 20:28:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hn1wc-0002XX-AG
	for git@vger.kernel.org; Sun, 13 May 2007 02:28:14 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 May 2007 02:28:14 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 May 2007 02:28:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47116>

<opublikowany i wys=B3any>

[Cc: Gerrit Pape <pape@smarden.org>, Junio C Hamano <junkio@cox.net>,
 git@vger.kernel.org]

Gerrit Pape wrote:

> this change would aid the creation of shortcuts to git repositories u=
sing
> simple substitution, such as:
> http://example.org/git/?p=3Dpath/to/repo.git;hb=3DHEAD;f=3D%s
>=20
> With this patch, if given the hash through the h=3D parameter, or the=
 hash
> base (hb=3D) and a filename (f=3D), gitweb uses cat-file -t to automa=
tically set
> the a=3D parameter.

> -if (defined $project) {
> -     $action ||=3D 'summary';
> -} else {
> -     $action ||=3D 'project_list';
> +if (!defined $action) {
> +     if (defined $hash) {
> +             $action =3D git_get_type($hash);
> +     } elsif (defined $hash_base && defined $file_name) {
> +             $action =3D git_get_type("$hash_base:$file_name");
> +     } elsif (defined $project) {
> +             $action =3D 'summary';
> +     } else {
> +             $action =3D 'project_list';
> +     }

NOTE:

We have something similar for the only committag we support, namely
the shortened sha1 of object, which leads to an "object", which chooses
appropriate view using git_get_type / git-cat-file -t.

But contrary to the above solution it does it by creating a _redirect_
to a proper view, instead of silently selecting proper view like in
a patch above. Creating a redirect allows price for invoking=20
git-cat-file -t to be paid only once. User would bookmark correct view.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
