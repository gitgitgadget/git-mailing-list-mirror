Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B947620A40
	for <e@80x24.org>; Mon, 27 Nov 2017 04:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751136AbdK0Efj (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 23:35:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57799 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751045AbdK0Efi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 23:35:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9C3CBBEE4;
        Sun, 26 Nov 2017 23:35:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KOmRtHPA2ZgZ82g5fKM7aCK3zik=; b=UjVfyc
        VVBsgzRfJOc1+Iu8KcSI03mcglGyywClqiuvTodcJorv0+83csppyhoXXajzZsDr
        N8KFMF3BU+Q8D40bz42utVfvjQ2sTv6yf3Oc+Kn5ZKN1H2cJSLCY36fHKyb0RVWo
        JsKeZZRjaywlhNFGSE9HjVNhoIorol4caB5NU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=opl1XS7Q3FpthwM1RmINfHOVqY4jCEBg
        /DpoKKaTaWo7TmLeb9Nxz7DATlmIEHodFV+5RrWKWNLeRpHPjZUqflzMUdDB+q3K
        hthxA9cY8+6oAoskoaVoRwdUp0K2Wic2A68zT4Ws1gX7KoONKg1phJCXl0fXeLQA
        djxOs/DyDpM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F381BBEE2;
        Sun, 26 Nov 2017 23:35:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E907BBEE0;
        Sun, 26 Nov 2017 23:35:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Takuto Ikuta <tikuta@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use OBJECT_INFO_QUICK to speedup git fetch-pack
References: <0102015ffbbb2905-570eadd1-6b5c-46af-a3a9-bddfbd01c242-000000@eu-west-1.amazonses.com>
Date:   Mon, 27 Nov 2017 13:35:35 +0900
In-Reply-To: <0102015ffbbb2905-570eadd1-6b5c-46af-a3a9-bddfbd01c242-000000@eu-west-1.amazonses.com>
        (Takuto Ikuta's message of "Mon, 27 Nov 2017 04:27:47 +0000")
Message-ID: <xmqqo9noe3u0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A2C3992-D32C-11E7-97DD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Takuto Ikuta <tikuta@google.com> writes:

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 008b25d3db087..0184584e80599 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -716,7 +716,7 @@ static int everything_local(struct fetch_pack_args *args,
>  	for (ref = *refs; ref; ref = ref->next) {
>  		struct object *o;
>  
> -		if (!has_object_file(&ref->old_oid))
> +		if (!has_object_file_with_flags(&ref->old_oid, OBJECT_INFO_QUICK))
>  			continue;
>  

It appears that great minds think alike?

cf. https://public-inbox.org/git/20171120202920.7ppcwmzkxifywtoj@sigill.intra.peff.net/

The 5-patch series that contains the same change as this one is
cooking and will hopefully be in the released version before the end
of the year.


