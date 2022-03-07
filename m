Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40760C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbiCGLg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbiCGLgx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:36:53 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2A84925D
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 03:35:59 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g3so7220152edu.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 03:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rWD8MgAzHF1r98veMPPiYPh8Uwdfb5mWIPFmkYYF49M=;
        b=lqbaXYCYRMm3a7i07BU1xSrGF415phyLPZ/GwlvhS1EnTWDDhWcKBOjdlxrV7cgGKA
         8EIbPKcnvulSNtIHGP/fbfuVXQRwMUiFtNZZ9585Y5neXA52TJRKxu1J0mn5CqrndEJ6
         7IYVVehsGu1tpbCxY8qsfOPxBqzXv3i3QVyudQRPzJY5k8M4Eh2ESLw7i6/IZC5zfnwR
         tmjxbkkabYgVDInxLzGiFbefob1GcFvdBtZ/NqhMcLDbO6adaPn9oOq8TftijMLiSqJR
         bfmudAS907veX/1LXYDQPZ/EgCylOhcYAQOgvq6scK+lbpNHxMwkhVTnmFsm+RNFvxYw
         hqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rWD8MgAzHF1r98veMPPiYPh8Uwdfb5mWIPFmkYYF49M=;
        b=HOalGJTLZB/4YmQk9W3uFBytAvzt3F91zWn6prW2d1XwXdMjd9j3l4lpErmmvnj0Hs
         uOr0Tpwo/CRMWFLhk2yIxDoxPn26hQXJB0aQQbySnesCupbwoThWOnj1advoiMVmEV9j
         wfIjvOxPGzp9aKSFLnaj+/m3DmY24C9ohwToUNoBXXCuNPMFmtuin75evk1nvzOrXgDN
         Im2Cv2b+K1Dm0nqxeuUCGXTtY+WQ0zeHv2WOjNMiHT0mG8zTj84gAYrTODwazjNa/L8S
         9aL7hjPWf+jmRZsBcgNfyWkOHmWjt9TH5qT7i1PmUnqP2Wkby9yZKn2DtlKzKfOFVTmq
         O4jg==
X-Gm-Message-State: AOAM532i6QAV82xS3OB+PPOV6CEwWOd7sqenTjxLX39+P+k9N3PT3ODy
        l/lu9cRDRhwZY5UNEiitd+aiREUV7uY=
X-Google-Smtp-Source: ABdhPJzD5m13fr47vcnfyZZil9Iav82WmZ1CY4/G3WaWy16Tr50xe/HFAJOtJMeza3kEu6VCDTXTrQ==
X-Received: by 2002:a05:6402:2694:b0:411:f0b1:7f90 with SMTP id w20-20020a056402269400b00411f0b17f90mr10449118edd.398.1646652957329;
        Mon, 07 Mar 2022 03:35:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m26-20020a1709060d9a00b006da81fb9d72sm4646206eji.100.2022.03.07.03.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 03:35:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRBee-001S9T-9Q;
        Mon, 07 Mar 2022 12:35:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 30/30] update-index: convert fsmonitor warnings to
 advise
Date:   Mon, 07 Mar 2022 12:29:34 +0100
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <b915b95cc2f82728e3f5f7135f041a709a74ce5d.1646160213.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <b915b95cc2f82728e3f5f7135f041a709a74ce5d.1646160213.git.gitgitgadget@gmail.com>
Message-ID: <220307.86mti20zc3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/update-index.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 876112abb21..d335f1ac72a 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1238,18 +1238,18 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  	if (fsmonitor > 0) {
>  		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
>  		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
> -			warning(_("core.fsmonitor is unset; "
> -				"set it if you really want to "
> -				"enable fsmonitor"));
> +			advise(_("core.fsmonitor is unset; "
> +				 "set it if you really want to "
> +				 "enable fsmonitor"));
>  		}
>  		add_fsmonitor(&the_index);
>  		report(_("fsmonitor enabled"));
>  	} else if (!fsmonitor) {
>  		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
>  		if (fsm_mode > FSMONITOR_MODE_DISABLED)
> -			warning(_("core.fsmonitor is set; "
> -				"remove it if you really want to "
> -				"disable fsmonitor"));
> +			advise(_("core.fsmonitor is set; "
> +				 "remove it if you really want to "
> +				 "disable fsmonitor"));
>  		remove_fsmonitor(&the_index);
>  		report(_("fsmonitor disabled"));
>  	}

For any new advice you should:

 * Add it to advice.[ch]
 * Add it to Documentation/config/advise.txt
 * This should use advise_if_enabled() with the relevant enum you add
   (which should also be documented in the *.txt)

I'm not oppposed to this change per-se, but I think this narrow change
makes the post-image of builtin/update-index.c worse.

Why are we issuing an advice() only for this config, but not changing
the other two uses of warning()? In the post-image:
    
    6 matches for "\(advise\|warning\)" in buffer: update-index.c                                                                                                                                       1195:                        warning(_("core.splitIndex is set to false; "
       1204:                        warning(_("core.splitIndex is set to true; "
       1216:                        warning(_("core.untrackedCache is set to true; "
       1228:                        warning(_("core.untrackedCache is set to false; "
       1241:                        advise(_("core.fsmonitor is unset; "
       1250:                        advise(_("core.fsmonitor is set; "

We should either leave these alone, or give them all the treatment of
adding a new advise.updateIndexConfig or whatever, and have them all use
advise_if_enabled(ADVICE_UPDATE_INDEX_CONFIG, ...).

Also these existing messages seem really confusing both for the
fsmonitor & others. We're telling the user "do XYZ to disable ABC", but
then right afterwards we say "ABC disabled" via report()?

