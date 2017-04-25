Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C91D1FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 19:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1951433AbdDYTHH (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 15:07:07 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38156 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942092AbdDYTHF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 15:07:05 -0400
Received: by mail-it0-f44.google.com with SMTP id f187so20075758ite.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JJItMGiK9u/E/l4YLQLDIl/GRVy3KND1KJ7HcEUFNlw=;
        b=YloX7EkLRHwuTfODD6QWyXVcj2V8pwTXHo+VadbLJZ9ncMYNI/MiYYs1wyMJ1E8yvs
         dvICtLj7XdWVhrmYxHtl7cENoRKVamK8XsxJdj5qy/uDt32dDyY9Im2K0BbkWFUrdpKO
         PTq0vo9kfZ84xDRdEPSGvZm8pQF7ImLPmZxit2f9yxQE3Wjhe+0b4dPY0I0Gzwz4c4eL
         mlrCb7aNP4yDw+R/8smm3FCw4yNUHBn6b19/6wcfD+rqjrMw9edPHSR4K7ogppvmOITu
         jF9KV99c1JIlqPmixx2FUI4DLtt7GbntFwL2ToBkhI5pvBj8O+jx0zGb8FIFbnlqmWSH
         ilTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JJItMGiK9u/E/l4YLQLDIl/GRVy3KND1KJ7HcEUFNlw=;
        b=rQJUPpv+crdH7tTnozW9cqMi4HrfXL8nPkv2d0umPOubLmX5ZpFjaxPriKFOh7sK/O
         Ap1XKBgGerBCdN0MD9bRUoH0Q4LvR5c0yXAorMzg0mBj6M65e44p7vpKPFhd8+ovFkgQ
         CgYT74vXYz78SecxPrL3igLL2QvJd4B2zEY1YCwG7HmbRz10lDs4gqoqHs28653YQQ0z
         2UbPcr7sfbJSZN6mZjnk6mm07sRPKJvRYMa4MNbg13Zq+OX6etxN+FIFIOhOk37bqq1X
         e52TjOoSbfg1nJeC2WQL3MGyFMQAHI0DSE03pUiF8uAJ0hQ6/0vGDX8YJfU0yl2lI1zt
         Wx/A==
X-Gm-Message-State: AN3rC/6epHHK2XQX5UrGgvkcwooIjqqqIbqEwTYVKjX1eHDmXOkhMH62
        H0Z7HF/hAiQt60FC
X-Received: by 10.36.125.8 with SMTP id b8mr2380143itc.31.1493147224811;
        Tue, 25 Apr 2017 12:07:04 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id g69sm2194803itg.17.2017.04.25.12.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 12:07:03 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org, computersforpeace@gmail.com
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] sequencer: require trailing NL in footers
Date:   Tue, 25 Apr 2017 12:06:51 -0700
Message-Id: <20170425190651.8910-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
In-Reply-To: <20170421220155.GA142345@google.com>
References: <20170421220155.GA142345@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 967dfd4 ("sequencer: use trailer's trailer layout",
2016-11-29), sequencer was taught to use the same mechanism as
interpret-trailers to determine the nature of the trailer of a commit
message (referred to as the "footer" in sequencer.c). However, the
requirement that a footer end in a newline character was inadvertently
removed. Restore that requirement.

While writing this commit, I noticed that if the "ignore_footer"
parameter in "has_conforming_footer" is greater than the distance
between the trailer start and sb->len, "has_conforming_footer" will
return an unexpected result. This does not occur in practice, because
"ignore_footer" is either zero or the return value of an invocation to
"ignore_non_trailer", which only skips empty lines and comment lines.
This commit contains a comment explaining this in the function's
documentation.

Reported-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

Thanks for the bug report. Here's a fix - I've verified this with the
way to reproduce provided in the original e-mail, and it seems to work
now.

The commit message of the referenced commit
(7b309aef0463340d3ad5449d1f605d14e10a4225) does not end in a newline,
which is probably why different behavior was observed with this commit
(as compared to others).

 sequencer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 77afecaeb..4cbe64b7f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -151,6 +151,12 @@ static const char *get_todo_path(const struct replay_opts *opts)
  * Returns 1 for conforming footer
  * Returns 2 when sob exists within conforming footer
  * Returns 3 when sob exists within conforming footer as last entry
+ *
+ * A footer that does not end in a newline is considered non-conforming.
+ *
+ * ignore_footer, if not zero, should be the return value of an invocation to
+ * ignore_non_trailer. See the documentation of that function for more
+ * information.
  */
 static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	int ignore_footer)
@@ -159,6 +165,11 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	int i;
 	int found_sob = 0, found_sob_last = 0;
 
+	if (sb->len <= ignore_footer)
+		return 0;
+	if (sb->buf[sb->len - ignore_footer - 1] != '\n')
+		return 0;
+
 	trailer_info_get(&info, sb->buf);
 
 	if (info.trailer_start == info.trailer_end)
-- 
2.13.0.rc0.306.g87b477812d-goog

