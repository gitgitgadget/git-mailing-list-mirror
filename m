Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552D5C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 11:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D65460F6B
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 11:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhITLXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 07:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhITLXK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 07:23:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D73C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 04:21:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id j13so59976018edv.13
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 04:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NPftQ1+0ItUjHkWjkqcOmgpMOG5RrokjLVJuo65C/Ug=;
        b=EG8IcNVT4Gx8ladisa9QyL3DBzhDk81ZDRwnE6XJXGfLESu9gsGrq1llQohQRmSHEk
         /P/VnmBKan28MEKd4PfZT/uOV1a74JCgc0/E4uyc0B9z0WP8N6eMaqyBVs9RczUlFcY+
         CUyzUo1IF3FDkL6eFhNCncbNY3ku13/BnAplMeXS+ue6pIRA1apPmZGzKiQfR9YorRuq
         3PsxTn534Tt9ZkL7Fk23oheOqfj39Wk7HVvFKpHgspVSlxhDgUn33S1UNStoRbJD01mA
         ifGAHlPmKmwGxP1zMSED28q/U3r5cWDqBa5B1ARBT/zOnhQsWFcaCgVf8WB/JtRI0cCv
         7zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NPftQ1+0ItUjHkWjkqcOmgpMOG5RrokjLVJuo65C/Ug=;
        b=koOSGY2S9Ns+1eLzEtRTPcho9jBMBblTiIP77DjnACnIyO9nCFTvt51bI6IPelqaDI
         wdrhO3yTPvoyQPWHBAv1n0s7ad+pwKnWHURPCacBnJYgQUlNh1DXeuBURmhM6oy9ldBX
         XGaoHsK9r8C5xDLSx7pLigL6SSPApLzdhmKTQ5e8vs1eUahbxdCylemLkCBBGDTscamN
         9wTfm6rK3zMtAlPa1ix5geqq08tXWtyiTUqayGZuWTz+sbkKfhREWkaASxdZo3dz3hFe
         QY2BCARhA9q8OQExL2GSZTCE+oYboLnbfS/ZzQTgWAw00dCfTb1D70uyXmp4LIll7Cb0
         AKow==
X-Gm-Message-State: AOAM530pQYDtavqnccG6q04yEZKNHRnOyuQWfogYLyLKyCal2fwj06Qk
        tdas1onKOUpgj7kUOWJ6l/FOOSN/jfQ=
X-Google-Smtp-Source: ABdhPJz78Drv+H/kdZFJb4fNbpo+8iXl9csq8JOz1e6w/7IvF5b9ZEg5wzSDeCqkRT7qWM8T8V8v6Q==
X-Received: by 2002:a17:906:a08d:: with SMTP id q13mr27685680ejy.465.1632136902160;
        Mon, 20 Sep 2021 04:21:42 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p23sm7128889edw.94.2021.09.20.04.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 04:21:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fangyi Zhou <me@fangyi.io>
Cc:     git@vger.kernel.org, Peter Kaestle <peter@piie.net>,
        =?utf-8?Q?Martin?= =?utf-8?Q?_=C3=85gren?= 
        <martin.agren@gmail.com>
Subject: Re: [PATCH v2] .mailmap: Update mailmap entry for Fangyi Zhou and
 Peter Kaestle
Date:   Mon, 20 Sep 2021 13:18:58 +0200
References: <20210920084719.29122-1-me@fangyi.io>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210920084719.29122-1-me@fangyi.io>
Message-ID: <877dfbbigr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Fangyi Zhou wrote:

> Acked-by: Peter Kaestle <peter@piie.net>
> Signed-off-by: Fangyi Zhou <me@fangyi.io>
> ---
>  .mailmap | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index 9c6a446bdf..854f397796 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -70,7 +70,8 @@ Eric S. Raymond <esr@thyrsus.com>
>  Eric Wong <e@80x24.org> <normalperson@yhbt.net>
>  Erik Faye-Lund <kusmabite@gmail.com> <kusmabite@googlemail.com>
>  Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> <eyvind-git@orakel.ntn=
u.no>
> -Fangyi Zhou <fangyi.zhou@yuriko.moe> Zhou Fangyi
> +Fangyi Zhou <me@fangyi.io> <fangyi.zhou@yuriko.moe>
> +Fangyi Zhou <me@fangyi.io> Zhou Fangyi <fangyi.zhou@yuriko.moe>
>  Florian Achleitner <florian.achleitner.2.6.31@gmail.com> <florian.achlei=
tner2.6.31@gmail.com>
>  Franck Bui-Huu <vagabon.xyz@gmail.com> <fbuihuu@gmail.com>
>  Frank Lichtenheld <frank@lichtenheld.de> <djpig@debian.org>
> @@ -209,6 +210,7 @@ Paul Mackerras <paulus@samba.org> <paulus@dorrigo.(no=
ne)>
>  Paul Mackerras <paulus@samba.org> <paulus@pogo.(none)>
>  Peter Baumann <waste.manager@gmx.de> <Peter.B.Baumann@stud.informatik.un=
i-erlangen.de>
>  Peter Baumann <waste.manager@gmx.de> <siprbaum@stud.informatik.uni-erlan=
gen.de>
> +Peter Kaestle <peter@piie.net> <peter.kaestle@nokia.com>
>  Peter Krefting <peter@softwolves.pp.se> <peter@softwolves.pp.se>
>  Peter Krefting <peter@softwolves.pp.se> <peter@svarten.intern.softwolves=
.pp.se>
>  Petr Baudis <pasky@ucw.cz> <pasky@suse.cz>

I'm sure the maintainer would appreciate you and Martin =C3=85gren
<martin.agren@gmail.com> (CC'd) coordinating, i.e. there's also this
outstanding change that overlaps with yours:

    https://lore.kernel.org/git/20200816153037.1143576-1-martin.agren@gmail=
.com/

I.e. can everyone who wants to update the mailmap consolidate their
discussion/changes into one thread and come up with some recipe that
works for all of them?

FWIW I validated the change you made, while you could do your hunk more
minimally as:

    -Fangyi Zhou <fangyi.zhou@yuriko.moe> Zhou Fangyi
    +Fangyi Zhou <fangyi.zhou@yuriko.moe>
    +<fangyi.zhou@yuriko.moe> <me@fangyi.io>

I understand per recent mailmap discussion that Junio prefers having the
entries sorted over eliminating redundancy.
