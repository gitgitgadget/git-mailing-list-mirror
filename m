Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CDE61F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeG3REh (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:04:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39784 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbeG3REh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:04:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so106781wmb.4
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CVg6IxfBqJzGbK5LgIdbUv5KuNABDyXGAiC12buaOzE=;
        b=e+pHpFtgZ07xT1+FxT+3Y8x8DpzspJNqJVBEQdtMqyYjUXI2p0HeaVw8nbf6qGKGUp
         /G9gjD/uu0l9yGMFNnRO5ZLXLlMrANmbj8wMwSKOw8zFHi/uQ+Efk03G4GUYhJisk+F+
         SOA625k3Q5y8X2XeA5xvTTYWC92ozvsXHihflef0HNYdXi8E+TEcwGW1/yzPANtPeanN
         9RmzJ3e1k/D4eL8ztBiD/zfwpyws9v2ev/W2O23SCeIoWuiQLZGYnreyXWckuSyAHxj2
         rVHi9ixwMJA5PEDAGmm7exLFOGYjFyUw/iMhYBDqzh5H7QIwlFWPE7LgNA5T/zdwfEvC
         S7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CVg6IxfBqJzGbK5LgIdbUv5KuNABDyXGAiC12buaOzE=;
        b=C1qLAKqU+p6RSj6WskXNr/8/EL/TS0udVNQgtIktwwsawGCmU67lQ7CnOcE0Ag1Pv8
         zHb83WUFL295oZ0EHmtvuZPn0tNwcvrKH3PBsHBVMFQdWrbQ5RjakPR+Xck1LhSqoFmZ
         3v2H/uPUr6+bWQTrtlfVqnO79/LNTtYf20pjbDwdTdsQgCLZKJZOvNTB1MSSEmXETNv5
         ywhnwTqOvWP3dN+Mgw88zhyNJVNiJ6vco+qKa8oIkozfvRy52JytEPTojBXrE2Dso4mV
         zX3cRAHyA5ptVwinu2WVBU8YeqZE22OH4m4d1AeIHJyqF+LGqIrRyaZut/MLkE9zcOia
         4ngA==
X-Gm-Message-State: AOUpUlGD9x6CI+iubQG/yM4F8bleUUlhSA2oNU5iq0gxjmktVDOCL+S3
        I+dgrHn/TCnM1Ot2uyCi5u0=
X-Google-Smtp-Source: AAOMgpcluYJdex9w3PCO/nWJiQ87YJ5NhQGVv5J6SawthtoEDuuEwtMHwP3o4ixLxwpyarlaHVJAOA==
X-Received: by 2002:a1c:8010:: with SMTP id b16-v6mr16451552wmd.41.1532964546149;
        Mon, 30 Jul 2018 08:29:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k3-v6sm13764893wme.44.2018.07.30.08.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 08:29:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Akinori MUSHA <knu@iDaemons.org>
Subject: Re: [PATCH 0/2] fix "rebase -i --root" corrupting root commit
References: <20180730092929.71114-1-sunshine@sunshineco.com>
        <1f172fc1-4b51-cdf7-e841-5ca41e209be4@talktalk.net>
Date:   Mon, 30 Jul 2018 08:29:05 -0700
In-Reply-To: <1f172fc1-4b51-cdf7-e841-5ca41e209be4@talktalk.net> (Phillip
        Wood's message of "Mon, 30 Jul 2018 13:14:27 +0100")
Message-ID: <xmqq1sbkkaim.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

>> Moreover, patch 2/2 of this series provides a more thorough fix overall
>> than Akinori, so it may make sense to replace his patch with this
>> series, though perhaps keep the test his patch adds to augment the
>> strict test of the "author" header added by this series.
>
> Johannes and I have some fixups for Akinori's patch on the branch
> fix-t3403-author-script-test at https://github.com/phillipwood/git
>
> That branch also contains a fix for the bad quoting of names with "'" in
> them. I think it would be good to somehow try and combine this series
> with those patches.

Thanks for working well together.  Always nice to see contributors
thinking beyond immediate band-aid and for longer term ;-)

> I'd really like to see a single function to read and another to write
> the author script that is shared by 'git am' and 'git rebase -i', rather
> than the two writers and three readers we have at the moment. I was
> thinking of doing that in the longer term, but given the extra bug
> you've found in read_author_script() maybe we should do that sooner
> rather than later.

