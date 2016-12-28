Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7F4200E0
	for <e@80x24.org>; Wed, 28 Dec 2016 00:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbcL1AGR (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 19:06:17 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33118 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbcL1AGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 19:06:16 -0500
Received: by mail-pg0-f46.google.com with SMTP id g1so110264860pgn.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 16:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EXuhE4+LicXeuGsatblRlyQ1PPzKvbu2Nqv/q1fTJ0o=;
        b=l1kJ59DPWSfe9G7uFHk3hT0xuxieSpyZ0kZe/jOEgQaCh0uRvTOBi4XaTNc62jIl0O
         dEavlg9q+iNxG6izH6NDdinmC8moxLf6Z/BDKmzptiWJjPhSoniClzvb205BbbZo1GyW
         a695jw4MZeq0gE1CAb0i6gKASTESzrSKfx6LmMJScCKQMBtmfS0ZdO+PuUN92oMgsYSD
         aqRxJGc+hB/IrevWCNLoO+N5rNGCMhcdLqyyw41uN/5MuKSq+zmIj0A1R5Mf/gKS1v+N
         FvQ64J2uReLr0fhUYtyv685IQHvRJxS2MtOUdvlA8emGy4sev9KAlTPZG2jCPT/VK+DQ
         G65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EXuhE4+LicXeuGsatblRlyQ1PPzKvbu2Nqv/q1fTJ0o=;
        b=Uh+JLR0yPkX0cU+1Xyhrz3FfkITUhxS+76SHbrRt0aax0yhkjvQPxnbEZ2SDaCC3Xl
         lqCYiDDxQVVB/X84qZjb7Y2bvIwP5fhsxQYVIt6FzYqV0mEmFgfvV12+xIA4C03915M5
         2AxNHoq6pKTXjo1pRQ/crYu1OlJWy/Zc/HJGD0tumbdd3vkWAD4nb5hoU+6metuKoM4L
         +7pjXLxlAz6fg0OYYsFIEnRiOiRxrFkGxsPqtErLrU90SO+/z2D030vF+pq8LCohWESx
         VD+6JEx9hhvMnlHOy0xdRiCUYKILmxxXFC2oMk9ie/65IeSg+t5vhFfUDW2coGmScfb5
         B/nA==
X-Gm-Message-State: AIkVDXJvtjmxcu1LlO5ZgeeKXgwN5Scyz4OHAGltFhvZ2lsq6B2Ci99Dl6FJdT7WtoTuSM+h
X-Received: by 10.84.212.144 with SMTP id e16mr71831035pli.140.1482883567315;
        Tue, 27 Dec 2016 16:06:07 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1aa:810:98b9:be05])
        by smtp.gmail.com with ESMTPSA id x4sm92720351pgc.14.2016.12.27.16.06.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Dec 2016 16:06:06 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] pathspec: give better message for submodule related pathspec error
Date:   Tue, 27 Dec 2016 16:05:59 -0800
Message-Id: <20161228000559.17842-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.196.gee862f456e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Every once in a while someone complains to the mailing list to have
run into this weird assertion[1].

The usual response from the mailing list is link to old discussions[2],
and acknowledging the problem stating it is known.

For now just improve the user visible error message.

[1] https://www.google.com/search?q=item-%3Enowildcard_len
[2] http://git.661346.n2.nabble.com/assert-failed-in-submodule-edge-case-td7628687.html
    https://www.spinics.net/lists/git/msg249473.html

Signed-off-by: Stefan Beller <sbeller@google.com>
---

If you were following the mailing list closely today, you may sense
that I am cleaning up stalled branches. :)

I think such a hot fix is warranted given how often we had reports
on the mailing list.

Thanks,
Stefan

 pathspec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 22ca74a126..d522f43331 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -313,8 +313,11 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	}
 
 	/* sanity checks, pathspec matchers assume these are sane */
-	assert(item->nowildcard_len <= item->len &&
-	       item->prefix         <= item->len);
+	if (item->nowildcard_len <= item->len &&
+	    item->prefix         <= item->len)
+		die (_("Path leads inside submodule '%s', but the submodule "
+		       "was not recognized, i.e. not initialized or deleted"),
+		       ce->name);
 	return magic;
 }
 
-- 
2.11.0.196.gee862f456e.dirty

