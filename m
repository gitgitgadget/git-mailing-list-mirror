Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441BFC54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 02:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjAYCLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 21:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAYCLT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 21:11:19 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772E14F865
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 18:11:18 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id g23so16550692plq.12
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 18:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuPAOw5BToOiTS97gk+K9+rDmuNXNPwQpbMbFHxfv/0=;
        b=KIky2baZuJVGBxDPYfZyr25rGVl7wsFlb+bmdN/0sfUWaUnFSZuiLmWdGtZVMsa+q5
         DFveh02K0RaHs2F05SkADxdheLVgfQfAM/rAf1n7uK+JS95pTnWIpXt3uxGYdXKWIWVy
         +2YaEYrTMYQYYS21eAF9xNoSRboTzqU0TZkMvypQ44lrX7zr/xfxv9ntBDDRFvMStNk2
         OP6VNqyQtYdR9LhTVzZhjcdH1mF1DCsED7Bs8WRRUnwYf9kQEct7RaHKa3iUa6KpMxA0
         EGflfCQQHRVGc2Sik7UsiUVqkDssDozI2gNrmpgmKJMNjlvIO4P+Pmz7DCPyHRXhpd/H
         w+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PuPAOw5BToOiTS97gk+K9+rDmuNXNPwQpbMbFHxfv/0=;
        b=mJuaQv67akd6Yk9x6BB/NBdtNhLcrfGdjFImuNGT7WgSf2Tn5bvsrWDgiSKqxMzYTz
         DPYaCMao+n+QqsKRdC9ydArTqik3LsumHzEPspmvWzwR370Yhi/3R8lzmJ7Lk5QETik/
         kzL3wivbuZePeI5rtsJ1xdyNLOU1lwIh4jNyic+JcQB8/xMXw1186sQmqbruGRMqfb1B
         cogjXE37U5sUgOPu2zCnCASDTf8ihCVlBqwU7QYcjAKQJygMVWcavY9SX+MJdYe+vAii
         SvQjXXh2KN61CpOhxJSJoPd34RwMioN4AF/0Z+D8LG/DBObXFTCrPpXtPLm7sCRQdBcV
         Xa+g==
X-Gm-Message-State: AFqh2kq4WDWo9FIW6h1N3iLAkdeJYYCwTngJt8MnZTAsYJbcxj1JTZnH
        323RNIpkFwXeLeNFL7HxdWQ=
X-Google-Smtp-Source: AMrXdXtGzCPSUNS8TFqhlwC5bEGhQ33V43Fb/TMpOjRhtQUCwjPCkHLqGF6hSjAAdKZuyuSlfC3faA==
X-Received: by 2002:a17:902:b701:b0:194:7771:4eeb with SMTP id d1-20020a170902b70100b0019477714eebmr27090438pls.40.1674612677847;
        Tue, 24 Jan 2023 18:11:17 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id jh6-20020a170903328600b001960cf9655fsm2273408plb.309.2023.01.24.18.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 18:11:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Hemmer <git@stormcloud9.net>
Subject: Re: [PATCH 2/5] log: Refactor duplicated code to headerize
 recipient lists
References: <20230119223858.29262-1-zev@bewilderbeest.net>
        <20230119223858.29262-3-zev@bewilderbeest.net>
Date:   Tue, 24 Jan 2023 18:11:16 -0800
In-Reply-To: <20230119223858.29262-3-zev@bewilderbeest.net> (Zev Weiss's
        message of "Thu, 19 Jan 2023 14:38:55 -0800")
Message-ID: <xmqqo7qnfjnf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zev Weiss <zev@bewilderbeest.net> writes:

> Subject: Re: [PATCH 2/5] log: Refactor duplicated code to headerize recipient lists

Style: "log: Refactor" -> "log: refactor"

cf. Documentation/SubmittingPatches[[summary-section]]

> The To and Cc headers are handled identically (the only difference is
> the header name tag), so we might as well reuse the same code for both
> instead of duplicating it.

Makes tons of sense.  But seeing this one ...

> +	recipients_to_header_buf("To", &buf, &extra_to);
> +	recipients_to_header_buf("Cc", &buf, &extra_cc);

... the parameters to the function probably should be ...

> +void recipients_to_header_buf(const char *hdr, struct strbuf *buf,
> +			      const struct string_list *recipients);

... in this order, instead:

    format_recipients(&buf, "To", &extra_to);

That is, "To" and &extra_to are much closely related to each other
than they are to &buf in the sense that they are both input to the
helper function to work on, while &buf is an output buffer, and we
tend to place closer things together, next to each other.

Other than that, removal of repetition is very good.

Thanks.
