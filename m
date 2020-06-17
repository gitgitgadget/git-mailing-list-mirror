Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA82C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974F8206DB
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXFWvDE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgFQUKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgFQUKl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 16:10:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6A1C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 13:10:41 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v14so1828708pgl.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xsglgFSVpZiFqXQvSHVQHCtwqLW1tLEXxZEZG/hV9o0=;
        b=rXFWvDE+VluLjZcXDGj+lh2SUnj2dlH9wCqXhRv7aNe1epObd2LBMXqJ+DMdfp5CAM
         Y3fsBrQHuL7QkMTyt6+IZB2VBTLFuGJ3bWaogJwnZEcCqlK30lSYgSVGe8ZwO/OUJ4M9
         wFsFYXk3010/PTjkPC1ov2T6ZEd2dfdQMdtA/YJz+32lZHBpM8lSbd1kP6Kc7wAvlWGX
         5i7MD4vNtBNYN/nvsK5AM/Hp8gHQQPIWvLFnl6uHbmb1rbpnJKliK9v3PcAxlDiMsO+C
         VyOuLhF/dSzhM0jCYvfUzHIrdzJ1LqaGunVRn3giDnprLTrMN1HduQb4JUkfireIHw4d
         +xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xsglgFSVpZiFqXQvSHVQHCtwqLW1tLEXxZEZG/hV9o0=;
        b=PuiVYvVqVR0p0G/WyIu6q25UZlylz6eOdKs4j/wEs97P1xq81zu/MqkVdjdVsk83Vg
         2c/Foe3YObny8KRmJlcEkBRqnKm60ezaFIcum1LKzga7XA5kq2g9mEu441Nn5wx+bls0
         sm9U2J3l96LyM01Ji+T4xZ2QKQ2yoyk/Zy4+ZceOhZBYT+u9n2OzvRuSDEdzVT9DHXs9
         BWRF/bxRW2GZiFYzJo39rXexAXXjHkCJhX/8hpr8P7iLQ+JjnS89CyYsG8b2+UiKyxua
         MIzBTpZwxFBxVVGu1BmxTPcFC6/E3AlxeLYYJZE0wB2/pOxjsZPWBKscjWib8wcNcr6Z
         62Jw==
X-Gm-Message-State: AOAM533hN+7Q1ypE3q6MjL4IrfF1Uaq6j1OwdH9BITffWvKC0sMzS77v
        r/E9sUStuDlPV5rXtquajdgG0bzb
X-Google-Smtp-Source: ABdhPJwUdl54QjPHvruFkTY/hO/tkoPqsXMSnTEsb/u+6YyVYxsEWo+J2dK1a4CzO37XrrdGq9QDdw==
X-Received: by 2002:a63:4d53:: with SMTP id n19mr488387pgl.60.1592424640254;
        Wed, 17 Jun 2020 13:10:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id o207sm662511pfd.56.2020.06.17.13.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:10:39 -0700 (PDT)
Date:   Wed, 17 Jun 2020 13:10:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     demerphq <demerphq@gmail.com>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna 
        <sergio.a.vianna@gmail.com>, konstantin@linuxfoundation.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        don@goodman-wilson.com, Git <git@vger.kernel.org>,
        newren@gmail.com, philipoakley@iee.email,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200617201037.GA86579@google.com>
References: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
 <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com>
 <CANgJU+WoGNKuvZHAtLAfNAUfFdoLWHiDis_rSV-AfT9WspmHgA@mail.gmail.com>
 <20200616074316.GA21462@kitsune.suse.cz>
 <CANgJU+XzD9Nnnu4qWExpOUBy+u1=23SRCQy-=6aAVFJAowkjYg@mail.gmail.com>
 <xmqq5zbpv53g.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5zbpv53g.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> demerphq <demerphq@gmail.com> writes:

>> kind of confusion. Consider how this conversation goes for us:
>>
>> A: "No you need to fetch trunk from the remote, then you need to merge
>> it to your local trunk and then push it to the master trunk".
>> B: "Ok."
>
> Hmph, why isn't the last one "trunk trunk"?
>
>> Similarly when the perl project migrated to git we renamed "master" to
>> "blead" to reduce the possibility "master master" confusion.
>
> Or put it differently, "your local master?  remote master?  or the
> primary master?" would be a way to state the phrase A asked in the
> example without renaming the name for the primary branch to 'trunk'.
>
> What I am trying to get at is, after changing the name that is given
> by default to the primary branch in a newly created repositories by
> "git init" to 'main' (which I am OK with, and it seems that the
> major projects and repository hosting services will be doing anyway
> with or without getting themselves in this discussion on this list),
> wouldn't we risk the same "master master" confusion caused by and to
> those newer users who learn 'main' is the word given to the primary
> thing?

I think Yves's point is that when the tool you are building has a
component named $FOO, it's confusing to also have a branch named $FOO.

So for example, if we were in the habit of calling main.c 'main' and
frequently referring to it, this could be a reason to avoid also using
'main' as the name of the primary development branch.  When someone
says "that's fixed in main", it could prompt a moment of confusion ---
did they mean that there's a fix in main.c, or that the fix has landed
in the main branch?

In particular when building distributed systems, historically it has
been common to have one of the components being built be named
'master'.

Fortunately in this context, I haven't heard 'main' used frequently
that way.  (I suppose it helps that main() functions are often short.)

Thanks,
Jonathan
