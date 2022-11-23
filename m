Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C76AC4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 02:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbiKWCTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 21:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiKWCTK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 21:19:10 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7EBC67DE
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 18:19:10 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so611878pjc.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 18:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLDGHv3FK4YNdMBWxWv3X1Y148oqz0HQhInjlBFgZkQ=;
        b=nkfWbLJx7rnjlD1D334Hw/C7vKzErvALE9AKdKACo+PZb6WVGEb6hMyFlrATvA3iX0
         g+Mv/61rGUFmfOQkcu7sPsT5NrRwwVOYmY65Qym/C4OFFJ5ph78nDbGngF2jeKjAg2d/
         tNVdU+YuJrKxA9btShIyj9Uel2DMLA1PWvMKDAaHSlUfahytatuZBdgBrMPfzNFkwi54
         aI+FAQL4U/td1fHVzORb3X824W89+3z+SqwNQjGf/ct0Z/JV4gSSH2efrOJxCYPB1pSD
         P/NWXhmu43F++tlOvwgpFwj0y9R8FwFwkxjgsgFyIZLSHcU763atat5Wbl12eMla8iv0
         lgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLDGHv3FK4YNdMBWxWv3X1Y148oqz0HQhInjlBFgZkQ=;
        b=SZffDkU49d3EXAnlsHfcB5nkZDl7hBqAkPiwPY5LFA+WhiJ3vF7+N3z9r9ZYHjs/7n
         +hiG75AXKpd9yAmMxiA+y2rgIDFwUbQj03hRHb1sCtHpkSMlTksYW8YibR2diCIueWBH
         XE7KpMVWqpaB3Tr0GAYgOyJXrhyjGg5Af3Dpw3LG1+R06g0JkdMH3rL1AUs9CbIAkHGp
         XXd5u/vl/Ne9p7zHdvm/a9GGc8WPPMne9/cVmcVbCmyayfVnl8IBRxMcMrY6ZuMF1rDg
         n3Ij8YytxH8kZGeuwIrL+64rOT0LoYMPHJjOf+EglFrB/JH5KkgcSoPYzKRFQV7OVj59
         BFBA==
X-Gm-Message-State: ANoB5pmltYBt5WXgNLZ5Oe4a9XbnQYZOe+Mw1yHGzyuQ57gul/fPC+rR
        alY0Z08oy2YeEluXm/zcXEQ=
X-Google-Smtp-Source: AA0mqf6GkHyZTqrnn1OrGZbMAll5T12PhrqPjQqtvZ785mRMI0F1/oWlNiAtLkHF7XKnAwJlo7c6+A==
X-Received: by 2002:a17:903:2783:b0:186:a97d:6bc8 with SMTP id jw3-20020a170903278300b00186a97d6bc8mr7255134plb.101.1669169949496;
        Tue, 22 Nov 2022 18:19:09 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d33-20020a631d61000000b004777c56747csm3697014pgm.11.2022.11.22.18.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 18:19:08 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: ab/remove--super-prefix & ab/submodule-no-abspath
References: <xmqqfseargo4.fsf@gitster.g>
        <221123.86edtua8i6.gmgdl@evledraar.gmail.com>
Date:   Wed, 23 Nov 2022 11:19:08 +0900
In-Reply-To: <221123.86edtua8i6.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 23 Nov 2022 00:06:09 +0100")
Message-ID: <xmqqleo2o1k3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> * ab/submodule-no-abspath (2022-11-09) 1 commit
>>   (merged to 'next' on 2022-11-18 at 34d0accc7b)
>>  + submodule--helper absorbgitdirs: no abspaths in "Migrating git..."
>>  (this branch is used by ab/remove--super-prefix.)
>>
>>  Remove an absolute path in the "Migrating git directory" message.
>>
>>  Will merge to 'master'.
>>  source: <patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com>
>
> Glen pointed out an issue in ab/submodule-no-abspath which I just
> submitted a fix-on-top for in [1].

I'll queue that and keep the result in 'next' in the meantime, but
given that this seems to induce additional conflicts and who knows
what else is broken in it, I am not sure if it is a good use of our
time to even worry about "fixing" it.  What upside does it have with
the patch, other than the "Migrating git" message, which does not
even look like an improvement, at least to me?

> There will be a merge conflict with ab/remove--super-prefix, but one
> which I tried to make easy to resolve when crafting [1]. The resolution
> is:

... not something we would want to even worry about during -rc period.

Thanks.
