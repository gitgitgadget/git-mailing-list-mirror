Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15A851FC44
	for <e@80x24.org>; Tue,  9 May 2017 02:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbdEIC7u (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 22:59:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:47810 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdEIC7t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 22:59:49 -0400
Received: (qmail 11893 invoked by uid 109); 9 May 2017 02:59:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 02:59:49 +0000
Received: (qmail 19099 invoked by uid 111); 9 May 2017 03:00:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 23:00:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 22:59:46 -0400
Date:   Mon, 8 May 2017 22:59:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-objects: disable pack reuse for object-selection
 options
Message-ID: <20170509025946.7lozhjwblra7i6sp@sigill.intra.peff.net>
References: <20170502084326.65eisqmr4th5cbf7@sigill.intra.peff.net>
 <xmqq4lww9cas.fsf@gitster.mtv.corp.google.com>
 <20170508073143.lu73w5b54lvstty2@sigill.intra.peff.net>
 <xmqqd1bi7ta5.fsf@gitster.mtv.corp.google.com>
 <20170509020010.meefcustv7uufard@sigill.intra.peff.net>
 <xmqqfuge6akl.fsf@gitster.mtv.corp.google.com>
 <20170509022114.s3tpxrgtplsopr4x@sigill.intra.peff.net>
 <xmqq4lwu68zy.fsf@gitster.mtv.corp.google.com>
 <20170509025412.6fkrlnbsdk6qmoia@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170509025412.6fkrlnbsdk6qmoia@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 10:54:12PM -0400, Jeff King wrote:

> Contents are the same. I decided to leave the "; do" as it
> matches the rest of the script. If we're going to fix it, we
> should do them all.

Like this, perhaps.

I didn't go on a crusade against "; do" in the other scripts, but
perhaps that is low-hanging fruit that somebody else might want to pick.

-- >8 --
Subject: [PATCH] t5310: fix "; do" style

Our usual shell style is to put the "do" of a loop on its
own line, like:

  while $cond
  do
          something
  done

instead of:

  while $cond; do
          something
  done

We have a bit of both in our code base, but the former is
what's in CodingGuidelines (and outnumbers the latter in t/
by about 6:1).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5310-pack-bitmaps.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index c3ddfa217..20e2473a0 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -20,11 +20,13 @@ has_any () {
 }
 
 test_expect_success 'setup repo with moderate-sized history' '
-	for i in $(test_seq 1 10); do
+	for i in $(test_seq 1 10)
+	do
 		test_commit $i
 	done &&
 	git checkout -b other HEAD~5 &&
-	for i in $(test_seq 1 10); do
+	for i in $(test_seq 1 10)
+	do
 		test_commit side-$i
 	done &&
 	git checkout master &&
@@ -104,7 +106,8 @@ test_expect_success 'clone from bitmapped repository' '
 '
 
 test_expect_success 'setup further non-bitmapped commits' '
-	for i in $(test_seq 1 10); do
+	for i in $(test_seq 1 10)
+	do
 		test_commit further-$i
 	done
 '
@@ -300,7 +303,8 @@ test_expect_success 'set up reusable pack' '
 
 test_expect_success 'pack reuse respects --honor-pack-keep' '
 	test_when_finished "rm -f .git/objects/pack/*.keep" &&
-	for i in .git/objects/pack/*.pack; do
+	for i in .git/objects/pack/*.pack
+	do
 		>${i%.pack}.keep
 	done &&
 	reusable_pack --honor-pack-keep >empty.pack &&
-- 
2.13.0.rc2.436.g524cea07c

