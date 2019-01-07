Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A8A91F803
	for <e@80x24.org>; Mon,  7 Jan 2019 19:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfAGTBR (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 14:01:17 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36134 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbfAGTBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 14:01:16 -0500
Received: by mail-pg1-f202.google.com with SMTP id 143so603945pgc.3
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 11:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rmrXafvKPcy4KVusyVH7Im5UfMqi94svK7kT5WYZxOI=;
        b=b810PSa77Mcl/LV/GUzGPVRonCX4ED2M67mA5fxNDpYmLbbiQ3iNPOPOEfmhDJ5JVq
         683QaNfnR/V58e1tzTHRi8i36PnBvA9CH86COuT9TKOUsxFdTORrWckvzahdunpLFcYx
         toks8jqcHl0hUdPfU46Dn5F1JRDmPIQ5qXj0W+bzbgBNclsZn8WG9nZKHIlERAz9ppdT
         MbGwqFwEhggd05+t1pzbEevdjBZaLToShXHa6F04UNNuz4GxQ04njncMho5ppQVHke42
         VRSoc/Rqwh35VAfehFqgHHQcB9UPRF22FO5FgItTvMmJiMyAx+49kC7xCfzVmdB1UZaQ
         /s3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rmrXafvKPcy4KVusyVH7Im5UfMqi94svK7kT5WYZxOI=;
        b=cVDVX4Vjrz+W1feWznGJzMaTAR0wgZm/XjkPr5vL9eYBSIsvKu2LGLpRw+92OSLeCJ
         qQ6/MAE10LevPvJV9wPZ7Geuq22qDjXCzmwJxbRF7zejFCEJFrG2u49d4LcL20BB7CMl
         NgOS/6Yy+TppcnIPLs+Mzz6xMX0+iixsVREIv50U+MXX/Rvt3FGGATm9zNcVu0L5rclT
         Wzo+KxHzED8pzf5g2AOFxpf7XKPPJjdei1dEn6wXYDVq+uxgYVl10hfCuTxidouaVTQF
         VyDgrzz2/+hUn5Xxj6HuprtRHdHUDgLGJHEudHhMWebE0Ac0e6u9LUZ5wJpCP6rtiaR4
         xyxQ==
X-Gm-Message-State: AA+aEWbDaRZAd7fKgFHw4QnIRABoDylmenQTnwXXGxAcCxv682LJud96
        kyHk4ohALvFi5K7jjfPiZHO++Hre4foTNqIjJLI6
X-Google-Smtp-Source: AFSGD/Xlne2hg7+8deEDa2PbtkH8tRKqn8GWvHcxKcctKCK9ESee3bmFtipkEyyaXIhmnIDEKLwzHpx+jem8ugX5dk4w
X-Received: by 2002:a62:131b:: with SMTP id b27mr28169322pfj.82.1546887675297;
 Mon, 07 Jan 2019 11:01:15 -0800 (PST)
Date:   Mon,  7 Jan 2019 11:01:11 -0800
In-Reply-To: <20181229211915.161686-2-masayasuzuki@google.com>
Message-Id: <20190107190111.227874-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181229211915.161686-2-masayasuzuki@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v2 1/2] Use packet_reader instead of packet_read_line
From:   Jonathan Tan <jonathantanmy@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, peff@peff.net, steadmon@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> By using and sharing a packet_reader while handling a Git pack protocol
> request, the same reader option is used throughout the code. This makes
> it easy to set a reader option to the request parsing code.

I see that packet_read() and packet_read_line_buf() invocations are also
removed, so it might be better to use "Use packet_reader instead of
packet_read.*" as the commit title.

The code looks correct to me - most of the changes are removals of
packet_read_line(), replaced with a packet_reader that has
PACKET_READ_CHOMP_NEWLINE. One instance is packet_read(), for which the
corresponding reader does not have PACKET_READ_CHOMP_NEWLINE (noted
below); and another instance is packet_read_line_buf(), for which the
corresponding reader is instantiated accordingly with the buffer (also
noted below).

> -		if (!strcmp(line, "push-cert")) {
> +		if (!strcmp(reader->line, "push-cert")) {
>  			int true_flush = 0;
> -			char certbuf[1024];
> +			int saved_options = reader->options;
> +			reader->options &= ~PACKET_READ_CHOMP_NEWLINE;
>  
>  			for (;;) {
> -				len = packet_read(0, NULL, NULL,
> -						  certbuf, sizeof(certbuf), 0);
> -				if (!len) {
> +				packet_reader_read(reader);
> +				if (reader->status == PACKET_READ_FLUSH) {
>  					true_flush = 1;
>  					break;
>  				}
> -				if (!strcmp(certbuf, "push-cert-end\n"))
> +				if (reader->status != PACKET_READ_NORMAL) {
> +					die("protocol error: got an unexpected packet");
> +				}
> +				if (!strcmp(reader->line, "push-cert-end\n"))
>  					break; /* end of cert */
> -				strbuf_addstr(&push_cert, certbuf);
> +				strbuf_addstr(&push_cert, reader->line);
>  			}
> +			reader->options = saved_options;

Here, packet_read() is used, so we shouldn't chomp the newline, so this
is correct.

> -		char *line;
> +		struct packet_reader reader;
> +		packet_reader_init(&reader, -1, last->buf, last->len,
> +				   PACKET_READ_CHOMP_NEWLINE);
>  
>  		/*
>  		 * smart HTTP response; validate that the service
>  		 * pkt-line matches our request.
>  		 */
> -		line = packet_read_line_buf(&last->buf, &last->len, NULL);
> -		if (!line)
> +		if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
>  			die("invalid server response; expected service, got flush packet");
>  
>  		strbuf_reset(&exp);
>  		strbuf_addf(&exp, "# service=%s", service);
> -		if (strcmp(line, exp.buf))
> -			die("invalid server response; got '%s'", line);
> +		if (strcmp(reader.line, exp.buf))
> +			die("invalid server response; got '%s'", reader.line);
>  		strbuf_release(&exp);
>  
>  		/* The header can include additional metadata lines, up
>  		 * until a packet flush marker.  Ignore these now, but
>  		 * in the future we might start to scan them.
>  		 */
> -		while (packet_read_line_buf(&last->buf, &last->len, NULL))
> -			;
> +		for (;;) {
> +			packet_reader_read(&reader);
> +			if (reader.pktlen <= 0) {
> +				break;
> +			}
> +		}
> +
> +		last->buf = reader.src_buffer;
> +		last->len = reader.src_len;

And here, packet_reader_init() correctly initializes the packet_reader
with the buffer, and we need to know where in the buffer to continue
after parsing the additional metadata lines and the packet flush, so we
assign the state of the reader to last->buf and last->len.

(Incidentally, with this change, there is no longer any usage of
packet_read_line_buf(), but we can remove that in a subsequent patch.)

In summary, this looks like a good change. Configuration of reader
metadata (file descriptors, input buffers, and flags) is now more
centralized, and there are fewer file descriptor constants and variables
(which all look like ints) strewn around.
