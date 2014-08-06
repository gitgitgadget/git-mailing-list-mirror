From: Nico Williams <nico@cryptonector.com>
Subject: Re: "Branch objects" (was: Re: cherry picking and merge)
Date: Wed, 6 Aug 2014 15:07:27 -0500
Message-ID: <20140806200726.GE23449@localhost>
References: <CANQwDwcHSO+KwhZbo4BTcWnAWGWbJzNQ7CY2m3nq+p0t9uDeqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 22:07:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF7Ui-0006mm-PV
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 22:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbaHFUH3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2014 16:07:29 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:53869 "EHLO
	homiemail-a64.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753026AbaHFUH2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Aug 2014 16:07:28 -0400
Received: from homiemail-a64.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a64.g.dreamhost.com (Postfix) with ESMTP id 2A0B1438072;
	Wed,  6 Aug 2014 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to:content-transfer-encoding; s=
	cryptonector.com; bh=zK9yrBN24pQz0ebNWCiBU9mozBI=; b=BOytOty6cIp
	GybvmOIQB3KH6GXZIh3ghhpMtxck/pB5TpEs+fMtIGe4vTRwc2GucPVWcKJwNaNP
	4mBxdGD5W0W+ObPRGrdeamoXjsBPAW78mGZ65wNcs69Xq0CtJZu8HCYaKnYmHcLi
	hVqRn8L7R8RN/GfvSAXOK5DwyvkIIXmE=
Received: from localhost (108-207-244-174.lightspeed.austtx.sbcglobal.net [108.207.244.174])
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a64.g.dreamhost.com (Postfix) with ESMTPA id B232243806C;
	Wed,  6 Aug 2014 13:07:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANQwDwcHSO+KwhZbo4BTcWnAWGWbJzNQ7CY2m3nq+p0t9uDeqg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254897>

On Wed, Aug 06, 2014 at 08:31:18PM +0200, Jakub Nar=C4=99bski wrote:
> On Wed, Aug 6, 2014 at 6:26 PM, Nico Williams <nico@cryptonector.com>=
 wrote:
> > My proposal was to put this sort of ancillary history info in a
> > "branch object" (and that branches should be objects).  This would
> > have a number of benefits, not the least of which is that at push t=
ime
> > you can drop such ancillary history without having to alter the
> > commits being pushed.
>=20
> Is it something like object-ified reflog, similar to how replacement
> objects (git-replace) can be thought to be object-ified grafts (I kno=
w
> they are more)? Do I understand it correctly?

Yes, per-branch.  At push time a commit would be pushed to the upstream
branch listing the commits pushed now (and who by).  Locally every
rebase/cherry-pick/merge/commit onto the branch would appear in the
branch object's history, kinda just like the reflog.  The main
difference is that the upstream branch's history could be viewed.

> Did you plan to (ab)use known object types: tree and commit (a bit
> similar to git-replace and git-note object, though there is no need f=
or
> fanout trees - the top level tree can reproduce refs hierarchy)? I se=
e
> that you planned to (ab)use existing transfer mechanism of refs and
> objects...

Just like signed tags, basically.

> > Reverts upstream?  The revert should record the commit hash of the
> > commit it reverts (but file-level reverts lose), so that this could=
 be
> > noticed.
>=20
> If it is object-ified reflog then reverts are not a problem...

Right.

> > Rebases upstream?  Well, that shouldn't happen, but if it does then
> > you must rebase --onto and any cherry-picks of upstream rebased
> > commits lose their ties to those (but this can be detected).
>=20
> With rebases the problem is that it would be nice to have (at least
> for a short time) the history of series of patches (the metahistory,
> or history of a branch), but usually one doesn't need old pre-rebase
> version after cleaning up the history for publishing.

Right.

> > In general recording more metadata (assuming there's not privacy
> > issues to consider) can't hurt.  Using it might, but having the opt=
ion
> > to can also help.
>=20
> True...

The principle should be to record as much metadata as possible, pruning
ancillary metadata (reflog-like metadata that isn't on the commits) onl=
y
at push time. =20

Nico
--=20
