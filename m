From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Tracking empty directories
Date: Tue, 1 Feb 2011 21:09:15 +0200
Message-ID: <20110201190915.GB2370@LK-Perkele-VI.localdomain>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <AANLkTi=u6=mhOd9LFYRy48y41xRcXmYDtktOKoBjjMgO@mail.gmail.com>
 <20110201181509.GA2370@LK-Perkele-VI.localdomain>
 <201102011931.40559.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 20:09:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkLbi-0004Vi-F1
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 20:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080Ab1BATJg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 14:09:36 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:41374 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab1BATJg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 14:09:36 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id E92CD8C5AA;
	Tue,  1 Feb 2011 21:09:34 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A053E7E2CD1; Tue, 01 Feb 2011 21:09:34 +0200
Received: from LK-Perkele-VI (a88-112-56-215.elisa-laajakaista.fi [88.112.56.215])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 699CA41BE2;
	Tue,  1 Feb 2011 21:09:28 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <201102011931.40559.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165847>

On Tue, Feb 01, 2011 at 07:31:38PM +0100, Jakub Narebski wrote:
> Dnia wtorek 1. lutego 2011 19:15, Ilari Liusvaara napisa=C5=82:
> >=20
> > Worse problem than the index: Tree entries. Those are actually tran=
sferable
> > and IIRC older (current?) git versions don't handle empty subdirect=
ories
> > (pointing entry of type directory to empty tree hash) all too well.=
=2E.
>=20
> What did you mean by "don't handle" here?  The following entry
>=20
>   040000 tree 22d5826c087c4b9dcc72e2131c2cfb061403f7eb	empty
>=20
> should be not a problem; empty tree is hardcoded and also shouldn't t=
here
> be a problem with such object.  Is the problem when checking out such=
 tree
> (writing to index and/or working area)?

Yes, writing to index/working area. IIRC, having such entry in tree cau=
ses
a "ghost directory". I don't exactly recall what such thing broke, but =
I
remember that it broke something (merging?)...

Those ghosts also had annoying tendency to persist between commits. Com=
mits
didn't kill them. Rm didn't work. You had to create something on top/in=
side to
get rid of them.

> > Worse yet, there isn't easy way to break the tree parser to avoid c=
urrent
> > git versions from screwing things up (IIRC, when I tested, invalid =
octal
> > numbers finally broke it, invalid file types didn't do the trick)..=
=2E
>=20
> Well, then 1.8.0 version could be good place to break backwards=20
> compatibility; we did similar thing when introducing submodule entrie=
s,
> isn't it?

Hint: Entry of mode "88888" blows up the tree parser nicely... :-)

At the same time, it could be useful to have manually tracked directori=
es
(incidate via "sticky" bit of tree entry mode?)

-Ilari
