From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/2] blame: large-scale performance rewrite
Date: Sat, 26 Apr 2014 19:30:06 +0200
Message-ID: <874n1g80dd.fsf@fencepost.gnu.org>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
	<CAJo=hJukmej1rJXuVoECwd7AxmSue8Wmv4rBmCHEYcWBWNarSw@mail.gmail.com>
	<87wqec8rb5.fsf@fencepost.gnu.org>
	<CAJo=hJs=ap=Ct_PzOsO=vHmDVMvUF+nvbB7b67bgnmug+Yrohg@mail.gmail.com>
	<87d2g481nb.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:30:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We6Qg-0007Ur-7k
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 19:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbaDZRaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Apr 2014 13:30:14 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:46244 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbaDZRaH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2014 13:30:07 -0400
Received: from localhost ([127.0.0.1]:45286 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1We6QQ-0007mb-Ua; Sat, 26 Apr 2014 13:30:07 -0400
Received: by lola (Postfix, from userid 1000)
	id 7B9B1E05FE; Sat, 26 Apr 2014 19:30:06 +0200 (CEST)
In-Reply-To: <87d2g481nb.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Sat, 26 Apr 2014 19:02:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247166>

David Kastrup <dak@gnu.org> writes:

> http://repo.or.cz/r/wortliste.git
> git blame [-M / -C] wortliste
>
> The latter one is _really_ taking a severe hit from the O(n^2)
> algorithms.  If your benchmarks for that one still point mostly to th=
e
> unpacking, your jgit blame should be fine regarding the stuff
> I=A0reimplemented.

Here's some example:

dak@lola:/usr/local/tmp/wortliste$ time git blame -n -s wortliste >/tmp=
/wl1

real	15m47.118s
user	14m39.928s
sys	1m1.872s
dak@lola:/usr/local/tmp/wortliste$ time ../git/git blame -n -s wortlist=
e >/tmp/wl2

real	3m40.947s
user	2m40.296s
sys	0m59.440s

Note how the system time is almost the same.  I have some patches which
make quite a bit of difference with that (at best, saving about half of
the system time), but I have not yet found the silver bullet where I'd
be reasonably sure that temporary memory use with non-linear history
stays strictly in nice bounds.

--=20
David Kastrup
