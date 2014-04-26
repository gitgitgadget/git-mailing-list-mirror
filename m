From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/2] blame: large-scale performance rewrite
Date: Sat, 26 Apr 2014 19:02:32 +0200
Message-ID: <87d2g481nb.fsf@fencepost.gnu.org>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
	<CAJo=hJukmej1rJXuVoECwd7AxmSue8Wmv4rBmCHEYcWBWNarSw@mail.gmail.com>
	<87wqec8rb5.fsf@fencepost.gnu.org>
	<CAJo=hJs=ap=Ct_PzOsO=vHmDVMvUF+nvbB7b67bgnmug+Yrohg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:02:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We5zs-0007nE-0Y
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 19:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbaDZRCe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Apr 2014 13:02:34 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:45245 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbaDZRCe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2014 13:02:34 -0400
Received: from localhost ([127.0.0.1]:44287 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1We5zl-0000J5-Dq; Sat, 26 Apr 2014 13:02:33 -0400
Received: by lola (Postfix, from userid 1000)
	id DB182E05FE; Sat, 26 Apr 2014 19:02:32 +0200 (CEST)
In-Reply-To: <CAJo=hJs=ap=Ct_PzOsO=vHmDVMvUF+nvbB7b67bgnmug+Yrohg@mail.gmail.com>
	(Shawn Pearce's message of "Sat, 26 Apr 2014 09:01:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247160>

Shawn Pearce <spearce@spearce.org> writes:

> Thanks for doing this. Unfortunately I can't read the patch itself as
> I am also trying to improve JGit's blame code for $DAY_JOB, and JGit
> is BSD licensed.

Actually, I'd have suggested asking $EMPLOYER to buy the rights for
looking at the code, but as I wrote previously, I'd seriously doubt tha=
t
he'd get his money's worth for use in a _Java_ implementation.

The C code I proposed is good for files with many small changes: I'd
suggest benchmarking your JGit code with some of them.  If the JGit is
still dominated by unpacking, your implementation should be fine.  The
current C version instead thrashes around digging through its own
all-purpose single linear list.

Here are two real-world test cases:

git://git.savannah.gnu.org/emacs.git
git blame [-M / -C] src/xdisp.c

http://repo.or.cz/r/wortliste.git
git blame [-M / -C] wortliste

The latter one is _really_ taking a severe hit from the O(n^2)
algorithms.  If your benchmarks for that one still point mostly to the
unpacking, your jgit blame should be fine regarding the stuff
I=A0reimplemented.

--=20
David Kastrup
