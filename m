Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9391F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 01:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbeKTMZg (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 07:25:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58436 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730044AbeKTMZf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 07:25:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3A6E27305;
        Mon, 19 Nov 2018 20:58:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BOTdgNB/lyVUFj+UImzpi0wSim0=; b=ZelRfC
        nEGDZOlQyY9gu8Fq7B39kWUiiEsWHdtRDdaDt34aQ10emY3yyhy12w9+pUwiiVZ0
        U1lflrfGNEifivCvTJwKzPubnnSzvU3sSu1J3+ZIm50DuXU7eLRFfmSicRkcSbKw
        BT7VTZ/rNYgnC0yZ6srFTNKGs+C0JTRwqJfH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uG+bEmiQe1uiQ5Q0F+PWkRfQRdHJSEXV
        URLFpm57LA08DvsPMIu7XaKxTl4a5eDDarvLeD7EL6dKVfUZRsmHf7OjpMCo1UEU
        EH83/mE6SGfsClE3MVp7ts/h2SfBtRbtjGkg279AvfOJNDgVntAoeSAoKerfzfQS
        /3nEQTUBBvk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ADAFE27302;
        Mon, 19 Nov 2018 20:58:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B965F27301;
        Mon, 19 Nov 2018 20:58:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sven Strickroth <email@cs-ware.de>
Cc:     git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] msvc: Directly use MS version (_stricmp) of strcasecmp
References: <ad85731f-2c47-f455-c9d3-d47a5fj1e29@cs-ware.de>
        <20181118215820.GA14514@sigill.intra.peff.net>
        <xmqqk1l9esey.fsf@gitster-ct.c.googlers.com>
        <15a7df69-25d8-c168-dd43-a43b7f0d34c1@cs-ware.de>
Date:   Tue, 20 Nov 2018 10:58:50 +0900
In-Reply-To: <15a7df69-25d8-c168-dd43-a43b7f0d34c1@cs-ware.de> (Sven
        Strickroth's message of "Mon, 19 Nov 2018 16:14:42 +0100")
Message-ID: <xmqqefbgcxwl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D49E7326-EC67-11E8-A62B-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sven Strickroth <email@cs-ware.de> writes:

> This also removes an implicit conversion from size_t (unsigned) to int (signed).
>
> _stricmp as well as _strnicmp are both available since VS2012.
>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---
>  compat/msvc.h | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Will apply, thanks.

The substition from ftello with _ftelli64 does not appear in our
codebase yet, but it was easy enough to adjust the patch myself, so
no need to resend this patch.

> diff --git a/compat/msvc.h b/compat/msvc.h
> index e6e1a6bbf7..2d558bae14 100644
> --- a/compat/msvc.h
> +++ b/compat/msvc.h
> @@ -14,18 +14,12 @@
>  #define inline __inline
>  #define __inline__ __inline
>  #define __attribute__(x)
> +#define strcasecmp   _stricmp
>  #define strncasecmp  _strnicmp
>  #define ftruncate    _chsize
>  #define strtoull     _strtoui64
>  #define strtoll      _strtoi64
>  
> -static __inline int strcasecmp (const char *s1, const char *s2)
> -{
> -	int size1 = strlen(s1);
> -	int sisz2 = strlen(s2);
> -	return _strnicmp(s1, s2, sisz2 > size1 ? sisz2 : size1);
> -}
> -
>  #undef ERROR
>  
>  #define ftello _ftelli64
