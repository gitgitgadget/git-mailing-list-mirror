From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v11 00/10] bisect terms
Date: Mon, 29 Jun 2015 17:40:25 +0200
Message-ID: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 29 17:41:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9bB5-00033O-7c
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 17:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbbF2Pkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 11:40:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46694 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782AbbF2Pku (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 11:40:50 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFeedV018083
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2015 17:40:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFeg76031660;
	Mon, 29 Jun 2015 17:40:42 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9bAo-0008DC-Ho; Mon, 29 Jun 2015 17:40:42 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.gd2bff5d
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 29 Jun 2015 17:40:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5TFeedV018083
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436197242.48028@QfulRh4kVKzW0OvxlXjzcw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272956>

Hi,

So, here's a reroll that tries to address the ongoing discussion.

The first patches are preparatory steps, which are IMHO good
regardless of the features. I kept the user-interface to chose terms
at the end, and tried to keep the UI patches as small as possible.

I have the feeling that "bisect: add the terms old/new" should be
dropped, but I have no strong opinion on that. If you like the
feature, say so. If you think the feature doesn't bring enough, and
should eventually be obsoleted by "guess which commit is old and which
is new", say so too.

The beginning of the series didn't change much since v10. The major
change is that I gave up using "git bisect terms <foo> <bar>", and
implemented the same feature in "git bisect start". We're losing the
ability to run "git bisect terms" several times to change the terms
before we use them, but I'm not sure this was a useful feature. OTOH,
we're back to the principle "git bisect start" starts from a fresh
state, this avoids confusing the situation where the user has leftover
from yesterday's "git bisect terms". And the code is much, much
simpler.

Antoine Delaite (4):
  bisect: correction of typo
  bisect: replace hardcoded "bad|good" by variables
  bisect: simplify the addition of new bisect terms
  bisect: add the terms old/new

Matthieu Moy (5):
  Documentation/bisect: move getting help section to the end
  bisect: don't mix option parsing and non-trivial code
  bisect: sanity check on terms
  bisect: add 'git bisect terms' to view the current terms
  bisect: allow setting any user-specified in 'git bisect start'

Michael Haggerty (1):
  Documentation/bisect: revise overall content

 Documentation/git-bisect.txt | 236 ++++++++++++++++++++++++++++-----------
 bisect.c                     |  94 ++++++++++++----
 git-bisect.sh                | 255 +++++++++++++++++++++++++++++++++++--------
 revision.c                   |  19 +++-
 t/t6030-bisect-porcelain.sh  | 137 ++++++++++++++++++++++-
 5 files changed, 612 insertions(+), 129 deletions(-)

-- 
2.5.0.rc0.10.gd2bff5d
