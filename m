Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AF9C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 17:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiGURqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 13:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiGURqg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 13:46:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D488C17B
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:46:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m13so3070818edc.5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=pERynifiQeEJM1YU8IVAy3MQkhR504ufVdV5JYf4ef0=;
        b=kzDCGfR7IINRFe7ZOpV7Qk63suNC/oXUBtCbop7Z95xkJzm40lJRsEfXLtmUZGTlcU
         +/rWay5jiuzlVLX5wuUXWQW1wWJowo+b5yL3+v2ogeSpE98HLvfQhrtNr+PkRwfyC3W/
         gRIoG8FDdNR885jN3xn2Z05tUucSggzW4P2CDz4mIGnGC9kSoOODVgrpjNDFZmvknmG3
         XryH1q1iFygk6rQtQrcWgD80EFGInfTexTaYmhUFmVMrhPdvWSfwTCQBY/lxo+1Pz8M/
         JpKxOnZBmSwq7SpUyeE2zsKcZkf1WgLYwQYMEOeUuTNH/oSgmW/9mnjlO4YasvwdgkoR
         BX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=pERynifiQeEJM1YU8IVAy3MQkhR504ufVdV5JYf4ef0=;
        b=K5IZshjM4wEH1Zw5cB0aeoIwBK2CLRUhrGo1ciZzNYHDEjHuI80IbKFFP0dNlmxuKi
         kkSaHTBZaixpkhL3wKCfp+OjkeszYv9WAIP5N1G0JliQ4koN520K7fOjcUN6BCcwtnGW
         MYR1j4g1bP6n0MIRE3mjEH/ZONaLppo2VmvLHC7PzP9gjm7cS8rZzuhkB/Uu/BoEZDmF
         XftpJIsflgxKtbD8DoAapCm6qIPBm+gy7EDwcxRC2F2BOknINuzdmsmoMFDSEP3uxVJl
         kU8PMjElGpco97QrtGtgL5BiQzFIX1YtZ7zKQP45p5pjYk/j0vy78y1avhO3bc8sCdpG
         kDlQ==
X-Gm-Message-State: AJIora/ZcBWD3bz5d+/vGL336RWEO3SKytr+6c+R9OvrU4z2lve60/U6
        ilLhoZruFkQD33oXFsCd68Q=
X-Google-Smtp-Source: AGRyM1uCtWFHpgR15DC1RnNWhgaTISAIxbdFdUtMjN9h3G0s2qgMbFFNpCARGfXs/1oyKI3Kam60vA==
X-Received: by 2002:a05:6402:38f:b0:43b:c651:5041 with SMTP id o15-20020a056402038f00b0043bc6515041mr4712260edv.327.1658425590238;
        Thu, 21 Jul 2022 10:46:30 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709060cca00b0072b2ef2757csm1056240ejh.180.2022.07.21.10.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:46:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEaFo-004jwb-5e;
        Thu, 21 Jul 2022 19:46:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v2 08/24] submodule--helper: add and use *_release()
 functions
Date:   Thu, 21 Jul 2022 19:44:27 +0200
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
 <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
 <patch-v2-08.24-b7582391c91-20220719T204458Z-avarab@gmail.com>
 <xmqqr12f3e9e.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqr12f3e9e.fsf@gitster.g>
Message-ID: <220721.86edyetl3f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 20 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Add release functions for "struct module_list", "struct
>> submodule_update_clone" and "struct update_data".
>
> OK, this does a lot of things, but in short, nobody bothered to free
> module_list (i.e. list of cache entries borrowed from the index to
> represent the paths we are interested in that are gitlinks),
> update_data (which has module_list among other things that do not
> need to be freed), and submodule_update_clone (which has
> update_data, update_clone_data and failed_clones list) in the
> original (in other words, these release helpers had to be invented
> by this patch, not factored out from some codepaths that free them).
>
> I think the earlier part of the patch that deals with module_list is
> correct.  I also think the last one that clears update_data in
> module_update() is correct.

...

> I am not sure about the helper that releases suc, especially how
> suc->update_data is left alone by update_submodules().  Presumably
> the caller is responsible for releasing the resources held by
> update_data member alone, but the interaction makes me feel dirty.
> Luckily there is only one caller of suc_release(), so we can design
> however dirty interface for convenience, but still it feels wrong to
> design a release() helper that pretends to be usable by general
> public, yet they have to be aware of the fact that some members in
> the struct are still their responsibility to release.  I dunno.

But isn't this fine because that "update_data" member has a "const" on
it:

	/* configuration parameters which are passed on to the children */
	const struct update_data *update_data;

I fix other similar ownership issues you pointed out for a re-roll I'm
preparing, but I don't see why this one is a problem as long as that
"const" is there, it's a slot we use for passing things in externally &
to ferry it along.
