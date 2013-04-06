From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Collective wisdom about repos on NFS accessed by concurrent clients (== corruption!?)
Date: Sat, 6 Apr 2013 07:49:20 -0400
Organization: PD Inc
Message-ID: <CB4C1FB3EB914D079EE0534228DE372D@black>
References: <515419D0.7030107@olwing.se> <515EC51C.9070206@olwing.se><87li8xrt5f.fsf@linux-k42r.v.cablecom.net><515EE38D.2000502@olwing.se> <871uaorscq.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "'Git List'" <git@vger.kernel.org>
To: "'Thomas Rast'" <trast@inf.ethz.ch>,
	"=?iso-8859-1?Q?'Kenneth_=D6lwing'?=" <kenneth@olwing.se>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:52:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWV6-0001b9-RF
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422848Ab3DFNC3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Apr 2013 09:02:29 -0400
Received: from projects.pdinc.us ([67.90.184.26]:55505 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422819Ab3DFNC3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Apr 2013 09:02:29 -0400
X-Greylist: delayed 4376 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Apr 2013 09:02:28 EDT
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id r36Bmve3011591;
	Sat, 6 Apr 2013 07:48:57 -0400
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <871uaorscq.fsf@linux-k42r.v.cablecom.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Thread-Index: Ac4ynl0wNacOIUexRneGsTYPIszeGgAHhbdA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220240>

> -----Original Message-----
> From: Thomas Rast
> Sent: Saturday, April 06, 2013 4:12
>=20
> Kenneth =D6lwing <kenneth@olwing.se> writes:
>=20
> > On 2013-04-05 15:42, Thomas Rast wrote:
> >> Can you run the same tests under strace or similar, and gather the=
=20
> >> relevant outputs? Otherwise it's probably very hard to say what is=
=20
> >> going wrong. In particular we've had some reports on lustre that=20
> >> boiled down to "impossible" returns from libc functions, not git=20
> >> issues. It's hard to say without some evidence.
> > Thomas, thanks for your reply.
> >
> > I'm assuming I should strace the git commands as they're=20
> issued? I'm=20
> > already collecting regular stdout/err output in a log as I go. Is=20
> > there any debugging things I can turn on to make the calls issue=20
> > internal tracing of some sort?
>=20
> I don't think there's any internal debugging that helps at this point=
=2E
> Usually errors pointing to corruption are caused by a chain=20
> of syscalls failing in some way, and the final error shows=20
> only the last one, so
> strace() output is very interesting.
>=20
> > The main issue I see is that I suspect it will generate so=20
> much data=20
> > that it'll overflow my disk ;-).
>=20
> Well, assuming you have some automated way of detecting when=20
> it fails, you can just overwrite the same strace output file=20
> repeatedly; we're only interested in the last one (or all the=20
> last ones if several gits fail concurrently).

We use tmpwatch for this type of issue, especially with oracle traces. =
Set up a
directory and tell tmpwatch to delete files older than X. This will kee=
p the
files at bay and when you detect a problem stop  the clean up script.

>=20
> Fiddling with strace will unfortunately change the timings=20
> somewhat (causing a bunch of extra context switches per=20
> syscall), but I hope that you can still get it to reproduce.



--
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
This message is copyright PD Inc, subject to license 20080407P00.

=20
