Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79792C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 17:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjAMRcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 12:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjAMRaP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 12:30:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF299086D
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:19:08 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o18so1885050pji.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7sTVZARpIRTwU9BsWewp0h6g6d1H6AGpD9CeBH6cLY=;
        b=J41iwWnutJLmg/fkerZW7sLgfmup8sA6XGPPlP3DebGuBxxQvNq88eD5XKwS/ZolcI
         XJlU6nQJbjfq8SjcO/FbEqghfx4myq2f7GWI2xwMSxC7C2ucUBVdbY1gKJY9cPSZWOcU
         Xd50rv8wpSQ6swtLGL9+QcZSpaEsB8Q795FwHBEJXVFPs+hswDmh7Fl+u4I6Oo69T4Mb
         ez5sf5VgzHAfZ1i05u26Tdd0oLODDQXKkW0US+RBJY3i+QBTZEcKO6mQ29/Xo/LLeGV6
         YYHSGCQoAFuinjkS1GNN0j4R8iUu5QZaX8SapCPUt7WpFM/YfrVqApokuFC3JV9MwsDu
         FlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7sTVZARpIRTwU9BsWewp0h6g6d1H6AGpD9CeBH6cLY=;
        b=wWs2MzJ6P6GlzLUKmgos25/OZgQ5A2mkM3Vvh4GxsKGIfYGevcidTzD8m6cVx2zLnN
         mVXLdtvzutHPhZ22ItHFiM4csyQKb43WbmO1CXVKXk7tB5SB0o+gxX7oXFXNUsL5n74L
         e1SpIfxREMWpCL0sIBjy9lj/u8SLd2EDOCtBCnJvZHRLJZPDJf4zhJu0TlEuCdnIJMie
         v3h/uylWDVyN31VUIHXvpvtr+0vhCZ633dTV73aI7i7qQLpqHglMjDpv3avaIFoG+iAE
         CiO3dIfAOVEPCwtkyYmmEzdvWgrqN3hXGwd1NTMop2jm4dJNw8OwXNR0g7v5XatZ8owb
         sjaA==
X-Gm-Message-State: AFqh2kpoVmRbb5qdgIP6k36Jd3Pwvi5a+3/Izs6j/zgBa5E0jv5CdRtr
        yP/naeMLdmChsISHNj8DRQY=
X-Google-Smtp-Source: AMrXdXsV0b7/QqhsJX4VQYe49YGmqY8IXt+Hsi+pu6ro1kqeahqUvBhr2kIptnjfdRK2FoalI6rhVA==
X-Received: by 2002:a17:902:c50e:b0:194:586a:77ba with SMTP id o14-20020a170902c50e00b00194586a77bamr8704076plx.52.1673630347951;
        Fri, 13 Jan 2023 09:19:07 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00189ac5a2340sm14415687plh.124.2023.01.13.09.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:19:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org
Subject: Re: BUG: git grep behave oddly with alternatives
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
        <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
        <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
        <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
        <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
        <e5165840-331c-e9b6-b45f-62abab860d79@web.de>
        <Y7flVcALZQgz0VPl@coredump.intra.peff.net>
        <26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de>
        <Y78GXZvyrOrXhe7n@coredump.intra.peff.net>
        <4165031d-e7f1-0477-2245-6a8e312de522@web.de>
        <Y8CBrtmL45tA/N8z@coredump.intra.peff.net>
        <230113.86ilhazved.gmgdl@evledraar.gmail.com>
Date:   Fri, 13 Jan 2023 09:19:06 -0800
In-Reply-To: <230113.86ilhazved.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 13 Jan 2023 09:28:59 +0100")
Message-ID: <xmqq5yda5p4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Jan 12 2023, Jeff King wrote:
>
>> So it does seem like all bets are off for what people can and should
>> expect here. Which isn't to say we should make things worse. I mostly
>> wondered if REG_ENHANCED might take us closer to what glibc was doing by
>> default, but it doesn't seem like it.

I thought that René's "Use enhanced only when doing BRE" was fairly
focused, but I am very tempted to accept ...

> There's a couple of ways out of this that I don't see in this thread:
>
> - Declare it not a problem: We have -G, -E and -P to map to BRE, ERE and
>   PCRE. One view is to say the first two must match POSIX, another is
>   tha whatever the platform thinks they should do is how they should
>   act.

... this view.  The story "BRE and ERE work via what system
libraries provide, and 'git grep' matches what system grep' does" is
an easy to understand view.

> - Just mandate PCRE for Mac OS, then map -E to -P. We could do this with
>   the pcre2convert() API and PCRE2_CONVERT_POSIX_EXTENDED flag,
>   i.e. PCRE's own "translate this to ERE".

Presumably this is to ensure -E works identically everywhere?  If
so, then we should do that everywhere, not just on macOS.  But again
it makes "git grep -E" slightly incompatible with "grep" on systems
(including macOS), so...
