Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7D4C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 15:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiCJPRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiCJPQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 10:16:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7821AE64
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 07:15:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x5so7355603edd.11
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 07:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=tbI/bk99u2DB8D4zu93cEpaqtOkE1f7I/N2hVhzfXl0=;
        b=H89tI2ksx0A0Rw8GjbH7pFd06kvYtHmIAwfEnzPUPIeGMv1HrqI4xpX3xQC0qfYRRw
         4UHh189wmcn7qP80v5VfJ/321Uy8IHatlX1Rs4+cgT15CuK85CVjzKy9QoMi39y3EbiA
         MNf3MOLRkU9eeW4+YK402KxsVG+49nmL/n9zVFqOBAIMxk6FF2c43tZfTQW6bSOLsRp4
         LqCKP1Bq3vlP9RDh9swruLyNYsMdCGFiIgm5MGOVCtHf0lWlyL6mdgkuFYh2/1A9HA9u
         rILGLOPQrj/H6CGPc51CLs/5XAx3FeIZDGTe3RxVYcOk/ipHhW5SInONSd8vUBqGjv4C
         80ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=tbI/bk99u2DB8D4zu93cEpaqtOkE1f7I/N2hVhzfXl0=;
        b=qNBo3qtljbQHYPuPpze9W/bdd+afAtxYg4xozdFGrbT/GxY3CSFa6iGplL1Um4Ex79
         duSXb8qjT9BQG223zs1Xos+Z43QLRCyfzZhfT3xQVel2CtnRj3uVO2KjBd2PCY+QYjph
         jxqajDji8GDB2ae6zfuFFqF0FxmAOMFOyJsiMhZxY7F6mBItu7jvvD+EueN6xQU0lGib
         ZzSBYUGSRC0uZFTtoDgSZc6OlPNnoEu46IijO00qvP9b3BzuuConMa/7rv0U3T7Wgpdt
         EWdsjwPcxMDHnNEoLHT5ppahLlaPCKFnHkm97UOUYw2iITehaEVSoqOJveQNQy3x0LU3
         BX8Q==
X-Gm-Message-State: AOAM531Wt+xyQd+5NBqUQZN/P4L9iPOW0KUhtoKS+nCuF2vAh0DM9+Nn
        QkVt+fyIrZwWjYpYRVTa4LA=
X-Google-Smtp-Source: ABdhPJxzHQhCcou2qPAzwwc9kTmKcq6q6YjjR8QNK7ZADty/tiiZ7fSqa+Ac3dhDiSw8u8eld7kWKQ==
X-Received: by 2002:a05:6402:1941:b0:413:2555:53e3 with SMTP id f1-20020a056402194100b00413255553e3mr4913541edz.164.1646925356966;
        Thu, 10 Mar 2022 07:15:56 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u10-20020a50d94a000000b004131aa2525esm2192647edj.49.2022.03.10.07.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 07:15:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSKWB-000YA4-He;
        Thu, 10 Mar 2022 16:15:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 17/24] revisions API: have release_revisions() release
 "cmdline"
Date:   Thu, 10 Mar 2022 16:10:36 +0100
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-17.24-b5687ed1355-20220309T123321Z-avarab@gmail.com>
 <4e564691-0ef6-a867-647e-c26064b0bb36@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <4e564691-0ef6-a867-647e-c26064b0bb36@github.com>
Message-ID: <220310.86sfrpj0t0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Derrick Stolee wrote:

> On 3/9/2022 8:16 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Extend the the release_revisions() function so that it frees the
>> "cmdline" in the "struct ref_info". This in combination with a
>> preceding change to free "commits" and "mailmap" means that we can
>> whitelist another test under "TEST_PASSES_SANITIZE_LEAK=3Dtrue".
>
> Could you consider changing your vocabulary to use "allowlist"
> (with the opposite term being "denylist")?

I looked at some of the wording with past changes like that, which in
some cases was entirely different. See some of:

    git log --grep=3DSANITIZE

But I figred for the nascent v2 re-roll that avoiding the churn was
better, particularly since there's various similar phrasing on "master"
already.
