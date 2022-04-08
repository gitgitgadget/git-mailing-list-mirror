Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E41C433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 08:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiDHItR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 04:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiDHItP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 04:49:15 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A755A32B316
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 01:47:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dr20so15829883ejc.6
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 01:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YsF+L7nl9tqFczCQfbg2utFnuZAUAmm9FjqsPNqtb+Q=;
        b=XXFHo06EO9pJzYLh8f4YKsvB8S++Szl+XzcYCmGFZH6qAfI/VM3QbM/qw7Hd8jVRVW
         vP/ROlweC8UwXy0K3wyCHJKdsGjnUwf9B4C7SsSTKsnAownFsAQmSbT3KD+3hN8x09vn
         AVDQIS7zCWljL7I1fqeMfuDv297rRbLR/jBXRICfRgwsmPGpHwkQIZ9B7aRrwsGl4Ldd
         jJM7HshLuN3Gqk/yewiAe3SRGi1U1JaQ5Q7kQKOeZXc8UUyrjLqGM/C7Zx8PUsrDOn7r
         gBDJAD9eL161MXEucQyVCe51vHQOS7NLJigYvEaCxrFgmYxXHiRY/K/kTb6JjVoQZLdY
         nxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YsF+L7nl9tqFczCQfbg2utFnuZAUAmm9FjqsPNqtb+Q=;
        b=lOuP6U72mOTemcqGaFG63NHqilS0fbDuX6vldidBb10k7+TEboPmFmvGW/3gTtWiau
         9/53O42zdmrp/lbgn2Iw6KNYtCTtWSfGTja1Uc4FnJiK2xcV+vUjCX92g4kPxuUCROJ5
         nndFaF7mAoUtImBMONuwPGnrv6YRnjKjpaVn/rz+i2W8BxB6iRJItWfohdygWCulBz5w
         JE73QLIB845CwVcgkqEed8Uxarvo+anHmGt3NaELEqAvhauLjTgBHBwfE+uQWNI3+iNF
         764Whg56r9KzMWcdUDFxjKJuy37WUIZLJSV6IFPBuymMs5FjpnaHeMKlm+Fll86JTf2p
         oshQ==
X-Gm-Message-State: AOAM5319zioeACcrL9sQCvBZf+3Pw9vBkdycozJQw7LnLhjBkjiep83U
        5TJnBT3PAB1WQ3LiWfCZ1wI=
X-Google-Smtp-Source: ABdhPJy3cdI4wh4E+XPqeVhHrk7wtZvoFYygKCqK+8HeJFMHnoSFKGZdQc+APjq5TbQw9BMCbSFtTg==
X-Received: by 2002:a17:907:2a53:b0:6ce:e4fe:3f92 with SMTP id fe19-20020a1709072a5300b006cee4fe3f92mr17217564ejc.389.1649407628958;
        Fri, 08 Apr 2022 01:47:08 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s11-20020a1709066c8b00b006e7ca6f0401sm5998490ejr.136.2022.04.08.01.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 01:47:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nckGp-001FBt-U4;
        Fri, 08 Apr 2022 10:47:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Thomas Gummerer <t.gummerer@gmail.com>,
        joostkremers@fastmail.fm
Subject: Re: [PATCH] stash: disable literal treatment when passing top pathspec
Date:   Fri, 08 Apr 2022 10:46:38 +0200
References: <20220408031228.782547-1-kyle@kyleam.com>
 <e93e9bb1-8bd1-a70f-f671-ca322c14c7a1@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <e93e9bb1-8bd1-a70f-f671-ca322c14c7a1@gmail.com>
Message-ID: <220408.868rsgc67o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 08 2022, Bagas Sanjaya wrote:

> On 08/04/22 10.12, Kyle Meyer wrote:
>> +test_expect_success 'stash -u works with --literal-pathspecs' '
>> +	>untracked &&
>> +	git --literal-pathspecs stash -u &&
>> +	test_path_is_missing untracked
>> +'
>
> Why not "touch untracked" instead?

The ">" form is correct here. We use "touch" when updating the timestamp
to something in particular is important, but here we're just creating an
empty file.
