Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC70CC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 15:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242512AbiAZPCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242584AbiAZPCn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 10:02:43 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC4CC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 07:02:43 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u24so23307054eds.11
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 07:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=v9iG997ocsLdy44q7nhj5Tinhl1b8J5+r9L4yY/7qHk=;
        b=oS9w6211omwxJLtsMi1j42Oz3r8ejJq+HXuF0j/lK9lTaF9Q0xqTjzN53pxLbNdbtQ
         xHZ0/GBQzTe1CrgB+QDuAJ60jtjN7JvyH5NHilK/zNkojtBaJb1AKdAW7sAlGbZFfv2w
         y37tJ3VJOCH7Eb3EDeXs2fy6Si965HWfL5MAAY5RkB9XqyVk71V5RSYdpsJ/ihjxO1BF
         EkktnMwlf+xTZckpPUH28qxF07VXGaXU46lTgzXwuXNjoescnvyD08RRVRmfI3IsiNqL
         k8zefoJwgi25VV9430IxsIyGQME0XPHtYGQjfffqqJpNlhH1CylfEmMXJVv6nngQEw7n
         rPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=v9iG997ocsLdy44q7nhj5Tinhl1b8J5+r9L4yY/7qHk=;
        b=PlfFxJFfh9rsHDVrEoERBsz6OVPXjcCFY/q8u4CScc+ORke2hhb6Y95vB8VakJAiuz
         Kv59ZDPbOmEGtwkdvdGwj+NGQBSlyK8cUIWq2FI23t94u9WcIRIVVluuykjQVqIaAh5O
         cAMjypRT+y1CdPENJPn5i9LIyCRiTpHreBQAp9zkHr0k79sqh76j20DHc0OGWnE3J8aO
         BOfbbR5Wl1fSTmwCS/eZT1G3bJXNSU4u/+6oyfdjxfGvNpPA/uJH/6CU+hJ+Pr/aRVfw
         LNEKVMcfYE5WPx5oXe7ClTXrhhORKb2CfRFiX2HHR15YNO41G1yJUw7yxJbtqRlX64fF
         FJmg==
X-Gm-Message-State: AOAM533MBkQD0g2dHv2wduwlrUoK6RpDLHBBwYSORUYGLaCvS50TouVO
        rfPGKbOJJsdqIHcnlUfRtPc=
X-Google-Smtp-Source: ABdhPJxt6EbDJZZ/+WXM3bwqeGb/QuY4WDQm01C3vZ4Fs9dUTp+6BMCk+3OiACnn28pF0I04BFr6cw==
X-Received: by 2002:a05:6402:40cb:: with SMTP id z11mr17314760edb.127.1643209361788;
        Wed, 26 Jan 2022 07:02:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g6sm5336512ejz.170.2022.01.26.07.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:02:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCjom-003AAx-Mm;
        Wed, 26 Jan 2022 16:02:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 1/9] t5326: demonstrate bitmap corruption after
 permutation
Date:   Wed, 26 Jan 2022 16:01:20 +0100
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
 <7ea9cced8ec79a8e39948a5e4b8dde6e9b54695a.1643150456.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <7ea9cced8ec79a8e39948a5e4b8dde6e9b54695a.1643150456.git.me@ttaylorr.com>
Message-ID: <220126.8635lafskv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 25 2022, Taylor Blau wrote:

> +test_expect_failure 'changing the preferred pack does not corrupt bitmaps' '
> +	rm -fr repo &&
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&

Nit: The initial "rm -fr" isn't needed here, and we should aim to have
tests clean up after themselves, not needing to clean up after other
tests.

This appears to have been copy/pasted from the test you added in
54156af0d66 (t5326: test propagating hashcache values, 2021-09-17),
which needlessly used that pattern, the tests you added preceding it
follow the "clean up your own mess" pattern.
