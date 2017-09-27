Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB9D52047F
	for <e@80x24.org>; Wed, 27 Sep 2017 21:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbdI0V65 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 17:58:57 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:46978 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbdI0V64 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 17:58:56 -0400
Received: by mail-pf0-f170.google.com with SMTP id r68so7922189pfj.3
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TrL1vsBIYjnXuoRagagP1iuRIu65EYim98SJdJ2Iaz4=;
        b=qmAL7C/aDeVbs5MjTq5afmpvzVy6BuZ8FUjv0htAmPh6jUn7+qQPoLBxUvhwV0jUcz
         DCPXRvD55o6kLNqtGKAFZd/ddzRXK5GrWE2hYKHIVoLzOWDQ+ZaweJxe0COc8D5m9x+Y
         21L9IhEkUIdWJpKFe3cwlx891FPDvhMcTBS+91E5FkJWgQoYKUiwpSRX6/1ShHs6ZPY0
         Gztgx935kxetzEBWX2/nXMWuWG8h3xQVpWP6ntsKc6RK1L1OewTie61F7PXwinCh+5ST
         xWcnbfaSGGuiw+Izade4D8p01Wo4txlUdUYdawzh56zSg8sY1daUy3gx48WhxDMLVe/A
         +CbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TrL1vsBIYjnXuoRagagP1iuRIu65EYim98SJdJ2Iaz4=;
        b=doz3/nIQQzZiavonEzCn0dPM/PXRxXI/hiD0Z+Q52ioXaBc9m004/aexjdM+/t8Ywi
         L5XIGbftwJfjjze+SLGRn3NZ140lDvV2CbHeayjdahwOFUU9F5Vug7DVn7z2Au1ulA0t
         6TIFjQCLQg3MuS3FaZ2pBtMantvsJeoktc4hkyolNT+KlzZlGfJlhhTjdHwNldSIhKaQ
         QJogCsH3MdHnwYJXP84tXG+/LAifnhiWzz19tczeZCVuoBf4zFNqxcxLXAGwXwPpf8h7
         3WwcHktdpRdacHpnZadnW9wpVQuw9YZyVLY1SKNQ1XT15+szdTimyHs9FyWbL/G5hbfN
         xbwg==
X-Gm-Message-State: AHPjjUiUXJLwpyCXnDPrXOpmc8pC2c17HVZFRtcwf0zVFAEHKIRIxDel
        mwxZnk3Mm3zFj5PjU1qFyQMfFQ==
X-Google-Smtp-Source: AOwi7QDpK72qbf6wIn+rqznPuxDdDCRcZEwk7jELcE7Hs6ho9HTEK1YWF1ZeIeIXYhYODaXU5VuUPA==
X-Received: by 10.99.160.65 with SMTP id u1mr2433060pgn.227.1506549536088;
        Wed, 27 Sep 2017 14:58:56 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:45a1:47cd:f4ee:d772])
        by smtp.gmail.com with ESMTPSA id r3sm18961698pgf.48.2017.09.27.14.58.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 14:58:54 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        torvalds@linux-foundation.org
Subject: [PATCH] diff: correct newline in summary for renamed files
Date:   Wed, 27 Sep 2017 14:58:52 -0700
Message-Id: <20170927215852.20163-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <CAGZ79kbCgTNaunfneWHP3xkLeXwW72CZZWs7Sv8A7QL_UYE_HQ@mail.gmail.com>
References: <CAGZ79kbCgTNaunfneWHP3xkLeXwW72CZZWs7Sv8A7QL_UYE_HQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

In 146fdb0dfe (diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY,
2017-06-29), the conversion from direct printing to the symbol emission
dropped the new line character for renamed, copied and rewritten files.

Add the emission of a newline, add a test for this case.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Linus, I assumed your sign off for the original patch. Thanks for spotting.
 
 Adding the mode change to t4016 seems like the easiest way to test it.
 
 Thanks,
 Stefan
  
 diff.c                | 1 +
 t/t4016-diff-quote.sh | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/diff.c b/diff.c
index 3c6a3e0faa..653bb2e72e 100644
--- a/diff.c
+++ b/diff.c
@@ -5272,6 +5272,7 @@ static void show_mode_change(struct diff_options *opt, struct diff_filepair *p,
 			strbuf_addch(&sb, ' ');
 			quote_c_style(p->two->path, &sb, NULL, 0);
 		}
+		strbuf_addch(&sb, '\n');
 		emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
 				 sb.buf, sb.len, 0);
 		strbuf_release(&sb);
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index 9c48e5c2c9..514056dd10 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -30,6 +30,7 @@ test_expect_success setup '
 	git add . &&
 	git commit -m initial &&
 	git mv "$P0.0" "R$P0.0" &&
+	chmod a+x "R$P0.0" &&
 	git mv "$P0.1" "R$P1.0" &&
 	git mv "$P0.2" "R$P2.0" &&
 	git mv "$P0.3" "R$P3.0" &&
@@ -47,6 +48,7 @@ cat >expect <<\EOF
  rename pathname.2 => Rpathname with SP.0 (100%)
  rename "pathname\twith HT.2" => Rpathname with SP.1 (100%)
  rename pathname.0 => Rpathname.0 (100%)
+ mode change 100644 => 100755
  rename "pathname\twith HT.0" => Rpathname.1 (100%)
 EOF
 '
-- 
2.14.0.rc0.3.g6c2e499285

