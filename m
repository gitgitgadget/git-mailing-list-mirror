From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 0/4] Fix how for-each-ref handles broken loose references
Date: Wed,  3 Jun 2015 15:51:55 +0200
Message-ID: <cover.1433339279.git.mhagger@alum.mit.edu>
Cc: Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 15:52:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z095f-0005gd-BR
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 15:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199AbbFCNwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 09:52:15 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63180 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753872AbbFCNwJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 09:52:09 -0400
X-AuditID: 1207440d-f79026d000000bad-f1-556f0684390f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id CD.F3.02989.4860F655; Wed,  3 Jun 2015 09:52:04 -0400 (EDT)
Received: from michael.fritz.box (p4FC96DFC.dip0.t-ipconnect.de [79.201.109.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t53Dq150005566
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 3 Jun 2015 09:52:03 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsUixO6iqNvClh9q8GeqhMWZvnCLrivdTBYN
	vVeYLW6vmM9s8aOlh9li8+Z2Fgc2j7/vPzB5LNhU6tF05iizx7PePYweFy8pe3zeJBfAFsVt
	k5RYUhacmZ6nb5fAndGz+wJbwX2Oiq5pW5gaGCexdzFyckgImEhM2dvACGGLSVy4t56ti5GL
	Q0jgMqPEpPcrmEASQgInmCT6l8uC2GwCuhKLeprB4iICahIT2w6xgNjMApsZJTofBnUxcnAI
	C/hInPiaBRJmEVCV+PLxIStImFfAXOLUSWGIVXIS54//ZJ7AyL2AkWEVo1xiTmmubm5iZk5x
	arJucXJiXl5qka6RXm5miV5qSukmRki48O5g/L9O5hCjAAejEg+vQ1heqBBrYllxZe4hRkkO
	JiVR3jVfgEJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeF++A8rxpiRWVqUW5cOkpDlYlMR51Zao
	+wkJpCeWpGanphakFsFkZTg4lCR4W1nzQ4UEi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJL
	SzLiQUEeXwwMc5AUD9DeOJB23uKCxFygKETrKUZFKXHeGSAJAZBERmke3FhYEnjFKA70pTDv
	EpAqHmACget+BTSYCWhwu0AOyOCSRISUVANjoknoDz/nDX/VFc5nqmnuMF27d1JQTKVgzE+/
	PetOXe0tcGYVuzMvYJrSbpHW6QrLL2lnuHYsEtzebfhoRUZx21S99k+zfvZM1ykQ/PBO+QzD
	Z0/fOTIJD55M8tiWP2Wds0FThaPZ+Q98uW8WP1g6peu+cpZB0V/t4HMbp35q0zhh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270685>

This reroll addresses all of the comments about v1 [1] and v2 [2].
Thanks to Stefan, Junio, and Peff for their comments about v2.

Changes since v2:

* Simplify logic flow in read_loose_refs().
* Remove unnecessary call to hashclr() in read_loose_refs().
* Improve a comment and commit message.

This patch series is also available from my GitHub account [3] as
branch for-each-ref-errors.

[1] http://thread.gmane.org/gmane.comp.version-control.git/270429
[2] http://thread.gmane.org/gmane.comp.version-control.git/270556
[3] https://github.com/mhagger/git

Michael Haggerty (4):
  t6301: new tests of for-each-ref error handling
  for-each-ref: report broken references correctly
  read_loose_refs(): simplify function logic
  read_loose_refs(): treat NULL_SHA1 loose references as broken

 builtin/for-each-ref.c         |  5 ++++
 refs.c                         | 29 ++++++++++++++++------
 t/t6301-for-each-ref-errors.sh | 56 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 7 deletions(-)
 create mode 100755 t/t6301-for-each-ref-errors.sh

-- 
2.1.4
