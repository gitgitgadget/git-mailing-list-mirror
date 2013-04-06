From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Collective wisdom about repos on NFS accessed by concurrent clients (== corruption!?)
Date: Sat, 6 Apr 2013 10:11:33 +0200
Message-ID: <871uaorscq.fsf@linux-k42r.v.cablecom.net>
References: <515419D0.7030107@olwing.se> <515EC51C.9070206@olwing.se>
	<87li8xrt5f.fsf@linux-k42r.v.cablecom.net>
	<515EE38D.2000502@olwing.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Kenneth =?utf-8?Q?=C3=96lwing?= <kenneth@olwing.se>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:42:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWT3-0001b9-Ql
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820Ab3DFILj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Apr 2013 04:11:39 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:12184 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756156Ab3DFILf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Apr 2013 04:11:35 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 6 Apr
 2013 10:11:21 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (87.231.156.75) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Sat, 6 Apr 2013 10:11:32 +0200
In-Reply-To: <515EE38D.2000502@olwing.se> ("Kenneth \=\?utf-8\?Q\?\=C3\=96lwing\?\=
 \=\?utf-8\?Q\?\=22's\?\= message of "Fri,
	05 Apr 2013 16:45:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [87.231.156.75]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220225>

Kenneth =C3=96lwing <kenneth@olwing.se> writes:

> On 2013-04-05 15:42, Thomas Rast wrote:
>> Can you run the same tests under strace or similar, and gather the
>> relevant outputs? Otherwise it's probably very hard to say what is
>> going wrong. In particular we've had some reports on lustre that
>> boiled down to "impossible" returns from libc functions, not git
>> issues. It's hard to say without some evidence.=20
> Thomas, thanks for your reply.
>
> I'm assuming I should strace the git commands as they're issued? I'm
> already collecting regular stdout/err output in a log as I go. Is
> there any debugging things I can turn on to make the calls issue
> internal tracing of some sort?

I don't think there's any internal debugging that helps at this point.
Usually errors pointing to corruption are caused by a chain of syscalls
failing in some way, and the final error shows only the last one, so
strace() output is very interesting.

> The main issue I see is that I suspect it will generate so much data
> that it'll overflow my disk ;-).

Well, assuming you have some automated way of detecting when it fails,
you can just overwrite the same strace output file repeatedly; we're
only interested in the last one (or all the last ones if several gits
fail concurrently).

=46iddling with strace will unfortunately change the timings somewhat
(causing a bunch of extra context switches per syscall), but I hope tha=
t
you can still get it to reproduce.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
