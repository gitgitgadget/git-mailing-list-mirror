Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3740C1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 20:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeI1DNR (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 23:13:17 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:37079 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeI1DNR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 23:13:17 -0400
Received: by mail-wr1-f53.google.com with SMTP id u12-v6so4083812wrr.4
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SCmzv4TEpzz9Pff137zNvclw4sLRIjrex6Gv3OLe5Uc=;
        b=MLBdGeNeifLcXHzX+t1rkJerCuYziOSeLw2GPyDXtWisqLik0h5igoJNOS/on5eReR
         ITgHlM2jItszK6wQG+ufkjC/MlGqhygWHX8+j2K36I6A2y7gdMNXuXRQJkRFF5rp34N3
         V71f/9m5+ojNQbhNpSBrcD+eeKT0/IXCAOMhoKOi/q+g6xOmpJoOtvmbndOQ1XnE2BRc
         OvZ+Vny5nMcMWthN2uBFTaSrla9xnpcoTbrcXFI5nWTNIRa2KpwJeJcAAtzkZvqndZaW
         5v+PTO8NsNGqvgAIemXw7+w700rvSg30a3qTxz3xZT5FnYEyl2YNdE+m41yq2LsqJEPo
         RfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SCmzv4TEpzz9Pff137zNvclw4sLRIjrex6Gv3OLe5Uc=;
        b=bheHuD/whuYkuG2zRqsmrgEhoiaUNTYQF1zw49MqXQk804wVZTRUXlqZ2LjPKX2Ui8
         6iGcsLG2WyLY8GNb/8ku5PErieeR7w/3SLFDCAL9j7lvmdg5iA9PBchAw6CifAa6bLI5
         Es8i7wdI9uRfKsN90zbCTLJvViXQpYgxBzawHB1+jeC1Pu2u/qhjnRYexrwoNurP9wuY
         KMExZdAZVD8eQFWdI2AMn5CWLjfiP2F3xiVXcEC9BJMmMl8MoOpJA2EhMVbRMpn3CK4R
         3HEM5oBCV/QfoIHfrX/kZlPD0qJ4sVTnin7TH1MFyPeNsOGMMk9jYXwcEG47Ca0X7Uxa
         u8dA==
X-Gm-Message-State: ABuFfojHq5b7bPk03kznRrWrfPeYDRdALzmGWsjVWPmDyBRSh/1GeRL5
        NduqGzAcrdjkmUL4rmd/Uu8=
X-Google-Smtp-Source: ACcGV61AYW4zcJ4lAOGjNJ981W0c3Ybc/qe6XKEDQM9AYQ8pGcw7W4Q0tRMRFYgtQjBap/azTDEx7A==
X-Received: by 2002:adf:80a3:: with SMTP id 32-v6mr10291397wrl.231.1538081586631;
        Thu, 27 Sep 2018 13:53:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g75-v6sm5074989wrd.1.2018.09.27.13.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 13:53:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Avoid ls-refs when possible in protocol v2
References: <20180925225355.74237-1-jonathantanmy@google.com>
        <cover.1538075680.git.jonathantanmy@google.com>
Date:   Thu, 27 Sep 2018 13:53:05 -0700
In-Reply-To: <cover.1538075680.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 27 Sep 2018 12:24:03 -0700")
Message-ID: <xmqqva6qfyry.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> To answer Junio's questions in [1], I think it's best to include the
> full patch set that I'm developing, so here it is. The original patch is
> now patch 3 of this set.

Yeah, taking it out of context did make its purpose fuzzy.  Without
the other patches in the series that set the overall direction of
reducing ls-refs, it was unclear why some transports are marked to
specifically want to automatically call transport_get_remote_refs().
With these surrounding changes, "we call it as needed, because an
earlier step may not have called it" starts to sound quite sensible.

