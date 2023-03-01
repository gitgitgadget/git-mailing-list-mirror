Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C5FC678D4
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 19:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCATkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 14:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCATkT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 14:40:19 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731101B2ED
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 11:40:18 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id v11so11642438plz.8
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 11:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJ/mgSCwVvBIgi5J+DpPVkuM1NHO9abOuyaBuO8F2Bo=;
        b=EzaVodRrnk2NhbUtqavts/o7jGI64k1GPMYnPF9a0vXgNZnjie0G0XtwtIBg/Gmv7C
         MbvI78zQqJv3+8ydxUNwhvTK4NCMA+X8TgBdYjM5WNvUjZ8rv8UwLfwTYOGiIv7GiuYO
         hz/xHIw+zflV4v5dI/HPJ2GXYhJF6uvIPgg8hK9HeGVKoPaQ2S3mTu+5tDhoccCPAd8M
         LXRO32xzpt2ogRb+DVwC0kzwqRjqXUOCgOvjRt+bUEmJJQEIIVA8+jT0blT976wKXyDM
         HH95EIYn6H+PzmPy6BLI0DHDpfdWdYykgvd4ezed/pEOMoGbZ8SM+NKUNIXHhPv53bu3
         N7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LJ/mgSCwVvBIgi5J+DpPVkuM1NHO9abOuyaBuO8F2Bo=;
        b=oNUbLaf06gYBvrYP+GmclPORCk9aGzznjTrRO+lERRfA6IdX3F6C5ek2yTbxPYsvdI
         oNjPiJ52DKJlqoRHAmjdnJ6gSp/ARc4hcYfxsXuFhfRscNqKXJtKRo+w9IIxl1fP/ytw
         KWXI53E6R2z1rguChUoNKRzZzt+oPgFSPRN3EvPpN/pVEX8EXaOpD3pN8N1q/u05Hx7+
         9j6igtaZfNRw7//CsljYFtmp1Q0ADjnhITybAzV4h+oQTho8Cw6UDKTk/Q4JRfDcdK+V
         CiTvrenA8fcUPilsbZn1tA3a3cULV/zWLfjga8REjlKGRgaSvYdJB5Xm4e1ckbwGHrDO
         GVOA==
X-Gm-Message-State: AO0yUKVCq8U8Trbuf5J+/ocsArSoZBZzb568E9woIXYkRvOI/xUXkPTj
        5mhGNQAJOG2Aj+FOzEuR9fs=
X-Google-Smtp-Source: AK7set86edtYSOKGJm8qK4EB6Q5FMf/XUqq1/cRIc8Unyc8FNIG7hBbwYiTqv1fUhaKfDfX20gGohw==
X-Received: by 2002:a05:6a20:3d92:b0:cd:1ccf:246b with SMTP id s18-20020a056a203d9200b000cd1ccf246bmr9009600pzi.57.1677699617805;
        Wed, 01 Mar 2023 11:40:17 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id j13-20020a62b60d000000b005a8851e0cddsm8263564pff.188.2023.03.01.11.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 11:40:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: "git diff" surprising default output
References: <871qm849co.fsf@osv.gnss.ru>
Date:   Wed, 01 Mar 2023 11:40:17 -0800
In-Reply-To: <871qm849co.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        01 Mar 2023 21:25:43 +0300")
Message-ID: <xmqqzg8wmfa6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I figured the offender is --indent-heuristic that is described in the
> manual as:
>
>       Enable the heuristic that shifts diff hunk boundaries to make
>       patches easier to read. This is the default.
>
> but apparently rather makes patches harder to read, at least at some
> conditions. Turning it off helps to get the expected result:

As a heuristic, it is not surprising that it has some corner cases
where it does not shine.  I think the version that was eventually
merged starts here

  https://lore.kernel.org/git/cover.1473068229.git.mhagger@alum.mit.edu/

and we should be able to find a few links to the original
observation that motivated the change, e.g.

  https://public-inbox.org/git/cover.1470259583.git.mhagger@alum.mit.edu/



Thanks.
