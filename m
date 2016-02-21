From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/2] Fix test failures with GNU grep 2.23
Date: Sun, 21 Feb 2016 17:32:20 +0000
Message-ID: <cover.1456075680.git.john@keeping.me.uk>
References: <20160219193310.GA1299@sigill.intra.peff.net>
Cc: John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 18:32:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXXsL-0004LY-H7
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbcBURct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 12:32:49 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:45454 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbcBURct (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 12:32:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E0328CDA56D;
	Sun, 21 Feb 2016 17:32:47 +0000 (GMT)
X-Quarantine-ID: <GknVFU2sI1Cs>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GknVFU2sI1Cs; Sun, 21 Feb 2016 17:32:47 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 8CC48CDA2D4;
	Sun, 21 Feb 2016 17:32:33 +0000 (GMT)
X-Mailer: git-send-email 2.7.1.503.g3cfa3ac
In-Reply-To: <20160219193310.GA1299@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286804>

On Fri, Feb 19, 2016 at 02:33:10PM -0500, Jeff King wrote:
> On Fri, Feb 19, 2016 at 07:23:11PM +0000, John Keeping wrote:
> 
> > I suspect that any grep that lacks "-a" also lacks binary file handling
> > that will break these tests.  I found a Solaris grep that doesn't
> > support "-a" and it treats these files as text.
> > 
> > From that perspective, it would be better to have a central place that
> > deals with figuring out how to get grep to work for us.  Perhaps we need
> > test_grep to get this right.  We already have test_cmp_bin() as a thin
> > wrapper around cmp so I don't think this is completely unprecedented.
> 
> I think 99% of the time we are using grep for ascii text. As evidenced
> by the number of test failures we see with the new grep, it is a small
> minority that feed binary gibberish. I'd prefer if "-a" handling didn't
> need to pollute anything outside of this narrow range of tests (and as
> with my prereq suggestion, I am even find just skipping this narrow
> range of tests on platforms with no "-a", though falling back to running
> without "-a" is fine if it works).

I went with using sed in this series because it seems to be the simplest
and most compatible way to extract lines from the input.  We don't need
any special casing to figure out if an implementation needs "-a" or if
it doesn't support that option and all the implementation I tested
support the constructs used here.

John Keeping (2):
  t8005: avoid grep on non-ASCII data
  t9200: avoid grep on non-ASCII data

 t/t8005-blame-i18n.sh          | 16 ++++++++--------
 t/t9200-git-cvsexportcommit.sh |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.7.1.503.g3cfa3ac
