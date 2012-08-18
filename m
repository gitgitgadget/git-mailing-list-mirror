From: mhagger@alum.mit.edu
Subject: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest namespace change
Date: Sat, 18 Aug 2012 19:14:43 +0200
Message-ID: <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
References: <20120719213311.GA20385@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Muranov <alexey.muranov@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 18 19:22:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2mja-0007AD-C2
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 19:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143Ab2HRRWC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 13:22:02 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:61585 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750903Ab2HRRWA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Aug 2012 13:22:00 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Aug 2012 13:22:00 EDT
X-AuditID: 12074412-b7f216d0000008e3-c8-502fcd91ff51
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 75.0B.02275.19DCF205; Sat, 18 Aug 2012 13:14:57 -0400 (EDT)
Received: from michael.fritz.box (p57A25507.dip.t-dialin.net [87.162.85.7])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7IHEnrR001968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 18 Aug 2012 13:14:55 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <20120719213311.GA20385@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsUixO6iqDvxrH6AwbaTshYL+/qZLbqudDNZ
	NPReYbaYcL+B2eL2ivnMFj9aepgtVu5ayOTA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx9xPi1g9
	Pm+SC2CL4rZJSiwpC85Mz9O3S+DOWDv1KlPBZMmKVWeDGhi/CncxcnJICJhIbJp6jh3CFpO4
	cG89WxcjF4eQwGVGiW0vWlkhnNNMEk/3tTKDVLEJSEm8bOwB6xARkJX4fngjI0gRs8BEJold
	O+eAFQkLhElsPXAHrIhFQFViw7n1QJM4OHgFXCRmTdKA2KYo8eP7GrByTgFriZ/77zJOYORZ
	wMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXTC83s0QvNaV0EyMksIR2MK4/KXeIUYCDUYmH
	V2GNXoAQa2JZcWXuIUZJDiYlUd73Z/QDhPiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw6p4AKudN
	SaysSi3Kh0lJc7AoifP+XKzuJySQnliSmp2aWpBaBJOV4eBQkuDdATJUsCg1PbUiLTOnBCHN
	xMEJMpxLSqQ4NS8ltSixtCQjHhQB8cXAGABJ8QDtPQnSzltckJgLFIVoPcWoy3Hw69m7jEIs
	efl5qVLivAtBigRAijJK8+BWwNLIK0ZxoI+Fea+DVPEAUxDcpFdAS5iAlqwU0QVZUpKIkJJq
	YJxjH33/w+ckDrHQN9rTWSZIfJBaEX7oYJFEttv6YzeXBwpVBk08yrdRM5zl2KeAY3G7DM+v
	OPXH7uCvk3qfVE66Pli6/1mPicjMBNepMxRnXbOLvJB28/VC7+PVC048PtylLSdm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203678>

From: Michael Haggerty <mhagger@alum.mit.edu>

On 08/17/2012 01:29 AM, Junio C Hamano wrote:> Junio C Hamano <gitster@pobox.com> writes:
>> I like the general direction.  Perhaps a long distant future
>> direction could be to also use the same trick in the ref namespace
>> so that we can have 'next' branch itself, and 'next/foo', 'next/bar'
>> forks that are based on the 'next' branch at the same time (it
>> obviously is a totally unrelated topic)?
> 
> I notice that I was responsible for making this topic veer in the
> wrong direction by bringing up a new feature "having 'next' and
> 'next/bar' at the same time" which nobody asked.  Perhaps we can
> drop that for now to simplify the scope of the topic, to bring the
> log graveyard back on track?

Given that a flag day would anyway be required to add a d/f-tolerant
system, I could live with a separate "graveyard" namespace as
originally proposed by Jeff.

However, I still think that as long as we are making a jump, we could
try to land closer to the ultimate destination.  So here are some
patches that apply on top of Jeff's to show what I mean.  (Please also
note that I made some technical comments about Jeff's patches in an
earlier email.)

The first two patches fix a breakage that I see when I apply Jeff's
patches to master.

The third changes the implementation of refname_to_graveyard_reflog()
and graveyard_reflog_to_refname() and touches up some test cases.  It
changes the naming convention for dead references to

    "$GIT_DIR/logs/refs~d/heads~d/foo~d/bar~d/baz~f"

I.e., the dead reflogs are stored closer to the living.  It is not
obvious whether the "refs" part of the name should be munged to
"refs~d" as I have done, or left unmunged.  The argument in favor of
munging is that the algorithm is more uniform.  On the other hand,
extending the same scheme to loose references would produce filenames
like

    "$GIT_DIR/refs~d/heads~d/foo~d/bar~d/baz~f"

or maybe they should be nested inside of the refs directory like

    "$GIT_DIR/refs/refs~d/heads~d/foo~d/bar~d/baz~f"

(which would also give a better place to store top-level reference
names).

I structured the patches to apply on top of Jeff's for presentation
purposes, but if they are desired it would of course make more sense
to squash his and mine together in the obvious way.

I am a little bit worried that there are other test cases that use
"git prune" in the belief that it will remove all commits that were
referred to by deleted references.  The test suite runs cleanly for me
with these patches, but before they are integrated we should audit the
places where the test suite calls to "git prune" to make sure that
they are still testing what they think.

Michael Haggerty (3):
  t9300: format test in modern style prior to modifying it
  Delete reflogs for dead references to allow pruning
  Change naming convention for the reflog graveyard

 refs.c                               | 31 ++++++++++++++++++++++++-------
 t/t7701-repack-unpack-unreachable.sh |  4 ++--
 t/t9300-fast-import.sh               | 13 +++++++------
 3 files changed, 33 insertions(+), 15 deletions(-)

-- 
1.7.11.3
