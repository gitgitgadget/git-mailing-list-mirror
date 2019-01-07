Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0150C1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 08:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfAGIj1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 03:39:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:56406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726448AbfAGIj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 03:39:26 -0500
Received: (qmail 1774 invoked by uid 109); 7 Jan 2019 08:39:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Jan 2019 08:39:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 838 invoked by uid 111); 7 Jan 2019 08:39:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 Jan 2019 03:39:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2019 03:39:24 -0500
Date:   Mon, 7 Jan 2019 03:39:24 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 09/11] sha1-file: prefer "loose object file" to "sha1 file"
 in messages
Message-ID: <20190107083924.GI29431@sigill.intra.peff.net>
References: <20190107083150.GC21362@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107083150.GC21362@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're reporting an error for a loose object, let's use that term.
It's more consistent with other parts of Git, and it is future-proof
against changes to the hash function.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1-file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index da6d78976f..07cc9b548b 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1552,9 +1552,9 @@ int hash_object_file(const void *buf, unsigned long len, const char *type,
 static void close_loose_object(int fd)
 {
 	if (fsync_object_files)
-		fsync_or_die(fd, "sha1 file");
+		fsync_or_die(fd, "loose object file");
 	if (close(fd) != 0)
-		die_errno(_("error when closing sha1 file"));
+		die_errno(_("error when closing loose object file"));
 }
 
 /* Size of directory component, including the ending '/' */
@@ -1645,7 +1645,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		ret = git_deflate(&stream, Z_FINISH);
 		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
 		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
-			die(_("unable to write sha1 file"));
+			die(_("unable to write loose object file"));
 		stream.next_out = compressed;
 		stream.avail_out = sizeof(compressed);
 	} while (ret == Z_OK);
-- 
2.20.1.470.g640a3e2614

