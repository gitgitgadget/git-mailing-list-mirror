Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C69B1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 03:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbeKLNly (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 08:41:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59141 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbeKLNlx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 08:41:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02B3B2E6B9;
        Sun, 11 Nov 2018 22:50:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ciEJ2veB/ybp+MNtBMq7ji8yJiY=; b=OAxLU+
        mUkaqe7kiM9B+xTYOVenuyvxa5Tcl0WfHS3f0RRYSDsm3FsUcAm/BvlIG7/y0CG3
        Bfl8iUbZRS7uXukw21h/vq8VLffFHeE1ORC5sw6NDproWhIvFxqGPilQXe3W3CKY
        CwzwBQ4ap2Sk5F0CCaAE7aWdsMc9oUviC/2Sk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QmjXB0K11r/PKsp7D+qnNXq/tgt9n9D8
        7BJXalX5R3Fd3UYvGzZQgAlh7pLRGu71ZRnRNUE4ko/iPawc2wLhn5xljc+ugVqG
        9QQhn3glK4OZqvf6PB+xbON17TRWuN76MTAD5ULyonm/CdLTzvXpBBayQcb63ZBF
        iTtVaEtNkHs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EFA542E6B7;
        Sun, 11 Nov 2018 22:50:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 12D382E6B6;
        Sun, 11 Nov 2018 22:50:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] remote-curl.c: xcurl_off_t is not portable (on 32 bit platfoms)
References: <20181025161310.29249-1-tboegi@web.de>
        <20181109174110.27630-1-tboegi@web.de>
Date:   Mon, 12 Nov 2018 12:50:30 +0900
In-Reply-To: <20181109174110.27630-1-tboegi@web.de> (tboegi's message of "Fri,
        9 Nov 2018 18:41:10 +0100")
Message-ID: <xmqqbm6v3qex.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B9C054E-E62E-11E8-BD88-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

>
> This is a re-semd, the orignal patch was part of a 2
> patch-series.
> This patch needed some rework, and here should be
> the polished version.

Will queue.  Next time, please refrain from saying "re-send", if you
changed anything in the patch (or the log message), as the phrase
implies you are sending the same thing as before (just in case the
earlier one was not seen, for example).  Marking it as vN+1 like you
did for this patch and having a reference to the original would make
it clear, though ;-)

Thanks.

> remote-curl.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 762a55a75f..1220dffcdc 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -617,10 +617,11 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
>  	return err;
>  }
>  
> -static curl_off_t xcurl_off_t(ssize_t len) {
> -	if (len > maximum_signed_value_of_type(curl_off_t))
> +static curl_off_t xcurl_off_t(size_t len) {
> +	uintmax_t size = len;
> +	if (size > maximum_signed_value_of_type(curl_off_t))
>  		die("cannot handle pushes this big");
> -	return (curl_off_t) len;
> +	return (curl_off_t)size;
>  }
>  
>  static int post_rpc(struct rpc_state *rpc)
