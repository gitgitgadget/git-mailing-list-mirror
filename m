Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E2011F462
	for <e@80x24.org>; Mon, 10 Jun 2019 21:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388999AbfFJVrL (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 17:47:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64041 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387661AbfFJVrL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 17:47:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 336046B32F;
        Mon, 10 Jun 2019 17:47:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LOd+JfSrqL2hBUUyiF8nR3CR11s=; b=jlvDPr
        /1lAPItMTcaOyAWFB/FBnpVh2q3mhthxbpLKXRUNxrAdZAMx1s1VANjCgk3TwN23
        AcEdhWgWhGPZFJVDdu9eUlYS/xlMvc0LMLXRIT+2sFEKJ28SaIJuRMrnjLzX1R2T
        z+eGTadD1pQmxHlSm+oJcXyoM2JvFeKWJcNR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LK3D+IO0qEvSGYo7F9L2y7U5vXy1Y5JO
        3jF53JmlvCOQ8Y2t7mu4iOnpXeh8Svu272UF483v92UjP5vItMPkXRtTJ9GycsGa
        H8dt61801J8lc3CgsfJshGnU/RGqGJ8e24KokWDOurw6M8M/MmKk0prr4OP8q8AC
        Vdkbf3m7G2s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BC766B32E;
        Mon, 10 Jun 2019 17:47:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 581546B32D;
        Mon, 10 Jun 2019 17:47:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, philipoakley@iee.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 04/16] commit-graph: load commit-graph chains
References: <pull.184.v4.git.gitgitgadget@gmail.com>
        <pull.184.v5.git.gitgitgadget@gmail.com>
        <fc3423046b9b2fc43bf8323dd41281f0a29b9d0a.1559932699.git.gitgitgadget@gmail.com>
Date:   Mon, 10 Jun 2019 14:47:04 -0700
In-Reply-To: <fc3423046b9b2fc43bf8323dd41281f0a29b9d0a.1559932699.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 07 Jun 2019
        11:38:23 -0700 (PDT)")
Message-ID: <xmqqy329kt9j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A5CC238-8BC9-11E9-910A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	fp = fopen(chain_name, "r");
> +	stat_res = stat(chain_name, &st);
> +	free(chain_name);
> +
> +	if (!fp ||
> +	    stat_res ||
> +	    st.st_size <= the_hash_algo->hexsz)
> +		return NULL;
> +
> +	count = st.st_size / (the_hash_algo->hexsz + 1);
> +	oids = xcalloc(count, sizeof(struct object_id));
> +
> +	for (i = 0; i < count && valid; i++) {
> +		char *graph_name;
> +		struct commit_graph *g;
> +
> +		if (strbuf_getline_lf(&line, fp) == EOF)
> +			break;
> +
> +		if (get_oid_hex(line.buf, &oids[i])) {
> +			warning(_("invalid commit-graph chain: line '%s' not a hash"),
> +				line.buf);
> +			valid = 0;
> +			break;
> +		}
> +
> +		graph_name = get_split_graph_filename(obj_dir, line.buf);
> +		g = load_commit_graph_one(graph_name);
> +		free(graph_name);
> +
> +		if (g && add_graph_to_chain(g, graph_chain, oids, i))
> +			graph_chain = g;
> +		else
> +			valid = 0;
> +	}

At this point, if 'i' is smaller than 'count', that would indicate
that the file was corrupt (we hit one of the 'break' in the loop).

How would we handle such an error?  It appears that the strategy
taken in this loop is to "read as many as possible without an error
and then give up upon the first error---keep whatever we have read
so far", so from that point of view, the only thing that is missing
may be a warning() after the loop.

> +
> +	free(oids);
> +	fclose(fp);
> +
> +	return graph_chain;
> +}
> +
> +static struct commit_graph *read_commit_graph_one(struct repository *r, const char *obj_dir)
> +{
> +	struct commit_graph *g = load_commit_graph_v1(r, obj_dir);
> +
> +	if (!g)
> +		g = load_commit_graph_chain(r, obj_dir);
> +
> +	return g;
> +}
> +
>  static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
>  {
> -	char *graph_name;
>  
>  	if (r->objects->commit_graph)
>  		return;
>  
> -	graph_name = get_commit_graph_filename(obj_dir);
> -	r->objects->commit_graph =
> -		load_commit_graph_one(graph_name);
> -
> -	FREE_AND_NULL(graph_name);
> +	r->objects->commit_graph = read_commit_graph_one(r, obj_dir);
>  }
>  
>  /*
