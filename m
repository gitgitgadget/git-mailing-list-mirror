From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git svn : hook before 'git svn dcommit'
Date: Wed, 17 Aug 2011 13:37:01 -0700
Message-ID: <20110817203701.GB24581@dcvr.yhbt.net>
References: <1313438699-9926-1-git-send-email-frederic.heitzmann@gmail.com>
 <7vty9ijs1i.fsf@alter.siamese.dyndns.org>
 <20110817003023.GA30153@dcvr.yhbt.net>
 <CALeToSWJNK=q4iPwxNvgGin0T61oLKJd=b9F3cSSo0vVebrhhQ@mail.gmail.com>
 <CALeToSUidWgiJ+PxuphnBZOQGNStNOO9==EswfLDpFr2GYy=nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 22:37:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtmrT-0008Qm-Lu
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 22:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114Ab1HQUhE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Aug 2011 16:37:04 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40432 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924Ab1HQUhC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 16:37:02 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 937F421091;
	Wed, 17 Aug 2011 20:37:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALeToSUidWgiJ+PxuphnBZOQGNStNOO9==EswfLDpFr2GYy=nA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179535>

=46r=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.com> wrote:
> 4) Before merging back to master and commitng to SVN, it is necessary
> to remove commits with reference data (git rebase -i --onto master
> master topic ...)
> 5) merge topic branch with master and git svn dcommit
>=20
> -- end --
>=20
> It is very easy to forget step 4, and svn commit lots of useless data=
=2E

I agree.

> Proposal 1)
> * commit reference data with some specific mark in the commit message
> (e.g. "NO_SVN")
> * use pre-svn-dcommit hook to detect such commits

The problem with this is hook standardization across committers and eve=
n
across different machines/directories a committer may use.

> Proposal 2) (not fully feasable for what I know)
> * git svn clone to a bare repo
> * clone a working repo from the the bare repo.
> * steps 2, 3, maybe 3bis, ... then 4
> * push commits to the bare repo, while using pre-receive or update
> hook to look for wrong commits, and abort if so.
> * use post-receive hook to trigger git svn dcommit
>=20
> Main drawback for proposal 2 (appart from needing 2 repo instead of
> one) is that each time you want to update your working=C2=A0 repo, yo=
u have
> to git svn rebase the bare repo, then git pull.

Proposal 2 is way too complicated, I hate it.

> All things begin equal, proposal 1 seems to be the easier path, but i=
t
> is highly debatable.

I had Proposal 3 in my original response:

> 2011/8/17 Eric Wong <normalperson@yhbt.net> wrote:
> > Perhaps an interactive option for dcommit would be just as useful?

1 and 3 can both implemented, but I think 3 would be easier to
use/setup/standardize.  I suspect it's also easier to train oneself to
always use "dcommit -i".  Perhaps even default to interactive mode
like git-send-email does nowadays.

Unfortunately interactive dcommit requires more effort to implement.

--=20
Eric Wong
