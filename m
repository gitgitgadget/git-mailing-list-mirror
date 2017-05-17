Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D577201A7
	for <e@80x24.org>; Wed, 17 May 2017 17:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754599AbdEQR5h (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 13:57:37 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35801 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbdEQR5f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 13:57:35 -0400
Received: by mail-pf0-f181.google.com with SMTP id n23so10994195pfb.2
        for <git@vger.kernel.org>; Wed, 17 May 2017 10:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k7DD6KQeQAjztXU/+dkJao3QueKWPxnJgNC6AfvvenA=;
        b=cqrKchqk62BBv+qwcB3/3HpfjmrY+hHcuxTaZGxJGJl6V8ldiDjDvBEoQLig7cbc1h
         qfvNzonGPWm0KQ+QBzUUCIb7qDwRhr8teLx4YivPol1+s7bOn1nu/+dyCw3iAf703jLw
         bw9kb0gnH1hP6xSlulR+lqREOH7D661pWvRGD905puETabGNev+1j/6slexH9x4cphJ9
         QIDYK3+dPuIOvc+Sd/NIFQ+TczQOAnlZIEZrkoMSl8HH9F5WrRAfG2KXD0rILKqJQw7A
         y/I0ue3fehBTFpBKOskJe3VuN8dK49N8MWjZF+SBIHZbdJDxFWVJLeHYUTrsRKE3gPho
         7tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k7DD6KQeQAjztXU/+dkJao3QueKWPxnJgNC6AfvvenA=;
        b=T4hi/cXO6rDbWmcw/0XdCjf7+wq6JeMLayQ5CoQI1JVqj7bt9e9/er6Ecg/rsgokNl
         3CjKP2wSFqh5igigUdFA9lZ9lexDKh5wXRC0LSk057XfXlhjLdr8MMscJwWAYhUppQuh
         lTT4vUZ7XD+S1gj/TsEuI0o6orGH35MA5GJ2SJFWVGBt5yGulL9e2tMcJhHhdZxOW8kR
         f9FxmUmnttLZBjVuvlu19sX+4W+YS3YU55rwe094GOsKI4X9RS4gap/K7CH6qVrGDX4F
         kjkF0cXBkbr98jKeDvog8oAS3p9C/9iFdcIsmJXikczPD6tqYnP2z7+alLzMJN4R5ecG
         8QqA==
X-Gm-Message-State: AODbwcA+/1WX5H+268xG/Jo9QYukWdoDkvdX8MzsHS3BidNGr5j2GGs3
        7Bg3gRFV+4GTDdxafwE8v/hFoEQstobl
X-Received: by 10.98.148.2 with SMTP id m2mr18174pfe.194.1495043855130; Wed,
 17 May 2017 10:57:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 17 May 2017 10:57:34 -0700 (PDT)
In-Reply-To: <eedc8f85c8237515bc66584649b1e3f3d547049c.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu> <eedc8f85c8237515bc66584649b1e3f3d547049c.1495014840.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 17 May 2017 10:57:34 -0700
Message-ID: <CAGZ79kb65sv8g6XUQMcGTkZ0ubpY2LYpj7g2wv15knXuv7oKhw@mail.gmail.com>
Subject: Re: [PATCH 17/23] get_packed_ref_cache(): assume "packed-refs" won't
 change while locked
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 5:05 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> If we've got the "packed-refs" file locked, then it can't change;
> there's no need to keep calling `stat_validity_check()` on it.

This change will work in a world where all Git implementations
obey a lock. If there is at least one implementation that doesn't
care about the existence of lock files we may introduce a race
here.

I am not sure if it is worth to be extra careful in the common case
though. But I could imagine some people using a git repo on an
NFS concurrently with different implementations and one of them
is an old / careless lock-ignoring implementation.

My opinion is not strong enough that I'd veto such a patch
just food for thought.

Thanks,
Stefan
