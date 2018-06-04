Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 547801F403
	for <e@80x24.org>; Mon,  4 Jun 2018 04:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbeFDEcB (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 00:32:01 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:50423 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeFDEcA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 00:32:00 -0400
Received: by mail-wm0-f41.google.com with SMTP id e16-v6so1441487wmd.0
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 21:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YXnRfQ3OwzFUb22v213gj9qZ0IVUwUNMGheQgJ5xDNE=;
        b=inUgvdVsqlPoc42Iw/oRZSZlpCqr2LQrl7RqcI5lylYrhisBlDhFY2sR/PXs3kDFO4
         m9/vFNBq42M2cgWTNz2AhTquAdpBioTracSuzTuTaMn31EUmZzPNo/LhOcB3+yLxqOUA
         gLLLair/OxW30CzYe00F9Ax++GrEaAzzRUkYsZ1MWQVA9zOOzN8WU65RzpuEPK6/x2gH
         tCTuRSiK31T1eyjoF7dSmVMv4SZ5rfCf+6rVihgQ+E8AXK9Aw4FPw1j3PpCHvvtkzYZV
         5iLTa6XoYdvFbPTp9xKdRodyiEQNPoDGRnvr3RrZFcJQhrJKpcs1P6ip5grGmhQowdLx
         dFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YXnRfQ3OwzFUb22v213gj9qZ0IVUwUNMGheQgJ5xDNE=;
        b=QNjX9oc/gD7TH6/9CYKjllzuEq81othjeE4DeoWYb/zOsaRfMd9OvfPzkvuhcBuwy4
         O3bq/OWOy6rMDvyI6fTpjgi+dAsrHXWP/LaKgFfuDR+SmOXV0x9EaWZ83assRDd3sZSa
         IvZuXZmo0fFwB9bKfI7NAmHlPTXof1K9FQUGht3M1Ds1TsWjKpN9P10IIL5q3v3MeIKj
         Yp65AgbZAlSfxY2t0QrwmSSkA1SqCRgj4D5GDKzybjgqC1h+53CkULfm7ehMvarL7tNA
         kNRlyfLinRQp+00nCrTqz1MF5X7BsnSxNlcgWLsCsNj+EhxXIe/OjSYDcdJsZk9IRL61
         6V6A==
X-Gm-Message-State: ALKqPwcWXAMooGPO1pWImZ3JfKzCCb3NCYvzRMzeLuDD+j48ucmO2Ysq
        Nf/zPb59lh/nQzdaPIycrM7eL1Eh
X-Google-Smtp-Source: ADUXVKKfBgh7CRa7US8XJDOP6/rCixdWarbSRxAfCuPoa7Rpt/piqli7T/CkbDcVrcVyR9LfdkYMuw==
X-Received: by 2002:a1c:40d4:: with SMTP id n203-v6mr7651765wma.101.1528086719294;
        Sun, 03 Jun 2018 21:31:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s2-v6sm24143379wrn.75.2018.06.03.21.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 21:31:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] http-backend: respect CONTENT_LENGTH for receive-pack
References: <20180602212749.21324-1-max@max630.net>
        <20180602212749.21324-3-max@max630.net>
Date:   Mon, 04 Jun 2018 13:31:58 +0900
In-Reply-To: <20180602212749.21324-3-max@max630.net> (Max Kirillov's message
        of "Sun, 3 Jun 2018 00:27:49 +0300")
Message-ID: <xmqqefhn5g01.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> +static void pipe_fixed_length(const char *prog_name, int out, size_t req_len)
> +{
> +	unsigned char buf[8192];
> +	size_t remaining_len = req_len;
> +
> +	while (remaining_len > 0) {
> +		size_t chunk_length = remaining_len > sizeof(buf) ? sizeof(buf) : remaining_len;
> +		size_t n = xread(0, buf, chunk_length);
> +		if (n < 0)
> +			die_errno("Reading request failed");

n that is of type size_t is unsigned and cannot be negative here.
