From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-archive and tar options
Date: Mon, 18 Jul 2011 22:50:21 +0200
Message-ID: <4E249C8D.10107@lsrfire.ath.cx>
References: <ivla29$liu$1@dough.gmane.org> <20110714015656.GA20136@sigill.intra.peff.net> <4E1F2468.6080409@lsrfire.ath.cx> <20110714172718.GA21341@sigill.intra.peff.net> <7vei1s36bl.fsf@alter.siamese.dyndns.org> <20110714212502.GA29848@sigill.intra.peff.net> <7vwrfk1lv3.fsf@alter.siamese.dyndns.org> <4E20AA42.7000003@lsrfire.ath.cx> <4E248A2E.3090902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 22:50:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qium4-0004Yz-5l
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 22:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab1GRUuj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 16:50:39 -0400
Received: from india601.server4you.de ([85.25.151.105]:45073 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab1GRUui (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 16:50:38 -0400
Received: from [192.168.2.106] (p4FFDB1F3.dip.t-dialin.net [79.253.177.243])
	by india601.server4you.de (Postfix) with ESMTPSA id E10362F802D;
	Mon, 18 Jul 2011 22:50:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <4E248A2E.3090902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177407>

Am 18.07.2011 21:31, schrieb Neal Kreitzinger:
> In regards to use cases in general, my impression is that git-archive=
 is
> for producing archives useful for deployment.  The target deployed
> structure may vary so expecting the source git repo to reflect this i=
s
> unfeasable.  It seems like utilizing the local tar installation would
> effect the necessary transformations. I'm not sure what the source an=
d
> target tar version disparity problems might me.

Direct deployment is not an _intended_ use case, but I see that it migh=
t
be useful for that, especially with scripting languages.

I'm not sure I like tar's --transform option, though.  This seems to be
too heavy a solution.  For your example it would be enough to support
multiple tree arguments (with their own respective prefixes) in one go.

> A practical problem with the pax header is that its only useful if yo=
u
> still have the archive.  Archives usually get deleted after being
> extracted.  Therefore, an option to also generate (and add to the
> archive) an automatic "VERSION.TXT" file of some sort which specifies
> the context of the archive would be much more useful.  It would need =
its
> own --prefix option because oftentimes it would be dynamically genera=
ted
> based on the git-archive request.

The attribute export-subst with its $Format:$ expansion is intended to
be used for such version files.  It still lacks the ability to produce
git-describe-style version strings, but commit hashes can be used inste=
ad.

> Another use case is that it seems like there should also be the optio=
n
> to only tar the objects changed between a specified range of commits.
> However, I'm not sure if tar can handle deletions (moves, deletions,
> renames) upon extraction in this context.

Well, you could build a list of paths using git log --name-status or
similar and feed that to git archive.  If you want to keep a directory
in sync with a repo, why not use git checkout, though? :)

> I can see that my use cases are something that I can script myself, b=
ut
> to do so it seems like I would be better off using a non-bare repo
> checkout as an intermediary.  If that is what I am expected to do the=
n I
> am not sure what the usefulness of git-archive is intended to be.  Ma=
ybe
> I don't understand what others use it for.

The primary use case is to create source code archives that people can
download, build and deploy who are not interested in downloading the
whole history or in using git at all.

Ren=E9
