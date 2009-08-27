From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: finding unmerged branches
Date: Fri, 28 Aug 2009 00:35:04 +0200
Message-ID: <20090827223504.GA18307@atjola.homenet>
References: <20090827220241.GA1413@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 00:35:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgnYy-0001uj-1a
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 00:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbZH0WfJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 18:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbZH0WfI
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 18:35:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:46643 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751481AbZH0WfH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 18:35:07 -0400
Received: (qmail invoked by alias); 27 Aug 2009 22:35:08 -0000
Received: from i59F5455C.versanet.de (EHLO atjola.homenet) [89.245.69.92]
  by mail.gmx.net (mp022) with SMTP; 28 Aug 2009 00:35:08 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/mcsZQq93mPi1YHBqEHi7j/wjrkkZ24DBMnV+lbd
	fnjdY6E9PsVso6
Content-Disposition: inline
In-Reply-To: <20090827220241.GA1413@gnu.kitenet.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127229>

On 2009.08.27 18:02:41 -0400, Joey Hess wrote:
> My situation is this: My project has a lot of remotes with
> lots of branches; about 250 branches in total. I want to
> figure out which of these branches to look at to consider
> merging.
>=20
> So, I reach for git branch -a --no-merged master; that's what
> its man page says its for. But this still finds 120 branches,
> and a lot of them are not things I want to look at. Many of
> them are copies of some of my own branches.
>=20
> What I really want is a way to find remote branches that
> are not merged with any of my local branches (or any origin
> branches). A slow and stupid implementation of that is in the
> attached git-unmerged script, and it weeds the branch list
> down to 68 branches, which are mostly really ones I might
> want to look at.
>=20
> So, three questions:
>=20
> * Is this situation somewhat common, or an I doing something wrong?
>   (Assuming that I have a good reason to want to look at remote=20
>   branches rather than waiting to get merge requests.)
> * Is there a better way to accomplish this than a slow perl script th=
at
>   runs git branch -r --merged foreach of my branches?

Hm, not sure if I'd call it "better", but probably at least a bit
faster. You could create a "fake" merge to combine all the branches.

git branch -r --no-merged $(
  : | git commit-tree HEAD^{tree} $(
    git for-each-ref --format=3D'-p %(refname)' \
      refs/heads/ \
      refs/remotes/origin
    )
  )

Bj=F6rn
