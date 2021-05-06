Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AABFC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 08:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E4E661166
	for <git@archiver.kernel.org>; Thu,  6 May 2021 08:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhEFIrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 04:47:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55331 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhEFIrO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 04:47:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E98CC0751;
        Thu,  6 May 2021 04:46:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=030FQp8319KwA10NDmFh536esMNq2SKDsv8Jk5
        urSlw=; b=YHGw55RSk7nGThSy2XSCs2N1PD5Hc6aKLy8tbGljAAzHL/rukkpyOr
        ZBVWrl+eOgsNO+10q4aMB0eRjzLkdlb0xnREDlAsP5jFclAJfpHGOYoxJbJ2ym04
        NPTSyGKKQJtj1YDlf9w3BKx1ApM0XXE2HgBJLHASme5US0AhuJ5vY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56DCAC0750;
        Thu,  6 May 2021 04:46:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CEE6AC074F;
        Thu,  6 May 2021 04:46:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Fix a small flaw in the comment of strmap.h
References: <20210506081936.29887-1-dyroneteng@gmail.com>
Date:   Thu, 06 May 2021 17:46:15 +0900
In-Reply-To: <20210506081936.29887-1-dyroneteng@gmail.com> (Teng Long's
        message of "Thu, 6 May 2021 16:19:36 +0800")
Message-ID: <xmqq35v0z1uw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84C9BDB6-AE47-11EB-9B1C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Subject: Re: [PATCH] Fix a small flaw in the comment of strmap.h

cf. Documentation/SubmittingPatches::summary-section

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  strmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/strmap.h b/strmap.h
> index 1e152d832d..0d1d00d14e 100644
> --- a/strmap.h
> +++ b/strmap.h
> @@ -78,7 +78,7 @@ struct strmap_entry *strmap_get_entry(struct strmap *map, const char *str);
>  void *strmap_get(struct strmap *map, const char *str);
>  
>  /*
> - * Return non-zero iff "str" is present in the map. This differs from
> + * Return non-zero if "str" is present in the map. This differs from

The original is correct; this function returns a non-zero value if
and only if (iff is a common abbreviation for this expression) "str"
is in the map, implying that when "str" is not in the map, the
caller can rest assured that the function will not return a non-zero
value (in other words, the caller is guaranteed to receive zero).

If you change that to "if", the comment no longer says what happens
when "str" is *not* present in the map, which is making it worse.
