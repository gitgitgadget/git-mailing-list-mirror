From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: git stash doesn't honor --work-tree or =?utf-8?b?R0lUX1dPUktfVFJFRQ==?=
Date: Sat, 30 Nov 2013 21:22:01 +0000 (UTC)
Message-ID: <loom.20131130T221443-682@post.gmane.org>
References: <CABL6xpD9jvJWjUj0n+mgC419fGzA2N-b_yJho9zharCD6YTSiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 30 22:22:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vmrzg-0003JV-Aj
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 22:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965Ab3K3VWY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Nov 2013 16:22:24 -0500
Received: from plane.gmane.org ([80.91.229.3]:43855 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817Ab3K3VWX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 16:22:23 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Vmrza-0003Gu-6Y
	for git@vger.kernel.org; Sat, 30 Nov 2013 22:22:22 +0100
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 22:22:22 +0100
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 22:22:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:25.0) Gecko/20100101 Firefox/25.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238572>

Aaron Brooks <aaron <at> brooks1.net> writes:

>=20
> Unlike other commands, git stash doesn't work outside of the worktree=
,
> even when --work-tree is specified:
>=20
> (...)
>=20
> It looks like the "require_work_tree" function should check the
> environment variables in addition to the status of the PWD (via
> git-rev-parse).
>=20
> Having looked through several of the other git-*.sh scripts, I think
> other shell based git commands will have similar problems.
>=20
> Thanks,
>=20
> Aaron
>=20

The environment variables are properly exported. I verified this by
adding 'echo $GIT_WORK_TREE; echo $GIT_DIR' at the top of git-stash.sh.
So these should propagate to "child gits" just fine, and so it shouldn'=
t
be necessary to test them explicitly.

The problem seems to be that git rev-parse --is-inside-work-tree does
not honor these. In fact it doesn't even honor --git-dir or --work-tree=
=2E
Judging by the name this may be intentional.

In the mean time, if you are able to use Git 1.8.5, `git -C test-repo
stash` will work just fine.

=C3=98sse
