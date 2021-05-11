Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F398C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 06:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8F06144F
	for <git@archiver.kernel.org>; Tue, 11 May 2021 06:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhEKG6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 02:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhEKG6O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 02:58:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD90C06175F
        for <git@vger.kernel.org>; Mon, 10 May 2021 23:57:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id n25so21563779edr.5
        for <git@vger.kernel.org>; Mon, 10 May 2021 23:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gco0BPVYIVxNxmRiOHidGxPNI0iarLOBOR9PNYnwBOI=;
        b=pg4P8sF+o1l6A6Q99qk9P3hU5BOe0PvUhH/OTP9CZuy89P5T2VCFaLDo5zsv8C4aiH
         HFYgRcW9MZdLxtk/VcI/9LSQkE5OwBc/Xuu1M0QI8bP+fCwPCehZY/sQP0j4PtVzSpO5
         LHskgBknQ+ooVS5eJY7YGVxRN8DHMG5Y889Kkcj0M1UzIFcrxKgV4KSQW1nBy8F38ZdB
         9M037msSEjWe+RB1/dBan9Y7F+3pct8hxNkjxJUWB2qPurxaMZgHfPq3f6wiSJujr0CG
         M9/hAq3Wahz9rBbe+YJkKrvQgUADW19ZoGY2CsGIptMyqaUMkuhdJ1OAnbUC9OOk8hQh
         CCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gco0BPVYIVxNxmRiOHidGxPNI0iarLOBOR9PNYnwBOI=;
        b=kNR/4WBq1HWwJXi9PqnBxcuaBBBkRjn0ZeQHsxlJK6hJtktD+in8vysk8Lfq1NcME4
         TQtb45WMndNEqQxyNcnLpfm6glQTIJSXlNUeR34+aHmFyVnZdB44+gi9ro5tRJBtcqQi
         WSefkg4lHGXRI8xIKXPntradDEa7s0yPNocxRR1tVgJn+F3WcSZVtesd6ek7yeDpnqLa
         75bo7oltCiF1CHB6EKzP3+PIYhch6wgE9Y+1lBdbmViKGza/AF6qXwEIZlZNyZHtzBEa
         Vz9l9EmNTY4NTzM4h6qkdP0bp35jvgjfxs+orph5zBpGGy/RpfxJrkXopasnQcs9Xmsl
         vlTg==
X-Gm-Message-State: AOAM533oYBJs4aCM47xzwvzyLbXoWZluH1lNcRMWJHROgB8eBVDz4CqT
        5UgFhNSoKuwnOzdXof7dP3df/qczjAJtow==
X-Google-Smtp-Source: ABdhPJxargaLc6xwqTWbvsq2AtCFtOqC34h+2+TdaYB53y+n0RTiLxNLuPMRNy6pkEdxsGuqlCjN9Q==
X-Received: by 2002:a05:6402:31a7:: with SMTP id dj7mr33869376edb.314.1620716226489;
        Mon, 10 May 2021 23:57:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ck4sm13431936edb.56.2021.05.10.23.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 23:57:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] Makefile/perl: correctly re-generate build/* +
 speed up under NO_GETTEXT=Y
Date:   Tue, 11 May 2021 08:56:40 +0200
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com>
 <xmqqzgx2pi5y.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqzgx2pi5y.fsf@gitster.g>
Message-ID: <87a6p1u5a6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 11 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The summary, from v1:
>>
>>     These patches are relatively trivial fixes for bugs noticed when I w=
as
>>     working on recent send-email patches. We don't re-build perl/build/*
>>     assets when variables that affect them are changed, and needlessly u=
se
>>     our non-mock gettext Perl i18n framework under NO_GETTEXT=3DY if the
>>     system happens to have Locale::Messages installed.
>>
>> Changes since v1:
>
> Hmph, didn't reviewers declare that the previous round good enough?
> I thought I merged it 'next' already.

I sent this re-roll before I noticed that. Nevermind & sorry for the
noise.
