Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9418D1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 15:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754820AbeFRPmw (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 11:42:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41826 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933585AbeFRPmu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 11:42:50 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so17343450wrq.8
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=La3PdE10ys1V96Orv9vOqM3V432NbgWiC4dTlIeegcc=;
        b=hPadGF3Tty8sIbWHqHXkOTmxXJ99GOtquh0QDdo7jyD6jTlvhUuCv+dYOUtw6zSKnJ
         /VWU4YTiu8JxSMolqd2wYOgOFm81hBTCRsV7jwUNPZYF03ZDpvWaCkvi9Tps4KPow4dF
         cvb0SdzPo5UeHTK7W7HpLwWOe+USAJfhgzSbKQZS+8SGLd+1CguKPUc0MFetnkFzGqvr
         MRUm2NIDwMDgaKFHCOwpQ3oB9yIhb33WPkDzB9YATx70O64kTnU/hd9fPa69bYqrtL6Y
         n3m9VMhxH/+H1yOtrXtG6ljhjE96RVyWRvycnhmq6aD3wzIHSj2/yWZpiWvqL14nQPEa
         Qiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=La3PdE10ys1V96Orv9vOqM3V432NbgWiC4dTlIeegcc=;
        b=FXw8GMKXqENY3+2BTfOtTakIa3R4mKtLDkKZsgICTouO9WAFRi0nR+XTO3NNjW9Xg2
         Gc2PcyVu+sqPZwu3aNhLOBMFj/EVFCKfIUnTSwhePfEcueRq88NRZklYDJeKGS8mZhVG
         q4E2jqf6aKdy4nRhDKg1s4Hj7kUejHRnTbUjRCERG6mChbjs3UxFne3t7XU2I5ibiZKY
         Mlvu+ADGWNM5oYLSuu0Qdx+sb+vEsDilFVrcGKPvZHJ8Nvqc68qTHFweUN3Ny+oNYB6h
         mws/zzsgxx4Lov+hCLsuHT3VPAPvfB8mGvyyMSZ3H4fT1zIqlUH6YXWjo1vNRU2QUoWT
         is0w==
X-Gm-Message-State: APt69E0ZTwlRgzqncLfX8P2AqRC2pTXSZ4+2a86Y6LQenrImtYLby4fw
        GGCQ/o4jv/0CR0+Z2EHfHk4=
X-Google-Smtp-Source: ADUXVKKFLAnBa8i9RQ1ZUEfo8N2RzzhnW2s2fafr0pKlWoShvHB//PK2HBOnL70pBDUwe20sqJrsRg==
X-Received: by 2002:adf:e6d0:: with SMTP id y16-v6mr11604031wrm.35.1529336569185;
        Mon, 18 Jun 2018 08:42:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y8-v6sm20358419wrs.0.2018.06.18.08.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 08:42:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, ch <cr@onlinehome.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] sequencer: do not squash 'reword' commits when we hit conflicts
References: <CAPig+cRKxpNrTNSEgB66LBxcJk1b24ViR=T-fkqo07wxMFywpQ@mail.gmail.com>
        <20180617053703.19856-1-newren@gmail.com>
        <d62d834a-58dd-590a-cf71-028220323bf9@talktalk.net>
        <nycvar.QRO.7.76.6.1806172048270.77@tvgsbejvaqbjf.bet>
        <0ead1e75-98e9-8357-3e8d-2ff2f3cc5cc0@talktalk.net>
Date:   Mon, 18 Jun 2018 08:42:47 -0700
In-Reply-To: <0ead1e75-98e9-8357-3e8d-2ff2f3cc5cc0@talktalk.net> (Phillip
        Wood's message of "Mon, 18 Jun 2018 11:20:47 +0100")
Message-ID: <xmqqsh5kxfrc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

>> Oh, you're right, the fast-forwarding path would pose a problem. I think
>> there is an easy way to resolve this, though: in the case that we do want
>> to amend the to-be-reworded commit, we simply have to see whether HEAD
>> points to the very same commit mentioned in the `reword` command:
>
> That's clever, I think to get it to work for rewording the root commit,
> it will need to do something like comparing HEAD to squash-onto as well.

So, for the second attempt by Elijah, Dscho said it is good while
you noticed a problem with ff, to which Dscho agreed is a better
approach, and you extended it which brings us here.

I'll leave the thread hanging here while I pick other leftover bits
for 2.18 final and then will come back.  Hopefully by that time I'll
find the final version of the patch to conclude this topic that I
can apply on top of 2.18.0 ;-)

Thanks.
