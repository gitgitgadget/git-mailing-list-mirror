Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75BC21F404
	for <e@80x24.org>; Thu,  1 Mar 2018 20:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161694AbeCAUss (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 15:48:48 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44923 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161630AbeCAUsr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 15:48:47 -0500
Received: by mail-wr0-f196.google.com with SMTP id v65so7960404wrc.11
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 12:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rkLqxPU01uQFomAfztjhpIPzIT1tF39DUmJJj+HbfQk=;
        b=XlmK11DNLjzqz1qSwKgk2+FGmr4Lcszo5CN4bdrDcECgxDsE7H+MdgVhzojOGcqwRZ
         ZJ4tC7sAJsNQjfI8ZK3lB61I9bbc/4jItA2iTxchDw3S0tGDnbAL0Em1NyaiNhy4guSP
         iURMIBMi9sxdmS1RXeJxLqCu7WAh4+GeDdd8ld7/QWPCnGbHZ1tDaMQNPQRUXPQbjjPV
         RylHsAEMEyIuDJY0FRk8bD4lpTnrHh0lLyFNDY0MCIKVl2+klDkLxQU8kX3PagfO6kDE
         r0UbLOvoAFD2xEhxQqBJxUPPBDjBar1Mja5B/YCl5mbDbjK1kI9PasM93IIogaLLn05n
         53Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rkLqxPU01uQFomAfztjhpIPzIT1tF39DUmJJj+HbfQk=;
        b=F2mIWHpywxSN7QTtW+m/IhjKElgEuq/01kmCOXlHziLg5u2uek4f26NN4UaLs+vDsz
         eZW+o0xNIpXzyinaFNJAzjn50hFrkvgLTjo9/sPMRNsTjrnTRenMQsEk4iLEEe6tRcbQ
         NBrNQSzmi6eVV3zRzNjBMiZ2Wp3HwYUWxgkGaXc7IIztYWOlsM92J08/Bp8aw+AtCuGB
         DAbRwv2/ZtWiGyRVE4jCu6LpUr19CuC3rLjtAz7Y1QxGcDnbGLVMH+UcO8E7v9wXHqIA
         Q1uO0M/jBQkCQ8QwAGW3IkU99gHGPaeEunNyWA5MkopPEV1XB8t5t5vUdUVDEz62w81f
         y+3w==
X-Gm-Message-State: APf1xPA7/2S5hPKg7T2M5XQNswgg5UZrX6B5SmCmvboNHlRfVE7CeQLK
        opob0VVorDSpnfdXLB9CbxA5HIaR
X-Google-Smtp-Source: AG47ELtG2/pACuQtAaHP/lDN4ZVPzd7nxOeY+RVUQIje6+QmoZStNGAjcKoUdLciodGtLmg5zYcE/g==
X-Received: by 10.223.176.86 with SMTP id g22mr2799006wra.11.1519937325495;
        Thu, 01 Mar 2018 12:48:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d8sm2282573wrf.8.2018.03.01.12.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 12:48:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 02/35] pkt-line: allow peeking a packet line without consuming it
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-3-bmwill@google.com>
Date:   Thu, 01 Mar 2018 12:48:44 -0800
In-Reply-To: <20180228232252.102167-3-bmwill@google.com> (Brandon Williams's
        message of "Wed, 28 Feb 2018 15:22:19 -0800")
Message-ID: <xmqqk1uvfro3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +enum packet_read_status packet_reader_read(struct packet_reader *reader)
> +{
> +	if (reader->line_peeked) {
> +		reader->line_peeked = 0;
> +		return reader->status;
> +	}
> +
> +	reader->status = packet_read_with_status(reader->fd,
> +						 &reader->src_buffer,
> +						 &reader->src_len,
> +						 reader->buffer,
> +						 reader->buffer_size,
> +						 &reader->pktlen,
> +						 reader->options);
> +
> +	switch (reader->status) {
> +	case PACKET_READ_EOF:
> +		reader->pktlen = -1;
> +		reader->line = NULL;
> +		break;
> +	case PACKET_READ_NORMAL:
> +		reader->line = reader->buffer;
> +		break;
> +	case PACKET_READ_FLUSH:
> +		reader->pktlen = 0;
> +		reader->line = NULL;
> +		break;
> +	}
> +
> +	return reader->status;
> +}

With the way _peek() interface interacts with the reader instance
(which by the way I find is well designed), it is understandable
that we want almost everything available in reader's fields, but
having to manually clear pktlen field upon non NORMAL status feels
a bit strange.  

Perhaps that is because the underlying packet_read_with_status()
does not set *pktlen in these cases?  Shouldn't it be doing that so
the caller does not have to?

A similar comment applies for reader's line field.  In priniciple,
as the status field is part of a reader, it does not have to exist
as a separate field, i.e.

	#define line_of(reader) \
		((reader).status == PACKET_READ_NORMAL ? \
		(reader).buffer : NULL)

can be used to as substitute for it.  I guess it depends on how the
actual callers wants to use this interface.
