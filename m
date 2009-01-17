From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 0/7] customizable --color-words
Date: Sat, 17 Jan 2009 17:29:41 +0100
Message-ID: <1232209788-10408-1-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 17:31:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOE4g-0007ql-Fr
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 17:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763378AbZAQQ3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 11:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763126AbZAQQ3l
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 11:29:41 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:41359 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489AbZAQQ3k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 11:29:40 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:39 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:38 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 17 Jan 2009 16:29:38.0972 (UTC) FILETIME=[CAE355C0:01C978C0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106079>

Johannes Schindelin wrote:
> Thomas, could you pick up the patches from my 'my-next' branch and 
> maintain an "official" topic branch?

I cherry-picked the three commits you had there, and rebuilt on top.
I pushed them to

  git://repo.or.cz/git/trast.git tr/word-diff-p2

again (js/word-diff-p1 again points directly at your half).

The changes on your side since my last push (hence your last sent
patches&squashes I collected) were only a pair of quotes changed from
double to single.

On my side I mainly tweaked the TeX pattern since I noticed it didn't
match many non-alnums such as (), and therefore declare them
unchanged:

-       "\\\\[a-zA-Z@]+|[][{}]|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
+       "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+|[^[:space:]]"),

I also added a clause to the C++ pattern to allow it to match
declarations such as

  int Foo::bar(...)

(it would give up on the :: before).


Johannes Schindelin (4):
  Add color_fwrite_lines(), a function coloring each line individually
  color-words: refactor word splitting and use ALLOC_GROW()
  color-words: change algorithm to allow for 0-character word
    boundaries
  color-words: take an optional regular expression describing words

Thomas Rast (3):
  color-words: enable REG_NEWLINE to help user
  color-words: expand docs with precise semantics
  color-words: make regex configurable via attributes

 Documentation/diff-options.txt  |   17 +++-
 Documentation/gitattributes.txt |   21 ++++
 color.c                         |   28 +++++
 color.h                         |    1 +
 diff.c                          |  222 ++++++++++++++++++++++++++-------------
 diff.h                          |    1 +
 t/t4034-diff-words.sh           |  159 ++++++++++++++++++++++++++++
 userdiff.c                      |   78 +++++++++++---
 userdiff.h                      |    1 +
 9 files changed, 440 insertions(+), 88 deletions(-)
 create mode 100755 t/t4034-diff-words.sh
