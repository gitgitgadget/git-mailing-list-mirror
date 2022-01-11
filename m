Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57EBC433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 19:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiAKTkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 14:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbiAKTkv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 14:40:51 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E250C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:40:51 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id w9so273549iol.13
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gVBA6DdjKjO5xgE6VXaXVcKPu7kpLv1R2+WzKiRd0fE=;
        b=IMRLMgOJP0lKwqH2k06I0N+WTC4eXa1+lHWmo56PUphqi5sm+JiUzTTIcgLyiyaxFP
         kSZecD2IQXZ/Bw3NRE8u9DjLNtt1nMFs0d4m+kRma125OTltIRdjgUQoGGEXAIE9Sefw
         PnkgkXP2dB1Y2tPR/UMoiniPGspS7SYFjfFOT4HA39x9QoAtExXEIbPXIlUYKzBXgY7J
         lLZB62WjCXVju3AKxedidvP/k3ZDNmXVUJFPKAHRU9vdbeVBlh/HUs96FJjfVfppkRDv
         r11GnAHC5s6ZkcrEFof5llOaobA8FzHjkJSOtvX/EkvfzWHmkp9xjvbXup5NeTX9KHe9
         ECWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gVBA6DdjKjO5xgE6VXaXVcKPu7kpLv1R2+WzKiRd0fE=;
        b=HyfaIIj43VQupOFe2Uo7ZCLi5T+kC4yKi7Lp5Msa+jy+zhl5FNExBZrsTtlYhSl2n1
         +BIeO03a4yU5IiavR3THKqrc+AiF9nAZFTeeYRTP6e+bS56Y0iEhDG0WGX2SLEWV13gy
         wU+oaq7I07wI7CyYSwhTcXn/qhkde+tyebfSaQ5yXhBIiJDIuRSFeVH0EWuSZ80D96Su
         YB4el8S+I9ef+549GgbV6lqVTs5rHpLoQ0TtAgwalGbsvliEaFJEbiX2mEca/ZUAa9fy
         sRqE9JdgFgxMiIYB0C6wyqay0oqvNExMJdUYTJaeBMlIPel8+LFGS6Hq/IYg1x65f6N2
         lOqA==
X-Gm-Message-State: AOAM533a/a/T2DHPvsHZzM1TpR5w4Pxoc388sJAu349vNulUwTmFnkR1
        5PffWGsNyGiVbjS9G0XKzdx1sw==
X-Google-Smtp-Source: ABdhPJzqgoGz341btfleIjcWtqMU2Dg1FKOFBdha+vGyvuaYe3/MKPpviNfc5nwr4QxYpOmvVAOT5A==
X-Received: by 2002:a5e:9b07:: with SMTP id j7mr3040669iok.136.1641930051022;
        Tue, 11 Jan 2022 11:40:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i23sm4475205ila.85.2022.01.11.11.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 11:40:50 -0800 (PST)
Date:   Tue, 11 Jan 2022 14:40:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] t/gpg: simplify test for unknown key
Message-ID: <Yd3dQkGxG1hbjThH@nand.local>
References: <20220107091432.581225-1-fs@gigacodes.de>
 <220111.86r19exl4z.gmgdl@evledraar.gmail.com>
 <20220111172621.qwupg4oyosvpeguu@fs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220111172621.qwupg4oyosvpeguu@fs>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 06:26:21PM +0100, Fabian Stelzer wrote:
> > I was about to submit
> > exactly this patch for you but with:
> >
> > 	-       test_must_fail git verify-commit thirteenth-signed 2>actual &&
> > 	+       test_must_fail env GNUPGHOME="$GNUPGHOME_NOT_USED" git verify-commit initial 2>actual &&
> >
> > Both of those are probably a good thing to do here. I.e.:
> >
> > 1. Didn't we have portability issues with "ENV_VAR=VALUE shell_function ..." ?
>
> I'm not good with portability stuff and trust your judgment on this.

See [1] and the ensuing discussion for a good summary. Re-reading
that thread and comparing it with what we see with `git grep
test_must_fail env -- t` confirms that that

    test_must_fail env GNUPGHOME="$GNUPGHOME_NOT_USED" git verify-commit ...

is the right thing to do here.

> > 2. You're pointing to a nonexisting ./empty_home, but shouldn't we use
> >    $GNUPGHOME_NOT_USED? The existing "show unknown signature with custom format"
> >    test in the same file does that.
>
> I was not aware of $GNUPGHOME_NOT_USED but it is used in a similar fashion.
> However it is set to the old value of $GNUPGHOME before we change it in
> lib-gpg.sh which seems wrong to me. Wouldn't it then just pick up the gpg
> homedir of whatever the test environment has?
> Using the variable is good, but i would set it to a known empty directory
> or?

Yeah, t7510 captures the value of $GNUPGHOME as $GNUPGHOME_NOT_USED
before sourcing t/lib-gpg.sh. So long as nobody else has tampered with
$GNUPGHOME, they should get `$TRASH_DIRECTORY/gnupg-home-not-used`.

But I'm less certain that there isn't somebody accidentally ignoring the
"not-used" portion of the test $GNUPGHOME ;).

And I don't think that reasoning through it all is that worthwhile, so
I'm fine with what a much more direct ./empty_home here.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com/
