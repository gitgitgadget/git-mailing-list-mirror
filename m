Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4BBF1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbfHZSKA (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:10:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50238 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730228AbfHZSKA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:10:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43E51177B75;
        Mon, 26 Aug 2019 14:09:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9DhNiBJ4MvFTJouypokYKNdy68U=; b=gJS8qJ
        emGIRVDSBxC7VNd6H0A1jSnfXVJ8LoPxvplPvkfns405RhpkwdZtO6/t8NY3edPU
        XG/aUn9OmdE2ZQ3/gUy6+3bOchMCgjnap9/aIWPcFVgZp/t17S/dF+5V3OrP0N0U
        LDf6pPhymdjCM+79M2ONtc2F0vTCdSRQkkxiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dw6Nj2XvQVdDcCkXdtFj4sN/dgckRHK0
        kI1dEFZB+6ea/hedgrWIWHa1pQ6rl814xFAkakLPmjXKZT8oXSa//bTorjgPqXDO
        fsykZ4qChwY4PLTF7be8DZeeQFVwvhkSz5VQ6zaqoZloRQFMJIOXGNjPE616XB2Y
        smKm4ynX0HA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3988C177B74;
        Mon, 26 Aug 2019 14:09:58 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8BDF7177B73;
        Mon, 26 Aug 2019 14:09:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http: don't leak urlmatch_config.vars
References: <20190826074911.23792-1-mh@glandium.org>
Date:   Mon, 26 Aug 2019 11:09:56 -0700
In-Reply-To: <20190826074911.23792-1-mh@glandium.org> (Mike Hommey's message
        of "Mon, 26 Aug 2019 16:49:11 +0900")
Message-ID: <xmqqblwbhk7f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B667A818-C82C-11E9-9D72-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  http.c | 1 +
>  1 file changed, 1 insertion(+)

This matches what builtin/config.c::get_urlmatch() does, which makes
sense.

Thanks.

>
> diff --git a/http.c b/http.c
> index 27aa0a3192..9e33584f2d 100644
> --- a/http.c
> +++ b/http.c
> @@ -1073,6 +1073,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  
>  	git_config(urlmatch_config_entry, &config);
>  	free(normalized_url);
> +	string_list_clear(&config.vars, 1);
>  
>  #if LIBCURL_VERSION_NUM >= 0x073800
>  	if (http_ssl_backend) {
