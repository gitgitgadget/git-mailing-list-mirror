From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Thu, 1 Jan 2009 17:56:13 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901011747010.5086@localhost.localdomain>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20090101204652.GA26128@chistera.yi.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Fri Jan 02 02:59:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIZKP-0007Kq-Un
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 02:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbZABB4f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jan 2009 20:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753558AbZABB4e
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 20:56:34 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43453 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750911AbZABB4e (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jan 2009 20:56:34 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n021uFZG010494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Jan 2009 17:56:16 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n021uDbM024635;
	Thu, 1 Jan 2009 17:56:14 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090101204652.GA26128@chistera.yi.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.924 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104354>



On Thu, 1 Jan 2009, Adeodato Sim=C3=B3 wrote:
>=20
> For me, the cases where I find patience output to be of substantial
> higher readability are those involving a rewrite of several consecuti=
ve
> paragraphs (i.e., lines of code separated by blank lines). Compare:

I don't think that's a "patience diff" issue.

That's simply an issue of merging consecutive diff fragments together i=
f=20
they are close-by, and that's independent of the actual diff algorithm=20
itself.

> I'll note that in this particular case, `git diff` yielded the very s=
ame
> results with or without --patience. I don't know why that is, Johanne=
s?
> I'll also note that /usr/bin/diff produces (in this case) something
> closer to patience than to git.

See above - I really don't think this has anything to do with "patience=
 vs=20
non-patience". It's more akin to the things we do for our merge conflic=
t=20
markers: if we have two merge conflicts next to each other, with just a=
=20
couple of lines in between, we coalesce the merge conflicts into one=20
larger one instead.

We don't do that for regular diffs - they're always kept minimal (ok, n=
ot=20
really minimal, but as close to minimal as the algorithm finds them).

See commit f407f14deaa14ebddd0d27238523ced8eca74393 for the git merge=20
conflict merging. We _could_ do similar things for regular diffs. It's=20
sometimes useful, sometimes not.

		Linus
