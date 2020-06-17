Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E258C433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D3D21532
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQNFkjvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgFQURN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgFQURN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 16:17:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B5DC06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 13:17:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y18so1455701plr.4
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vbqdvBS+YsBat0AIiL1JH+N6+AQ+WdlZyIt/KBJIVkA=;
        b=eQNFkjvdyRwgW2FP2dUDDKM7UPLB4+ubGdD5RCQnmz07HLOrrJiKGoWmojeby1kFA2
         sqsMIK8n4WW5owV4LnJgA6Kdh5ytvg829TUbOnLQ5gZW+Y6GM+kv0LLbmUjyAZJQxMfi
         Jq36ijYcKJR9P8lPBoZjVOqzC14++FxP3mdx2wsgjMFmXT5BTPYn2yHIVRiVjOzsTYv8
         pkSOJWw3a+leDf22Ccm2fsDKffP52kqGkYt+o9NX8L+YmktwCBz9uTuPjD8qJUhwpEbV
         UeAqPPfLu43GaEBwgWLvGnPg6v1sBkj2QVHCgYDGMl9hgBgxGqtQLMfQ9hYTuwerBVE+
         /0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vbqdvBS+YsBat0AIiL1JH+N6+AQ+WdlZyIt/KBJIVkA=;
        b=ttqZT4luBYEoBTldSjgARMiQa9jtSWoV4stAADcTudhlWiM5/CA8ejTUt/u6L1QtQL
         VlSGK27lTwGv0lTiuwpPEIQbaaOStLxXaVmRt1diklTXW5ejFcQbaT705xJnAQ7MtKN7
         yIXiyNFnxs5kCs9ou+nFsU3fio/gBLxU8UHzTVC9YarJ/EGbyD6OFFW6do68iKOmF0ad
         lKJKJpCQ0ZJpjyncSp8YhFN9C5ksrpFwzPU2L7ZkQDEkEBmRS94qerEAU67HfBBbtAyI
         MNrgPO88Tz0Sxe4gl93Bsh26byYLeRK7xeIjq31K98HDPMSlHuhhcAXfRwa6ZWqQ2Y5k
         XOvA==
X-Gm-Message-State: AOAM53277QQWe9ZNZ5KPq6X73+5w3nP0TnH9080NHBWh6CvcU2kLQRrw
        2BoPYvQTJqmd5iN24vSV69g=
X-Google-Smtp-Source: ABdhPJyruTnAldEsVhUWIc86fsrIiijoQpeM4Gvt6KjHG6uUYQeL0UTNd59O0HlV7xVjVZcAmB65/g==
X-Received: by 2002:a17:902:7785:: with SMTP id o5mr732092pll.288.1592425032455;
        Wed, 17 Jun 2020 13:17:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id s26sm557435pga.80.2020.06.17.13.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:17:11 -0700 (PDT)
Date:   Wed, 17 Jun 2020 13:17:09 -0700
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
Message-ID: <20200617201709.GB86579@google.com>
References: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
 <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com>
 <CANgJU+WoGNKuvZHAtLAfNAUfFdoLWHiDis_rSV-AfT9WspmHgA@mail.gmail.com>
 <20200616074316.GA21462@kitsune.suse.cz>
 <CANgJU+XzD9Nnnu4qWExpOUBy+u1=23SRCQy-=6aAVFJAowkjYg@mail.gmail.com>
 <xmqq5zbpv53g.fsf@gitster.c.googlers.com>
 <20200617201037.GA86579@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617201037.GA86579@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Junio C Hamano wrote:
>> demerphq <demerphq@gmail.com> writes:

>>> kind of confusion. Consider how this conversation goes for us:
>>>
>>> A: "No you need to fetch trunk from the remote, then you need to merge
>>> it to your local trunk and then push it to the master trunk".
>>> B: "Ok."
>>
>> Hmph, why isn't the last one "trunk trunk"?
[...]
>> What I am trying to get at is, after changing the name that is given
>> by default to the primary branch in a newly created repositories by
>> "git init" to 'main' (which I am OK with, and it seems that the
>> major projects and repository hosting services will be doing anyway
>> with or without getting themselves in this discussion on this list),
>> wouldn't we risk the same "master master" confusion caused by and to
>> those newer users who learn 'main' is the word given to the primary
>> thing?
>
> I think Yves's point is that when the tool you are building has a
> component named $FOO, it's confusing to also have a branch named $FOO.
[...]
> In particular when building distributed systems, historically it has
> been common to have one of the components being built be named
> 'master'.

Of course I missed the other point --- hostnames like master.<domain>
(e.g., a hypothetical master.kernel.org), refering to the source of
truth for something that then gets replicated.

I don't think we're likely to see hostnames like main.kernel.org
because it's just *so generic* as a word.

Jonathan
