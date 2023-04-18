Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA75C77B78
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 19:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjDRTUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjDRTUB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 15:20:01 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6213D1FC3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:19:36 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v9so9653989ybm.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681845528; x=1684437528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cEz+IGEOZrlMZAJLqUNyPK7jLzwh9XjxUPuK8lSgZng=;
        b=dgAd320Vm2WSnWH1b0zcTdCX+PF+AVeeXgRt2uaMbynHjQRJjAJuYWQnvN9Szv5AOJ
         41NnAv7GQdgghBpXXxAhAGtEFkKcLrPsP58+NOqliK15j1SIbtNS+4gLLTGPv3K6wKky
         722tNgcyl01YA8Nx2Xo+1E5sVfLMyMfpJxnh4Y9UdRzrNU1doKPmbVqCTbxEOyo3SVAO
         nqolBQ6bmZR3DVXsdiIY+kBim46HVtXZ5IoUoI0PlkAZo+kWAgqXXYYkfl7+c7gD8CjS
         P5sahixRH2zt59B6GHD/nyeKASoKNAiL7jbe4H13V0bbThTLETP4lQU7Jyrme9t/6pfJ
         fUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845528; x=1684437528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEz+IGEOZrlMZAJLqUNyPK7jLzwh9XjxUPuK8lSgZng=;
        b=ItXuyQ/BKjcgSBw0biZlU8YFN8I/YGzMq3aP+g8bUjWs4KPPL/sbWBRbnjxmW0ydAb
         MIO54oriAQa2O+fHIqQZOWHjNUov/L6VO+Dnma5wxGbt4Wu6IOge+N6jxbIWKlMuC6I9
         s4Nwy+2z8r0DCx8S2jVjE69DHXsloxbPPaelkkUIge+7j1i0sfVg8B6uFSQxsXLrU5hS
         6ZvR2zJCcwzo3FGEQdJ6hJX5qNHFC/sOOu6Iq1N2Juh1oI88R2ycUHxgh/fq5RaysVAt
         c7MxpklzWRWWEdoKTkSMwORurM1UfGSUNsH4er0K5r4ZXnzc06xICPVCS02AbK/M/tDQ
         aq1A==
X-Gm-Message-State: AAQBX9eiIgshJGI3GZ6CaJ80gldZ1GhshvuqpdWSbPVEEknMFSlwOcIt
        kRNq/XEYuYicv4oSVmjKb8eQaut30urrXVeEab2xLw==
X-Google-Smtp-Source: AKy350aTjYd9gp2pxx+eXPc6CTRgaN6TpJCr/SnIf8DkWW4AWo+TuBWjIGvU4aIqfIp/owEUlhT64w==
X-Received: by 2002:a05:6902:707:b0:b8f:3685:c12a with SMTP id k7-20020a056902070700b00b8f3685c12amr22691367ybt.39.1681845527952;
        Tue, 18 Apr 2023 12:18:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 126-20020a250a84000000b00b8f54571fc0sm2326961ybk.5.2023.04.18.12.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:18:47 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:18:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/6] string-list: introduce `string_list_setlen()`
Message-ID: <2a20ad8bc5513aae912c53a294092ee5087e1873.1681845518.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1681845518.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681845518.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is sometimes useful to reduce the size of a `string_list`'s list of
items without having to re-allocate them. For example, doing the
following:

    struct strbuf buf = STRBUF_INIT;
    struct string_list parts = STRING_LIST_INIT_NO_DUP;
    while (strbuf_getline(&buf, stdin) != EOF) {
      parts.nr = 0;
      string_list_split_in_place(&parts, buf.buf, ":", -1);
      /* ... */
    }
    string_list_clear(&parts, 0);

is preferable over calling `string_list_clear()` on every iteration of
the loop. This is because `string_list_clear()` causes us free our
existing `items` array. This means that every time we call
`string_list_split_in_place()`, the string-list internals re-allocate
the same size array.

Since in the above example we do not care about the individual parts
after processing each line, it is much more efficient to pretend that
there aren't any elements in the `string_list` by setting `list->nr` to
0 while leaving the list of elements allocated as-is.

This allows `string_list_split_in_place()` to overwrite any existing
entries without needing to free and re-allocate them.

However, setting `list->nr` manually is not safe in all instances. There
are a couple of cases worth worrying about:

  - If the `string_list` is initialized with `strdup_strings`,
    truncating the list can lead to overwriting strings which are
    allocated elsewhere. If there aren't any other pointers to those
    strings other than the ones inside of the `items` array, they will
    become unreachable and leak.

    (We could ourselves free the truncated items between
    string_list->items[nr] and `list->nr`, but no present or future
    callers would benefit from this additional complexity).

  - If the given `nr` is larger than the current value of `list->nr`,
    we'll trick the `string_list` into a state where it thinks there are
    more items allocated than there actually are, which can lead to
    undefined behavior if we try to read or write those entries.

Guard against both of these by introducing a helper function which
guards assignment of `list->nr` against each of the above conditions.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 string-list.c |  9 +++++++++
 string-list.h | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/string-list.c b/string-list.c
index b27a53f2e1..f0b3cdae94 100644
--- a/string-list.c
+++ b/string-list.c
@@ -203,6 +203,15 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
 	list->nr = list->alloc = 0;
 }
 
+void string_list_setlen(struct string_list *list, size_t nr)
+{
+	if (list->strdup_strings)
+		BUG("cannot setlen a string_list which owns its entries");
+	if (nr > list->nr)
+		BUG("cannot grow a string_list with setlen");
+	list->nr = nr;
+}
+
 struct string_list_item *string_list_append_nodup(struct string_list *list,
 						  char *string)
 {
diff --git a/string-list.h b/string-list.h
index f01bbb0bb6..b41ecda6f4 100644
--- a/string-list.h
+++ b/string-list.h
@@ -134,6 +134,16 @@ typedef void (*string_list_clear_func_t)(void *p, const char *str);
 /** Call a custom clear function on each util pointer */
 void string_list_clear_func(struct string_list *list, string_list_clear_func_t clearfunc);
 
+/*
+ * Set the length of a string_list to `nr`, provided that (a) `list`
+ * does not own its own storage, and (b) that `nr` is no larger than
+ * `list->nr`.
+ *
+ * Useful when "shrinking" `list` to write over existing entries that
+ * are no longer used without reallocating.
+ */
+void string_list_setlen(struct string_list *list, size_t nr);
+
 /**
  * Apply `func` to each item. If `func` returns nonzero, the
  * iteration aborts and the return value is propagated.
-- 
2.40.0.358.g56d2318a6d

