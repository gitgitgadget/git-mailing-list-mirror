From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git-svn: fix ls-tree usage with dash-prefixed paths
Date: Tue, 31 Mar 2009 11:41:07 +0200
Message-ID: <20090331094107.GC3307@atjola.homenet>
References: <20090329060858.GB15773@dcvr.yhbt.net> <20090329061045.GA29721@dcvr.yhbt.net> <7v8wmoqdc1.fsf@gitster.siamese.dyndns.org> <20090329215651.GA4355@dcvr.yhbt.net> <7v3acvldc7.fsf@gitster.siamese.dyndns.org> <20090330174151.GA32728@dcvr.yhbt.net> <7vy6umdgxq.fsf@gitster.siamese.dyndns.org> <20090330225834.GA24254@dcvr.yhbt.net> <20090331071100.GA3307@atjola.homenet> <20090331073147.GB3307@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Anton Gyllenberg <anton@iki.fi>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 11:43:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoaUW-0005UI-7r
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 11:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbZCaJlO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 05:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbZCaJlN
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 05:41:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:51717 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750890AbZCaJlM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 05:41:12 -0400
Received: (qmail invoked by alias); 31 Mar 2009 09:41:10 -0000
Received: from i59F54235.versanet.de (EHLO atjola.local) [89.245.66.53]
  by mail.gmx.net (mp044) with SMTP; 31 Mar 2009 11:41:10 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18cBJx/Dd8c6OPJewQwEdS5drLlFwqVkEybvHO2FT
	fWG0fIigo6skDK
Content-Disposition: inline
In-Reply-To: <20090331073147.GB3307@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115238>

On 2009.03.31 09:31:47 +0200, Bj=F6rn Steinbrink wrote:
> On 2009.03.31 09:11:00 +0200, Bj=F6rn Steinbrink wrote:
> > And interestingly, the problem doesn't seem to be in
> > show_tree/show_recursive, but in match_tree_entry.
> >=20
> > With "git ls-tree HEAD gitweb/git-favicon.png g" we descend into gi=
tweb/
> > and at some point we get:
> >=20
> > match =3D "g"
> > base =3D "gitweb/"
> >=20
> > And we have:
> > if (baselen >=3D matchlen) {
> > 	if (strncmp(base, match, matchlen))
> > 		continue;
> > 	/* The base is a subdirectory of a path which was specified */
> > 	return 1;
> > }
> >=20
> > So we return 1 there. The code doesn't do what the comment says, so=
 I
> > guess we can be pretty sure that the behaviour is not intended.
>=20
> Yup, it's in match_tree_entry, you get the same thing with git show.
> With git.git, you can try with:
>=20
> git show 4fa535a -- Documentation/git-merge.txt D
>=20
> I'll try to get a patch done, if noone beats me to it.

Ah, crap, "git show" actually uses a different function,
tree_entry_interesting, which happens to have the same problem, but
needs a slightly different fix.

Bj=F6rn
