Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08B511F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 21:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbdARVLa (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:11:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63634 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752078AbdARVL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:11:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C702162B0E;
        Wed, 18 Jan 2017 16:11:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HlKdga7GZoOW7iDlyPojLYBGpro=; b=o4O66b
        wWczu0Eyx09MiG/MEK0gfp8ZImkS0aQ47f8ffSt/+gE2D5MXyPPFSzIC26rUlBDc
        sHAxx4w1GLfjFtTcUCEGqg0FQSlU+8T+ZPBh/Gl32NFzkJKEhJ/G3kCIBCsacUc1
        mRWqojAWmgWi7pv+EJkJnUozFm+dgCvgAhK3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EKmH+oRhaJ1ML89eP/Gc0X5tOP+OJ1Wm
        XNpC1N8DFJQrshm9co8YXNscvg1S9t9KRFdZV5LZY4bNVt5ON4shFinvQxfO6RCV
        FtxGzck44obDIWhjXIIgEGYgUgNgD7saDk6H9qhufXf/1yVte3UKtA7bLuYsxg6N
        M6lJgCDreT0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BDA8162B0D;
        Wed, 18 Jan 2017 16:11:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2ACBF62B0C;
        Wed, 18 Jan 2017 16:11:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] document index_name_pos
References: <20170117233503.27137-1-sbeller@google.com>
        <20170117233503.27137-2-sbeller@google.com>
Date:   Wed, 18 Jan 2017 13:11:27 -0800
In-Reply-To: <20170117233503.27137-2-sbeller@google.com> (Stefan Beller's
        message of "Tue, 17 Jan 2017 15:35:00 -0800")
Message-ID: <xmqqk29s3wg0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD47466E-DDC2-11E6-8413-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  cache.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index 1b67f078dd..270a0d0ea7 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -575,7 +575,22 @@ extern int verify_path(const char *path);
>  extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
>  extern void adjust_dirname_case(struct index_state *istate, char *name);
>  extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
> +
> +/*
> + * Searches for an entry defined by name and namelen in the given index.
> + * If the return value is positive (including 0) it is the position of an
> + * exact match. If the return value is negative, the negated value minus 1 is the
> + * position where the entry would be inserted.
> + * Example: In the current index we have the files b,d,e:
> + * index_name_pos(&index, "a", 1) -> -1
> + * index_name_pos(&index, "b", 1) ->  0
> + * index_name_pos(&index, "c", 1) -> -2
> + * index_name_pos(&index, "d", 1) ->  1
> + * index_name_pos(&index, "e", 1) ->  2

The above may not be wrong per-se, but it misses one important case.
A conflicted entry in the index with the same name is considered to
sort after the name this asks.  If there are stage #1 and stage #3
entries for path "g" in addition to the above, i.e.

	[0] [1] [2] [3] [4]
	b#0 d#0 e#0 g#1 g#3

then 

	index_name_pos(&index, "g", 1) -> -3 - 1 = -4
        index_name_pos(&index, "h", 1) -> -5 - 1 = -6

> + * index_name_pos(&index, "f", 1) -> -3
> + */

Shouldn't this be -4?  We originally have [0], [1], and [2] in the
index, and "f" needs to go to [3], so -3 - 1 = -4, no?

>  extern int index_name_pos(const struct index_state *, const char *name, int namelen);
> +
>  #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
>  #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
>  #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
