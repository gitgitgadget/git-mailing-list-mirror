Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48DA1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeDPWet (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:34:49 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:42417 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbeDPWer (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:34:47 -0400
Received: by mail-wr0-f174.google.com with SMTP id s18so30214719wrg.9
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qmj7yMu8LfsMh69FpKh64QmkMNhHCTzAjwSjsFL0ges=;
        b=RfgzJrQmJzCr8TABRKJcf1ZPXxfofyPup6gbg+90wCMyjOVEacGTisQFf7RxQ+7EjJ
         dBdMJ+cBctghOIXJrUsZk3hKSLF2o8u1BW4EErcRfEnlnv6X1bPsBP/QkVKpy2/Cj3zp
         QBo7K9KcZiyI58m0K/W3Q1gt0e144zVP8I004pF2tPGyAJ/TAHUgtfZxERXLmgR4XitK
         EK7lAA3HkrB+UtVj6xQSrGl8coSXUR/ZERb6aqctt8IORKG+/SErEifeEQeOxn9mugKm
         aOV52gMJkhAzkt8TKrtQtk+KP7OFzcEGwah7o1caanoIEzidkMSOVfJjq27Y6plNKbXa
         rVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qmj7yMu8LfsMh69FpKh64QmkMNhHCTzAjwSjsFL0ges=;
        b=CsQ2XpspNSGudzRvUD33kI4GL+ailzW0LKB6rtEGkx2d5AQlvzuRN2vl4BoYHNJmyJ
         6OtyjR46UgCULx+M+aV3oDBTnJ+v6AlYSm5z92ZI66OmDgcfQ3Y1w5tUOXDiF70yHmI/
         ulD66efqBOJOgg9pS6ywYEDJL/sfWgpZ/6SNmEEmVrhTXwHDGQ8Bzk7D6L3hj+iE6QH2
         kM7OppY/u9M+8oelCZGFt5j5GJYEkCQwiaG7sTFbllZXGD5vtpunJSdMK9iCLIw+geor
         3yAQIh6k3WS5928I+Jx2XCfz1LQF2CHSRhMxnz0szh9g5AKMDnunVGydcjHm0cBqd4RB
         k/gQ==
X-Gm-Message-State: ALQs6tD2oPsUNZVolwLS5i0H01wfKbnTRF3mtSljffwMe+OKpk/8dLMz
        j5keB9sPlI3ucpf1qJ21LM4=
X-Google-Smtp-Source: AIpwx49NI7KLsjHnQ1uhD7xyTIavER2hGaw46TF3qElUWzbQPH9g35egfemeXOHEslVO2ClNJLnUzA==
X-Received: by 10.28.107.5 with SMTP id g5mr49639wmc.133.1523918086335;
        Mon, 16 Apr 2018 15:34:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 4sm4703959wrz.58.2018.04.16.15.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 15:34:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, mgorny@gentoo.org,
        Peter Backes <rtc@helen.plasma.xg8.de>,
        winserver.support@winserver.com, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Optimizing writes to unchanged files during merges?
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
        <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com>
        <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
        <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
        <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
        <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
        <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
        <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com>
        <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com>
        <xmqqbmekylgc.fsf@gitster-ct.c.googlers.com>
        <CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com>
        <F1738316-71EF-4053-82E5-F009F491CCE8@gmail.com>
        <CA+P7+xrmAHjaF=wze1iu0=cZBY3WcHXqpuDep3Nrev+zmt_Gog@mail.gmail.com>
        <CA+P7+xoVcPV_mFS3WpUvCUR7N4SzJ5WBZqpGT3VVWdkPjh6Qww@mail.gmail.com>
Date:   Tue, 17 Apr 2018 07:34:45 +0900
In-Reply-To: <CA+P7+xoVcPV_mFS3WpUvCUR7N4SzJ5WBZqpGT3VVWdkPjh6Qww@mail.gmail.com>
        (Jacob Keller's message of "Mon, 16 Apr 2018 10:45:29 -0700")
Message-ID: <xmqqvacqwzju.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Mon, Apr 16, 2018 at 10:43 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> ...
> I think a better solution for your problem would be to extend the
> build system you're using to avoid rebuilding when the contents
> haven't changed since last build (possibly by using hashes?). At the
> very least, I would not want this to be default, as it could possibly
> result in *no* build when there should be one, which is far more
> confusing to debug.

Yup.

Even though I take many optional features that I do not see need to
support on the core side and I do not plan to use personally, as
long as the implementation is cleanly separated to make it clear
that those who do not use them won't negatively affected, I would
not want to have this in a system I maintain and get blamed by those
who get burned by it.  Something like ccache, not a version control
system, is meant to serve this audience.
