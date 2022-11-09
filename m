Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0390C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 16:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiKIQHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 11:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiKIQHp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 11:07:45 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF37220CD
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 08:07:44 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ft34so11613695ejc.12
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 08:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=acp4bUwA081C3paR/vCTPXEvMbtmDce9mEpSHyLmc5A=;
        b=k2BW7OmXRtXOBYVhFHDQqMXoTzvMoceEN/9RVMQ+0q20RKZSgso9aqr92cP82Xt7He
         Sg3zun125uGEA2+cDMNxm+LrZWUGjEDDdIdaZA+QnhhI/3ogSlF873+NZdb6eaSsxdYk
         HRf/fzJb8euUfj15OWufKKGVWBsBDj7HYlNF25tiDyyIWC2X1umqIJIzHQAI/q9q3Y9P
         u403BmiQv0fif5gNBGnl7wdb+xuGoayFxcTBHLS8LQXDpav4btcBRQ555iWCL9Fo1EAd
         cq6ovI1VxmDk1ARO+0lxbCKOjFH3VQe1OefHEquXHWCZV8udywewQIZ95VMxAbbZgsZe
         NFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=acp4bUwA081C3paR/vCTPXEvMbtmDce9mEpSHyLmc5A=;
        b=mfPmtYANq+v1KJS/070zCS4ufvYjdPDA56vD0AV2iUpo7UTUOJ7OWSzaSXkgkZLbjo
         SNVCfcypsOcc1gOmpcrlcmZhgBIXI3hGQnz0Wd025p/Fk1ClvEipRR4yERt72EH9IaEI
         xmBEuk1zw4vN9IG2ZB27zcICWPVHmkEunP5m0kzQOZGQr/4ejVWDXjk7RUf14F2geqah
         tOeBApSK4vT/AqLzbb/zc7gthFRxe4BbFceyTYNfXB4WP7+eGQOBzyQaUYVLAd3Z2XmF
         C6OV62ZC/K6or43DDlLqXae8WUcY+UqXYr9F03zna3mu8SYOprNqjUIV7kTnoJzBWz9G
         wklw==
X-Gm-Message-State: ACrzQf19/m+BAKVmZp1UYc2nBTwLu6/AkwtqMtgGo5oRPf8gD6UN8k+R
        M1TohmpchBsihyrhnx2gM/w=
X-Google-Smtp-Source: AMsMyM4GE/rwixj4waFeefP4k8l5Voy5R/FxvmBUb0flttSBSBvTxq9hTTPjChE8j9duJuczwJ9ndg==
X-Received: by 2002:a17:906:9c87:b0:7ae:1e53:8dd4 with SMTP id fj7-20020a1709069c8700b007ae1e538dd4mr1099937ejc.42.1668010062569;
        Wed, 09 Nov 2022 08:07:42 -0800 (PST)
Received: from gmgdl ([109.38.150.4])
        by smtp.gmail.com with ESMTPSA id kv15-20020a17090778cf00b007adf125cde4sm6172602ejc.13.2022.11.09.08.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:07:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osnc5-0010JT-0n;
        Wed, 09 Nov 2022 17:07:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/2] rebase: stop setting GIT_REFLOG_ACTION
Date:   Wed, 09 Nov 2022 17:05:24 +0100
References: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
 <pull.1405.v2.git.1668003718.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1405.v2.git.1668003718.gitgitgadget@gmail.com>
Message-ID: <221109.86leokp0vm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 09 2022, Phillip Wood via GitGitGadget wrote:

> This is a follow up to pw/rebase-reflog-fixes that moves away from using
> GIT_REFLOG_ACTION internally.
>
> Thanks to Taylor & =C3=86var for their comments on V1. I've updated the c=
ommit
> message of patch 1 as suggested by Taylor, the code is unchanged.
>
> Phillip Wood (2):
>   sequencer: stop exporting GIT_REFLOG_ACTION
>   rebase: stop exporting GIT_REFLOG_ACTION
>
>  builtin/rebase.c | 27 +++++++++++++++------------
>  sequencer.c      | 45 +++++++++++++++++++++++++--------------------
>  sequencer.h      |  6 ++++++
>  3 files changed, 46 insertions(+), 32 deletions(-)
>
>
> base-commit: 3b08839926fcc7cc48cf4c759737c1a71af430c1
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1405%2F=
phillipwood%2Fmore-rebase-reflog-fixes-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1405/phill=
ipwood/more-rebase-reflog-fixes-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1405
>
> Range-diff vs v1:
>
>  1:  e9c3f5ac5c6 ! 1:  655b4e89f59 sequencer: stop exporting GIT_REFLOG_A=
CTION
>      @@ Commit message
>           pass the reflog action around in a variable and use it to set
>           GIT_REFLOG_ACTION in the child environment when running "git co=
mmit".
>=20=20=20=20=20=20=20
>      +    Within the sequencer GIT_REFLOG_ACTION is no longer set and is =
only read
>      +    by sequencer_reflog_action(). It is still set by rebase before =
calling
>      +    the sequencer, that will be addressed in the next commit. cherr=
y-pick
>      +    and revert are unaffected as they do not set GIT_REFLOG_ACTION =
before
>      +    calling the sequencer.
>      +
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>=20=20=20=20=20=20=20
>        ## sequencer.c ##
>  2:  d3747bcc8d1 =3D 2:  31df037eafe rebase: stop exporting GIT_REFLOG_AC=
TION

Thanks, FWIW I'm happy to give this my "Reviewed-by", per [1] I've
looked this over carefully.

The tl;dr of that is that this fixes a leak, and adds another one, but
the root cause of the added one is that you're using an existing
destructor that we sometimes don't call, which we can just address as a
follow-up generic issue (I've got patches to fix it).

But for now this is a good step forward, and fixes the leak that's
"unique" t this codepath.

And of course, just makes managing the "reflog" variable nicer in
general, as we're no longer talking to ourselves within the same process
with setenv()/getenv().

1. https://lore.kernel.org/git/221108.864jv9sc9r.gmgdl@evledraar.gmail.com/
