Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D737B1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 21:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbdARVQo (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:16:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52806 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751864AbdARVQh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:16:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B89461025;
        Wed, 18 Jan 2017 16:16:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zIYfE/KJuZEPD1g7I2Y/T0pvfCg=; b=OKS9kw
        Ijnc7fEexiC7g6lCzrvkN+nLaOx3Ka/DuimG13on7qvLN6Euj5OEQ0nm7OuhYRoK
        nFprls1+tv6rMlFK26f4y9g5rxwoQKyRa45jj0kVHa8Itf27bCZWlBoe2J9EK2UR
        WHtGNKSsKXRrhwgwvYOoVotDNf3cae732Aptk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s1uwMGn4b1qEJv9ZhcTE7LMuabZ2kNqX
        KAHMdOJ2XZP9y44aq+rRFUjrIzvaekWDJXiGyO3hLCawZKpocGjWVDrFfvWxgO/P
        K7XzW8oRBg3hE4eKQ0K/wNKXVEmSIYdyB6Q84kV4GMgcloXnWYBMfA5Ol5lHqe0d
        q7KSKkHFBeU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92D2C61023;
        Wed, 18 Jan 2017 16:16:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F117461021;
        Wed, 18 Jan 2017 16:16:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] remove_index_entry_at: move documentation to cache.h
References: <20170117233503.27137-1-sbeller@google.com>
        <20170117233503.27137-3-sbeller@google.com>
Date:   Wed, 18 Jan 2017 13:16:22 -0800
In-Reply-To: <20170117233503.27137-3-sbeller@google.com> (Stefan Beller's
        message of "Tue, 17 Jan 2017 15:35:01 -0800")
Message-ID: <xmqqfukg3w7t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D98CF56-DDC3-11E6-BB4A-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  cache.h      | 3 +++
>  read-cache.c | 1 -
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/cache.h b/cache.h
> index 270a0d0ea7..26632065a5 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -599,7 +599,10 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
>  #define ADD_CACHE_KEEP_CACHE_TREE 32	/* Do not invalidate cache-tree */
>  extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
>  extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
> +
> +/* Remove entry, return 1 if there are more entries after pos. */
>  extern int remove_index_entry_at(struct index_state *, int pos);

What is the reason why this now promise to return 1, as opposed to
the original that were allowed to return anything that is "true"?
Is it because you are adding other return values that mean different
things?  

If that is the case it may be fine (it depends on what these other
values mean and what use case it supports), but please do that in a
separate patch.

> +
>  extern void remove_marked_cache_entries(struct index_state *istate);
>  extern int remove_file_from_index(struct index_state *, const char *path);
>  #define ADD_CACHE_VERBOSE 1
> diff --git a/read-cache.c b/read-cache.c
> index 2eca639cce..63a414cdb5 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -503,7 +503,6 @@ int index_name_pos(const struct index_state *istate, const char *name, int namel
>  	return index_name_stage_pos(istate, name, namelen, 0);
>  }
>  
> -/* Remove entry, return true if there are more entries to go.. */
>  int remove_index_entry_at(struct index_state *istate, int pos)
>  {
>  	struct cache_entry *ce = istate->cache[pos];
