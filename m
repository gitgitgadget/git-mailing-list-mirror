Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD13C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 00:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiGNANh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 20:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiGNANg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 20:13:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CB3273
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 17:13:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id z23so539619eju.8
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 17:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SaSiPKb2cY+ydieVfKwTmcpirS6LvPAJpBS04vy8hoI=;
        b=UhMgK8H5+WSc/PCIhexBkxLGFZaCvaHNxbo0Lj5r/YtkApHoD5gxwFHR1rCAarGwpJ
         fScSSHvKKDoOt7vqCOxTD7tkU9jPhADhfMTSRqivLdTGtzWVv3T8Mnv/3oKRwSjxooZm
         kFKcLzR0ND4ysARMDC+1IarOikxWHSDTAmm1/g2sSQzI7QEyXuAUJ27TDPOAB1TmSW19
         9skn8q+a4Bg+5TW3zQjdFb91YfAIT4xfhoRTJHBcrNds4q9FdfSR5R5Ge2S8/Ejbn0L7
         BdH6S32L7o4+zEu2Moobzmfi3aqOEgYszrW99DUIT7wc9eTa8Iu0EMk4zsbareo3DR88
         Jwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SaSiPKb2cY+ydieVfKwTmcpirS6LvPAJpBS04vy8hoI=;
        b=z9KYA8xX2fVBbqKf85ctUWBSh2jNNOHk3yIsu22IIIPpn2KiKISBrM1Le1LbVhp2Xi
         QjOMXFd4sXyklsv5VzM0ceqw+9R3X5ubavMtBihf4DDKZmPVsVqpQRelUpSFDujJ8HQo
         5lmMlah8HD5RwY8UWD6j4O0cdW1N+xqvIroFSXkjT+I2R3wnAKZyigPMTfXSSe8QNFCv
         A7jKABn3w68QS0OXmvd5g3cZimgwBgIc0a3a5MWxWGHZv2VKrbirVvNChGX0r5lrgEWb
         0vKQ1CFOk8WGq0fZq2dZ8uGeK5sy+sRKUrdHProPBRbQivad812njlEmRYPA10kwCu3q
         0xbg==
X-Gm-Message-State: AJIora+MG4l1QF39pbQ+dI7tTzf+hoCu1dZgNO06j690cZrfM/KMyr0V
        MWWn5/EkZC8yj9ZLjU+VZGg=
X-Google-Smtp-Source: AGRyM1vWszrKUMd6Pl+mZwmXE2dQOTgqFdA91hnNfWDXO/0r9JKxwZcH3XmGQP8e8s0WaH+xtD9U6A==
X-Received: by 2002:a17:906:8a45:b0:72b:31d4:d537 with SMTP id gx5-20020a1709068a4500b0072b31d4d537mr6018177ejc.170.1657757611138;
        Wed, 13 Jul 2022 17:13:31 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b19-20020a17090636d300b00722e7e48dfdsm8579ejc.218.2022.07.13.17.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 17:13:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBmTy-0022ta-01;
        Thu, 14 Jul 2022 02:13:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH 03/11] submodule--helper: fix "module_clone_data" memory
 leaks
Date:   Thu, 14 Jul 2022 02:06:56 +0200
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
 <patch-03.11-e5ec6945409-20220713T131601Z-avarab@gmail.com>
 <kl6lmtdc6hhp.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lilo06g82.fsf@chooglen-macbookpro.roam.corp.google.com>
 <220713.86o7xs3g76.gmgdl@evledraar.gmail.com>
 <kl6l8row62dg.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6l8row62dg.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220714.86k08g361i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 13 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> [...]
>> What do you think?
>
> Frankly I'm ok with moving things around; I think the code could use
> a little cleaning up :)=20

Yeah, but this whole part of it is something we'll be throwing away
entirely anyway, so I wanted to leave it at just fixing the memory leaks
as narrowly as possible for now.

I.e. we invoke "clone" from submodule--helper itself, which we don't
need to do if we just invoke it as a function, in which case this whole
argv v.s. dynamically generated difference goes away.

Well, we'll have a constant string in some cases, but we'll likely
either strdup them all with a strvec, or more likely pass the arguments
with custom "options" struct or something.

> But yeah, I think my suggestion isn't so great -
> it's a bit weird to keep around an auto variable that exists only to be
> dup-ed to the thing we care about. We can forget about that.
>
> I do think that it's worth avoiding the "sometimes dup, sometimes not"
> pattern if we can, though (of course these are just my non-C instincts
> talking), and we can do that here if we just choose not to assign back
> to .path. Something like:
>
>   struct module_clone_data {
>     const char *prefix;
>   -	const char *path;
>   +	char *path;
>   +	const char *path_argv;
>
>   ...
>
>    	if (!is_absolute_path(clone_data->path)) {
>   -		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
>   +		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path_argv=
);
>   +		clone_data->path =3D strbuf_detach(&sb, NULL);
>    	} else {
>   -		clone_data->path =3D xstrdup(clone_data->path);
>   +		clone_data->path =3D xstrdup(clone_data->path_argv);
>    	}
>
> would be clearer to me since the const pointer never points to something
> that the struct actually owns.

I think that actually makes a lot of sense, I'll probably just change it
to that. I'll mull over this again when I get to re-rolling this
(depending on future comments), thanks!

> But if the "=3D .to_free =3D " idiom is well-understood and accepted to t=
he
> point that we don't need to actively avoid "sometimes dup, sometimes
> not", then we should drop my suggestion and just go with your patch :)

FWIW "git grep ' =3D to_free =3D ' finds a fair bit of them, but luckily we
usually don't need to play that particular game...
