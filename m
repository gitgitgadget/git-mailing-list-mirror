Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAAFC433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 15:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B5761284
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 15:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353528AbhDGP1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 11:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbhDGP1B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 11:27:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A808C061756
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 08:26:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i18so14970849wrm.5
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 08:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=pqUjudOYKEBVpZWUXH7HZlaq4FlTBMC0/Cv1/UWg/Tk=;
        b=J2PMkLjZuWSi63s1vEzelSRPUo1Xib/tizsVDtt5UKPj3GNU3vjfnTAdGNDWWrA8uu
         Hqjhug96pFyv0SO+FP9uVweOPKRQCYWmcoY4t1ern6fBwZJzmD0zOhYSIskGh3o49uxH
         VGd1Kdb49onCDEXHOLDkYpGbsIdBAJltNBI55miVB3vEW30qIO7fwlogmHx1k22PLWYU
         USD2nDKoH3/ZnsZNQPzkWsLErF150wRL0M9PrnRa6EpbYii56CoRaq5FGLIjH4lu2+dL
         FINA1JETTvsdwmybBuWhp3BybLJTVFkfGVhBM7aQNZ4cMwTGrvW8h9nom8lmlVub2svh
         YwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=pqUjudOYKEBVpZWUXH7HZlaq4FlTBMC0/Cv1/UWg/Tk=;
        b=aH8KPY4IcAUxsSg8IAl6MOIIX+tMdhloWeGmaRLtjAVohMzwndF0Q0eBXnVFHTyGbo
         GGdObpiZne4BCyfka89zIB66nTZAYn/0oIHpiF/KiOx35TxQU02wjPcfvEnz0Lz7UNF8
         CVklhve1Wc/Eh8kymVvQHo1zIa6Xa+JXo3d6j0QR+HhoUkP6cnv1SPwylnhkFkr20EmE
         xXf5XgvuhakWweLdAUjq818KlnkXuZX9BGZdZQ9Z7oFvcwBa1rjiCKyhVDkH/EGEpkJd
         +oKamtMAdRRE+QitW8SYSxJ38EbkcB8mbe1xgKQQxhMnRaja5Bi1Ao+N2UkBxWFFe5Ed
         lNpg==
X-Gm-Message-State: AOAM533ES6lZ1GmlC8xKtW4JpnPXBcIIOS+/JItvNu3MF+ngq0+T4Oef
        gGcotiOKkMW/OnvwT7kLfock2xCJbJk=
X-Google-Smtp-Source: ABdhPJwxNNs6bhCZ4XHCRuqr31huK20RJq5y7yNmP68AA1Dgr2kRC+wqNsdEyr9UA3PkfUoafHyzEg==
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr2904022wrt.78.1617809210265;
        Wed, 07 Apr 2021 08:26:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7sm15046681wru.74.2021.04.07.08.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 08:26:49 -0700 (PDT)
Message-Id: <pull.927.v2.git.1617809209164.gitgitgadget@gmail.com>
In-Reply-To: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Apr 2021 15:26:48 +0000
Subject: [PATCH v2] [GSOC] ref-filter: use single strbuf for all output
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

When we use `git for-each-ref`, every ref will call
`show_ref_array_item()` and allocate its own final strbuf
and error strbuf. Instead, we can reuse these two strbuf
for each step ref's output.

The performance for `git for-each-ref` on the Git repository
itself with performance testing tool `hyperfine` changes from
18.7 ms ± 0.4 ms to 18.2 ms ± 0.3 ms.

This approach is similar to the one used by 79ed0a5
(cat-file: use a single strbuf for all output, 2018-08-14)
to speed up the cat-file builtin.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] ref-filter: use single strbuf for all output
    
    Now git for-each-ref can reuse two buffers for all refs output, the
    performance is slightly improved.
    
    Now there may be a question : Should the original interface
    show_ref_array_items be retained?
    
    Thanks.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-927%2Fadlternative%2Fref-filter-single-buf-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-927/adlternative/ref-filter-single-buf-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/927

Range-diff vs v1:

 1:  bcc3feb4de7c ! 1:  3aed12c4f5a8 [GSOC] ref-filter: use single strbuf for all output
     @@ Commit message
      
          When we use `git for-each-ref`, every ref will call
          `show_ref_array_item()` and allocate its own final strbuf
     -    and error strbuf. Instead, we can provide two single strbuf:
     -    final_buf and error_buf that get reused for each output.
     +    and error strbuf. Instead, we can reuse these two strbuf
     +    for each step ref's output.
      
     -    When run it 100 times:
     +    The performance for `git for-each-ref` on the Git repository
     +    itself with performance testing tool `hyperfine` changes from
     +    18.7 ms ± 0.4 ms to 18.2 ms ± 0.3 ms.
      
     -    $ git for-each-ref
     -
     -    on git.git :
     -
     -    3.19s user
     -    3.88s system
     -    35% cpu
     -    20.199 total
     -
     -    to:
     -
     -    2.89s user
     -    4.00s system
     -    34% cpu
     -    19.741 total
     -
     -    The performance has been slightly improved.
     +    This approach is similar to the one used by 79ed0a5
     +    (cat-file: use a single strbuf for all output, 2018-08-14)
     +    to speed up the cat-file builtin.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## builtin/for-each-ref.c ##
     -@@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
     - 	struct ref_array array;
     - 	struct ref_filter filter;
     - 	struct ref_format format = REF_FORMAT_INIT;
     -+	struct strbuf final_buf = STRBUF_INIT;
     -+	struct strbuf error_buf = STRBUF_INIT;
     +@@ builtin/for-each-ref.c: static char const * const for_each_ref_usage[] = {
       
     - 	struct option opts[] = {
     - 		OPT_BIT('s', "shell", &format.quote_style,
     + int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
     + {
     +-	int i;
     + 	struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
     + 	int maxcount = 0, icase = 0;
     + 	struct ref_array array;
      @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
     + 
       	if (!maxcount || array.nr < maxcount)
       		maxcount = array.nr;
     - 	for (i = 0; i < maxcount; i++)
     +-	for (i = 0; i < maxcount; i++)
      -		show_ref_array_item(array.items[i], &format);
     -+		show_ref_array_item(array.items[i], &format, &final_buf, &error_buf);
     ++	show_ref_array_items(array.items, &format, maxcount);
       	ref_array_clear(&array);
       	return 0;
       }
      
     - ## builtin/tag.c ##
     -@@ builtin/tag.c: static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
     - 		     struct ref_format *format)
     - {
     - 	struct ref_array array;
     -+	struct strbuf final_buf = STRBUF_INIT;
     -+	struct strbuf error_buf = STRBUF_INIT;
     - 	char *to_free = NULL;
     - 	int i;
     - 
     -@@ builtin/tag.c: static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
     - 	ref_array_sort(sorting, &array);
     - 
     - 	for (i = 0; i < array.nr; i++)
     --		show_ref_array_item(array.items[i], format);
     -+		show_ref_array_item(array.items[i], format, &final_buf, &error_buf);
     - 	ref_array_clear(&array);
     - 	free(to_free);
     - 
     -
       ## ref-filter.c ##
      @@ ref-filter.c: int format_ref_array_item(struct ref_array_item *info,
     + 	return 0;
       }
       
     - void show_ref_array_item(struct ref_array_item *info,
     --			 const struct ref_format *format)
     ++void show_ref_array_items(struct ref_array_item **info,
      +			 const struct ref_format *format,
     -+			 struct strbuf *final_buf,
     -+			 struct strbuf *error_buf)
     - {
     --	struct strbuf final_buf = STRBUF_INIT;
     --	struct strbuf error_buf = STRBUF_INIT;
     - 
     --	if (format_ref_array_item(info, format, &final_buf, &error_buf))
     --		die("%s", error_buf.buf);
     --	fwrite(final_buf.buf, 1, final_buf.len, stdout);
     --	strbuf_release(&error_buf);
     --	strbuf_release(&final_buf);
     -+	if (format_ref_array_item(info, format, final_buf, error_buf))
     -+		die("%s", error_buf->buf);
     -+	fwrite(final_buf->buf, 1, final_buf->len, stdout);
     -+	strbuf_reset(error_buf);
     -+	strbuf_reset(final_buf);
     - 	putchar('\n');
     - }
     - 
     -@@ ref-filter.c: void pretty_print_ref(const char *name, const struct object_id *oid,
     - 		      const struct ref_format *format)
     - {
     - 	struct ref_array_item *ref_item;
     ++			 size_t n)
     ++{
      +	struct strbuf final_buf = STRBUF_INIT;
      +	struct strbuf error_buf = STRBUF_INIT;
     ++	size_t i;
      +
     - 	ref_item = new_ref_array_item(name, oid);
     - 	ref_item->kind = ref_kind_from_refname(name);
     --	show_ref_array_item(ref_item, format);
     -+	show_ref_array_item(ref_item, format, &final_buf, &error_buf);
     - 	free_array_item(ref_item);
     - }
     - 
     ++	for (i = 0; i < n; i++) {
     ++		if (format_ref_array_item(info[i], format, &final_buf, &error_buf))
     ++			die("%s", error_buf.buf);
     ++		fwrite(final_buf.buf, 1, final_buf.len, stdout);
     ++		strbuf_reset(&error_buf);
     ++		strbuf_reset(&final_buf);
     ++		putchar('\n');
     ++	}
     ++	strbuf_release(&error_buf);
     ++	strbuf_release(&final_buf);
     ++}
     ++
     + void show_ref_array_item(struct ref_array_item *info,
     + 			 const struct ref_format *format)
     + {
      
       ## ref-filter.h ##
      @@ ref-filter.h: int format_ref_array_item(struct ref_array_item *info,
     - 			  struct strbuf *final_buf,
       			  struct strbuf *error_buf);
       /*  Print the ref using the given format and quote_style */
     --void show_ref_array_item(struct ref_array_item *info, const struct ref_format *format);
     -+void show_ref_array_item(struct ref_array_item *info,
     + void show_ref_array_item(struct ref_array_item *info, const struct ref_format *format);
     ++/*  Print the refs using the given format and quote_style and maxcount */
     ++void show_ref_array_items(struct ref_array_item **info,
      +			 const struct ref_format *format,
     -+			 struct strbuf *final_buf,
     -+			 struct strbuf *error_buf);
     ++			 size_t n);
     ++
       /*  Parse a single sort specifier and add it to the list */
       void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *atom);
       /*  Callback function for parsing the sort option */


 builtin/for-each-ref.c |  4 +---
 ref-filter.c           | 20 ++++++++++++++++++++
 ref-filter.h           |  5 +++++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index cb9c81a04606..d630402230f3 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -16,7 +16,6 @@ static char const * const for_each_ref_usage[] = {
 
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 	int maxcount = 0, icase = 0;
 	struct ref_array array;
@@ -80,8 +79,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	if (!maxcount || array.nr < maxcount)
 		maxcount = array.nr;
-	for (i = 0; i < maxcount; i++)
-		show_ref_array_item(array.items[i], &format);
+	show_ref_array_items(array.items, &format, maxcount);
 	ref_array_clear(&array);
 	return 0;
 }
diff --git a/ref-filter.c b/ref-filter.c
index f0bd32f71416..27bbf9b6c8ac 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2435,6 +2435,26 @@ int format_ref_array_item(struct ref_array_item *info,
 	return 0;
 }
 
+void show_ref_array_items(struct ref_array_item **info,
+			 const struct ref_format *format,
+			 size_t n)
+{
+	struct strbuf final_buf = STRBUF_INIT;
+	struct strbuf error_buf = STRBUF_INIT;
+	size_t i;
+
+	for (i = 0; i < n; i++) {
+		if (format_ref_array_item(info[i], format, &final_buf, &error_buf))
+			die("%s", error_buf.buf);
+		fwrite(final_buf.buf, 1, final_buf.len, stdout);
+		strbuf_reset(&error_buf);
+		strbuf_reset(&final_buf);
+		putchar('\n');
+	}
+	strbuf_release(&error_buf);
+	strbuf_release(&final_buf);
+}
+
 void show_ref_array_item(struct ref_array_item *info,
 			 const struct ref_format *format)
 {
diff --git a/ref-filter.h b/ref-filter.h
index 19ea4c413409..eb7e79a6676d 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -121,6 +121,11 @@ int format_ref_array_item(struct ref_array_item *info,
 			  struct strbuf *error_buf);
 /*  Print the ref using the given format and quote_style */
 void show_ref_array_item(struct ref_array_item *info, const struct ref_format *format);
+/*  Print the refs using the given format and quote_style and maxcount */
+void show_ref_array_items(struct ref_array_item **info,
+			 const struct ref_format *format,
+			 size_t n);
+
 /*  Parse a single sort specifier and add it to the list */
 void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *atom);
 /*  Callback function for parsing the sort option */

base-commit: 2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48
-- 
gitgitgadget
