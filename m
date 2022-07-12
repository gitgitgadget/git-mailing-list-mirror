Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0DBC433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 06:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiGLG4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 02:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGLG4n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 02:56:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4210951CC
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 23:56:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t3so8635349edd.0
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 23:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PkQw+bpjR/dl8lGgZH3EWzlBJfdGxto+NezrN6il0II=;
        b=PHHhq7/sOTWjDJ05RqChgx2kw+P+z8BDPXml3bM0ZF+B3lYmiVYS42Q7WzimYUNUgI
         4rCu7KW+gvsmuum7GWnhFhEZYcrGAqDd5V2W4V1a/ngxfcKcFyvWYpoPCLbRPGVGYI0c
         hGaINNw9Jt8KNYTEfWXFioEe6qHstfyfSS0S6bBGfNeMq5OuRcP8A6wN1G/qsUoNiDG7
         81zrluRVDyTal3vvDN+0nwUI50dpk7WzDsNLVf6xepThMHXGg/3R7d1GOYdGQYev9Hoj
         BJMTqt1YJd6Sd6mzPCON670NNU4CpElnrkuHk5IVmhZz6UdaTVdrZ7wy4svL4aTJMwmY
         4Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PkQw+bpjR/dl8lGgZH3EWzlBJfdGxto+NezrN6il0II=;
        b=Z65MV0RYYR4ovuYJJs1JHEfH8Ta99sJWPVBsmE6wL9492bn/pFZVY+GLME1pKBhWsC
         BsKKMkoPQ8XsapB6BrYSf6RDjERlrtdgUvMU2XyPfdPqIvpUD2N2m9GvqMBmpddINZFR
         D9zg6ytJqhAbNbymMP6oUL0TMgBenrXcqcWns/ZLsGp3wb8L4cDjXSOVWloHHmipzK+G
         PgXXtJYi9RqSduzr/s8Jd3SCVtmTV3sCUg1AitbgAEVXGvSkpLyDD66N3pdgQ+U8AdmH
         ek0F30CsCHBRpNQIMskK1GN4pskmJwSv+A2VydqAWAbIxqpQex3qiPQT3qb74XzvkTB+
         fTjA==
X-Gm-Message-State: AJIora8mj06hcC0Q7WDops1uHHiwULYDlgRbJgtQ+7iOM2QjbrzBhTFq
        SOMevegdIfzUJsGQnvEs2uMSpXSBYCg09w==
X-Google-Smtp-Source: AGRyM1vLii6+RSXzN8/9p2BwYTGnxrqQIys6GmEHKwP2OeqpUNHT+jAMyF5b4DM64oJUWmQrLAblWQ==
X-Received: by 2002:a05:6402:3511:b0:43a:cb79:e7cb with SMTP id b17-20020a056402351100b0043acb79e7cbmr15504355edd.43.1657609001231;
        Mon, 11 Jul 2022 23:56:41 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id fy12-20020a1709069f0c00b0072b7d76211dsm523426ejc.107.2022.07.11.23.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 23:56:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oB9p2-0018bV-0Q;
        Tue, 12 Jul 2022 08:56:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 4/4] .clang-format: don't indent "goto" labels
Date:   Tue, 12 Jul 2022 08:55:54 +0200
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
 <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
 <RFC-patch-4.4-e3a95c62bda-20220711T110019Z-avarab@gmail.com>
 <xmqq35f7nyy8.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq35f7nyy8.fsf@gitster.g>
Message-ID: <220712.86h73m6cpk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 11 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This change is a slightly mixed bag, we have a lot of "goto" labels
>> that are indented by exactly one space.
>>
>> Before & after this change running "make style-all-diff-apply" will
>> yield:
>>
>> 	509 files changed, 13042 insertions(+), 12745 deletions(-)
>> 	510 files changed, 13039 insertions(+), 12742 deletions(-)
>
> More files changed with fewer changes, or the above is not
> copy-and-paste but typed in?

It's copy/pasted, i.e. it's hit & miss when you massage these settings
if we change more files, or change fewer lines or whatever, and thes may
not be the same changes in the same files...
