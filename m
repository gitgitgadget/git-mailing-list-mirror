Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092E3E9271B
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 17:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjJERvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjJERvr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 13:51:47 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295E7BF
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 10:51:45 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-65b07651b97so6675206d6.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696528304; x=1697133104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pLzAudvbeKPoIzbv7kpRNGFeE/jcg9M7xEQWxY7V/MY=;
        b=T1ofReWRiNV5qOAhEApF8ECOfPfBWUYz/teBw3t53rKp6pIshSDlp4hcG9yEgZ15Nl
         gK4yR+HzeVU326RG2EYEbitW2NjrXppj0/3vaQHWo+wbxvRjxbJKZKGumPW8NCZYi8jO
         qQiYbTDyIWmqHuvw1hirr5b2I6PJ+IgPikEbHQfEzEpXL4O04V5mjhJ86JpKNMc0q5Oh
         AY3OzcttD6uOe/6HV03pmt0/iXnJHR1f9oyq0P1maH9753I11snAuBmaEynWXQMGPaBQ
         yHbFzqWGYXl+D/+03sU6/AQqIc4iKmaY8Fjdp1Icv+aQ5UBOls7NI0qZ0q2+vYcSTflz
         URfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696528304; x=1697133104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLzAudvbeKPoIzbv7kpRNGFeE/jcg9M7xEQWxY7V/MY=;
        b=Q8DlrAKPTCcTAuNjq4ignUrsCOfnOexVNk0F/XHIjQm7QDzUVhFWZjOKE0VbOQ3Gh0
         2mVJsRPWe4iYDvqV2aCb4eNO4a+Oa81ZzZ/P62+UZ4KRkqWgJIRueX3JWz/J5iautGrL
         +KrQGtWF+rXhluQUCXlTj9JYkCBTTE+4XzGgsv0/qyRatn6rcZgy33l57/k+acxAuVaB
         8FGVNbMyBvcxcfOVWqxb+yeiNR3P4Ta/XqtrP+o8urcTt78JydgT0ytchiPi+K8SIcnr
         iXRMOVhqlfcNgLbuGKl31/jLYAYZdX2GIyjs4VlyABBsKWupIdYE6aAud0hpVCGJk7Tn
         y+HA==
X-Gm-Message-State: AOJu0YykB3SBt05OZPH/yMt1yCUuhljNeIsLafQ74aJ5NFSN7CCRJ+nL
        IRsjxqd5tj61NUZhkN7mtV9XcC0MFy4d8zwNAWylkQ==
X-Google-Smtp-Source: AGHT+IGMA/1mBG//GJuSifuI4n9wRVAkVQeYfni7PdjA8R1+j3xmQnXvO1+zjMr4ID4PMN/Q9c13Yw==
X-Received: by 2002:a0c:e78b:0:b0:64f:6199:a8e with SMTP id x11-20020a0ce78b000000b0064f61990a8emr5894847qvn.23.1696528304226;
        Thu, 05 Oct 2023 10:51:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x6-20020a0cda06000000b0065b1c26c89asm657942qvj.145.2023.10.05.10.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 10:51:43 -0700 (PDT)
Date:   Thu, 5 Oct 2023 13:51:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/10] commit-graph: free write-context entries before
 overwriting
Message-ID: <ZR73rpsKiTBF/rYj@nand.local>
References: <20231003202504.GA7697@coredump.intra.peff.net>
 <20231003203055.GH7812@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003203055.GH7812@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 04:30:55PM -0400, Jeff King wrote:
> diff --git a/commit-graph.c b/commit-graph.c
> index 4aa2f294f1..744b7eb1a3 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2065,9 +2065,11 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  			free(graph_name);
>  		}
>
> +		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
>  		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] = xstrdup(hash_to_hex(file_hash));
>  		final_graph_name = get_split_graph_filename(ctx->odb,
>  					ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
> +		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1]);
>  		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1] = final_graph_name;
>
>  		result = rename(ctx->graph_name, final_graph_name);

This hunk makes sense. It might be nice in the future to do something
like:

--- 8< ---
diff --git a/commit-graph.c b/commit-graph.c
index 5e8a3a5085..cadccbe276 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -59,7 +59,7 @@ void git_test_write_commit_graph_or_die(void)

 #define GRAPH_EXTRA_EDGES_NEEDED 0x80000000
 #define GRAPH_EDGE_LAST_MASK 0x7fffffff
-#define GRAPH_PARENT_NONE 0x70000000
+tdefine GRAPH_PARENT_NONE 0x70000000

 #define GRAPH_LAST_EDGE 0x80000000

@@ -1033,11 +1033,11 @@ struct write_commit_graph_context {
 	uint64_t progress_cnt;

 	char *base_graph_name;
-	int num_commit_graphs_before;
-	int num_commit_graphs_after;
-	char **commit_graph_filenames_before;
-	char **commit_graph_filenames_after;
-	char **commit_graph_hash_after;
+	struct {
+		size_t nr;
+		char **fname;
+		char **hash;
+	} graphs_before, graphs_after;
 	uint32_t new_num_commits_in_base;
 	struct commit_graph *new_base_graph;
--- >8 ---

...making the corresponding changes throughout the rest of the file. But
that is definitely out of scope here, and could easily be left for
another day.

#leftoverbits

Thanks,
Taylor
