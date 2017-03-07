Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B8F1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 23:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756255AbdCGXDe (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 18:03:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61857 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755194AbdCGXDd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 18:03:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 936E180E56;
        Tue,  7 Mar 2017 17:56:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hg5HXPcpHLsSdV+vC5k8DhDsaMs=; b=st6ici
        C/x79JOihAz2GAeFmxN9CbAW/HsVyDztvMrTrSc5MsjQqLhZV+KLUOCrfFF4Qntc
        /KLFdp8wwC1LF3kiP/BxS7guZdDcqSeoJsGQdzleHpCcPBDExdsyI0MoYoPu9e1O
        k8NdsWwzefeDkU2HL7v2i6D7YqW9p0nVxSEms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Aw3jj+Pc78JVU4ukdSTfQgWBJMPljGVK
        +m5Zjn8So+EP7WMQlazyRpUwiMiKFaKVtyq2t+c8WmO6yqM/b5qWRqnc5LAq4VZ/
        tv57UQEFJGuZIX6ek/XgfAftQq4V136Y9YBmU4Syxcq+aqtUs3W6S+tOO5YEehBE
        bCCVwtvD6rI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BC4480E55;
        Tue,  7 Mar 2017 17:56:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F200D80E54;
        Tue,  7 Mar 2017 17:56:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Horst Schirmeier <horst@schirmeier.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/6] send-pack: improve unpack-status error messages
References: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
        <20170307133736.4lpn7mgme26dqs3m@sigill.intra.peff.net>
Date:   Tue, 07 Mar 2017 14:56:27 -0800
In-Reply-To: <20170307133736.4lpn7mgme26dqs3m@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 7 Mar 2017 08:37:36 -0500")
Message-ID: <xmqq37eo66hw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CAEED88-0389-11E7-86BD-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When the remote tells us that the "unpack" step failed, we
> show an error message. However, unless you are familiar with
> the internals of send-pack and receive-pack, it was not
> clear that this represented an error on the remote side.
> Let's re-word to make that more obvious.
>
> Likewise, when we got an unexpected packet from the other
> end, we complained with a vague message but did not actually
> show the packet.  Let's fix that.

Both make sense.

> And finally, neither message was marked for translation. The
> message from the remote probably won't be translated, but
> there's no reason we can't do better for the local half.

Hmm, OK.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  send-pack.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/send-pack.c b/send-pack.c
> index 243633da1..83c23aef6 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -134,9 +134,9 @@ static int receive_unpack_status(int in)
>  {
>  	const char *line = packet_read_line(in, NULL);
>  	if (!skip_prefix(line, "unpack ", &line))
> -		return error("did not receive remote status");
> +		return error(_("unable to parse remote unpack status: %s"), line);
>  	if (strcmp(line, "ok"))
> -		return error("unpack failed: %s", line);
> +		return error(_("remote unpack failed: %s"), line);
>  	return 0;
>  }
