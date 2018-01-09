Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52A201F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934980AbeAIS5i (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:57:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61506 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932310AbeAIS5i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:57:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BFEFBE412;
        Tue,  9 Jan 2018 13:57:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UOWZ2pXqgjoXTJxKQwMSpHGhCoE=; b=Qq6x/r
        6Z/mNX/SQP3FN03Arm54Q4X7mBYiGxFSihORYDvEXKvjeciiX7vm27N4pImQJGe3
        bgZgPW/3fe1MP2m3nHNmP8jI17jJghpITd0WC7ChPwDuzMIDtC/gFkIBCkPL6JPZ
        MkyRvWPVCix1LdQaCCKVDqihIE1jLN6/mYYLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iI5wqhGD+Nz/i7iUOABnh5JoayCKbMKo
        nQHEqRn18aicEFi/b4kt7BlT42nEHNxf6KrykAOIA21FD1+JNAHr+ppQZTfHNefO
        myXybVpbvvh3Dguw1Nn92jDp33NO3+LKnpQMJQzR6HBB1EYRq1uYo8faTVPatkBr
        7pGGAGpLRaQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43831BE411;
        Tue,  9 Jan 2018 13:57:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB810BE410;
        Tue,  9 Jan 2018 13:57:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yasushi SHOJI <yasushi.shoji@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bisect: debug: convert struct object to object_id
References: <20180109110356.25824-1-yasushi.shoji@gmail.com>
Date:   Tue, 09 Jan 2018 10:57:33 -0800
In-Reply-To: <20180109110356.25824-1-yasushi.shoji@gmail.com> (Yasushi SHOJI's
        message of "Tue, 9 Jan 2018 20:03:56 +0900")
Message-ID: <xmqqr2qy6esi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F403F8D0-F56E-11E7-A5DD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yasushi SHOJI <yasushi.shoji@gmail.com> writes:

> The commit f2fd0760f62e79609fef7bfd7ecebb002e8e4ced converted struct
> object to object_id but a debug function show_list(), which is
> ifdef'ed to noop, in bisect.c wasn't.
>
> So fix it.
>
> Signed-off-by: Yasushi SHOJI <Yasushi.SHOJI@gmail.com>
> ---

Thanks.  That's quite an old breakage ;-)



>  bisect.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 3756f127b..0dd0f289a 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -132,7 +132,7 @@ static void show_list(const char *debug, int counted, int nr,
>  		unsigned flags = commit->object.flags;
>  		enum object_type type;
>  		unsigned long size;
> -		char *buf = read_sha1_file(commit->object.sha1, &type, &size);
> +		char *buf = read_sha1_file(commit->object.oid.hash, &type, &size);
>  		const char *subject_start;
>  		int subject_len;
>  
> @@ -144,10 +144,10 @@ static void show_list(const char *debug, int counted, int nr,
>  			fprintf(stderr, "%3d", weight(p));
>  		else
>  			fprintf(stderr, "---");
> -		fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.sha1));
> +		fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.oid.hash));
>  		for (pp = commit->parents; pp; pp = pp->next)
>  			fprintf(stderr, " %.*s", 8,
> -				sha1_to_hex(pp->item->object.sha1));
> +				sha1_to_hex(pp->item->object.oid.hash));
>  
>  		subject_len = find_commit_subject(buf, &subject_start);
>  		if (subject_len)
