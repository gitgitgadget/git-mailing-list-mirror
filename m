From: Wincent Colaiuta <win@wincent.com>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 19:23:12 +0200
Message-ID: <7E75E8FC-FC46-49BC-9610-7F62A3623576@wincent.com>
References: <9b3e2dc20806271331l2870ef94o4cd413ee40ab0d39@mail.gmail.com> <willow-jeske-01l7H4tHFEDjCgPV-01l7ZhB8FEDjCdJs> <willow-jeske-01l7ZyqpFEDjC=91ms>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Sinclair <radarsat1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: "David Jeske" <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 19:24:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCeA0-0006TS-75
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 19:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbYF1RXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jun 2008 13:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753057AbYF1RXV
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 13:23:21 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:35814 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbYF1RXU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jun 2008 13:23:20 -0400
Received: from cuzco.lan (80.pool85-53-24.dynamic.orange.es [85.53.24.80])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m5SHNEhs026107
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 28 Jun 2008 13:23:16 -0400
In-Reply-To: <willow-jeske-01l7ZyqpFEDjC=91ms>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86732>

El 27/6/2008, a las 22:45, David Jeske escribi=F3:

> - I could supercede 2-commits with 1, effectively making the bad-=20
> commit
> disappear in the linear history. Users who already have the history, =
=20
> however,
> would be unaffected, because the start/end endpoints are the same.


You can't do that. The start might be the same but the end point would =
=20
not, even if the file contents happened to be the same as they were =20
before. This is because each commit is identified by its SHA-1 hash, =20
and changing any ancestor anywhere in the DAG will have a trickle-down =
=20
effect to all subsequent commits which stem from it, changing their =20
SHA-1 hashes too. So you wind up with a different end point. This is =20
by design (see below).

El 27/6/2008, a las 22:51, David Jeske escribi=F3:

> What git can't do, is let me "supercede" the old DAG-subset, so =20
> people I shared
> them with can get my new changes without hurting their world. =20
> Currently git
> seems to rely on the idea that "if you accept changes into your tree =
=20
> that will
> be later rebased, it's up to you to figure it out". I don't see why =20
> that is the
> case.

It has to be this way because it is the only way to do distributed =20
SCM. Imagine for a minute that one developer has a commit "feedface", =20
fetched from another repo. If the commit or any parent (grand parent, =20
great grandparent etc) is changed then the hash _has_ to be different. =
=20
Otherwise you would have the untenable situation that two developers, =20
two repos, could refer to a particular commit "feedface" and it =20
wouldn't actually be the same thing. Distributed development would be =20
unworkably flakey if you couldn't rely on the stability of each =20
commit's SHA-1 hash, and that fact that it embodies not just that =20
particular state in the history, but all prior states too.

It's a totally basic, fundamental, central, non-negotiable concept to =20
Git's design. And not just an idiosyncrasy either; if you do a review =20
of other distributed SCMs out there you'll find that _all_ of them =20
have a similar underlying precept, as it's literally the only way to =20
do working distributed SCM.

Wincent
