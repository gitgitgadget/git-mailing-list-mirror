Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B1AC1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 22:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfF0Wyr (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 18:54:47 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:33676 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfF0Wyq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 18:54:46 -0400
Received: by mail-pl1-f201.google.com with SMTP id f2so2261409plr.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w7vpVJ8s7clxjwwCepQCPd9uZ8PX6ZSIFiVtWpSl6Js=;
        b=vge+IU4wyuDP4g2DBPKqveOG2sOvuNCxX/tvaTAcEnwwIJLQgkoIkoP0hBU2f4bSh4
         /TdSwgoeYmSROlc/fEId5Xh32zMEOuR3QqfouJ40X0JeDxCmGenmnVQIKRz1KGJOjHtb
         ZVcoNF0eARv0EthZraTtiw/EI17DsjlGSRykM+90MeaVRtS3GB9Pev2hT6IREXqk+YoJ
         mh9NPbmGVvlJyq/3H6+ZYqPvHwbfizDa0oBwmvEjqFTtLeCuinDaA0PkdotjAx5stkxd
         EJl1x5hU2uYhUzfwXxnYRZVxDq05KzU6ZmNlLXUAobJyMmkQ3hDz7yzoLFDj9hmGDqrV
         9jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w7vpVJ8s7clxjwwCepQCPd9uZ8PX6ZSIFiVtWpSl6Js=;
        b=IeK75BNIajin8yM6Vk82+9WtUSVmPxk3+ntH9fBRiKCDEoat3nYlPVcjkBqAHz1izu
         MFtoL79p8IPykTZvaBur0fu0ryQHU8l6QMR4IZlADANXEWro0fQEdE3Hs+0ngaClmg9l
         W/sLHM8lY42at3wklQvDyw721pPm7D2WmV0mLh1YOlxmYugCQ2+yEmOji3Fc4YhXKFGd
         WtHHwrqniIo6rXRnni2R+MAm9suRGXkjyR7dMAuQyLbYX/QJh3SzceBmDKTkDTzmriqO
         LUvgxtqhsrCw4bgRyNJF9uQGpZAGN/ube1A2+nyER9ap4NcPZhh6FUk3W+dMBG3ZtYpD
         egtA==
X-Gm-Message-State: APjAAAVZAdxKn1bSzY5NLa7I3+kHBXHuRg2d7eEFt0kl3EUd/2Uzcko6
        8APlLP70QYKTt98TTHhJJy8k247Lu59FON8WIPBP+1uy3dCZ33MuohHEeJjkgfFdZXrNl+3ENK1
        jjDfmxt8sFDkNhak6LPV6fqfyWGIB1c++sQT5CfpDYE80N0OXDj5GyEy/CEk=
X-Google-Smtp-Source: APXvYqxgPQj9C3FDSFSntVO5HSuFzpGr4Mln/a9BEohb8mASktI6OGoNFCj65RT3VgntMcUrx/omnxUusOL4
X-Received: by 2002:a63:607:: with SMTP id 7mr3753691pgg.240.1561676085479;
 Thu, 27 Jun 2019 15:54:45 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:54:13 -0700
In-Reply-To: <cover.1561675151.git.matvore@google.com>
Message-Id: <0af31656ccceefbf9eff82506b89c613613cef94.1561675151.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1561675151.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 09/10] list-objects-filter-options: clean up use of ALLOC_GROW
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net,
        Johannes.Schindelin@gmx.de
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
index bf20337ef4..cf5d70c196 100644
--- a/cache.h
+++ b/cache.h
@@ -653,33 +653,55 @@ int init_db(const char *git_dir, const char *real_git_dir,
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
index 2506dc8327..44bc1153d1 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -113,28 +113,26 @@ static int has_reserved_character(
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
 	char *decoded;
 	int result;
 
-	ALLOC_GROW(filter_options->sub, filter_options->sub_nr,
-		   filter_options->sub_alloc);
-	memset(&filter_options->sub[new_index], 0,
-	       sizeof(*filter_options->sub));
+	ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
+		      filter_options->sub_alloc);
 
 	decoded = url_percent_decode(subspec->buf);
 
 	result = has_reserved_character(subspec, errbuf) ||
 		gently_parse_list_objects_filter(
 			&filter_options->sub[new_index], decoded, errbuf);
 
 	free(decoded);
 	return result;
 }
@@ -248,27 +246,26 @@ int parse_list_objects_filter(
 			filter_options, arg, &errbuf);
 	} else {
 		/*
 		 * Make filter_options an LOFC_COMBINE spec so we can trivially
 		 * add subspecs to it.
 		 */
 		transform_to_combine_type(filter_options);
 
 		string_list_append(&filter_options->filter_spec, xstrdup("+"));
 		filter_spec_append_urlencode(filter_options, arg);
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
2.21.0

