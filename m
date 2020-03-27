Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D70CC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 15:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D00206F2
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 15:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="YAvd44ZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgC0PRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:17:45 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52955 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgC0PRo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 11:17:44 -0400
Received: by mail-pj1-f66.google.com with SMTP id ng8so4000175pjb.2
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Ci3ngf8L9wx88mHnTO7Jey05A3t1C/uihLInQK0t+A=;
        b=YAvd44ZUNa3acYYK1sfBQufMVdyS25/erEoopc4vwEa0O1gkl6rZDTQBMu3sL+lc0r
         OO4oTlmSIwnND9E4UnZmaOsiyMW133JJRtccIP8NRYfo8RG/MpO+zmw+w+7OcrwcijjE
         W5Mem0SI1WVKZeQm7E+rmccIz8PUARW20Y9/IR5B3yhZDVYHO70q5v3NWy1TkLT8n78f
         VIAY7XJk+ThHi0hLQlMQQT8p/2AsGQeMiMLWw8LphLtiaIF2d7cZfhi3lXB6RSHLggMi
         wg1WP05UTv9EPzp17RUnuhYogw8EntdRB/KXYKjZ8chWltGMPMn6iSRPPfJHz+vr4mnS
         JWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Ci3ngf8L9wx88mHnTO7Jey05A3t1C/uihLInQK0t+A=;
        b=HWOQGpFN2ayo3wACWHgjBjmOaoPxa+vNnTzeZlMGfnqFIVB7qYd4qx8r16HDac8XAP
         05fpd27WYBpZEBgUieDSfGFE33CinHZqFzvGYzCSzzCrzQjSjZkCwbYFLHpAPBlNrbqq
         84PcZB5ikucjhFy6SOcgqXsKq5YyYBwlDIC8gtB32w5UyR3mEaF4U/mmcTcsHIIrNb5i
         4LCHisEw87TzRRpKGfwK5T7U7kemcVxS2rcTP1xFmLf5bmXwLm7S/ozAngoAgkaJoAhG
         Ai5wobLxtqupaG1xyrhVaTssJjPxv++q23kp6UTjtf921bf35Ta+q461UYl2a8AJAX1B
         ZjhQ==
X-Gm-Message-State: ANhLgQ3trMJ9AiIy5m9wv7WFOaeVujrgaAA1b5HvbZrHCIRV8W6a1MMi
        D+D59gDTXi5HxIQIV5iJPqX3pA==
X-Google-Smtp-Source: ADFU+vtrmxNB/lQ+4ah4G4kBxF9S6+/yBywDbLRSN3Nj6ZwOVSpzEYkQq7DatME5uwDTmq9Cq9NLEg==
X-Received: by 2002:a17:90a:3ad0:: with SMTP id b74mr6800536pjc.58.1585322261279;
        Fri, 27 Mar 2020 08:17:41 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id m12sm3963604pjf.25.2020.03.27.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:17:40 -0700 (PDT)
Date:   Fri, 27 Mar 2020 09:17:39 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] upload-pack: handle unexpected delim packets
Message-ID: <20200327151739.GB30419@syl.local>
References: <20200327080210.GA604725@coredump.intra.peff.net>
 <20200327080338.GB605934@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200327080338.GB605934@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 04:03:38AM -0400, Jeff King wrote:
> When processing the arguments list for a v2 ls-refs or fetch command, we
> loop like this:
>
>   while (packet_reader_read(request) != PACKET_READ_FLUSH) {
>           const char *arg = request->line;
> 	  ...handle arg...
>   }
>
> to read and handle packets until we see a flush. The hidden assumption
> here is that anything except PACKET_READ_FLUSH will give us valid packet
> data to read. But that's not true; PACKET_READ_DELIM or PACKET_READ_EOF
> will leave packet->line as NULL, and we'll segfault trying to look at
> it.
>
> Instead, we should follow the more careful model demonstrated on the
> client side (e.g., in process_capabilities_v2): keep looping as long
> as we get normal packets, and then make sure that we broke out of the
> loop due to a real flush. That fixes the segfault and correctly
> diagnoses any unexpected input from the client.

This is a very clean fix, thank you.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  ls-refs.c                      |  5 ++++-
>  t/t5704-protocol-violations.sh | 33 +++++++++++++++++++++++++++++++++
>  upload-pack.c                  |  5 ++++-
>  3 files changed, 41 insertions(+), 2 deletions(-)
>  create mode 100755 t/t5704-protocol-violations.sh
>
> diff --git a/ls-refs.c b/ls-refs.c
> index 818aef70a0..50d86866c6 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -93,7 +93,7 @@ int ls_refs(struct repository *r, struct argv_array *keys,
>
>  	git_config(ls_refs_config, NULL);
>
> -	while (packet_reader_read(request) != PACKET_READ_FLUSH) {
> +	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
>  		const char *arg = request->line;
>  		const char *out;
>
> @@ -105,6 +105,9 @@ int ls_refs(struct repository *r, struct argv_array *keys,
>  			argv_array_push(&data.prefixes, out);
>  	}
>
> +	if (request->status != PACKET_READ_FLUSH)
> +		die(_("expected flush after ls-refs arguments"));
> +

...and it's implemented faithfully here. Thanks.

>  	head_ref_namespaced(send_ref, &data);
>  	for_each_namespaced_ref(send_ref, &data);
>  	packet_flush(1);
> diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
> new file mode 100755
> index 0000000000..950cfb21fe
> --- /dev/null
> +++ b/t/t5704-protocol-violations.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +
> +test_description='Test responses to violations of the network protocol. In most
> +of these cases it will generally be acceptable for one side to break off
> +communications if the other side says something unexpected. We are mostly
> +making sure that we do not segfault or otherwise behave badly.'
> +. ./test-lib.sh
> +
> +test_expect_success 'extra delim packet in v2 ls-refs args' '
> +	{
> +		packetize command=ls-refs &&
> +		printf 0001 &&
> +		# protocol expects 0000 flush here
> +		printf 0001
> +	} >input &&
> +	test_must_fail env GIT_PROTOCOL=version=2 \
> +		git upload-pack . <input 2>err &&
> +	test_i18ngrep "expected flush after ls-refs arguments" err
> +'
> +
> +test_expect_success 'extra delim packet in v2 fetch args' '
> +	{
> +		packetize command=fetch &&
> +		printf 0001 &&
> +		# protocol expects 0000 flush here
> +		printf 0001
> +	} >input &&
> +	test_must_fail env GIT_PROTOCOL=version=2 \
> +		git upload-pack . <input 2>err &&
> +	test_i18ngrep "expected flush after fetch arguments" err
> +'
>
> +test_done
> diff --git a/upload-pack.c b/upload-pack.c
> index c53249cac1..902d0ad5e1 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1252,7 +1252,7 @@ static void process_args(struct packet_reader *request,
>  			 struct upload_pack_data *data,
>  			 struct object_array *want_obj)
>  {
> -	while (packet_reader_read(request) != PACKET_READ_FLUSH) {
> +	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
>  		const char *arg = request->line;
>  		const char *p;
>
> @@ -1321,6 +1321,9 @@ static void process_args(struct packet_reader *request,
>  		/* ignore unknown lines maybe? */
>  		die("unexpected line: '%s'", arg);
>  	}
> +
> +	if (request->status != PACKET_READ_FLUSH)
> +		die(_("expected flush after fetch arguments"));
>  }

...and here, too :).

>  static int process_haves(struct oid_array *haves, struct oid_array *common,
> --
> 2.26.0.581.g322f77c0ee

Thanks,
Taylor
