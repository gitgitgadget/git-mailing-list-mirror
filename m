Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1B571F424
	for <e@80x24.org>; Thu, 26 Apr 2018 02:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbeDZCgD (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 22:36:03 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34898 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeDZCgC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 22:36:02 -0400
Received: by mail-wr0-f173.google.com with SMTP id w3-v6so55112861wrg.2
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 19:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gIeLdWZE7kpmSpIVcKPcD0HvH5DDHlTt+mYqdFGlT/A=;
        b=RKqAKliK9swvT4eUBdrydesrK3gwu30/2PhSdXDvTxg5Y9i3XfzQMhoT8Ic8k/QLL8
         nV641jACNcIGJhdt/HinaeTGtkBxUFSNi9u5uXdSOIBj9pePeDc45nYEvj4McvhDt1VZ
         /ruhhYJ4wkpYzL3x4k2JFN7yN0dN64uEIlQg/WRh9VNsoRltpG9ZYMTTyRiD2j4gsx19
         iPRXdAtcFNiKN0jVaQqI6ZN71ohIWOj+zaawfRRhZlwNLVaLBmlqC8hJwv6k/5FW1ubq
         JWaIwN6V31WaX25WmyZaxmb9wmdb4MUd8wvnXCY1sn7n6Gwiqc14ArXtQCtVDvDYRNDu
         QWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gIeLdWZE7kpmSpIVcKPcD0HvH5DDHlTt+mYqdFGlT/A=;
        b=dpjAPU9Ew+nI/QqRtjT52hUZxsdBPs6Crg57/FwWPQaEDVAoyoMPFpHjP81zUahDmk
         mH6RxJ/tunUKoAeTN03ApMhKgI9w04EUzzC/O7uwDRj/WxeOGIDAvMQiLZ6eULNiApxC
         RTNpzb33NTwgf9IPAhd4SMBEJxpFqCqCwMhHNwoXVsoFZ8qhJsVMTqOUfWP2linRZ4YD
         oyVM9W+uGlxng88SxP7eMEPnciHL40gW6w/hz11DJuk10DIL1VKLBkMM78NeKTB02XgR
         u99afntOHYpyirYYqFFWjNdTdzwvAkyaZG8dDG/a14fHeb7RUXiMrF/KQ3wUg/DWeqCo
         XO1Q==
X-Gm-Message-State: ALQs6tDKQUDQ3qPsWhYEt7MoEkUEDKmxZ0dZML5u62SprKcQWmO2BKeH
        gle1eqsfkbFlFo3VRw5qvqA=
X-Google-Smtp-Source: AIpwx4+uMnShC9cxwwAFXtnSbyzIMcu/GjsEu4A7b7nFZq+CnXkvOjt6RwnfC5RoMcDLfYUxD2Nj5A==
X-Received: by 2002:adf:968b:: with SMTP id u11-v6mr25547721wrb.184.1524710160507;
        Wed, 25 Apr 2018 19:36:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q16-v6sm22228263wrn.81.2018.04.25.19.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 19:35:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "jnareb\@gmail.com" <jnareb@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>
Subject: Re: [PATCH v4 03/10] commit-graph: compute generation numbers
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-4-dstolee@microsoft.com>
Date:   Thu, 26 Apr 2018 11:35:59 +0900
In-Reply-To: <20180425143735.240183-4-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 25 Apr 2018 14:37:56 +0000")
Message-ID: <xmqqvace3d9s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> @@ -439,6 +439,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
>  		else
>  			packedDate[0] = 0;
>  
> +		if ((*list)->generation != GENERATION_NUMBER_INFINITY)
> +			packedDate[0] |= htonl((*list)->generation << 2);
> +
>  		packedDate[1] = htonl((*list)->date);
>  		hashwrite(f, packedDate, 8);

The ones that have infinity are written as zero here.  The code that
reads the generation field off of a file in fill_commit_graph_info()
and fill_commit_in_graph() both leave such a record in file as-is,
so the reader of what we write out will think it is _ZERO, not _INF.

Not that it matters, as it seems that most of the code being added
by this series treat _ZERO and _INF more or less interchangeably.
But it does raise another question, i.e. do we need both _ZERO and
_INF, or is it sufficient to have just a single _UNKNOWN?

> @@ -571,6 +574,46 @@ static void close_reachable(struct packed_oid_list *oids)
>  	}
>  }
>  
> +static void compute_generation_numbers(struct commit** commits,
> +				       int nr_commits)
> +{
> +	int i;
> +	struct commit_list *list = NULL;
> +
> +	for (i = 0; i < nr_commits; i++) {
> +		if (commits[i]->generation != GENERATION_NUMBER_INFINITY &&
> +		    commits[i]->generation != GENERATION_NUMBER_ZERO)
> +			continue;
> +
> +		commit_list_insert(commits[i], &list);
> +		while (list) {
> +			struct commit *current = list->item;
> +			struct commit_list *parent;
> +			int all_parents_computed = 1;
> +			uint32_t max_generation = 0;
> +
> +			for (parent = current->parents; parent; parent = parent->next) {
> +				if (parent->item->generation == GENERATION_NUMBER_INFINITY ||
> +				    parent->item->generation == GENERATION_NUMBER_ZERO) {
> +					all_parents_computed = 0;
> +					commit_list_insert(parent->item, &list);
> +					break;
> +				} else if (parent->item->generation > max_generation) {
> +					max_generation = parent->item->generation;
> +				}
> +			}
> +
> +			if (all_parents_computed) {
> +				current->generation = max_generation + 1;
> +				pop_commit(&list);
> +			}

If we haven't computed all parents' generations yet,
current->generation is undefined (or at least "left as
initialized"), so it does not make much sense to attempt to clip it
at _MAX at this point.  At leat not yet.

IOW, shouldn't the following two lines be inside the "we now know
genno of all parents, so we can compute genno for commit" block
above?

> +			if (current->generation > GENERATION_NUMBER_MAX)
> +				current->generation = GENERATION_NUMBER_MAX;
> +		}
> +	}
> +}
> +
>  void write_commit_graph(const char *obj_dir,
>  			const char **pack_indexes,
>  			int nr_packs,
> @@ -694,6 +737,8 @@ void write_commit_graph(const char *obj_dir,
>  	if (commits.nr >= GRAPH_PARENT_MISSING)
>  		die(_("too many commits to write graph"));
>  
> +	compute_generation_numbers(commits.list, commits.nr);
> +
>  	graph_name = get_commit_graph_filename(obj_dir);
>  	fd = hold_lock_file_for_update(&lk, graph_name, 0);
