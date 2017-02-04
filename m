Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1421FAFC
	for <e@80x24.org>; Sat,  4 Feb 2017 06:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753791AbdBDGWC (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 01:22:02 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36699 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753762AbdBDGV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 01:21:59 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so2994337pfo.3
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 22:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2PuFZFdZwMomKDK2kt19i13irh001FkoPWmrAjE71i4=;
        b=oEEGFoipu45kr6WO3tyOhlPU5udEZvgeMsOYxSXYvUz1cFSs0TnTQO6njSedHM+vds
         ad2bb9q9x/+dzgFGhzvuNk0kPO9K3lxk94IhZt9rTQdi4fFvNNP9Zq7XotuN9MVcqY5d
         rQRoH/SNXWv1X1YvApOqm8xH2nkPcbpCi0Foyy3cCNslVIYltKkFXA1Vn4P/C/HU4qLK
         7ULcP+KiTQk2XUHSlN2He9DNNG6Xg81313g/b0Bu1gKt/mZuQAyfALY1nWVBYb3DXY7Z
         c3AfeFW/14lJiSZOyElmKQIUTxwJZ+eCI3hNrYmCr2+O5Trv+SCuXSgQ5mL+dprzcafQ
         tf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2PuFZFdZwMomKDK2kt19i13irh001FkoPWmrAjE71i4=;
        b=BSJAMxAW8AARHkO5MIqKYCx+8HAKbTTFxAUgHQFMEInbXsOnlPapXXv2vbMNQyhkxU
         fH9GbEMQLr+5zuiEQDKsUjMaAMNeIU/EORjsiPlSmHo4deogOf1jiaN+Mr2IfBprlp05
         VdKJfbwL5SlcyIJcQ3Ov+2TxWvbjSzVjy++z73a5brtq0/jqHQCY4mzH49IEZMVBEZw7
         XCYmdCSIOyHR6YjI2ZdAo3ue3PYMWr8c4BQk7FA0C9Fw3p9Rwf6VZcyXrqVDdGyrZgjh
         jIIOAEwWlRBYIA0La1cbvwOB4D1P49Am9/7+B9tsnrALeZJZijJnK0jx+f7t5Poa/Deg
         3U3A==
X-Gm-Message-State: AIkVDXKfyAYuhkDq2wH+UPZEQl6t2EDnIPXhri/qGpXpIg5tc1kKEQ7/FHs1oBHyKdq6WQ==
X-Received: by 10.98.59.204 with SMTP id w73mr983123pfj.73.1486189318409;
        Fri, 03 Feb 2017 22:21:58 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd9f:576d:b8fa:253a])
        by smtp.gmail.com with ESMTPSA id n73sm71596888pfa.9.2017.02.03.22.21.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 03 Feb 2017 22:21:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 00/12] completion: speed up refs completion
References: <20170203025405.8242-1-szeder.dev@gmail.com>
        <CA+P7+xqhjVQMXtO4gtQ_2VAVd3qrpVLncH6YpFHreVV2mHORxg@mail.gmail.com>
        <CA+P7+xpeyebN3pmSX09Avh1EvYVjALpBCQ9r2==q3SWTu3GMSw@mail.gmail.com>
Date:   Fri, 03 Feb 2017 22:21:55 -0800
In-Reply-To: <CA+P7+xpeyebN3pmSX09Avh1EvYVjALpBCQ9r2==q3SWTu3GMSw@mail.gmail.com>
        (Jacob Keller's message of "Fri, 3 Feb 2017 19:15:38 -0800")
Message-ID: <xmqq8tpm8oho.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Thu, Feb 2, 2017 at 8:15 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Thu, Feb 2, 2017 at 6:53 PM, SZEDER Gábor <szeder.dev@gmail.com> wrote:
>>> This series speeds up refs completion for large number of refs, partly
>>> by giving up disambiguating ambiguous refs (patch 6) and partly by
>>> ...
>>> It goes on top of the __gitdir() improvements series I just posted at:
>>>
>>>   http://public-inbox.org/git/20170203024829.8071-1-szeder.dev@gmail.com/T/
>>>
>> Nice! This is something i've been bothered by in the past since
>> completion would take a rather long time!
>
> I haven't had a chance to further investigate, but I tried this series
> out (from your github) and it appears that this series (or the
> previous series for __gitdir work) breaks "git log" ref completion.
> I'll have further details when I am able to investigate a it more.

Thanks, both.  I'll look forward to how the story unfolds from
sidelines ;-)

