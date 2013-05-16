From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v4 00/15] History traversal refinements
Date: Thu, 16 May 2013 18:32:26 +0300
Message-ID: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 17:40:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0Ho-00012I-Dy
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 17:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab3EPPjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 11:39:55 -0400
Received: from mo4.mail-out.ovh.net ([178.32.228.4]:33675 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab3EPPjk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 11:39:40 -0400
Received: from mail92.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id CD4D010540DC
	for <git@vger.kernel.org>; Thu, 16 May 2013 17:33:01 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 May 2013 17:33:01 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 16 May 2013 17:32:59 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
X-Ovh-Tracer-Id: 18170617123044167902
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -58
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -58
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224584>

No new functionality or bug fixes since v3, just tidying:

* Tests now use Junio's parent-checking functionality
* BOTTOM flags now set in a neater fashion (I think),
  separating it out from the cmdline stuff.
* Creation and use of BOTTOM flag now split into 4 separate
  commits - last version was too much for one commit, I feel.
* Finally decided that "relevant" is the word I was looking
  for. Obvious, really.
* On the subject of words, remove the only technical use
  of "uninteresting" that I found in the Documentation - I know
  that it always confused me until I read the source.

This sequence is based on my 2-commit ancestry-path "..." series,
but no longer depends on it due to the new way the BOTTOM flag
is initialised. But they both touch the t6019 test, so
applying this on top will avoid conflicts.

Junio C Hamano (2):
  t6111: allow checking the parents as well
  t6012: update test for tweaked full-history traversal

Kevin Bracey (13):
  decorate.c: compact table when growing
  t6019: test file dropped in -s ours merge
  t6111: new TREESAME test set
  t6111: add parents to tests
  rev-list-options.txt: correct TREESAME for P
  Documentation: avoid "uninteresting"
  revision.c: Make --full-history consider more merges
  simplify-merges: never remove all TREESAME parents
  simplify-merges: drop merge from irrelevant side branch
  revision.c: add BOTTOM flag for commits
  revision.c: discount side branches when computing TREESAME
  revision.c: don't show all merges for --parents
  revision.c: make default history consider bottom commits

 Documentation/rev-list-options.txt |  42 +--
 decorate.c                         |   2 +-
 revision.c                         | 539 ++++++++++++++++++++++++++++++++-----
 revision.h                         |   4 +-
 t/t6012-rev-list-simplify.sh       |  31 ++-
 t/t6019-rev-list-ancestry-path.sh  |  27 ++
 t/t6111-rev-list-treesame.sh       | 196 ++++++++++++++
 7 files changed, 750 insertions(+), 91 deletions(-)
 create mode 100755 t/t6111-rev-list-treesame.sh

-- 
1.8.3.rc0.28.g4b02ef5
