Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9445C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 22:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjDXWUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 18:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjDXWUU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 18:20:20 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BA96A59
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:20:16 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b8f549d36e8so8938580276.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682374816; x=1684966816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bFI2BL7bcCkF07NR9MDI1AUzu6vynoeiliNLGS3V+eE=;
        b=tO0GK+ZgnrvtZHy21lC9g52JCH5TIcfZkFaF1QRHVjtAgP8kYMRu+YwKIBNz6pQtXw
         mdb4QiQ0T22lAydmDA16ndZ2O3uwNsxc0OfGZa4xa3uuCOscHt75urbh0iBxC5VStTc6
         sNCUn9K6Zwc6xEAT2XF+qHk0alvdjSgWOOittn5hQ7kE9mStHfW1Mh3ainAy/kb9/WoD
         V3GsVNl1dzTgQbMI+iwDK+eO5HJf+XYwSM6kpP1alBotr8ELGpA0Mr5qM9nAjjG1t+CK
         yp4h5x3r1v9Q4N0T0zbpBof3rV7EoV30+APWo4Q6ZFQsIYMGb5IEvtsMHSiv31jZdUlT
         YWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374816; x=1684966816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFI2BL7bcCkF07NR9MDI1AUzu6vynoeiliNLGS3V+eE=;
        b=d9fzKfHw+IPpsDkoFmDuevU2JycUdWp+Nbgj56y2NXUc3SUe+udjOZjb+4yZjvetvk
         F7OjFxxIUigenXGjsVUa2+/Olk3GZYeGfDIZeuGaz6dZrUPBmB+OXuDUn08mPLeDAoiz
         FwTI1L8ZPNZRk+h4nVlXvY5kvLrRD0CTp/PcNDuTgJYYqVzSwX08BtIPDzzvRGkSYc06
         1KtRUlFRhIHWoqDmJnXW0gT95LHOmUB860X9sjUWhlEoSJBPk3sv/fyoZeZxdlBrv84p
         dQCXYCbD92LdJr+nEoLReziKuDO2DCrHlhuTODwNiGqogne7WMJcJkzApJUyECZWSs9l
         93GA==
X-Gm-Message-State: AAQBX9ehD9wKInF2NcgFwvUg0lIpFJgfUlCKeVxTLsR0RFb1oldbtpSt
        VWoCkUADkAil+coE08KQXdbInh3QtAnA0Sy9NU8e3g==
X-Google-Smtp-Source: AKy350abYgRNkSsC97cztM/xJNlK/+LA8ZnGT5/d4sYY0zEilhaaF7ZuvG4I1DW2IeJ573etFN/Uog==
X-Received: by 2002:a25:a188:0:b0:b99:4af6:185d with SMTP id a8-20020a25a188000000b00b994af6185dmr8714602ybi.6.1682374815766;
        Mon, 24 Apr 2023 15:20:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s14-20020a5b074e000000b00b993995abe4sm2395874ybq.60.2023.04.24.15.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:20:15 -0700 (PDT)
Date:   Mon, 24 Apr 2023 18:20:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 2/6] string-list: introduce `string_list_setlen()`
Message-ID: <ae8d0ce1f25f26da09f2e3f5bc68f85cc162ce64.1682374789.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1682374789.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682374789.git.me@ttaylorr.com>
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
index 5f5b60fe1c..0f8ac117fd 100644
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
index 77854840f7..122b318641 100644
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
2.40.0.380.gd2df7d2365

