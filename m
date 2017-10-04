Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B5E82036B
	for <e@80x24.org>; Wed,  4 Oct 2017 05:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbdJDFAX (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 01:00:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59406 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750909AbdJDFAW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 01:00:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D009A0C22;
        Wed,  4 Oct 2017 01:00:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S7W5ZdzHyFIMEFWCtlXF4WgRhms=; b=V2+VLh
        2rowt3utb04ysDmDXLpwFBcu2iwLmPM3yRpBJBQPz/943Bjv5sBNsrlp3MWGpXH8
        B4LUVIhfuBvO8aqWZ9Su0TwwemDUMWG5JlR53OZcsmgL6En+H7ym8GpsENUvP4dO
        ox2a/lwTxGRQGTpiQ5HEF7aB/pY5WrJwGQGfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RCLTtad3YZxP6WAf8IStKYScJ1H+apr7
        oGCBicgx785VrVuzmz/V4nrCETHTfyataM797W/Z800qR7BtNYZM42jn+dv8iGL6
        1iyp0Dg+QseqpYtSdPSHigI46b8C8XDholWkLQ9EqF4j/dZWXRl1389iUvKuIdWu
        MGnb9G0HdE4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7428CA0C20;
        Wed,  4 Oct 2017 01:00:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66868A0C11;
        Wed,  4 Oct 2017 01:00:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] strbuf doc: reuse after strbuf_release is fine
References: <20171003214646.GZ19555@aiede.mtv.corp.google.com>
        <20171003221740.26325-1-sbeller@google.com>
        <20171003222414.GC19555@aiede.mtv.corp.google.com>
        <20171003234919.qsr54ncmw6cihowi@sigill.intra.peff.net>
        <20171004023954.GK19555@aiede.mtv.corp.google.com>
Date:   Wed, 04 Oct 2017 14:00:08 +0900
In-Reply-To: <20171004023954.GK19555@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 3 Oct 2017 19:39:54 -0700")
Message-ID: <xmqq376zecdj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6053CEE-A8C0-11E7-A70F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> strbuf_release leaves the strbuf in a valid, initialized state, so
> there is no need to call strbuf_init after it.
>
> Moreover, this is not likely to change in the future: strbuf_release
> leaving the strbuf in a valid state has been easy to maintain and has
> been very helpful for Git's robustness and simplicity (e.g.,
> preventing use-after-free vulnerabilities).
>
> Document the semantics so the next generation of Git developers can
> become familiar with them without reading the implementation.  It is
> still not advisable to call strbuf_release too often because it is
> wasteful, so add a note pointing to strbuf_reset for that.
>
> The same semantics apply to strbuf_detach.  Add a similar note to its
> docstring to make that clear.
>
> Improved-by: Jeff King <peff@peff.net>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Jeff King wrote:
>
>> I think it's actually OK to use the string buffer after this function.
>> It's just an empty string.
>>
>> Perhaps we should be more explicit: this releases any resources and
>> resets to a pristine, empty state. I suspect strbuf_detach() probably
>> should make the same claim.
>
> Like this?

Looks good to me.


>
> Thanks,
> Jonathan
>
>  strbuf.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/strbuf.h b/strbuf.h
> index 7496cb8ec5..249df86711 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -82,8 +82,12 @@ extern char strbuf_slopbuf[];
>  extern void strbuf_init(struct strbuf *, size_t);
>  
>  /**
> - * Release a string buffer and the memory it used. You should not use the
> - * string buffer after using this function, unless you initialize it again.
> + * Release a string buffer and the memory it used. After this call, the
> + * strbuf points to an empty string that does not need to be free()ed, as
> + * if it had been set to `STRBUF_INIT` and never modified.
> + *
> + * To clear a strbuf in preparation for further use without the overhead
> + * of free()ing and malloc()ing again, use strbuf_reset() instead.
>   */
>  extern void strbuf_release(struct strbuf *);
>  
> @@ -91,6 +95,9 @@ extern void strbuf_release(struct strbuf *);
>   * Detach the string from the strbuf and returns it; you now own the
>   * storage the string occupies and it is your responsibility from then on
>   * to release it with `free(3)` when you are done with it.
> + *
> + * The strbuf that previously held the string is reset to `STRBUF_INIT` so
> + * it can be reused after calling this function.
>   */
>  extern char *strbuf_detach(struct strbuf *, size_t *);
