Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1AEC433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 13:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2215420771
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 13:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="heqb39qB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgIQNmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 09:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgIQNfB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 09:35:01 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A885C06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 06:34:46 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w16so2165628qkj.7
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6HXOIPWy3XoeYQ77oOgNsdHRmS4OdHDwXH3KkAqnT0s=;
        b=heqb39qBMc4UGV4zPyiImGRKjCPycuvU7xirlgjF/duAeH8+0moPZ6Yi1IhvWLSvbK
         9Fl+WTCTBONNXwqRQ2IGZwsGcuuSpsfnJfew3/Lf0rjUR1h9aLwVhko3mWlv+aSV4QP4
         t9UjPB4arXE8bcV+w1ah8ZxEQw/oEMlmROPdWi3aM+NDsMu8Mb/sT8s9JFxmyyfBP4KF
         whTNl9rw73d87mkqi9IeOnRZ6f67xd6w80Yfo7HueNPX0IvDux79Z8+u/U+ZBZbf8GMD
         lkHad5KVL7oaxCwQDjNNP37ewhB6T/o3lJRvtbqM8W27O5jlc8ZfSi3UvhD/JQwxG6UA
         ExIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6HXOIPWy3XoeYQ77oOgNsdHRmS4OdHDwXH3KkAqnT0s=;
        b=QUIKgFfrL5UEegHahPoqNst2cTwXptUEsfBBcGdsKVfQ9tWSnpGZZ/ejktJJSubSBF
         rAYRBuz2JF6dqqzhlRsMKVr65+/ZvnEfs9hMPizkMbjPFQ7y5mtq2cmUcSI6nq8eWVAN
         CRfJaQPv9sgTxYdQdb9L4f2nD5pZIO3vt88g5e9TgET+PJ6yUtsOuWy2wmFX8Sgm/Tcb
         Ed1p4hg3U2ikOVaEJQtrqRuGaeiUiazu86WF/V4AOl0+5okaHPwqocSyQlqE9j2mkhr5
         KuaeN99IaNL9VdGF+W4PJ0uay+iuXCDzaId3D9jJdHGTh6zqMYLcBHhN7/CrnUGjye+h
         pP8w==
X-Gm-Message-State: AOAM532qdww/tbfIS49MvX/9Lxj7QGZt4D/Uiq81oib2xsxvqxlbrbTs
        nEv8Nzg/wsl6ZlW0DIaCG6MCgQ==
X-Google-Smtp-Source: ABdhPJzH6cQwaSL9ueQtViMq4b2D3IJH7Q/ms3ioSZheJCY8aH+jB2Q6h/nz45YdKlsRCO7taHjl0A==
X-Received: by 2002:a37:6109:: with SMTP id v9mr27448250qkb.418.1600349685148;
        Thu, 17 Sep 2020 06:34:45 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:819f:6bba:e7ac:1ed8])
        by smtp.gmail.com with ESMTPSA id 205sm22686485qki.118.2020.09.17.06.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 06:34:44 -0700 (PDT)
Date:   Thu, 17 Sep 2020 09:34:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com, peff@peff.net, szeder.dev@gmail.com
Subject: Re: [PATCH v2 00/13] more miscellaneous Bloom filter improvements,
 redux
Message-ID: <20200917133442.GA12879@nand.local>
References: <20200917004518.GA6478@nand.local>
 <xmqqd02ltdzl.fsf@gitster.c.googlers.com>
 <20200917011049.GB6478@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917011049.GB6478@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

On Wed, Sep 16, 2020 at 09:10:49PM -0400, Taylor Blau wrote:
> I should have the patch in your inbox by the end of tonight, depending
> on how fast my workstation can run the ASan-enabled test suite 13 times
> ;).

All finished. This is sufficient to fix the ASan-enabled test suite,
along with fixing a bug where we wouldn't respect the limit on changed
paths when loading an existing commit-graph. This has nothing to do with
the user-specified '--max-new-filters', nor does it mean that we're
storing the limit in the commit-graph file. Instead it's because we're
loading the bloom_filter_settings struct from the graph and
initializing it ourselves, instead of using the default values (which is
the case when we don't load a graph at all).

Anyway, let's use this instead of 6/13. Here's an inter-diff that shows
the fix and test change:

  diff --git a/commit-graph.c b/commit-graph.c
  index 33af6c2430..fc6c6fdc3e 100644
  --- a/commit-graph.c
  +++ b/commit-graph.c
  @@ -424,6 +424,7 @@ struct commit_graph *parse_commit_graph(struct repository *r,
          graph->bloom_filter_settings->hash_version = hash_version;
          graph->bloom_filter_settings->num_hashes = get_be32(data + chunk_offset + 4);
          graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
  +				graph->bloom_filter_settings->max_changed_paths = DEFAULT_BLOOM_MAX_CHANGES;
        }
        break;
      }
  diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
  index dc7d62c778..5bc1627568 100755
  --- a/t/t4216-log-bloom.sh
  +++ b/t/t4216-log-bloom.sh
  @@ -175,11 +175,11 @@ test_expect_success 'persist filter settings' '
      GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=9 \
      GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY=15 \
      git commit-graph write --reachable --changed-paths &&
  -	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15" trace2.txt &&
  +	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2.txt &&
    GIT_TRACE2_EVENT="$(pwd)/trace2-auto.txt" \
      GIT_TRACE2_EVENT_NESTING=5 \
      git commit-graph write --reachable --changed-paths &&
  -	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15" trace2-auto.txt
  +	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2-auto.txt
   '

   test_max_changed_paths () {

...and here is the updated patch. Sorry again for all of the trouble.

--- >8 ---

Subject: [PATCH] commit-graph.c: store maximum changed paths

For now, we assume that there is a fixed constant describing the
maximum number of changed paths we are willing to store in a Bloom
filter.

Prepare for that to (at least partially) not be the case by making it a
member of the 'struct bloom_filter_settings'. This will be helpful in
the subsequent patches by reducing the size of test cases that exercise
storing too many changed paths, as well as preparing for an eventual
future in which this value might change.

This patch alone does not cause newly generated Bloom filters to use
a custom upper-bound on the maximum number of changed paths a single
Bloom filter can hold, that will occur in a later patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.h              | 11 ++++++++++-
 commit-graph.c       |  4 ++++
 t/t4216-log-bloom.sh |  4 ++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/bloom.h b/bloom.h
index d8fbb0fbf1..0b9b59a6fe 100644
--- a/bloom.h
+++ b/bloom.h
@@ -28,9 +28,18 @@ struct bloom_filter_settings {
 	 * that contain n*b bits.
 	 */
 	uint32_t bits_per_entry;
+
+	/*
+	 * The maximum number of changed paths per commit
+	 * before declaring a Bloom filter to be too-large.
+	 *
+	 * Not written to the commit-graph file.
+	 */
+	uint32_t max_changed_paths;
 };

-#define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
+#define DEFAULT_BLOOM_MAX_CHANGES 512
+#define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10, DEFAULT_BLOOM_MAX_CHANGES }
 #define BITS_PER_WORD 8
 #define BLOOMDATA_CHUNK_HEADER_SIZE 3 * sizeof(uint32_t)

diff --git a/commit-graph.c b/commit-graph.c
index ea54d108b9..ba6d4a4c6c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -424,6 +424,7 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 				graph->bloom_filter_settings->hash_version = hash_version;
 				graph->bloom_filter_settings->num_hashes = get_be32(data + chunk_offset + 4);
 				graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
+				graph->bloom_filter_settings->max_changed_paths = DEFAULT_BLOOM_MAX_CHANGES;
 			}
 			break;
 		}
@@ -1201,6 +1202,7 @@ static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
 	jw_object_intmax(&jw, "hash_version", ctx->bloom_settings->hash_version);
 	jw_object_intmax(&jw, "num_hashes", ctx->bloom_settings->num_hashes);
 	jw_object_intmax(&jw, "bits_per_entry", ctx->bloom_settings->bits_per_entry);
+	jw_object_intmax(&jw, "max_changed_paths", ctx->bloom_settings->max_changed_paths);
 	jw_end(&jw);

 	trace2_data_json("bloom", ctx->r, "settings", &jw);
@@ -1669,6 +1671,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 							      bloom_settings.bits_per_entry);
 		bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
 							  bloom_settings.num_hashes);
+		bloom_settings.max_changed_paths = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS",
+							  bloom_settings.max_changed_paths);
 		ctx->bloom_settings = &bloom_settings;
 	}

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fc7693806c..593571358d 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -174,11 +174,11 @@ test_expect_success 'persist filter settings' '
 		GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=9 \
 		GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY=15 \
 		git commit-graph write --reachable --changed-paths &&
-	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2.txt &&
+	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2-auto.txt" \
 		GIT_TRACE2_EVENT_NESTING=5 \
 		git commit-graph write --reachable --changed-paths &&
-	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2-auto.txt
+	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2-auto.txt
 '

 test_expect_success 'correctly report changes over limit' '
--
2.28.0.510.g86fdc5f89a

