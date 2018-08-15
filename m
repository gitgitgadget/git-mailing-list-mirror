Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D58BD1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbeHOU1B (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:27:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45652 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbeHOU1B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 16:27:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id f12-v6so1763153wrv.12
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eGw1qCv1p4zypsdQNSCRSBf9hphn02543TBgO8fouK0=;
        b=bYtukE69FKBxzgEqXV9I6tDPshptvOgl5YEcx/KTR5ORVI3Gqs3G6l62AGt7by5xrW
         fx6fYvluBxxv7l22V0Is+YqffvA+0zjvTgKaZ+jIpWdVEoTGoNGxvWb3Iw4FkCiIiQx7
         JCI0Kd7GV2LOQfmrIl+d/UsVhS3gxVrzZGQWgBZkoAzZSXfh6bdP+NfDM/E0W88D232B
         t7+8w9aS1OcZKH5yfAj+QSXfxIr8K62jm1M0C2brkdUAfup5de7MjM1yvlyaBkTxOPNv
         orMNowyGfPqPb0DFmAFWPFwiGhrD6j1SSf5CaMqMegIyCAILYuPfzG6ZO8vsG8luyc4e
         j12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eGw1qCv1p4zypsdQNSCRSBf9hphn02543TBgO8fouK0=;
        b=mroIAGUfgi20NgjSgLGM/mwWbNpLTEf5Hpdc0V9BmA0haYOpfHVEqieRkof1mV92RJ
         lQkEJql8DVPWtu839L9wEVeVDQUaX/m+B4bBpHYoMGRt01Lm9g40r7S5zK+ikzb2wnXu
         pJy6l1ndggB0Ri+pOm9ED2kQ7xLBovslWAweHLXA19z470p/r//RzkkSZrwdKcmGMCPn
         44W7P0usggSEdFCuXhT7oC4s4qUnjRmS1GMZ8n1hKnVOq1wsxtXpLOPesGEtZ+LnQo+z
         A6orifnp1jxCtvPEgipozlftMPuXzb+1QhY9jd+jwuvIoLztPT/+M67Al1+5D9ZPtpb/
         uPbA==
X-Gm-Message-State: AOUpUlGr37rGmyPoQB897f4bNfST4JYbfxYE3gjVT6exgmfaZHlYq0oA
        Lg0HjtOeGsOpU35Iny4td6c=
X-Google-Smtp-Source: AA+uWPzKn0Gnv0pl6oIoGs8VlSc+e4Q1CBjaH4EIhn2xghHzY68vZ4PrP8sIpoQc4WzOe3y9dUWy9Q==
X-Received: by 2002:adf:b519:: with SMTP id a25-v6mr17976339wrd.273.1534354435276;
        Wed, 15 Aug 2018 10:33:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m129-v6sm12850670wma.1.2018.08.15.10.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 10:33:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] cherry-pick: fix --quit not deleting CHERRY_PICK_HEAD
References: <20180815162308.17747-1-pclouds@gmail.com>
        <20180815162308.17747-2-pclouds@gmail.com>
        <xmqqpnyjilrd.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CkXRc9NXRHt3a7=v04to0bMTvZo9x7zYNZWPiGDKQqdg@mail.gmail.com>
Date:   Wed, 15 Aug 2018 10:33:54 -0700
In-Reply-To: <CACsJy8CkXRc9NXRHt3a7=v04to0bMTvZo9x7zYNZWPiGDKQqdg@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 15 Aug 2018 19:30:33 +0200")
Message-ID: <xmqqlg97ilfh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Aug 15, 2018 at 7:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Please do not hide this bugfix behind 1/2 that is likely to require
>> longer to cook than the fix itself.   And more importantly, it makes
>> it impossible to merge down the fix to the maintenance track, as I
>> do not think we'd want to merge 1/2 there.
>
> Oh sorry I did not think about that. Will drop 1/2 and send 2/2 as
> standalone. But for the record, I think this has been a bug since the
> introduction of --quit in this command (back when it was still called
> --reset).

If this bug has been there longer, it is a reason why we may want to
ensure that the fix applies to even older maintenance tracks.

Thanks.
