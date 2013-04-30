From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v2 0/8] History traversal refinements
Date: Tue, 30 Apr 2013 20:26:20 +0300
Message-ID: <1367342788-7795-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 19:35:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXESE-00055O-4X
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761237Ab3D3Rem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:34:42 -0400
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:45592 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761264Ab3D3Ref (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:34:35 -0400
Received: from mail414.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 85387FFA542
	for <git@vger.kernel.org>; Tue, 30 Apr 2013 19:26:43 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 30 Apr 2013 19:26:43 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 30 Apr 2013 19:26:41 +0200
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.1.632.gd2b1879
X-Ovh-Tracer-Id: 18361175681829867742
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.500013/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222960>

Okay, here's what I'll call v2 of this series. In the 3 parts from
before (4,6 & 7), I've addressed the comments from Junio and David,
corrected some errors, reconstructed the main commit message, and made
some adjustments in preparation for part 8.

New part 1 is just me making amends for writing NULL into decoration
and leaving cruft behind in part 4.

New part 2 expands the ancestry-path test - which is useful
because it's full of "-s ours" merges.

New part 3 has a little look at the TREESAME documentation bug -
maybe we should add Junio's little asterisk decorations.

Part 5 is Junio's test, in the correct place in the sequence. (Not
sure if it's valid to send that with git send-email - I'll find out).

And finally part 8 is a first attempt at the new UNINTERESTING/TREESAME
interaction logic. I'm pretty happy with the results it produces,
but it's an even more deep and scary change than the earlier
parts.

And we obviously need some more new tests - the effects of these changes
are almost non-existent on the pre-existing set. I'd like to beg for any
volunteers here - I'm not that proficient at shell scripting, and on
top of that something like this could really do with an independent
set of eyes checking that the claimed benefits actually match the
results. (And that the claims are understandable.)

Junio C Hamano (1):
  t6012: update test for tweaked full-history traversal

Kevin Bracey (7):
  decorate.c: compact table when growing
  t6019: test file dropped in -s ours merge
  rev-list-options.txt: correct TREESAME for P
  revision.c: Make --full-history consider more merges
  simplify-merges: never remove all TREESAME parents
  simplify-merges: drop merge from irrelevant side branch
  revision.c: discount UNINTERESTING parents

 Documentation/rev-list-options.txt |  38 ++--
 decorate.c                         |   2 +-
 revision.c                         | 453 +++++++++++++++++++++++++++++++++----
 revision.h                         |   1 +
 t/t6012-rev-list-simplify.sh       |  31 ++-
 t/t6019-rev-list-ancestry-path.sh  |  37 ++-
 6 files changed, 494 insertions(+), 68 deletions(-)

-- 
1.8.2.1.632.gd2b1879
