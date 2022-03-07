Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44073C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 15:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbiCGPq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiCGPqy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 10:46:54 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46F47EB02
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 07:45:59 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bi12so19763308ejb.3
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 07:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ii//j/V1HEuN2poRD9XvVR+yOdL23tEtu1aWCy/966k=;
        b=d1fgWgwJyjo2CGFiLYTGyVOmMUsdnx5osT8Y4kbOmAqttZ3C+wOY4uaTXDsrUjdOwU
         VqUbKdPoNC4G4ySlDcQ5pu4Sx/BQc//kLWBA4ZA0jQPNepEculh5KRyO66mX5QCef13R
         8rroGtuYsK1bWc+pHbu2GWotAn23SGRdAoFIDGtrLorwNLdTUHzV3jIotMIWetPSZ3Uk
         cXko0kR3Dn4Uz9DPh+0dpxUPE7/ItwJapOxeG1jIAcniWgAtbrS7pyrkjzI9M8c29XTo
         xLC0/Ol99aJsgYTcQ6SYW2Z50S+vZvB8IvZ8zRR4XyaWwit+Zj1hMCu55MsuyBHRwOnu
         TDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ii//j/V1HEuN2poRD9XvVR+yOdL23tEtu1aWCy/966k=;
        b=IiRokCoKycKfofA4gbh6njw5MQs707KSphfRaGLCAN0FuM9/6ru/0QfDKJ5wUR4W5s
         EIzzx5Jfc8IWnSdgBFI7Ekq+CIYpkmd1EpsJDPx8y8NvZZRugXk1ACb4AFR99er6rYB5
         8G4cN62vMzz/7E649ItrvRb/oWIgMW0BybG3qicSDDpffdrXTGNaU3ZxVGTfcl1HBlrL
         xHwXON1vu94dzBlk6TId8fJ4rSEuPdSUxzCgam6Ld08ZjVDJ8BJXxKJwSwCCHLmL3F0M
         0YezgFnq0N5hENPv5T8dqyIeLvILlHyDHidwk173FO+N1nX0CvYcl8BNfc4u7irwcefn
         Luxg==
X-Gm-Message-State: AOAM532UOUYW1Ecnt4z/Hh8yFxM1czsFQg1kI91raZkHXq1yzZtUtfQh
        iMxSVDxnn3tKssV4q+eDt3IAR+Nctws+3w==
X-Google-Smtp-Source: ABdhPJxOdbV8raGv1fnZjSSkXWNsYD6gHoAmCsnvhJWwX4Tj61i3mCn9NSSZ2dIxLXXDjHRoP5L1/A==
X-Received: by 2002:a17:906:58ce:b0:6da:b548:1bbb with SMTP id e14-20020a17090658ce00b006dab5481bbbmr9384581ejs.14.1646667958050;
        Mon, 07 Mar 2022 07:45:58 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b004136c2c357csm6343732edt.70.2022.03.07.07.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:45:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRFYb-001a2i-2n;
        Mon, 07 Mar 2022 16:45:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 10/11] bundle: create filtered bundles
Date:   Mon, 07 Mar 2022 16:44:29 +0100
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <5393e74708dfd38e5596d9e877a491e6ed8dda24.1645638911.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <5393e74708dfd38e5596d9e877a491e6ed8dda24.1645638911.git.gitgitgadget@gmail.com>
Message-ID: <220307.867d95zryi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>

Just something missed by Junio....

> +for filter in "blob:none" "tree:0" "tree:1" "blob:limit=100"
> +do
> +	test_expect_success 'filtered bundle: $filter' '

I think you'll need "" here, the description part of test_expect_success
isn't eval'd.

> +		test_when_finished rm -rf .git/objects/pack &&
> +		git bundle create partial.bdl \
> +			--all \
> +			--filter=$filter &&
> +
> +		git bundle verify partial.bdl >unfiltered &&
> +		make_user_friendly_and_stable_output <unfiltered >actual &&
> +
> +		cat >expect <<-EOF &&
> +		The bundle contains these 10 refs:
> +		<COMMIT-P> refs/heads/main
> +		<COMMIT-N> refs/heads/release
> +		<COMMIT-D> refs/heads/topic/1
> +		<COMMIT-H> refs/heads/topic/2
> +		<COMMIT-D> refs/pull/1/head
> +		<COMMIT-G> refs/pull/2/head
> +		<TAG-1> refs/tags/v1
> +		<TAG-2> refs/tags/v2
> +		<TAG-3> refs/tags/v3
> +		<COMMIT-P> HEAD
> +		The bundle uses this filter: $filter
> +		The bundle records a complete history.
> +		EOF
> +		test_cmp expect actual
> +	'
> +done
> +
>  test_done

I think this needs a corresponding documentation update, now "verify"
just talks about output related to whether the history is complete or
not.
