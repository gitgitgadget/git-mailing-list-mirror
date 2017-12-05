Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2733120A40
	for <e@80x24.org>; Tue,  5 Dec 2017 20:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbdLEUyg (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 15:54:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53816 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752387AbdLEUyg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 15:54:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B0B5C1FF1;
        Tue,  5 Dec 2017 15:54:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BxKhZLUHP+JpDQHHo62LSRwnrU8=; b=VW4ejo
        Hai7oXC4HphbFRsbCrBvcXg7URxDmZy87HbPw94rxN/zndWLJVkul12qyYfPlL79
        pL652xu+TGZPG3BMQJ38jYHrhqm5rP77/46AVPI9KU+eofp7oI92Brh8hUu5fb8O
        +24K//+n5hCkMP8c3On/vEfHm1zQlT/Lg+74Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gnZDewXBg4Gsamj9mb83ESGCvOh2Nv1P
        ouV6l7eCIbsdetmTW9XymWZCdbnHUJ0rREZTgvj73Gfcyx5ntfUmMBImSvkiX+lX
        sfhPT36W1zcwLR6cIns/8fTETYJ4GuvTromtkRTe7+LbZsnCkWbo9slyzfnLOEto
        ogWAppoTcPQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 531ACC1FF0;
        Tue,  5 Dec 2017 15:54:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9DFA6C1FEF;
        Tue,  5 Dec 2017 15:54:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        christian.couder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 09/12] fixup: sha1_file: convert gotos to break/continue
References: <20171205165854.64979-1-git@jeffhostetler.com>
        <20171205165854.64979-10-git@jeffhostetler.com>
Date:   Tue, 05 Dec 2017 12:54:33 -0800
In-Reply-To: <20171205165854.64979-10-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Tue, 5 Dec 2017 16:58:51 +0000")
Message-ID: <xmqqk1y0j3p2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FC4D5C4-D9FE-11E7-BC6A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  sha1_file.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)

The second (i.e. this) part and the third part are not yet in
'next', so it will perfectly be fine to squash these into the
commits that introduces the issues that are corrected in this
"fixup".  The same comment applies to all the other "fixup" patches.



>
> diff --git a/sha1_file.c b/sha1_file.c
> index fc7718a..ce67f27 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1180,30 +1180,30 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>  		}
>  	}
>  
> -retry:
> -	if (find_pack_entry(real, &e))
> -		goto found_packed;
> +	while (1) {
> +		if (find_pack_entry(real, &e))
> +			break;
>  
> -	/* Most likely it's a loose object. */
> -	if (!sha1_loose_object_info(real, oi, flags))
> -		return 0;
> +		/* Most likely it's a loose object. */
> +		if (!sha1_loose_object_info(real, oi, flags))
> +			return 0;
>  
> -	/* Not a loose object; someone else may have just packed it. */
> -	reprepare_packed_git();
> -	if (find_pack_entry(real, &e))
> -		goto found_packed;
> -
> -	/* Check if it is a missing object */
> -	if (fetch_if_missing && repository_format_partial_clone &&
> -	    !already_retried) {
> -		fetch_object(repository_format_partial_clone, real);
> -		already_retried = 1;
> -		goto retry;
> -	}
> +		/* Not a loose object; someone else may have just packed it. */
> +		reprepare_packed_git();
> +		if (find_pack_entry(real, &e))
> +			break;
>  
> -	return -1;
> +		/* Check if it is a missing object */
> +		if (fetch_if_missing && repository_format_partial_clone &&
> +		    !already_retried) {
> +			fetch_object(repository_format_partial_clone, real);
> +			already_retried = 1;
> +			continue;
> +		}
> +
> +		return -1;
> +	}
>  
> -found_packed:
>  	if (oi == &blank_oi)
>  		/*
>  		 * We know that the caller doesn't actually need the
