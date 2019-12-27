Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE37CC2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16C820740
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="eULgfhkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfL0N4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:56:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44269 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfL0N4k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:56:40 -0500
Received: by mail-pl1-f196.google.com with SMTP id az3so11753441plb.11
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=icy15Id/zba3+EXoO8JqxpullHeL9xxberavVWnCAU0=;
        b=eULgfhkwaoG2CY/vXxXZEche26Zy4QT8BKiJL8ih+m5thyIss/usfKCcc5oDrBoaJ8
         U9YNnxWP+HpHhdAor7lZPF07J16bYUyhpKJHqLXEQgtqEwqOAuoa4b1paCZmwqFtq9T9
         qVLX17j8EMp9xXuM3d6155q3mwkgbYOQ7P2Sri+y7ubiBBYq0rsqTQaYexNw3D0RJzcp
         RNWAEfOeHAnx2PeLW4I+kwUExXgM2E7kkpl3GcP1g5S0I31vp4Z+WgKFSwZ4aaag7Aup
         zK67lwuDmPfo4ny+JkufzkgExOdYq/UJa/ZCC+61RXdlsjBZd4/8LtE/UAtHcGzo851S
         Lhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=icy15Id/zba3+EXoO8JqxpullHeL9xxberavVWnCAU0=;
        b=plyKnC1RbG3j2hJkH8z+lSxGtB4kI7QOgtREnVnluyMNJqe1oRJTJhunM0S0DwcBdz
         TSPMrLNaWVbdGDLZPnM58/AbYkueON9bnY0hjPotNnc6F5ALQf+lBaKOun0AXM/Rahrj
         RA242zSvCIXDZDEOQs2gyJLeLsOy7D4DWmWZnmaxPQhv9MaB6NcYyXOHz4E3wR64akGC
         ++xtBcL7KmWdeKEZnpnRH0ss9ifqD0Eiadxz74TFJFoTf6WxWus0PSCJzppG+I/2l1aP
         btJWZ72WgD+ElaK3wxl6u5q3MpyEIq6gqC9MzersFLWhHtT2ZrSJ4St7kKQG5+iGskjd
         5n7g==
X-Gm-Message-State: APjAAAUwfhsuIch/ARpxHH4mKW+netiiWCQLN4xIHV8/iyqk1TEQkXCg
        3IR92XqYMb3/wO/CySQpUWINio1DECo=
X-Google-Smtp-Source: APXvYqxBAhyna1a1vl6n0ttgzVFqWMCb20u/TA+IxEYAAA3dCB48Tc+BmqDoNnblk4KMLWjeM1/LDQ==
X-Received: by 2002:a17:90a:77c1:: with SMTP id e1mr26495676pjs.134.1577454999516;
        Fri, 27 Dec 2019 05:56:39 -0800 (PST)
Received: from localhost ([27.109.113.235])
        by smtp.gmail.com with ESMTPSA id c2sm14353026pjq.27.2019.12.27.05.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:56:39 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] gpg-interface: add minTrustLevel as a configuration option
In-Reply-To: <xmqqblrx5yxu.fsf@gitster-ct.c.googlers.com>
References: <20191219000140.9056-1-hji@dyntopia.com> <20191222003123.10555-1-hji@dyntopia.com> <20191222003123.10555-2-hji@dyntopia.com> <xmqqblrx5yxu.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 27 Dec 2019 13:46:52 +0000
Message-ID: <87r20pkhir.hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 24 2019, Junio C Hamano wrote:
> Hans Jerry Illikainen <hji@dyntopia.com> writes:
>
>> +				/* Do we have trust level? */
>> +				if (sigcheck_gpg_status[i].flags & GPG_STATUS_TRUST_LEVEL) {
>> +					/*
>> +					 * GPG v1 and v2 differs in how the
>> +					 * TRUST_ lines are written.  Some
>> +					 * trust lines contain no additional
>> +					 * space-separated information for v1.
>> +					 */
>> +					next = strchr(line, ' ');
>> +					if (!next)
>> +						next = strchrnul(line, '\n');
>> +					trust = xmemdupz(line, next - line);
>
> I wonder if telling strcspn() to stop at either SP or LF is more in
> line with the existing codebase [*1*] and/or more readable.  It
> would make this part to:
>
> 		size_t trust_size = strcspn(line, " \n");
> 		trust = xmemdupz(line, trust_size);
>
> without the need to use or update the 'next' variable, if I am not
> mistaken?

I agree; fixed in v3.

> By the way, while we are looking at this patch, I notice that,
> throughout the function, the use of variable 'next' feels rather
> misleading, at least to me.
>
> [...]
>
> I wonder if the code becomes less misleading if we either (1)
> renamed 'next' to a name that hints more strongly that it is not the
> 'next' line but the end of the current token we are interested in,
> or (2) get rid of the pointer and instead counted size of the
> current token we are interested in, or perhaps both?  

Yeah the name 'next' does seem a bit counter-intuitive when used in
relation to 'line'.  Looking through the function it seems that both (1)
and (2) would work.

> This is not the fault of this patch, but I just mention it before I
> forget.
>
> Thanks.

Thanks for the review!

-- 
hji
