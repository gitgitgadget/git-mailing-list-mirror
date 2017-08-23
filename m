Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6420F20899
	for <e@80x24.org>; Wed, 23 Aug 2017 20:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932568AbdHWUKH (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 16:10:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61294 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932443AbdHWUKG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 16:10:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BC56A8B7B;
        Wed, 23 Aug 2017 16:10:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nL7yRJUybaj3XygCkZJO3euGGcU=; b=sMH2dE
        hgksdboC1HxzZGTTIMYIN1LX35ExbhDnL8kKzlKDTsW+2K7ViTK1kvGUrdKe7mg2
        Eg0a/2Z9KrfWmY5+QcnfF3WpCX6kQkn1SjthGkeBAr6pPPxJz61sxS3lhf9Q3oNo
        3YVv/DUT2qE4cLGdFCig+c/xSCvujDGYb/Q90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xubx65M6x+apSFo07CdrUDKL8hkByifo
        qs1XE4LV6P1O8DtooCwnCYjKtLAvDMv+z8o3gz7wPG2YIgGCn87bkZvOtHwjAQXB
        n2Q897iQwWm1X0mAuXPR3jxFLKYxRbquQT1Qv51P8s9jp5iERh1Imr/dUWrqRE9T
        RX3QAbG1vcU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EEE6A8B7A;
        Wed, 23 Aug 2017 16:10:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E136A8B70;
        Wed, 23 Aug 2017 16:10:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     <git@vger.kernel.org>, <peff@peff.net>
Subject: Re: [PATCH v3 1/4] imap-send: return with error if curl failed
References: <087f5907-6558-ce32-2f5c-2e418522c030@morey-chaisemartin.com>
        <da29995c-3c56-ac43-9f8f-12bf381711f3@morey-chaisemartin.com>
Date:   Wed, 23 Aug 2017 13:10:02 -0700
In-Reply-To: <da29995c-3c56-ac43-9f8f-12bf381711f3@morey-chaisemartin.com>
        (Nicolas Morey-Chaisemartin's message of "Tue, 22 Aug 2017 17:56:16
        +0200")
Message-ID: <xmqq378iyrj9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D49EEA0-883F-11E7-BEB8-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:

> curl_append_msgs_to_imap always returned 0, whether curl failed or not.
> Return a proper status so git imap-send will exit with an error code
> if womething wrong happened.

womething?  No need to resend only to fix if this is typo s/wome/some/.

>
> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
> ---
>  imap-send.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index b2d0b849b..09f29ea95 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1490,7 +1490,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
>  	curl_easy_cleanup(curl);
>  	curl_global_cleanup();
>  
> -	return 0;
> +	return res == CURLE_OK;
>  }
>  #endif
