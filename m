Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFA3C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 06:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiLBGED convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Dec 2022 01:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiLBGEB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 01:04:01 -0500
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE99CDC4F3
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 22:04:00 -0800 (PST)
Received: by mail-pf1-f177.google.com with SMTP id k79so3991328pfd.7
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 22:04:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2xuSBLnHMMlTgYlpxXPwP+M/h1FAJNNw3M+o3QYMhM=;
        b=yEpeUfBMXRpSNMLSIqMN/cgf7T9PR5zWhy6AA9oZRVt8asyhRRPoEaFhmW0muWbOiu
         alaq318brAf+v/GWPqB/igo8Qs1c6yIlcT5UC3ygVlVoYC2FX/PZH+loc6Md2Dzizgru
         KL8gLuH56V2V/Jc9nLn77bx/X7evZNzuZOzGDv3SnKag6HQLjqLcoblXqhLzBhPVyNb1
         TglOMBOThMN4PQqZzArbAV7jfo2CTnzfjqea78wptybjVCQ0N6/LZkPvUNw85N3umcwR
         E4yN2h9FIQ/SleDmHat/g1CwLc8IhHL6zXwPy7QjGY8eYGpk/imtG+ojHzNFZFmIbs5Q
         VJlQ==
X-Gm-Message-State: ANoB5pn9ftnjRbx4dHUjx7Tk2TF1kbQN07KWZP1jwq+v4zPi9ym6OgQv
        6OI/3C+2OKmDbbFqj+nxtPRItIoDYpEkwDSM7zs=
X-Google-Smtp-Source: AA0mqf4P6RM3TmrzE/pad7xazriZddREH85YW9sTkQUYEteYh8L3pyl1N0xJFxzZlj96j5ope4WbywCPHBpoKMSrd34=
X-Received: by 2002:a05:6a00:18a9:b0:572:6da6:218e with SMTP id
 x41-20020a056a0018a900b005726da6218emr51545000pfh.1.1669961040215; Thu, 01
 Dec 2022 22:04:00 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <patch-v2-2.8-345a667d5bb-20221202T000227Z-avarab@gmail.com>
 <02ead668-5b5d-877c-1e40-3656fd85945f@web.de> <20221202055905.2rqp26xu4nuknlxw@tb-raspi4>
In-Reply-To: <20221202055905.2rqp26xu4nuknlxw@tb-raspi4>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Dec 2022 01:03:49 -0500
Message-ID: <CAPig+cR2txMuv1E00TYuYJu=QU4psYi89VromYYKqHZb_7WQpQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] auto-crlf tests: check "git checkout" exit code
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2022 at 12:59 AM Torsten Bögershausen <tboegi@web.de> wrote:
> On Fri, Dec 02, 2022 at 02:02:55AM +0100, René Scharfe wrote:
> > Side note: The checkout commands only differ in their -c parameter.
> > They could be unified like this, which might simplify handling their
> > return code:
> >
> >       git ${ceol:+-c core.eol=$ceol} checkout -- crlf_false_attr__$f.txt
>
> That is a nice one. (I learned about the ${:+} yesterday).
> Is it supported by all the shells/os combinations ?

${:+} is well supported. It's POSIX. It's used heavily in the Git test
suite already. So, it's safe to use.
