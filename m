Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44A081F462
	for <e@80x24.org>; Sat,  1 Jun 2019 00:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfFAAgh (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 20:36:37 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:40469 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfFAAgh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 20:36:37 -0400
Received: by mail-qt1-f202.google.com with SMTP id 37so2081881qtc.7
        for <git@vger.kernel.org>; Fri, 31 May 2019 17:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yqEWilff9PfEDxnWwsAsf5xmQ2hB/9aS1CJfqlFT+BM=;
        b=ZT5F9EHOtZSzNdfAkZiB585TIXy8xHTBnTnQeHDA4vsrWS9ro4uHvpvOAEgtI0Ie5L
         Fb+YHxtBblZWO146riTaTpy14IGQAh7diaK/GwnEqYGlO0FKq0XNxO3gqYBtE1OHOwRM
         9xHAYJEJQSFnOjfYpe9lMLGbNIZl/tMHB53SCTFE52r589+1RcKW219TPZPbx+UZ06pY
         BkTvfGZ4OEhtp1ebX/9cPslF9829/O6bt0iC2WYJj5whLYOxdm0Gcw/4u+jpU32mKTgQ
         NRUjZ6M06Hm0vWc4Vpy0IDPh1Bw//UFvRIeppiI+hBTfHBIS1YtQLR0XVEdyNNvD27xW
         ZhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yqEWilff9PfEDxnWwsAsf5xmQ2hB/9aS1CJfqlFT+BM=;
        b=rrkSOg1nxTHZ6YDduHh9CI0mrp2PqboW52YlYb1bGEhF3VBg/zxGE2ce1TKmK/OVP7
         abYb1iYVgsySjrhYS0vKSqyvi91Czd1YVnBwHyrMEA8mP2vk0Ij3232kDZNNjdAEa+mZ
         2Rti+w8bjdGAy6qH3Owxl5nyBYA3gPohYaI2KNqtNcIOL7DpCQno3G1q6nrme2VSRu+k
         N7ADHmh656tQNzt3G4yLanxUooAapuUM5KGbeOkb8FEEJGwckhAfzHYQGFs2ow5OsVhX
         XCJMHAzrcmLPJmZKNHgk71o94oMm0T3ZaX+3gN9uH/553WMHeXdyHNtefCuvEaB6E25E
         d9zA==
X-Gm-Message-State: APjAAAWwy8W4y3T6YpNE9A6jnl0PWDLflw9iC07yiqUNrhd9legF1fKu
        ke52t5ZcbCgGxgwukPrZEcO9pR5U6B7H1FmfZv6QL/8MkA4bGn03lh+iUOlJEOgpFTUHmTLrord
        YhqauavNebZCm5EdBrDYz2roc+yzJqn6nv9dyQ5tu2tzslAw4m5vp8oArKlc=
X-Google-Smtp-Source: APXvYqzjpwDYj51paBVkKjnEph+18kggbIr78pcuogrrFhoqi5GLVeyWcSx/Pp/mreSz1U1PLRTF6uCtbf0q
X-Received: by 2002:a0c:9dc4:: with SMTP id p4mr11784434qvf.69.1559349395813;
 Fri, 31 May 2019 17:36:35 -0700 (PDT)
Date:   Fri, 31 May 2019 17:36:02 -0700
In-Reply-To: <20190601003603.90794-1-matvore@google.com>
Message-Id: <20190601003603.90794-9-matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v2 8/9] list-objects-filter-options: clean up use of ALLOC_GROW
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new macro ALLOC_GROW_BY which automatically zeros the added
array elements and takes care of updating the nr value. Use the macro in
code introduced earlier in this patchset.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 cache.h                       | 22 ++++++++++++++++++++++
 list-objects-filter-options.c | 17 +++++++----------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index fa8ede9a2d..847fbdeff0 100644
--- a/cache.h
+++ b/cache.h
@@ -652,33 +652,55 @@ int init_db(const char *git_dir, const char *real_git_dir,
 void sanitize_stdfds(void);
 int daemonize(void);
 
 #define alloc_nr(x) (((x)+16)*3/2)
 
 /*
  * Realloc the buffer pointed at by variable 'x' so that it can hold
  * at least 'nr' entries; the number of entries currently allocated
  * is 'alloc', using the standard growing factor alloc_nr() macro.
  *
+ * Consider using ALLOC_GROW_BY instead of ALLOC_GROW as it has some
+ * added niceties.
+ *
  * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
  */
 #define ALLOC_GROW(x, nr, alloc) \
 	do { \
 		if ((nr) > alloc) { \
 			if (alloc_nr(alloc) < (nr)) \
 				alloc = (nr); \
 			else \
 				alloc = alloc_nr(alloc); \
 			REALLOC_ARRAY(x, alloc); \
 		} \
 	} while (0)
 
+/*
+ * Similar to ALLOC_GROW but handles updating of the nr value and
+ * zeroing the bytes of the newly-grown array elements.
+ *
+ * DO NOT USE any expression with side-effect for any of the
+ * arguments.
+ */
+#define ALLOC_GROW_BY(x, nr, increase, alloc) \
+	do { \
+		if (increase) { \
+			size_t new_nr = nr + (increase); \
+			if (new_nr < nr) \
+				BUG("negative growth in ALLOC_GROW_BY"); \
+			ALLOC_GROW(x, new_nr, alloc); \
+			memset((x) + nr, 0, sizeof(*(x)) * (increase)); \
+			nr = new_nr; \
+		} \
+	} while (0)
+
 /* Initialize and use the cache information */
 struct lock_file;
 void preload_index(struct index_state *index,
 		   const struct pathspec *pathspec,
 		   unsigned int refresh_flags);
 int do_read_index(struct index_state *istate, const char *path,
 		  int must_exist); /* for testting only! */
 int read_index_from(struct index_state *, const char *path,
 		    const char *gitdir);
 int is_index_unborn(struct index_state *);
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 5e98e4a309..d8abe6cfcf 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -142,26 +142,24 @@ static int has_reserved_character(
 	}
 
 	return 0;
 }
 
 static int parse_combine_subfilter(
 	struct list_objects_filter_options *filter_options,
 	struct strbuf *subspec,
 	struct strbuf *errbuf)
 {
-	size_t new_index = filter_options->sub_nr++;
+	size_t new_index = filter_options->sub_nr;
 
-	ALLOC_GROW(filter_options->sub, filter_options->sub_nr,
-		   filter_options->sub_alloc);
-	memset(&filter_options->sub[new_index], 0,
-	       sizeof(*filter_options->sub));
+	ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
+		      filter_options->sub_alloc);
 
 	return has_reserved_character(subspec, errbuf) ||
 		url_decode(subspec, errbuf) ||
 		gently_parse_list_objects_filter(
 			&filter_options->sub[new_index], subspec->buf, errbuf);
 }
 
 static int parse_combine_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
@@ -273,27 +271,26 @@ int parse_list_objects_filter(
 		/*
 		 * Make filter_options an LOFC_COMBINE spec so we can trivially
 		 * add subspecs to it.
 		 */
 		transform_to_combine_type(filter_options);
 
 		strbuf_addstr(&filter_options->filter_spec, "+");
 		add_url_encoded(&filter_options->filter_spec, arg);
 		trace_printf("Generated composite filter-spec: %s\n",
 			     filter_options->filter_spec.buf);
-		ALLOC_GROW(filter_options->sub, filter_options->sub_nr + 1,
-			   filter_options->sub_alloc);
-		filter_options = &filter_options->sub[filter_options->sub_nr++];
-		memset(filter_options, 0, sizeof(*filter_options));
+		ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
+			      filter_options->sub_alloc);
 
 		parse_error = gently_parse_list_objects_filter(
-			filter_options, arg, &errbuf);
+			&filter_options->sub[filter_options->sub_nr - 1], arg,
+			&errbuf);
 	}
 	if (parse_error)
 		die("%s", errbuf.buf);
 	return 0;
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset)
 {
 	struct list_objects_filter_options *filter_options = opt->value;
-- 
2.17.1

