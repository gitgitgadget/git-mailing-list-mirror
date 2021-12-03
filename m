Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84D1C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 11:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380307AbhLCLRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 06:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380305AbhLCLRf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 06:17:35 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F9AC06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 03:14:11 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o20so9937350eds.10
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 03:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SsqghcA6dYXyj2QQgWl93ixXhiaz/0YIOWGQU35HCeM=;
        b=Ew1YFgPv0xUSRvmMQ/XvvboJHirIqBoHrONAvdxdu37pOlr/7rqWFFz4FpcKlrwSOz
         WYRQk8XILXESLDqrBBpBmTeNsZeA3UK+BynOgwfuqCdvjmgjEjsLC9xFXeLcvNmtRcdx
         MS5fznriwj7LW+YkLOzAg0LlaXZ2VlgMRiyWaCwtYaLOMs5hsCLS2Rn+azhwx2L8D8Sk
         JGwt3Vz+2YF6yMZqw8pVyFqPj7erYuHeZq11PlKiyHoMxtCE9o1gIeUYPc/foEGzf6Cf
         IsmqzmgCOog1ZJW+p2vRcFXL8Qv24bdlKSGKEuwgIhCHpoueB79EIvlgcxrBPKXAdXJD
         vE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SsqghcA6dYXyj2QQgWl93ixXhiaz/0YIOWGQU35HCeM=;
        b=SxeXY86EGN6li6r4lkEij8OH8zh8Mj8lGkgg8mYCCnQRY2ho9k8zuCrzvB1Y8Yhw/d
         z2T8sqBJpFP6dQobfUGVHjkpFOq0MGWmLFN6rXS05tL1lZkbnx/VboFV7rWNDjPe3Pjb
         q1kKEF16bwC7Bsb98Z80VtUOf24y/g7l8j6emp4RIwcKg4gedNAjrAvu7Y74OaTvIunx
         myfedDbSG48yDBlN0jfI+VaIZlIRqWJT3W7JZBA1Kj94QaJthwwOmLWoCL+HwjqQiwoi
         m1dQ5lVAxG49py0Hrf6M7nlHL+uA47ttuyZzvXz6aKXdBlFAOYR+QqQa/M4AlBd79dUG
         KIHg==
X-Gm-Message-State: AOAM530jIDez1hDuMLEf4PPgsJ8YQbkpAMj+6eRc09OknWChltWuXqMP
        8XdKaNdRIK0omEsHfn3705fLPXW/y2ysfQ==
X-Google-Smtp-Source: ABdhPJwPWqrzfbH5gTK57P7mgUPwitRLpreNHPyaWF/oDej10S+FaFI+CGMDO3feXEnq+BhFw4Pz4w==
X-Received: by 2002:aa7:cd9a:: with SMTP id x26mr25397346edv.159.1638530049709;
        Fri, 03 Dec 2021 03:14:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cs15sm1660953ejc.31.2021.12.03.03.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 03:14:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mt6W0-0005mm-P7;
        Fri, 03 Dec 2021 12:14:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, git@vger.kernel.org
Subject: Re: [PATCH v4 7/7] ssh signing: verify ssh-keygen in test prereq
Date:   Fri, 03 Dec 2021 12:07:45 +0100
References: <20211117093529.13953-1-fs@gigacodes.de>
 <20211130141112.78193-1-fs@gigacodes.de>
 <20211130141112.78193-8-fs@gigacodes.de> <xmqqczmfyi44.fsf@gitster.g>
 <20211202093126.nuuvxjnhbkdu5pwn@fs> <xmqqwnknue3n.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqwnknue3n.fsf@gitster.g>
Message-ID: <211203.864k7qszy7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 02 2021, Junio C Hamano wrote:

> Fabian Stelzer <fs@gigacodes.de> writes:
>
>> Yes, that looks good. In this case the conflict is rather trivial, but
>> how could i prevent this / make it easier for you to merge these?
>> Especially since in this case the conflict only arose after a reroll
>> when both topics were already in seen. For a new topic i can of course
>> make them as "on top of XXX". Should I in the future rebase the
>> "support non ssh-* keytypes" topic on top of this series and mark it
>> as such? Or whats a good way to deal with things like this? (besides
>> avoiding merge conflicts altogether :D)
>
> For this particular one, my rerere database already knows how the
> conflict and its resolution should look like, so there is nothing
> that is urgently needed.
>
> If the other topic were to be rerolled, since either has hit 'next',
> basing it on top of the other, essentially making the result into a
> single series, may be the easiest (and that is basically avoiding
> conflicts altogether ;-).

...but to answer a bit of Fabian's question: Just as someone giving
these two topics a brief look it's not clear to me why the existing
GPGSSH prerequisite needs an adjustment at the same time as adding a
test that uses it (in addition to existing tests).

I.e. was it that it was always wrong, in that case I'd expect a patch
that fixes the prereq and doesn't make any other test changes in the
same commit as [1] does.

Or does it need to be more strict to cater to one new test being added
in the same commit, but that strictness doesn't apply to existing tests?

Then maybe it should be a new GPGSSH_THAT_NEW_REQUIRED_FEATURE, which
can in turn depend on the GPGSSH prerequisite.

Which, incidentally would help with any textual conflict, but more
importantly makes for clearer end-state, and maps prerequisites to those
existing tests that need those specific things, and not a more stricter
& recent requirement.

I don't know/think that any of this needs re-rolling, just my 0.02.

1. https://lore.kernel.org/git/20211119150707.3924636-2-fs@gigacodes.de/
