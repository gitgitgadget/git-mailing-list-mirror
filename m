Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B248B1F404
	for <e@80x24.org>; Thu,  1 Feb 2018 23:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751720AbeBAXra (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 18:47:30 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35935 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeBAXrW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 18:47:22 -0500
Received: by mail-wr0-f195.google.com with SMTP id y3so11004161wrh.3
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 15:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VhXCC2e1zRss9i6gZZQRMh1nzCM+3bz8XkUnQMCZxfQ=;
        b=WGqHf77DLode4KGv5cQ+hpplxvszEzyKE1qMR1Ff+GrWtn7RFtr+jVQYHhHflFHzgl
         +qQnqT7C8VzWP5ZIEKZnOX4iAVpI+M0Rsz5TMdheuV+wvdUayC7RK7otk5Umt1VF5sMT
         TxTSEavuCWosKDz3s3YkmeKHy/Lt0ItAZ1nJ9+iEK18z7fj/4GqQWXkmsF1bqjzGkBpl
         ZrCaSj89mDFaRTMi4Z+QAXHBZRnOPOvQwJYTe6uKUuea2ZsVAAWZt2KnIIr6/ajRHNQt
         PSKoy89lM/QjYFLOUu1AldrpyM/7rzc1yuq9ObLIOZ33qqCdxo13fgdm7UJou6NNTlOm
         OXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhXCC2e1zRss9i6gZZQRMh1nzCM+3bz8XkUnQMCZxfQ=;
        b=JK4xGC0u5bCJS8CHY7EUSZ7kQOgJ/CG/CBK7Yn0wdmJCVAt+MVsYTYL2h3TWIjIkcH
         oPI/bpkERUlDcGLMPJC92kBLb0XM09qgZKGLWAgyFkPjdbeMFnn0X52WJI6jznFs4lng
         vDjhMSRUdVlRcKy8Xkl4PtTN8sACD+FSA6gN2pzGzwhxTlJBgF5VCpHVOBIBINuPd49h
         HNu71qF16Rz6OJsKVxlJnBG3YM1kDGwX0KAWXz5jAPmHm+WdztBylinOmPdnAZzvPoeD
         /1QOb2d1fZ93DT8mSc/Y6RiUE+WE0hMv1SfazUO7E4Nb91R9iStvbP3tSRtr87NQY754
         ID5g==
X-Gm-Message-State: AKwxytfTcizVPT4OeNNGCUs+RN6m7nKcWowRP8g6oa9pe6ZpFpJcyiQX
        CqHyER63fiLhEzKyeGKfsr4=
X-Google-Smtp-Source: AH8x224sXrIYwtu1j2CBH5jIOsG5iVXAW9av6DeTK43GV/8owj7UqugYYO/ZDpDYhjTlCJMIhy7+Uw==
X-Received: by 10.223.196.154 with SMTP id m26mr977886wrf.56.1517528841607;
        Thu, 01 Feb 2018 15:47:21 -0800 (PST)
Received: from localhost.localdomain (x4db049fc.dyn.telefonica.de. [77.176.73.252])
        by smtp.gmail.com with ESMTPSA id l9sm1457521wrl.1.2018.02.01.15.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 15:47:20 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 04/14] commit-graph: implement construct_commit_graph()
Date:   Fri,  2 Feb 2018 00:46:43 +0100
Message-Id: <20180201234643.7331-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <1517348383-112294-5-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com> <1517348383-112294-5-git-send-email-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Teach Git to write a commit graph file by checking all packed objects
> to see if they are commits, then store the file in the given pack
> directory.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Makefile       |   1 +
>  commit-graph.c | 376 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  commit-graph.h |  20 +++
>  3 files changed, 397 insertions(+)
>  create mode 100644 commit-graph.c
>  create mode 100644 commit-graph.h


> diff --git a/commit-graph.c b/commit-graph.c
> new file mode 100644
> index 0000000000..db2b7390c7
> --- /dev/null
> +++ b/commit-graph.c

> +struct packed_commit_list {
> +	struct commit **list;
> +	int num;
> +	int size;
> +};
> +
> +struct packed_oid_list {
> +	struct object_id **list;
> +	int num;
> +	int size;
> +};

When we manage the memory allocation of an array with the ALLOC_GROW
macro, then we tend to call the helper fields as 'alloc' and 'nr'.

> +static int if_packed_commit_add_to_list(const struct object_id *oid,
> +					struct packed_git *pack,
> +					uint32_t pos,
> +					void *data)
> +{
> +	struct packed_oid_list *list = (struct packed_oid_list*)data;
> +	enum object_type type;
> +	unsigned long size;
> +	void *inner_data;
> +	off_t offset = nth_packed_object_offset(pack, pos);
> +	inner_data = unpack_entry(pack, offset, &type, &size);
> +
> +	if (inner_data)
> +		free(inner_data);
> +
> +	if (type != OBJ_COMMIT)
> +		return 0;
> +
> +	ALLOC_GROW(list->list, list->num + 1, list->size);
> +	list->list[list->num] = (struct object_id *)malloc(sizeof(struct object_id));
> +	oidcpy(list->list[list->num], oid);
> +	(list->num)++;
> +
> +	return 0;
> +}
> +
> +struct object_id *construct_commit_graph(const char *pack_dir)
> +{
> +	struct packed_oid_list oids;
> +	struct packed_commit_list commits;
> +	struct commit_graph_header hdr;
> +	struct sha1file *f;
> +	int i, count_distinct = 0;
> +	struct strbuf tmp_file = STRBUF_INIT;
> +	unsigned char final_hash[GIT_MAX_RAWSZ];
> +	char *graph_name;
> +	int fd;
> +	uint32_t chunk_ids[5];
> +	uint64_t chunk_offsets[5];
> +	int num_long_edges;
> +	struct object_id *f_hash;
> +	char *fname;
> +	struct commit_list *parent;
> +
> +	oids.num = 0;
> +	oids.size = 1024;
> +	ALLOC_ARRAY(oids.list, oids.size);
> +	for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
> +	QSORT(oids.list, oids.num, commit_compare);
> +
> +	count_distinct = 1;
> +	for (i = 1; i < oids.num; i++) {
> +		if (oidcmp(oids.list[i-1], oids.list[i]))
> +			count_distinct++;
> +	}
> +
> +	commits.num = 0;
> +	commits.size = count_distinct;
> +	ALLOC_ARRAY(commits.list, commits.size);
> +
> +	num_long_edges = 0;
> +	for (i = 0; i < oids.num; i++) {
> +		int num_parents = 0;
> +		if (i > 0 && !oidcmp(oids.list[i-1], oids.list[i]))
> +			continue;
> +
> +		commits.list[commits.num] = lookup_commit(oids.list[i]);
> +		parse_commit(commits.list[commits.num]);
> +
> +		for (parent = commits.list[commits.num]->parents;
> +		     parent; parent = parent->next)
> +			num_parents++;
> +
> +		if (num_parents > 2)
> +			num_long_edges += num_parents - 1;
> +
> +		commits.num++;
> +	}
> +
> +	strbuf_addstr(&tmp_file, pack_dir);
> +	strbuf_addstr(&tmp_file, "/tmp_graph_XXXXXX");
> +
> +	fd = git_mkstemp_mode(tmp_file.buf, 0444);
> +	if (fd < 0)
> +		die_errno("unable to create '%s'", tmp_file.buf);
> +
> +	graph_name = strbuf_detach(&tmp_file, NULL);
> +	f = sha1fd(fd, graph_name);
> +
> +	hdr.graph_signature = htonl(GRAPH_SIGNATURE);
> +	hdr.graph_version = GRAPH_VERSION;
> +	hdr.hash_version = GRAPH_OID_VERSION;
> +	hdr.hash_len = GRAPH_OID_LEN;
> +	hdr.num_chunks = 4;
> +
> +	assert(sizeof(hdr) == 8);
> +	sha1write(f, &hdr, sizeof(hdr));
> +
> +	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
> +	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
> +	chunk_ids[2] = GRAPH_CHUNKID_DATA;
> +	chunk_ids[3] = GRAPH_CHUNKID_LARGEEDGES;
> +	chunk_ids[4] = 0;
> +
> +	chunk_offsets[0] = sizeof(hdr) + GRAPH_CHUNKLOOKUP_SIZE;
> +	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
> +	chunk_offsets[2] = chunk_offsets[1] + GRAPH_OID_LEN * commits.num;
> +	chunk_offsets[3] = chunk_offsets[2] + (GRAPH_OID_LEN + 16) * commits.num;
> +	chunk_offsets[4] = chunk_offsets[3] + 4 * num_long_edges;
> +
> +	for (i = 0; i <= hdr.num_chunks; i++) {
> +		uint32_t chunk_write[3];
> +
> +		chunk_write[0] = htonl(chunk_ids[i]);
> +		chunk_write[1] = htonl(chunk_offsets[i] >> 32);
> +		chunk_write[2] = htonl(chunk_offsets[i] & 0xffffffff);
> +		sha1write(f, chunk_write, 12);
> +	}
> +
> +	write_graph_chunk_fanout(f, commits.list, commits.num);
> +	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.num);
> +	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.num);
> +	write_graph_chunk_large_edges(f, commits.list, commits.num);
> +
> +	sha1close(f, final_hash, CSUM_CLOSE | CSUM_FSYNC);
> +
> +	f_hash = (struct object_id *)malloc(sizeof(struct object_id));
> +	memcpy(f_hash->hash, final_hash, GIT_MAX_RAWSZ);

hashcpy(), perhaps?

> +	fname = get_commit_graph_filename_hash(pack_dir, f_hash);
> +
> +	if (rename(graph_name, fname))
> +		die("failed to rename %s to %s", graph_name, fname);
> +
> +	free(oids.list);
> +	oids.size = 0;
> +	oids.num = 0;
> +
> +	return f_hash;
> +}
> +
> diff --git a/commit-graph.h b/commit-graph.h
> new file mode 100644
> index 0000000000..7b3469a7df
> --- /dev/null
> +++ b/commit-graph.h
> @@ -0,0 +1,20 @@
> +#ifndef COMMIT_GRAPH_H
> +#define COMMIT_GRAPH_H
> +
> +#include "git-compat-util.h"
> +#include "commit.h"
> +
> +extern char* get_commit_graph_filename_hash(const char *pack_dir,
> +					    struct object_id *hash);
> +
> +struct commit_graph_header {
> +	uint32_t graph_signature;
> +	unsigned char graph_version;
> +	unsigned char hash_version;
> +	unsigned char hash_len;
> +	unsigned char num_chunks;
> +};
> +
> +extern struct object_id *construct_commit_graph(const char *pack_dir);
> +
> +#endif
> -- 
> 2.16.0.15.g9c3cf44.dirty


