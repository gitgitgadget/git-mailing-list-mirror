Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D756E20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 20:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754531AbdASUV7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 15:21:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53393 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754507AbdASUV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 15:21:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B58F2609AA;
        Thu, 19 Jan 2017 15:17:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C1y7yYBFFsMxPgqYZWL9uniOgnc=; b=BLxznR
        NGnxGnBkPobol6ADOyi0Dpt7Ba4joBztMoaPBXrYLsI3levmdKoCFkPLqorIVylZ
        hhFBJVoiJsc+rvIOfVoT9zdlhQFk+nMsxtGVxyS8OL+RqcNxqLhCI9i0S75MtT23
        TwmFYGenes5o102RRGC12Zv4hOnqCwUngi53c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YoyfnUDjoAg/GHBriqi/07q2cMSHEWRi
        UhSlwpmlCLSsfP0uL8FJ1unJdN+PvaPs3rwH9FVXnIMi9ePcnk0lrUrO/fZc8uCV
        tHkfS6mmr8FtUci3QArN2bpqR73PKqFEHN+1CAU6NMqbRT+KzYZCpaBW9YcVS5JO
        tbEuLZ4/YYI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA95B609A9;
        Thu, 19 Jan 2017 15:17:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17167609A8;
        Thu, 19 Jan 2017 15:17:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCHv3 1/4] cache.h: document index_name_pos
References: <20170118232145.31606-2-sbeller@google.com>
        <20170119031854.4570-1-sbeller@google.com>
        <20170119031854.4570-2-sbeller@google.com>
Date:   Thu, 19 Jan 2017 12:17:51 -0800
In-Reply-To: <20170119031854.4570-2-sbeller@google.com> (Stefan Beller's
        message of "Wed, 18 Jan 2017 19:18:51 -0800")
Message-ID: <xmqqziimztw0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B5AD0C4-DE84-11E6-9F4D-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  cache.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index 1b67f078dd..1469ddeafe 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -575,7 +575,26 @@ extern int verify_path(const char *path);
>  extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
>  extern void adjust_dirname_case(struct index_state *istate, char *name);
>  extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
> +
> +/*
> + * Searches for an entry defined by name and namelen in the given index.
> + * If the return value is positive (including 0) it is the position of an
> + * exact match. If the return value is negative, the negated value minus 1
> + * is the position where the entry would be inserted.

So if the return value is -3, you negate it to get 3 and then
subtract 1 to get 2.  The function is telling you that "e" will
sit at active_cache[2] in the following example.

Which is correct.

> + * Example: The current index consists of these files and its stages:
> + *
> + *   b#0, d#0, f#1, f#3
> + *
> + * index_name_pos(&index, "a", 1) -> -1
> + * index_name_pos(&index, "b", 1) ->  0
> + * index_name_pos(&index, "c", 1) -> -2
> + * index_name_pos(&index, "d", 1) ->  1
> + * index_name_pos(&index, "e", 1) -> -3
> + * index_name_pos(&index, "f", 1) -> -3
> + * index_name_pos(&index, "g", 1) -> -5
> + */

This time the counting seems correct.

Thanks.
