Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58FD71F453
	for <e@80x24.org>; Wed,  6 Feb 2019 20:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfBFUmO (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 15:42:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53142 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBFUmN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 15:42:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so3911642wml.2
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 12:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vo5A/K0vZzoBvLlQ0SsAd4JAkRxBOx2fW2U84ZY6018=;
        b=XhoWkZH0FtF2XFpiVQq/sjmKHqIRJp/mEfE30FSsA1+8tDV7WI3H4FwParWm2fl90i
         bGkFOkqDuJi+9/2kv3H55awpylt1DxOWH6PQCeLNg9ViQUw/4Mr8/SslyZn74pzL++fw
         oj2JphMe5bwoNXWhuaWGzStUp1HWKtDXLz3WoY0bV0NQaO1Acrvglc0XHD+RHJsWky3+
         /B6Bh0qLJ2dgMy40Nfxa8GduB0s++QItuwyAZ74VeClaMLE0nuxSUuj92s37LQbswfGR
         DsJdiZc5vgtIK9yQgHHZr9mW5jBs7K6DRKuiNLsw4wVv3isbCKi1Dxd26t4T4FO/U1sj
         sBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vo5A/K0vZzoBvLlQ0SsAd4JAkRxBOx2fW2U84ZY6018=;
        b=UqIm5YiK6CFXPKSpKNBWpdPU/GARHhXxfZe3flxFkhilAhkkUD17xj7giKZ7l4jCvl
         f9u716mFOM0Jl94ndyuCp9iCR4bcNWXKE4WLJcETNks3zfoVBl3C76pS04R+20TBxX8z
         UhKi1ShK5brcL8TXb9s1uJcqz/Um6LCIRZvrBdmFGisyDBTXiz3wrILgJl42hmv+ju6r
         NQoucUXsDrixiRtgfrpVWI7OCX5Ia259uB3Xuvqoq+klcSfV0n6bbg6bmgQoe1Me2oSk
         xmqeWxoODQAz1+8bSwdHazllTuaX6IvhYxjc9nGgSQUG9PGDrqp9XRVF3b3kADJ5mpcl
         4+BA==
X-Gm-Message-State: AHQUAuYG1igH+cJ4MDLOqly2Qk4rCQH7kp2ybHjyXkPDPkrZ8MvpRap8
        dCkZ9R0leErzdwx9K0Gp3Ig=
X-Google-Smtp-Source: AHgI3Ia5xD8f5Uj2+meDe5CZBx0enrSEH9GdFjdwH1e0qWXsAuon21nTYD5xUIyRxgoMdXGFWS/6Ww==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr4846119wmj.105.1549485731013;
        Wed, 06 Feb 2019 12:42:11 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e27sm33566838wra.67.2019.02.06.12.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 12:42:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] remote-curl: refactor smart-http discovery
References: <20190206191657.GE10231@sigill.intra.peff.net>
        <20190206191848.GA10893@sigill.intra.peff.net>
        <20190206192903.GE72177@google.com>
Date:   Wed, 06 Feb 2019 12:42:09 -0800
In-Reply-To: <20190206192903.GE72177@google.com> (Josh Steadmon's message of
        "Wed, 6 Feb 2019 11:29:03 -0800")
Message-ID: <xmqqzhr8ps2m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>> +	packet_reader_init(&reader, -1, d->buf, d->len,
>> +			   PACKET_READ_CHOMP_NEWLINE |
>> +			   PACKET_READ_DIE_ON_ERR_PACKET);
>> +	if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
>> +		die("invalid server response; expected service, got flush packet");
>
> This can also trigger on an EOF or a delim packet, should we clarify the
> error message?

You mean that it may not be "flush packet"?  I guess we can remove
", got X" part and that would probably be an improvement.

>> +
>> +	if (skip_prefix(reader.line, "# service=", &p) && !strcmp(p, service)) {
>> +		/*
>> +		 * The header can include additional metadata lines, up
>> +		 * until a packet flush marker.  Ignore these now, but
>> +		 * in the future we might start to scan them.
>> +		 */
>> +		for (;;) {
>> +			packet_reader_read(&reader);
>> +			if (reader.pktlen <= 0) {
>> +				break;
>> +			}
>> +		}
>
> Could we make this loop cleaner as:
>
> while (packet_reader_read(&reader) != PACKET_READ_NORMAL)
>   ;

The only case as far as I can tell that would make the difference
between the original and your simplified one would be if a packet
had a single newline and nothing else in it, in which case pktlen
would be zero (since we pass CHOMP_NEWLINE) and the return value
would be READ_NORMAL.  The original would break, while yours will
spin one more time.

Thanks.
