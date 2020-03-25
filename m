Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC6DC43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 14:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD5220836
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 14:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUMNlkhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgCYOY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:24:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40398 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbgCYOY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 10:24:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id l184so1106719pfl.7
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xY8DAFqRKYWLKVr1rhZW1zKZvL/P1TshPNIKJ5mz5l8=;
        b=iUMNlkhVg/eUEfWu+yTp6QUYFwmYg+/AGxyVzo4IZuoHR7N/swfeMw7K7Cnde2dvCQ
         DMhJR42MZuFAsLUr4mmDk9K95TKNNIqGz124siGVXQv1fhOit0EwfMwXYmhzbcZSarWv
         B7gvyYlhkbbp7zhbH/Ls6gdv+4fwQYlMTTlLzBFhVXMA1QkjBFvJe0/VYzfa8+wcAicy
         5VtdiVQ+2gz/JqvZqgPuRCzPEFB6eMD9Vh4M6jKqChNzKB7MCZ+vVnwXnWIcRW3BZPVw
         i46i267mlG5Rv84M+8g4oejdh2t/vR3Vu8ex6XwZ1gF433U+Ehv50IzBBqfZgTaO/ILU
         DNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xY8DAFqRKYWLKVr1rhZW1zKZvL/P1TshPNIKJ5mz5l8=;
        b=by7yk30q25lB6QueplyH3V8ce5fvUHo/wDseqMvtVqWp4Mf3yr5V2V0+eUq9mWbwQP
         4ziWs953c1dc6XZvhmgiBot7hVAMCPSNPTsoGbi4isHYVUcD5VPsW43DKlA7Gl75B66s
         RLczi1gk8pxICwMP94Kmmvzj4UZAtvCsPmoeOfPnjG2Z62aHpcYsL6dOyQzmRDEFtZkl
         aj4h8hZbbrO7S82D3OTgeFL9CBhOx7/Q4aqlbnjB/yZh9bPBSPelqhbmAkwVMtuIbZdf
         RFWZxFlzuAw5PibmGEOeBQ0/X0su15P47NPDpU6e3XzjuyKqE6VUZ3S4Xa3OndJVnYN4
         h6uw==
X-Gm-Message-State: ANhLgQ2zyiwSN9KTuvbsL9M/aIlIaDJlD1B2JC7k+6CheB5445F6LsNU
        X+uWj0XUIArda7CknvfDvLs=
X-Google-Smtp-Source: ADFU+vumzN9TMKA0Bh2h2RMV7gkXWdFm62vex7xI1W9mWzszpwhk9MzPFHjMims+4Umh5XHg9e6jzQ==
X-Received: by 2002:aa7:880c:: with SMTP id c12mr3472311pfo.77.1585146264387;
        Wed, 25 Mar 2020 07:24:24 -0700 (PDT)
Received: from localhost ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id u18sm18736101pfl.40.2020.03.25.07.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 07:24:23 -0700 (PDT)
Date:   Wed, 25 Mar 2020 21:24:21 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] t4124: fix test for non-compliant diff(1)
Message-ID: <20200325142421.GA20898@danh.dev>
References: <cover.1584838148.git.congdanhqx@gmail.com>
 <10f39c3d30d13e9141f081f985a0620954cc7493.1584838148.git.congdanhqx@gmail.com>
 <nycvar.QRO.7.76.6.2003231456200.46@tvgsbejvaqbjf.bet>
 <20200323150449.GC11801@danh.dev>
 <xmqq8sjq4wyf.fsf@gitster.c.googlers.com>
 <20200324034025.GE11801@danh.dev>
 <xmqqy2rp1tff.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy2rp1tff.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-24 11:47:32-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Danh Doan <congdanhqx@gmail.com> writes:
> 
> > Hence, if we're going to drop support for system that doesn't
> > understand "diff -u", we're going to:
> > - remove support for those variables:
> >   + GIT_TEST_CMP_USE_COPIED_CONTEXT
> 
> Folks who prefer "-c" even their platforms all are capable of "-u"
> may miss this, but I think that is a very small minority, and they
> would be OK (it is after all only needed when diagnosing test
> failures of our test suite, and by definition, those who are working
> to improve Git would know how to read "-u" output).
> 
> >   + GIT_TEST_CMP
> 
> I am not sure why you need to drop this one?  This is more about
> switching between "diff" and "cmp", and there are reasons why folks
> prefer latter especially when they are not debugging the tests.

I was thinking it could simplify the test_cmp code.
There was a problem which needs to be addressed by 2/8.

Yes, people may prefer to use cmp(1) because cmp(1) should be faster
than diff(1).

Anyway, it seems like we've decided to keep using normal-diff because
of HP-UX.

-- 
Danh
