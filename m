Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7EDD1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbeC1WMR (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:12:17 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35336 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbeC1WMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:12:16 -0400
Received: by mail-wr0-f194.google.com with SMTP id 80so3644119wrb.2
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 15:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oAFd4t+EfG+/EF6e2+NjMbCbE3NhofMpqEinAXe4aVk=;
        b=jKFnSlaZGK8H0vqck4zp67K/tr/qqKRtgTSHLOaMSa9QsRhHRmHxDPv5QVGeCSz9Ht
         wbaB8OfKF7YwxSyncs2m3iIugVpLM2gTzyzDBToBO2+HNCU3UKxS8mocGHejJhqVhwGx
         bGUwXDPg/38WCHnHkR/vdSslc49sgqRPwe47l9g8vxPNUF3ciXzYqyLSLn0yqZNt4VNv
         1+lm5688tMWZUyxBmi7pyKhP+bkOMH4YEFh+r9WgmS0tqy1T0SvYnRYHqK4iDk6EMqFD
         fwJO7ZhtJJ+qQZ80hEaPJX+zpdLLER00NOXyarkaKfjlbweKymBGcTSKs2OAJFI672S7
         MgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oAFd4t+EfG+/EF6e2+NjMbCbE3NhofMpqEinAXe4aVk=;
        b=nIvM8UOmJabQ13rRA0e0mTMemEejsG6EQ5cM/EQDzIFM8/txMAZN9tZ+RHwoJxLbFb
         1Rz13ZmJnnvdQYYyugvrRC5JQ852n4T4xVWG/DdtWg5+/ShTKa/O1gvfJTX/0NfnNvsc
         0YR6wGvwVTNshgQyIeZlpt1xbVpLvE9/IClJ8Y6IQf6uchufczLKkc01oEfb0Dy5s61+
         EXzOEuUtIPAB29yKgYUBbDObDG2UGOrR35EFn3+Rrca+lryfV1V8XsasbLD7thxMUunm
         08aR7aHiDZMlTu/TWeCW8bRqg9dEcrGtwoOsrYX/d+8bAckZklzJN1ZWiYNB0hiAFmUP
         xZ1A==
X-Gm-Message-State: AElRT7F3Kb79/BKxED7v+VEyaCZaFx54Kss7xo+p+h2+slRlIBYQYf2m
        FAwFJUrqV37uyV8xJs/7aMU=
X-Google-Smtp-Source: AIpwx4+BRCNDI21wN3a2VfRAEHqOv04eEl7GaogxJlWH8ddN+eOptrp8FgXaXwRv5juFlpShGSGmUA==
X-Received: by 10.223.142.244 with SMTP id q107mr4365724wrb.64.1522275134644;
        Wed, 28 Mar 2018 15:12:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v53sm7097675wrc.45.2018.03.28.15.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 15:12:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC/PATCH] upload-pack: disable object filtering when disabled by config
References: <20180328203303.GA260688@aiede.svl.corp.google.com>
Date:   Wed, 28 Mar 2018 15:12:12 -0700
In-Reply-To: <20180328203303.GA260688@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Wed, 28 Mar 2018 13:33:03 -0700")
Message-ID: <xmqqo9j77sub.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> When upload-pack gained partial clone support (v2.17.0-rc0~132^2~12,
> 2017-12-08), it was guarded by the uploadpack.allowFilter config item
> to allow server operators to control when they start supporting it.
>
> That config item didn't go far enough, though: it controls whether the
> 'filter' capability is advertised, but if a (custom) client ignores
> the capability advertisement and passes a filter specification anyway,
> the server would handle that despite allowFilter being false.
>
> This is particularly significant if a security bug is discovered in
> this new experimental partial clone code.  Installations without
> uploadpack.allowFilter ought not to be affected since they don't
> intend to support partial clone, but they would be swept up into being
> vulnerable.
>
> Simplify and limit the attack surface by making uploadpack.allowFilter
> disable the feature, not just the advertisement of it.
>
> NEEDSWORK: tests
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Noticed while reviewing the corresponding JGit code.
>
> If this change seems like a good idea, I can add tests and re-send it
> for real.

Yup.  The names of the static variables tell almost the whole story
to convince me why this is a good change ;-).  It is not about
advertising a feature alone, but if the feature is actually enabled,
so advertisement and handling of the feature should be either both
enabled or disabled.

Thanks.
