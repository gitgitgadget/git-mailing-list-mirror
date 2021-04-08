Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC12EC43461
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB86610C7
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhDHWp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHWp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 18:45:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D5C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 15:45:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u21so5594802ejo.13
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+QnlAplU1dMQ4zW/j3qJHetctVCU9I6oyGBJfW2CGhQ=;
        b=oHE2R4vU2ooxDZntik0eI7Wbz7ekh95DEkGWKgyn3ePUBTrfCEKIGvar1Z9xmuscbW
         5WHKNLSnsIlixggIKdDe2JrtditLmWnnS2D2VY96FM7/XAMEz63I+kpWUTfe4aSeKYN8
         AdPx9Lzq4tqHO+HNrvJE/eMMHFLtfkVuc/nKTHyl5qNYybBwpED2U6iZCI3NR6KzHzNO
         PcGHGtKur/eDCd4YmcIppzrLgcsHKqNBJwf0xmdsW6NfhnBvDQfg8IKi8ETaRmQQmxzD
         mH/727vCn8O+LP4NWGLx9ma/rXwh6FXtjy2Q60bNyFBOUYHO/NMneqeDbSweOI8XNt0H
         kbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+QnlAplU1dMQ4zW/j3qJHetctVCU9I6oyGBJfW2CGhQ=;
        b=sqF4bQlIYwqYOXiDjaP/2yNSOYnBUp0Hw/5iB/FeCmE0l0RWN2iUpbZguq6mFyeh8i
         eLYl7Xdc/x3GH6c6WAf3JkUP0jn+G5vOKGyvtK8TBVguVzulsHgpFWbS2xnwPk2kAkUW
         ZIto9PZwMGJuIwD05a9um9qZ1FiOO0Gr1v5g6QHCY/JemCRBdoCuMHuQi4sV9hxG4EaV
         SrEpELA6sIRGp6JfZW+9KSRMndrB8SuxVJTJzxvnhO0XOcI/9iN9IgLiS+FZEgzpuABZ
         UuDGp8/b+WUiBi43DzZhsTSNwaT/3pfnfIQQfaE39v4ZAH2LDa8Z2lMsJf/RQ84xAGZH
         qSHg==
X-Gm-Message-State: AOAM531vHjKh/cztakr+j7euzkUD//BB8dSWfYXgo2hhHS/wI4IqiBzg
        gqrZN1vqqJJYFujNqPHxUVQ=
X-Google-Smtp-Source: ABdhPJydjcwTs8mBWAbVbtf/vKfRiJGXERnhKn2ZnbQQKx0bLUWDMLa9lV4WLRJdFc2H8/NLZeCKuQ==
X-Received: by 2002:a17:906:1351:: with SMTP id x17mr13574086ejb.242.1617921945018;
        Thu, 08 Apr 2021 15:45:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l1sm367271edt.59.2021.04.08.15.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 15:45:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Georgios Kontaxis <geko1702+commits@99rst.org>,
        Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5] gitweb: redacted e-mail addresses feature.
References: <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com>
        <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
        <20210329014744.GA2813@dcvr>
        <8330ef0d7195de461f961d72f90998fa.squirrel@mail.kodaksys.org>
        <20210408171648.GA7133@dcvr> <xmqqmtu8sd2a.fsf@gitster.g>
        <20210408211904.GA16486@dcvr>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210408211904.GA16486@dcvr>
Date:   Fri, 09 Apr 2021 00:45:44 +0200
Message-ID: <87blaoieef.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 08 2021, Eric Wong wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Wong <e@80x24.org> writes:
>> > As a data point, none of the homograph@ candidates I posted here
>> > on Mar 29 have attracted any attempts on my mail server.
>> 
>> That is an interesting observation.  All homograph@ non-addresses,
>> if a human corrected the funnies in their spelling, would have hit
>> whoever handles @80x24.org mailboxes.
>> 
>> I take it to mean that as a future direction, replacing <redacted>
>> with the obfuscated-but-readable-by-humans homographs is a likely
>> improvement that would help human users while still inconveniencing
>> the crawlers.  It may however need some provision to prevent casual
>> end-users from cutting-and-pasting these homographs, as you said in
>> your original mention of the homograph approach.
>
> Yes, exactly.
>
>> But other than that, does the patch look reasonable?
>
> I only took a cursory glance at it, but v6 seemed fine.

Ditto, I left a small nit comment about a needless /i in a regex, but I
don't think that needs a re-roll.
