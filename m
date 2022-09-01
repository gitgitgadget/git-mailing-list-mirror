Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5622ECAAD2
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 21:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiIAVXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 17:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbiIAVXs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 17:23:48 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99BD92F40
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 14:23:47 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id o5-20020a1709026b0500b001755c286c81so1440plk.14
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date;
        bh=4dJLcXkWstt1hM+KMYsJQw+WRGMO16hkzgaaLQEVQWM=;
        b=dDxu8KFW2jBZYWBiI9QG7CY1f90GZBTP7h5mUNx1VayI9hgSImGbGov5c6Jm7aniEl
         5RKVqwClhGyTIjV5hkVlpPghSwPOf9fargrWF9kTD9GOOx7ZKrz6ywAjFPekJ6/eXiEf
         xgnOwx8twDGEOUIgJUF4md+lR0FS5D8HWJdGkr07W/im1yTBTAO06sGWqgIHDLilmdH3
         W/HEE+A1cWRXzAu449lR8LmqMUb5GOPZ3rYM+2xBtOqQSvhhn0V7IxTXgyxlOqO7qI89
         8lSdIXXsMlWNzH87jrcxmsINAj4Zo4z+D1LIzFfdG9D3IkFU2yvzdiVdQ6Mp2ZGEQOQB
         mIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date;
        bh=4dJLcXkWstt1hM+KMYsJQw+WRGMO16hkzgaaLQEVQWM=;
        b=1VE74LL5Pw4evdkEgAg4BV8b9P03wk67TrGhxchK/vWo+JZsPMaLaTdNLrvY9yDb0x
         MdIAJhthjppEMWq9bi4x6jJM2j4RmcjrjjwReQs/hxoh+E8TWg6etujFCm0Teum51kkQ
         6t2dSPlD38ygCBnduJNukNUXb8etOUgu7csoocYmBJbzmHBbc6vIhGsVmQnzrsWkzrs3
         LwfjKUD6SWgC6qapnUJSAy9qL5b+qGjxGVkM7M2AQHtiYpiSF1QB9jTWVsZ3K6TQ6j2z
         vNVpIsnRTpRHI58LaQOojxLCnFAXMGJBB/NmgMCLJMibHvv7h+DxIH1OHv7kJADLXv2t
         LIjw==
X-Gm-Message-State: ACgBeo2HWTE/7UOXfBB4sAXdreFieAPsFH0YJRa4CV9knwd0Ia/L5jqP
        tB43sJsMCJTJHvDdH5tY3XkOQbBNt36ZqQ==
X-Google-Smtp-Source: AA6agR58worpAswcTJydPzIFBwO/5eHUded4Kq3IPGbHbVgZq01enpQQtuDauwxROu5DDbbFLg6f/QOyimbScg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:92d8:0:b0:537:acbf:5e85 with SMTP id
 k24-20020aa792d8000000b00537acbf5e85mr32636428pfa.61.1662067427440; Thu, 01
 Sep 2022 14:23:47 -0700 (PDT)
Date:   Thu, 01 Sep 2022 14:23:45 -0700
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
Message-ID: <kl6lr10ubxge.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v7 00/17] submodule--helper: fix memory leaks
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This series fixes all of the memory leaks in
> builtin/submodule--helper.c that our test suite spots, except for
> those where the leak is downstream of cmd_submodule__helper() and
> caused by code that's not in builtin/submodule--helper.c (e.g. leaks
> in the object or config APIs, and in submodule.c).
>
> This re-roll is on top of the just-now re-rolled v4 of the base
> topic[1].
>
> Changes in v7:
>
>  * Rebase on top of the base topic.
>  * Clarify some questions on v6 in updated commit messages.
>  * Go with Glen's suggested "displaypath" fix. I also tried another
>    way which the commit discusses. The end result was better, but it
>    requires further submodule--helper cleanups, and this is already
>    quite an Odyssey. So FREE_AND_NULL() will do.
>
> 1. https://lore.kernel.org/git/cover-v4-00.33-00000000000-20220831T230519=
Z-avarab@gmail.com
>
> This series & passing CI can be seen at:
> https://github.com/avar/git/tree/avar/submodule--helper-memory-leaks-7

Thanks! And thanks especially for dealing with my stream of comments :)

This series + the prep series LGTM.

  Reviewed-by: Glen Choo <chooglen@google.com>
