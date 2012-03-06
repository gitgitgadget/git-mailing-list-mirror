From: Stephen Bash <bash@genarts.com>
Subject: Re: Approaches to SVN to Git conversion (was: Re: [RFC] "Remote helper for Subversion" project)
Date: Tue, 06 Mar 2012 15:35:45 -0500 (EST)
Message-ID: <ab5eb5a7-a446-4dc3-b8e8-e3f7ec306452@mail>
References: <CA+7g9Jwb=7wH7R3=ShhOGMdHXWmq4ZahocpaEuJdf+yBfCpA8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, David Barr <davidbarr@google.com>
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 21:36:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5174-0006A4-6y
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 21:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031053Ab2CFUf5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 15:35:57 -0500
Received: from hq.genarts.com ([173.9.65.1]:21440 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965249Ab2CFUf4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 15:35:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id BD05EBE8319;
	Tue,  6 Mar 2012 15:35:52 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Czop7FuV6IN; Tue,  6 Mar 2012 15:35:45 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 632E5BE8318;
	Tue,  6 Mar 2012 15:35:45 -0500 (EST)
In-Reply-To: <CA+7g9Jwb=7wH7R3=ShhOGMdHXWmq4ZahocpaEuJdf+yBfCpA8A@mail.gmail.com>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC17 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192387>



----- Original Message -----
> From: "Nathan Gray" <n8gray@n8gray.org>
> Sent: Tuesday, March 6, 2012 2:29:59 PM
> Subject: Re: Approaches to SVN to Git conversion (was: Re: [RFC] "Rem=
ote helper for Subversion" project)
>=20
> > > Personally, I think SVN export will always need a strong manual
> > > component to get the best results, so I've put quite a bit of wor=
k
> > > into designing a good SVN history format. =C2=A0Like git-fast-imp=
ort,
> > > it's an ASCII format designed both for human and machine
> > > consumption...
> >
> > First, I'm very impressed that you managed to get a language like
> > this up and working. =C2=A0It could prove very useful going forward=
=2E  =C2=A0On
> > the flip side, from my experiments over the last year I've actually
> > been leaning toward a solution that is more implicit than explicit.
> > Taking git-svn as a model, I've been trying to define a mapping
> > system (in Perl):
> >
> > =C2=A0my %branch_spec =3D { '/trunk/projname' =3D> 'master',
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0'/branches/*/projname' =3D> '/refs/heads/*' };
> > =C2=A0my %tag_spec =3D { '/tags/*/projname' =3D> '/refs/tags/*' };
>=20
> The problem of specifying and detecting branches is a major problem i=
n
> my upcoming conversion.  We've got toplevel trunk/branches/tags
> directories but underneath "branches" it's a free-for-all:
>=20
> /branches/codenameA/{projectA,projectB,projectC}
> /branches/codenameB   (actually a branch of projectA)
> /branches/developers/joe/frobnicator-experiment (also a branch of
> projectA)
>=20
> Clearly there's no simple regex that's going to capture this, so I'm
> reduced to listing every branch of projectA, which is tedious and
> error-prone.  However, what *would* work fabulously well for me is
> "marker file" detection.  Every copy of projectA has a certain file a=
t
> it's root.  Let's call it "markerFile.txt".  What I'd really love is =
a
> way to say:
>=20
> my %branch_markers =3D {'/branches/**/markerFile.txt' =3D>
>                       '/refs/heads/**'}

Ooo...  I like it.  I hadn't hit on this idea yet, but it certainly is =
a very helpful heuristic.  I doubt I'd have any sort of demo code for y=
ou in the near future, but it's definitely an idea to roll into the mix=
=2E

Thanks,
Stephen
