Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90109C433FE
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 745C161881
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbhKPSrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 13:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbhKPSq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 13:46:58 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F611C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:44:01 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id v23so27386836iom.12
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gZBifYu29RicsTSPffZCTWN1khmydc9btQjodBZojRw=;
        b=VWXqBZJrQ5EJ9qQQHc1RYmeVbIf6+opvmBddx9M0APSSALjyxQGaOLBmCKv+479PWf
         GxnWWHgr6X2BMODbHkPf9lSIPIIeeCWbuzWzW87cWZFrJzOoihAg/ZR+qGDlUCqIx/Zg
         hcNjxwH8xrERViQjY42vUBPeo+I+w+IGWPNWAT2579fQf0mAx4TAz5mKyAuxp0ubetVt
         5lf/+DmZKNudaBNxxDk/Kdd4ThSjtz+C+d6ih8GVHPd7AWVIha/7v+Wny03WArdi56Jr
         np5oc3hqkId+4b9S35ntIPHXVQptlG8GJUh2qNaNlgS6goXrgzZYG8MTRJc6yGG18l1Z
         fL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gZBifYu29RicsTSPffZCTWN1khmydc9btQjodBZojRw=;
        b=HE2nHWooEP5K4h9kP0npjgmuGNqPUkr80xxZETvhiAFshv154Wufm/iKETxyxIdyo6
         XI7QAEjPTPtKhkSPZ1rvfg0He6CaUNNYlbP5g56N+U4OedXaZukBzwe9LWnbD9f1qkWA
         Kw7d0Bc4Otke4dVjyuPK6j0uVeB/BwIkHX/ADHDV1+f35YkXzRZX+HDYYN/zy0kvue8u
         UHNpsXBzaLNv86yuFs60lJiDRgYhFVVoUEu8916tvcvsVAHEKyfdrJmakNWnuA2jz2H3
         FIO7rWxxn1EjkcF6uYN4niKRstwcLoMFXnvx8UTKCgSUOSvnuDTgoVfo2siDCqtED71C
         oSgw==
X-Gm-Message-State: AOAM532/IxCSEGl890xInAEJAbZEzLRdr7OC9b2t1BuDwQqYzI+trrBA
        taMW4tJ2nYavT1MW4v/rpZePIw==
X-Google-Smtp-Source: ABdhPJy05dHsSrQcwsnoOce6XmXMNwfO6vbR9Lx7ch3QgOBou8iLP2ChXe896BhHryoOcrxTesfLsg==
X-Received: by 2002:a5d:9493:: with SMTP id v19mr6441002ioj.34.1637088240589;
        Tue, 16 Nov 2021 10:44:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h17sm11729851ilj.69.2021.11.16.10.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 10:44:00 -0800 (PST)
Date:   Tue, 16 Nov 2021 13:43:59 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 00/21] C99: show meaningful <file>:<line> in trace2
 via macros
Message-ID: <YZP771pJl30ujluT@nand.local>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 11:18:10PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Since everyone's getting in on the C99 fun.
>
> Well, $subject and a bit more. This RFC series has bits and pieces
> from thing I've submitted before. I'd proposed to make variadic macros
> a hard dependency before in [1] because I wanted to get to the goal in
> $subject, perhaps the whole thing will be more convincing.
>
> This also includes the die_message() in a recent series of mine[2]
> that I abandoned.
>
> At the end of this series we expose a config variable to have
> usage/die/warning emit line numbers. I.e. going from:
>
>     $ git -c core.usageAddSource=false -c core.x=y config --get --bool core.x
>     fatal: bad boolean config value 'y' for 'core.x'
>
> To:
>
>     $ git -c core.usageAddSource=false -c core.x=y config --get --bool core.x
>     fatal: config.c:1241: bad boolean config value 'y' for 'core.x'

Just picking on this output change in particular. I agree that this is
easier for folks hacking on Git to trace down errors. But I'm not sure
that I could say then same about users, who will likely treat this extra
output as noise.

Now we may find it helpful if they include it in a bug report, but I
feel reasonably comfortable saying that the value there is pretty
marginal. I don't find it all that problematic to grep for a specific
error string, and usually find myself in the right place.

> I find that to make tracing down errors in the test suite, and 21/21
> has a GIT_TEST_* mode to turn it on there (which fails a lot now, but
> I'm hoping I'll eventually get passing).
>
> But most importantly we've now got meaningful file/line numbers in
> trace2 error events. I.e. from all of them being some line in usage.c:
>
>     $ GIT_TRACE2_EVENT=/dev/stdout ~/g/git/git -c core.usageAddSource=false -c core.x=y config --get --bool core.x 2>&1 2>/dev/null|grep error | jq -r .
>     {
>       "event": "error",
>       "sid": "20211115T221343.534151Z-Hc2f5b994-P003f3980",
>       "thread": "main",
>       "time": "2021-11-15T22:13:43.537981Z",
>       "file": "usage.c",
>       "line": 65,
>       "msg": "bad boolean config value 'y' for 'core.x'",
>       "fmt": "bad boolean config value '%s' for '%s'"
>     }
>
> To:
>
>     $ GIT_TRACE2_EVENT=/dev/stdout ~/g/git/git -c core.usageAddSource=false -c core.x=y config --get --bool core.x 2>&1 2>/dev/null|grep error | jq -r .
>     {
>       "event": "error",
>       "sid": "20211115T221357.083824Z-Hc2f5b994-P003f4a82",
>       "thread": "main",
>       "time": "2021-11-15T22:13:57.087596Z",
>       "file": "config.c",
>       "line": 1241,
>       "msg": "bad boolean config value 'y' for 'core.x'",
>       "fmt": "bad boolean config value '%s' for '%s'"
>     }

Neat. This is a use-case that has all of the value without putting it in
front of users all of the time. I like it.

> This is "RFC" mainly because there's a CI failure in 0061.2 with this,
> I still can't figure out what that's about (or if it's some fluke
> unrelated to this topic), but that has to be investigated.

Hmm. Putting the CI failures aside for a second, wouldn't we want to
hold off on something like this until we have flown the C99 weather
balloon for a while? If we suddenly start introducing C99-isms into the
code while brian's patch is still young, then we can suddenly no longer
say, "oh, just drop this #if because there are no other C99-specific
uses here", and instead compilers that don't support the newer standard
are out of luck.

That may have been already communicated elsewhere in this message and/or
throughout your patch series, so if I missed it, I apologize. Just
felt that it was worth stating the obvious before we go too far down the
wrong path.

Thanks,
Taylor
