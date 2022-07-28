Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907ACC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiG1Qd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiG1Qd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:33:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99861901E
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:33:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c12so2862507ede.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=Iwmy1Rdf6dhfFWnH5bb85w0e1+GHOSg5JZd16Z3lUxk=;
        b=NB9CLleQAUFxhAVm9eWBpc/RJbVU/exOd2itOQs9ucRq5x2eJbXun05c37izVE64TO
         hkzbuIFtILzfvLhNkrV/lHl1fPHfGZDR1YQKuxDR+8hbnPDljT3uwUnU5LbPUriJ+sNT
         sx6egI63HfOf5sc49i3EwhWsoRXHKkaLKF3ICHW3qDOe7iGlcY7EwYlcqv1Q+Xn90dZB
         05XrUDXUxSN+IJ1sxRMugfc8JeOJe55Tf9DyD82ndMiX6sS8+pMIt29jWemGiABZPDMF
         H9/HUiXLgRatCf1OUaqwlHKIFrz+6spCe87zvCT0FRX8tFsJLSaYGg6nGGbagiMIf70b
         7/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=Iwmy1Rdf6dhfFWnH5bb85w0e1+GHOSg5JZd16Z3lUxk=;
        b=KB8lgFuoCkA+Zw8k1bz67lz1GizQcHKQeBy9ksW3o51ipzxfY37A/mFNnnJ+IXFQz1
         /TgN35v1PvrhNubpRaTtPoPElEDVBIGBRwaA0Lltat56tEekgx+xuZ0s1bmgT4lkSCuT
         87NcY3U4noUzMvfugskaREdyG00cPq2DN79bwS1Xgvbz/ytXpxhQZvzTleymtEVPQsAl
         OFQpUE5OLV3d+LJZwfu7zXmw9u4Mw2M5dTt8PRNOSgYobJsDH9gbry9iU8IZPvbWU4jK
         ZInkDIZK3gEIw4m1It9DLHnCeM+gywdCnflZcqTZojDQIG34+khLcy5zCO0F0RqJcpLn
         gwOQ==
X-Gm-Message-State: AJIora+/HwTNviqdYK6EfY6JM3BX6jstC72DR3/A7agN2eu0OBoY0jOz
        0jcER3rOoVTGKHzitgWmorw=
X-Google-Smtp-Source: AGRyM1s1204ms0cBX/f4f6xs4F4U8Cc1649DbWUh+spj4Xr+Rj3zw8Uf5h/yWAwneIALdZ5vRjAqfg==
X-Received: by 2002:aa7:dd4b:0:b0:43a:d508:7cb9 with SMTP id o11-20020aa7dd4b000000b0043ad5087cb9mr28888234edw.218.1659026035018;
        Thu, 28 Jul 2022 09:33:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y6-20020a50eb86000000b0043bd192e826sm964627edr.17.2022.07.28.09.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:33:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oH6SP-007Aiu-St;
        Thu, 28 Jul 2022 18:33:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v3 02/26] submodule--helper: stop conflating "sb" in
 clone_submodule()
Date:   Thu, 28 Jul 2022 18:30:28 +0200
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
 <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
 <patch-v3-02.26-32e4ae7ead5-20220721T191249Z-avarab@gmail.com>
 <xmqqlesmf9or.fsf@gitster.g> <220722.86y1wlqmqr.gmgdl@evledraar.gmail.com>
 <xmqq8rolc7cu.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq8rolc7cu.fsf@gitster.g>
Message-ID: <220728.86wnbxjixa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 22 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> This looks like a roundabout way to say xstrfmt().
>>
>> Yes, I can fix this and others while I'm at it, but a lot of things like
>> that in this code are funny uses of APIs that we could improve.
>>
>> I think it's probably best to just leave these for now.
>
> Agreed.  We could instead have a separate series to fix API usage
> before these and then build leak-plugging on top, or the other way
> around, and in general "clean then plug" would make it easier to
> review the plugging patches (simply because it would be working on
> clean code, not code that misuses the API in strange ways), but it
> is too late now.  Lets make sure we do not forget to revisit the API
> misuse but lets avoid mixing it into the series.

I ended up doing the opposite of what you suggested here, but not
lightly.

When re-rolling the v4 of the leak series I noticed that some of what
was suggested I'd fix (and thanks a lot to you and Glen for the reviews)
was code that was either dead, or should really belong in a "test-tool"
at this point.

So, I could have addressed those by padding the "leak" series with more
digressions, but I felt that just cleanly splitting it into a "prep"
series and "leak fixes" was better, those two are the just-submitted:

	https://lore.kernel.org/cover-00.20-00000000000-20220728T161116Z-avarab@gm=
ail.com
	https://lore.kernel.org/git/cover-v4-00.17-00000000000-20220728T162442Z-av=
arab@gmail.com

Sorry if that causes any disruption for you. I noticed that you merged
the v3 into your "jch", but it didn't look anywhere close to "next", so
getting it more right to begin with seemed like a better trade-off.

Thanks!
