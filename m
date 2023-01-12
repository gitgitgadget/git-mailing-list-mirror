Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE917C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 08:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239860AbjALIvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 03:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbjALIvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 03:51:11 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B5EC6C
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 00:48:35 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qk9so43054881ejc.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 00:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=43kQ6RRCFzRWCxhuUZ04R0/Y6xcUAA7Z+6f8sHlY7es=;
        b=T3qH9aSL8qKeKFgaUnd+0/xv4sgwVVt8pZVRhqHK/H1ONz0Jd6WoduceR8kNSsnZ21
         G979LG4auI8NZTbpV5XhpRsEs9KR4h7LbtTYBI11ie2CjmgZytXTg0GOShQCbwqeNkYa
         XCq7vIPyA38Rz4wIIeafnJ4BuAF9anoUGzGV61ru6UrVubQ1iHSXFqudF690jPgOClmQ
         +YRvxNH8CNFD+dpaylqqxdwZqeoWZSp15F0IoMU+eQZtd6ixY2avk7f5muBRVo8pvj2P
         DsjcyRqjmL6XyvVz5bdZlv7tLguiZOza3jjF6JYWJ6hmxKDIi+vTOb4TEvbz1OsLaOlj
         dtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43kQ6RRCFzRWCxhuUZ04R0/Y6xcUAA7Z+6f8sHlY7es=;
        b=YoBapVl+pgH+oi6MXJt5pCJPush5qO0CurDjO+h3/Q1EpSq19Lv6M4jyqa7vth2PPV
         xhGQ2GUwBfSeg3m2cPxxF3Ke6Vs+3Kto7djfJYzwKWHqzLRoOIz/EfCVKp+Wmpbz4f3I
         0G+NaWZMzCvUVzz+Zt8I2DN5LKhb2pauUSKMyy/dMeto1uVBb3NkYRrFrOtvnsy/hDpv
         ABl7o3LBwtFlRxV8wuRZMVcHRPRNTY1amnr6Zu330M2ZpN9P7BgLlgswKzQq3nETS0+F
         5rr9CSOg1Qzqiavrvut2S/fsCrrurae5UAVMRQJVuclK8SfplpEQSllyE2wdhxCRRAvV
         /wZg==
X-Gm-Message-State: AFqh2kqpdeQq2zn5MqjuPE5oE/fE+9inHy5YnelUXQu1lUMzcvEf/zoz
        MEZnOnzqzLrcu+dKkLKn3p0ktYCmE2E=
X-Google-Smtp-Source: AMrXdXuXmluC/dUXBlFABtdqIfRxaJjaDXyBlwYGTjG25JQyoVdqngM3sJe4s7Ji7JcyWewjUisvDA==
X-Received: by 2002:a17:907:c689:b0:84d:122d:4af3 with SMTP id ue9-20020a170907c68900b0084d122d4af3mr23716543ejc.27.1673513313940;
        Thu, 12 Jan 2023 00:48:33 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906210200b0084c4a8062a0sm7245384ejt.149.2023.01.12.00.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 00:48:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFtGC-0004X8-1k;
        Thu, 12 Jan 2023 09:48:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v5 09/10] http: read HTTP WWW-Authenticate response headers
Date:   Thu, 12 Jan 2023 09:41:08 +0100
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <bcfec529d9581db3181cc6f3b3d4b4b8d315ca0c.1673475190.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <bcfec529d9581db3181cc6f3b3d4b4b8d315ca0c.1673475190.git.gitgitgadget@gmail.com>
Message-ID: <230112.86wn5s2l5r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 11 2023, Matthew John Cheetham via GitGitGadget wrote:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
> [...]
> +		} else if (buf.len) {
> +			const char *prev = values->v[values->nr - 1];
> +			struct strbuf append = STRBUF_INIT;
> +			strbuf_addstr(&append, prev);
> +
> +			/* Join two non-empty values with a single space. */
> +			if (append.len)
> +				strbuf_addch(&append, ' ');
> +
> +			strbuf_addbuf(&append, &buf);
> +
> +			strvec_pop(values);
> +			strvec_push_nodup(values, strbuf_detach(&append, NULL));
> +		}
> +

I've written something like the strvec_push_nodup() patch that preceded
this myself for similar reasons, and as recently noted in [1] I think
such a thing (although I implemented a different interface) might be
useful in general.

But this really doesn't seem like a good justification for adding this
new API. Let's instead do:

	} else if (buf.len) {
		const char *prev = values->v[values->nr - 1];
		/* Join two non-empty values with a single space. */
		const char *const sp = *prev ? " " : ""

		strvec_pop(values);
		strvec_pushf(values, "%s%s%s", prev, sp, buf.buf);
	}

There may be cases where a public strvec_push_nodup() simplifies things,
but this doesn't seem like such a case, just use strvec_pushf() directly
instead, and skip the strbuf & strbuf_detach().

I haven't compiled/tested the above, so there may e.g. be a typo in
there. But I think the general concept should work in this case.

1. https://lore.kernel.org/git/RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com/
