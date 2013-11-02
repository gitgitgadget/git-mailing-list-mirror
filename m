From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: Git 1.8.4.2: 'git-rev-parse --is-inside-git-dir' wrong output!
Date: Sat, 2 Nov 2013 10:24:36 +0000 (UTC)
Message-ID: <loom.20131102T110932-618@post.gmane.org>
References: <CACbqpSvU4qxc0WtquP6Eq8bZGjLxTrVhtT2Nqw90wb23ESkfcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 02 11:25:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcYOC-0007KD-B6
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 11:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851Ab3KBKY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Nov 2013 06:24:57 -0400
Received: from plane.gmane.org ([80.91.229.3]:59434 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830Ab3KBKY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Nov 2013 06:24:57 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VcYO0-0007Fi-2y
	for git@vger.kernel.org; Sat, 02 Nov 2013 11:24:56 +0100
Received: from 147.137.202.84.customer.cdi.no ([84.202.137.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Nov 2013 11:24:56 +0100
Received: from oystwa by 147.137.202.84.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Nov 2013 11:24:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.202.137.147 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237238>

Ville Walveranta <walveranta <at> gmail.com> writes:

>=20
> "git-rev-parse --is-inside-git-dir" outputs "fatal: Not a git
> repository (or any of the parent directories): .git", instead of
> "false" when outside of a git directory.  "--is-inside-work-tree"
> behaves the same way. Both commands work correctly (i.e. output
> "true") when inside a git directory, or inside a work tree,
> respectively.
>=20
> To test, I installed git 1.8.4.2 initially from
> https://launchpad.net/~git-core/+archive/ppa for Ubuntu 12.04.3, and
> then also compiled it from source, but both seem to behave the same
> way. The problem is not yet present in version 1.7.9.5.
>=20
> Thanks,
>=20
> Ville Walveranta
>

Hi,

I thought I'd try to bisect this but I ended up discovering that I get
the exact same behaviour with both 1.7.9.5 and 1.8.4.2. 1.7.9.5 will
also output 'fatal: ...' like 1.8.4.2 does.

Both version will however behave as expected if you provide --git-dir
and --work-tree:

    $ pwd
    /home/osse
    $ git --version
    git version 1.8.4.2
    $ git --git-dir=3D/home/osse/git/.git \
          --work-tree=3D/home/osse/git    \
        rev-parse  --is-inside-work-tree
    false

Ditto for --is-inside-git-dir.

Incidentally I discovered that the new -C option does *not* behave this
way:

$ git --version
git version 1.8.5.rc0.23.gaa27064
$ git -C /home/osse/git rev-parse --is-inside-work-tree
true

But given that the purpose of the -C option is to make Git behave as if
you were in that directory this is perhaps expected behaviour.

Regards,
=C3=98sse
