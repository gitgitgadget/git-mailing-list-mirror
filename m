Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71C81F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391007AbfIEWE6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:04:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37396 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfIEWE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:04:57 -0400
Received: by mail-io1-f67.google.com with SMTP id r4so8326325iop.4
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zLcrZnY90l4Hfr90Ula8PT5+zUvFU8174XND3uZ+jj8=;
        b=Jx2UqJTyAQkzOQef8dc68W6Cq7K/PBBi2VSJ+2hB0W9PNlDU+rlgRdfr64HQ9bAuNf
         c2pxQK59Xtsgpy416O5fIvZFXATjbRFQbWw2zV/si+SnCDgFqode+GGDfO5uNzGhwY3z
         CYhhtOThmlgXDiLvUxEZKnRIXXymSROpcsy1Qb5Fuykxx0wd+eHqanVEMfSj/lUiGdJR
         mKRPP78fHRdFPhGUWETJ+jGI2Xw1ovcaZ1tur2VY8ddGRxpPv6QiKQJnqjzbg/6NOvhk
         YOrodH6Ldwkjx8CUEIFkYWlqleMB6+adzPB1/3WwCjMMwEse/oPNT3bCT9gjnkniK3pG
         ARnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zLcrZnY90l4Hfr90Ula8PT5+zUvFU8174XND3uZ+jj8=;
        b=NRxzHxA3klTxEyv+aVT55HUuFpnm/bcduB5zrP87RppzkHXIiQjOrFUSOdqS/721ka
         ThKCF4FQrlWRG9B40zrh9ZPjaVvDZj3Rr0f3rRH4Ez6Ce06tPBXlaXUtteqv6klW7x5h
         LOyC7fl+Z0WJ2MvSrkC7wRn5D34NP36UZWElxiaEyAzIxagCKycF+xmD+S3XfWGOSlHC
         wU78pVuSrMxBEuIC0vuxZdZwsM83K6BBqbjwhJn8k1g+i8MWzZeQ+HRqf6xMaaO0HSAL
         UXIgOmeURAjyrMCHGaKKt9t6rFhgaN2H1DMoPsyWjD/AmeWTVRRgeceS/bph06kh4Alx
         NUrw==
X-Gm-Message-State: APjAAAVp0bplFwk30ypXcEU4LB1iFr5jJHEF13Q3dx4eJKVxLGJqL8ia
        OQ0hUYg66iwjWQwIwtF4K4/O9PLYM6sb2w==
X-Google-Smtp-Source: APXvYqw/dtWi1kedBRd1VQGYFlMbsrmgn0M9jy9z15lPSbi7upgxPOzT4rH77x1A2Sb2WLMpZ8ASiw==
X-Received: by 2002:a05:6638:93b:: with SMTP id 27mr754605jak.36.1567721096252;
        Thu, 05 Sep 2019 15:04:56 -0700 (PDT)
Received: from localhost ([2601:401:c500:7dd8:3c19:faad:a3bb:990d])
        by smtp.gmail.com with ESMTPSA id e139sm4520201iof.60.2019.09.05.15.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 15:04:55 -0700 (PDT)
Date:   Thu, 5 Sep 2019 18:04:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, peff@peff.net
Subject: [PATCH 2/3] commit-graph.c: handle commit parsing errors
Message-ID: <7fb6853ab31f35c27e5c220f11ea2de6e229a806.1567720960.git.me@ttaylorr.com>
References: <cover.1567720960.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1567720960.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To write a commit graph chunk, 'write_graph_chunk_data()' takes a list
of commits to write and parses each one before writing the necessary
data, and continuing on to the next commit in the list.

Since the majority of these commits are not parsed ahead of time (an
exception is made for the *last* commit in the list, which is parsed
early within 'copy_oids_to_commits'), it is possible that calling
'parse_commit_no_graph()' on them may return an error. Failing to catch
these errors before de-referencing later calls can result in a undefined
memory access and a SIGSEGV.

One such example of this is 'get_commit_tree_oid()', which expects a
parsed object as its input (in this case, the commit-graph code passes
'*list'). If '*list' causes a parse error, the subsequent call will
fail.

Prevent such an issue by checking the return value of
'parse_commit_no_graph()' to avoid passing an unparsed object to a
function which expects a parsed object, thus preventing a segfault.

It is worth noting that this fix is really skirting around the issue in
object.c's 'parse_object()', which makes it difficult to tell how
corrupt an object is without digging into it. Presumably one could
change the meaning of 'parse_object' returns, but this would require
adjusting each callsite accordingly. Instead of that, add an additional
check to the object parsed.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c          | 4 +++-
 t/t5318-commit-graph.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f2888c203b..6aa6998ecd 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -843,7 +843,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		uint32_t packedDate[2];
 		display_progress(ctx->progress, ++ctx->progress_cnt);
 
-		parse_commit_no_graph(*list);
+		if (parse_commit_no_graph(*list))
+			die(_("unable to parse commit %s"),
+				oid_to_hex(&(*list)->object.oid));
 		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
 
 		parent = (*list)->parents;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index c855f81930..abde8d4e90 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -585,7 +585,7 @@ test_expect_success 'get_commit_tree_in_graph works for non-the_repository' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'corrupt commit-graph write (broken parent)' '
+test_expect_success 'corrupt commit-graph write (broken parent)' '
 	rm -rf repo &&
 	git init repo &&
 	(
-- 
2.23.0

