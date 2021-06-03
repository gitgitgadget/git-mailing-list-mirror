Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E91C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 08:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12BB3613C9
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 08:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFCIfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 04:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhFCIfF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 04:35:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA4C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 01:33:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ce15so8012480ejb.4
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=eEoR1T2ILuBKLudKJmjDog0eo4xZE4pYnjS0VdRT5Is=;
        b=dwUMX4fuXOz9D60Pg8MYshIMQzXDbAfL8xSNW0KQMDQl4na87D0PuIo2tRf+lfX/Hc
         CsaX37hdk5FvwAhKGyPvtL0JtHGKLYsajSOyNVwWxXtas/Vx7v5KrNJ7A0zh7zxK9fqi
         3V5umyFxjeeA47xuFanZVfZ/w1iWfwYyLK+1cz69Vdi831iyzCFfGp21irCwR9hAB95y
         uukTZqpUI8OFHrLVVk/NvBuosZCrN8WQ1yYQtmNRl8PIQ+RbO2LRYUZkR2Ez2eT6lv4D
         01rUrKBnpWxcxtaPCEAqASWuFa9MIIJyBVeuTG7D6FAo1RNb7jHkar1dxKCGhd90cKg0
         5CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=eEoR1T2ILuBKLudKJmjDog0eo4xZE4pYnjS0VdRT5Is=;
        b=pP6PvRzna54MhyH6lhEHPJEqLjD8LYgkKk7Sge3kR0xMEvSZrY8hoSwaAA6uV0DXWh
         re+oVsufIzY+aIjYDnMhBjKt1Lewk9YrtkVDX+eXHOi6K0JeQ9EMSLconjM7sixZl8UX
         QfBHmWnHOvveKlCxcHPgW7n6gc0+cj9OnvPTY7WeXeB6VJAXr+DY+ToosHXUmdb2xDsT
         uFXJXdYwPL7H2f8OhFnNZ8mRmMjSp7K20CEeRt2RfArkwzxN3GFSW++s07K1PuAftLlX
         pjWgAlK15tYxwx376b67CZNboeWL8wZd6MZPKDYkMp+Jx/hPQyHRWceSD8eo7t1rMWjJ
         o9wA==
X-Gm-Message-State: AOAM531wc01mY0LS8zy0px/5it8PaUF8bQdtjnI5ilM+mMluKTKgdJqf
        rPf3eDLTSPoeVfspPyx5nsQ=
X-Google-Smtp-Source: ABdhPJzfz1LWlO5I2vMODkapoX0WaEY3xd+rGPHmAmR0LapAvpjnAh6nhB4I+4uk880prb9UEBUaeQ==
X-Received: by 2002:a17:906:c241:: with SMTP id bl1mr37505572ejb.536.1622709197686;
        Thu, 03 Jun 2021 01:33:17 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m16sm1335785edq.56.2021.06.03.01.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 01:33:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Gmail OAuth2 in git send-email
Date:   Thu, 03 Jun 2021 10:28:37 +0200
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <YLhx7nIptHUwXfBD@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YLhx7nIptHUwXfBD@google.com>
Message-ID: <878s3r73g3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 02 2021, Jonathan Nieder wrote:

> Hi,
>
> Bagas Sanjaya wrote:
>
>> We wonder whether git send-email can support Gmail OAuth2 so that we can
>> seamlessly send patches without having to choose either action. But howe=
ver,
>> we have to create a GCP project [1] first in order to enable Gmail API. =
This
>> can be overkill for some folks, but unfortunately that's the only way.
>
> Yes, that's how I have mutt and other tools working with my Gmail
> account set up.  See [1] for details.
>
>> If we want to enable support for Gmail OAuth2, should we hands-off API
>> configuration to git send-email users, or should we configure it on beha=
lf
>> of them? Note that when we go the former approach, some Gmail users simp=
ly
>> can't afford GCP pricing for whatever reason
>
> I didn't have to pay for GCP in order to set this up; I only had to
> follow the instructions at
> https://developers.google.com/identity/protocols/oauth2 to create a
> client ID and client secret for oauth access.
>
> Alas, I don't think Git can provide its own client secret to do this
> out of the box.  I could imagine Git providing a way to supply an API
> key at build time, but distros would need to go through a procedure
> similar to [2] to make use of it for their own builds.  If someone
> wants to set that up, I think that would make sense as its _own_
> separate package --- e.g. a "sendgmail" command that "git send-email"
> could use via the --sendmail-cmd option.  That way, it would be useful
> for a variety of calling programs and not just Git.

It's been a while but I set this up at some point, why would git or
distros need to make/register a private key? Last I checked you can take
software like git-send-email or whatever, and just register a new
"jonathan's e-mail sending script" with Google's OAuth thingy.

That "jonathan's e-mail sending script" happens to be git-send-email
with a bit of configuration isn't something they know or care about.

That seems like a much better approach than some centralized solution,
since as you note doing that will require some authority to manage keys
etc, and presumably if "jonathan's e-mail sending script" inadvertently
starts using git-send-email.perl to send spam, that would currently not
result in ban on "=C3=A6var's e-mail sending script", but if the two were
registered as the same application Google might overzelously ban those
as two tenticles of the same misbehaving "app".

