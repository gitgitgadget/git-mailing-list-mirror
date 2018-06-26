Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 829861F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeFZVZl (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:25:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40246 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbeFZVZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:25:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so3281784wma.5
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vXJBvev00Nzt14+sPOuZOL8+ygw4L4W6PWOxXK2IlfI=;
        b=BiAhEv1bwQox4u9kTJP2iYabeKB4UHvHCuuFJTuoTO3IK9mDUj2YSBL9C7dBTWkp2w
         g3DZmL2nzb8bvFj95HB23E0SCdKIuFO9CN9aiiRFjcSRaFadOkEG4zJymEHvB9+9NWRi
         SfjeUbU9dA7ZbccDi1s5BFLwsoLzTrHMnpnfYUYyBOa9Y96HCTlfARwIaPuTIVB8bsrS
         9/RRbRsKoa52e6urn1mnc/wChUugoEzwAbE51AjYH9gxMeokzexsFvzDsQM3pFvnFV/w
         Tph+R1F2vAhzk4D+O/eX4PCqGWHpBwu0eepNh315ihBedUo4nUAKOHX8V2+BOQKv8Xsk
         GiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vXJBvev00Nzt14+sPOuZOL8+ygw4L4W6PWOxXK2IlfI=;
        b=ueXCglpXiTO3ynY7Nw+Gldzol7dfdbI7uWth2RLKS10+XJ2cbCh1ibZcmKcCknKN6d
         cqXrLHFDrCzZKX6i+EDRD16fTB4ShZ6Y6MSNgieoSZljRKb75xHf0StHL71YUW6Todbb
         Erpyrg1jpD7VRfDYp3tGJOOHNnyFHlZSKgf+nZVJWQCylS8debAnlpapQ+RoBXGUHQrm
         wmNhf0DcUrqfc/3v8OpAEDtSIo+8U+iJKQbKVS4F4575tpTvooNyizvU+q+PASGuyu2I
         Va4aqCCmeLtOsbHe32GSneOK5YGNpujT2sRAHWFTmWvuI7lvXff9toCEmKMRUHbgYLAr
         +TTA==
X-Gm-Message-State: APt69E3/IuaayJogwzWa5rJXhLsGMWqlBZoz500/swoUfRVBO+rVvljF
        gCbeU4+sSOUAEdn3pKvfncw=
X-Google-Smtp-Source: AAOMgpeU6PMEJIWIb4VCMzL/DuQ4iRa4Fzjm0SahDwJQZpvHdYRc02bqoMRZN7li7TGmIarIVQEmdw==
X-Received: by 2002:a1c:568a:: with SMTP id k132-v6mr136570wmb.89.1530048339035;
        Tue, 26 Jun 2018 14:25:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e74-v6sm4869159wma.44.2018.06.26.14.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 14:25:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, sbeller@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 2/8] upload-pack: implement ref-in-want
References: <20180625185332.164142-1-bmwill@google.com>
        <20180626205438.110764-1-bmwill@google.com>
        <20180626205438.110764-3-bmwill@google.com>
Date:   Tue, 26 Jun 2018 14:25:38 -0700
In-Reply-To: <20180626205438.110764-3-bmwill@google.com> (Brandon Williams's
        message of "Tue, 26 Jun 2018 13:54:32 -0700")
Message-ID: <xmqqsh59i6jx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +    wanted-refs section
> +	* This section is only included if the client has requested a
> +	  ref using a 'want-ref' line and if a packfile section is also
> +	  included in the response.
> +
> +	* Always begins with the section header "wanted-refs".
> +
> +	* The server will send a ref listing ("<oid> <refname>") for
> +	  each reference requested using 'want-ref' lines.
> +
> +	* The server SHOULD NOT send any refs which were not requested
> +	  using 'want-ref' lines and a client MUST ignore refs which
> +	  weren't requested.

Just being curious, but the above feels the other way around.  Why
are we being more lenient to writers of broken server than writers
of broken clients?  The number of installations they need to take
back and replace is certainly lower for the former, which means
that, if exchanges of unsoliclited refs are unwanted, clients should
notice and barf (or warn) if the server misbehaves, and the server
should be forbidden from sending unsolicited refs, no?


> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> new file mode 100755
> index 000000000..0ef182970
> --- /dev/null
> +++ b/t/t5703-upload-pack-ref-in-want.sh
> @@ -0,0 +1,153 @@
> +#!/bin/sh
> +
> +test_description='upload-pack ref-in-want'
> +
> +. ./test-lib.sh
> +
> +get_actual_refs() {

Style.  "get_actual_refs () {"

> +	sed -n '/wanted-refs/,/0001/p' <out | sed '1d;$d' | test-pkt-line unpack >actual_refs

Unnecessary piping of sed output into another sed invocation?

	sed -n -e '/wanted-refs/,/0001/{
		/wanted-refs/d
		/0001/d
		p
	}'

or something like that?
