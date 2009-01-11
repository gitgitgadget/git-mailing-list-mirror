From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 0/4] customizable --color-words
Date: Sun, 11 Jan 2009 11:27:10 +0100
Message-ID: <cover.1231669012.git.trast@student.ethz.ch>
References: <7vr63atykr.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 11:28:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLxYe-0002rW-HI
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 11:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbZAKK1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 05:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbZAKK1J
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 05:27:09 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:42017 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbZAKK1I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 05:27:08 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Jan 2009 11:27:04 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Jan 2009 11:27:04 +0100
X-Mailer: git-send-email 1.6.1.279.g41f0
In-Reply-To: <7vr63atykr.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 11 Jan 2009 10:27:04.0353 (UTC) FILETIME=[25A56910:01C973D7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105160>

Johannes Schindelin wrote:
> On Sat, 10 Jan 2009, Thomas Rast wrote:
> > Johannes Schindelin wrote:
> > > So I still find your patch way too large

The bad news is... it just got bigger ;-)

> In your case, I imagine it would be much easier to get reviewers if you 
> had
> 
> 	patch 1/4 refactor color-words to allow for 0-character word 
> 		boundaries
> 	patch 2/4 allow regular expressions to define what makes a word

So here's a 4-patch series.  I put the first split in a different
place than you suggested, however.  I couldn't see a good way to
separate empty boundaries from regex splitting in such a way that the
first half can be exercised (is not just dead code).  1/4 basically
just rearranges code a bit and should be a real no-op patch.

Junio C Hamano wrote:
>     diff.c: In function 'scan_word_boundaries':
>     diff.c:512: warning: enumeration value 'DIFF_WORD_UNDEF' not handled in sw

Thanks, added a case to test for this.

There is one other minor semantic change in 2/4: the error reporting
in case your regex matched "foo\nbar" now says "before 'bar'" instead
of "near '\nbar'".  Other than that, there are only a bunch of added
comments when comparing the result of all four patches with v2.


Thomas Rast (4):
  word diff: comments, preparations for regex customization
  word diff: customizable word splits
  word diff: make regex configurable via attributes
  word diff: test customizable word splits

 Documentation/diff-options.txt  |   18 +++-
 Documentation/gitattributes.txt |   21 +++
 diff.c                          |  282 ++++++++++++++++++++++++++++++++++++---
 diff.h                          |    1 +
 t/t4033-diff-color-words.sh     |   90 +++++++++++++
 userdiff.c                      |   27 +++-
 userdiff.h                      |    1 +
 7 files changed, 413 insertions(+), 27 deletions(-)
 create mode 100755 t/t4033-diff-color-words.sh
