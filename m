From: Jeff King <peff@peff.net>
Subject: [PATCH] t7004: test that "git-tag -u" implies "-s"
Date: Mon, 10 Dec 2007 23:24:36 -0500
Message-ID: <20071211042436.GA23805@coredump.intra.peff.net>
References: <alpine.LFD.0.9999.0712101950110.28293@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Carlos Rica <jasampler@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 05:25:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1wg1-0001ql-JS
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 05:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbXLKEYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 23:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbXLKEYk
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 23:24:40 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1816 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbXLKEYj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 23:24:39 -0500
Received: (qmail 5331 invoked by uid 111); 11 Dec 2007 04:24:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 10 Dec 2007 23:24:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Dec 2007 23:24:36 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712101950110.28293@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67785>

This was lost in the C conversion, but recently fixed by
Linus.

Signed-off-by: Jeff King <peff@peff.net>
---
On Mon, Dec 10, 2007 at 08:08:06PM -0800, Linus Torvalds wrote:

> It used to be that passing the signing ID with the -u parameter also 
> (obviously!) implied that you wanted to sign and annotate the tag, but 
> that logic got dropped. It also totally ignored the actual key ID that was 
> passed in.
> [...]
> This has gotten only very minimal testing. Somebody should double-check it 
> all, and adding a test would probably be great too.

Looks good to me, and here's a test. It was trivial to whip up, since I
wrote a test for almost the identical bug a few days ago (that one was
"-s implies -a").

 t/t7004-tag.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index c7130c4..5393d35 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -682,6 +682,14 @@ test_expect_success '-s implies annotated tag' '
 	get_tag_msg implied-annotate >actual &&
 	git diff expect actual
 '
+get_tag_header implied-sign $commit commit $time >expect
+./fakeeditor >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success '-u implies signed tag' '
+	GIT_EDITOR=./fakeeditor git-tag -u CDDE430D implied-sign &&
+	get_tag_msg implied-sign >actual &&
+	git diff expect actual
+'
 
 test_expect_success \
 	'trying to create a signed tag with non-existing -F file should fail' '
-- 
1.5.3.7.2229.gd040e-dirty
