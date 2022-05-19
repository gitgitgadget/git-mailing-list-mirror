Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DA6C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 11:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbiESLbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 07:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbiESLai (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 07:30:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A8A4CD53
        for <git@vger.kernel.org>; Thu, 19 May 2022 04:30:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i27so9315018ejd.9
        for <git@vger.kernel.org>; Thu, 19 May 2022 04:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7037uovQBm+BhEarhQCLn4Di1Ko96Ud/c/VCf0ulv7U=;
        b=bKolaMhFkIaqOotMF6OtpRKS/5YoWY0ZT2jMwcdttQHsnQu2PTxJcp3K9u2Wu/MjXr
         kTnFOqPTAMgsFcIO5YvwRLDm4udb+hfpMjUjpWl/WJnQZP3wW1zfGzRHOdgozVOnAsT8
         dkCEpnsnX+zwTMrWl06uYm9RujXnseIZCvFor/5aY9P4ShvLkPTHzMAo1gOyCHFRIZci
         ewmM5as3a865VM515ueaO1Xl0n+MdEogwmRyO5p/icPyaIqtB28h5CtJcnFvrDcoQHAc
         NuIKzMGp+9mGQsQrDa5MoFqyn53dX41KWxKhPyHjV6JUYLJQgxba/gjzAIAwGmBlALvW
         m6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7037uovQBm+BhEarhQCLn4Di1Ko96Ud/c/VCf0ulv7U=;
        b=4V6tmficI9v/LxcewpPzqx0JfCx1VcAdOEMVKFj3EeCDQp7HPBmFmU0ROfVWfx4nsc
         e3t37umP27cwfN9isbL24wuMb5P4PBV4YyePmOzxoKdhXJhX1IC7n3p6WtznRjrAuKwR
         chtrpGWsl4uuVcHY4J/H+BtInBYaKwHUEot+12pC69wTjiePC73L/yBEGHPYpiht3fiF
         GAu0MN/8iE6PF9UpP2tpK9taS33Hsg7l0UO9FJ3LTmQ9RtrGwSpnYZAJOyRM+1lGHx8G
         4zjEzvKDRbtUfN+P60NiMP+zDIUq6Bfl6QoZexpJCWybUiF62w9CG5feSERY1VrUPDLC
         +3Eg==
X-Gm-Message-State: AOAM530d1ZfRPnSHqeS6hCMxCESvxAlDrPmC/Qpqi/ZToReSsf/crHti
        lddRcqQ+39iU356Pd+eY2OY=
X-Google-Smtp-Source: ABdhPJxl+vaF6e9sWLCBfB6T0j4GWYPKAXwABCRZ62VEAL0thMtTT+h1x7u5DQyhNZxD/uFsP//wZQ==
X-Received: by 2002:a17:907:7b88:b0:6fe:8c1e:ca1f with SMTP id ne8-20020a1709077b8800b006fe8c1eca1fmr3667546ejc.52.1652959835509;
        Thu, 19 May 2022 04:30:35 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id dk16-20020a0564021d9000b0042a6d0508a9sm2680002edb.73.2022.05.19.04.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 04:30:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nreMT-0025dQ-Vw;
        Thu, 19 May 2022 13:30:33 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 12/17] builtin/repack.c: support generating a cruft pack
Date:   Thu, 19 May 2022 13:29:26 +0200
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
 <5992a72cbf9e8d076f1e312a789b40d52656ad3c.1652915424.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <5992a72cbf9e8d076f1e312a789b40d52656ad3c.1652915424.git.me@ttaylorr.com>
Message-ID: <220519.86v8u14v52.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 18 2022, Taylor Blau wrote:

> +		tip="$(git rev-parse cruft)" &&

Here we don't hide the exit status of "git", as it'll be reflected in what's &&-chained.

> +		path="$objdir/$(test_oid_to_path "$(git rev-parse cruft)")" &&

But here we do, as we'll get the exit status of test_oid_to_path. But as
we just rev parsed it shouldn't this be $tip in any case?
