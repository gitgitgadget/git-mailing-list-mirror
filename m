Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50FDC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 14:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349544AbiCUOom (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349508AbiCUOok (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 10:44:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38C03B556
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 07:43:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qa43so30204474ejc.12
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=BtSo/uhX5w0r34+qP1L9zzeAJ2DmlKYb6+suCLsRHqA=;
        b=T+amkE/xbUBlWwDnrtY88mcF77PAlCdCJd5w0i4Y0errBVuru2d/lleYgJFhmXQD+T
         bRIV315strTT/nHk3hn7te8fRMbvyJ/G1FXKcN830jwoq1xUqor/Gkc5YB82DXb4HSJ6
         yJHQyQtS9yZjz9LSuFXbw17sS64TpPd2ZL4beHB1eoK7r4itFxGdpZQgGG8ez+JU4vBN
         fmPNSz2CoDyfrto579RM/pXD/855R0vApHivmxu1+6LANZk+iIbCk6I7Am5UZpiyrT+z
         lfPs3Ek7jK2U9jdV5TdrSL3kXaoJ2sRNGuOIcO4N3of22yJQeQidrk8I5yBo153OKlJ2
         newQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=BtSo/uhX5w0r34+qP1L9zzeAJ2DmlKYb6+suCLsRHqA=;
        b=qqTZdup8JlLEvZfLZChSs1fX1H60IglQHR42mG9aVWazuF6R0xaYH6/No1HTHTuOu2
         TqIjqLROquKdcaWCkBkN9+8PR9mHJTs8ryVFJDhKINqKYqoJh1BJmkGudRpIKXo9LICa
         u1rFZhUXJI7MAk4e6XjGBUZOAxCq5lGzMmaGFRyDcO5HIVkb4YTOIwiZpDXtQpkADR9G
         MBW6wdBEJHKbVDKYeWdguLAOi94OLEw9VlSEElFOm+MFKkkrx2Yactyb+e9Dtw0mgPtk
         FOgNYF+gvCgLvh6+4jdhPKFjp4ZCQSbNMfQNbCHQ2qwlNf8/Zolmco/zxH+HnM69+EbK
         yzGw==
X-Gm-Message-State: AOAM532pPTpZVtmIuFrDQI+oMX/AhZby17I6YYHN4c6evOirCSlJLmWn
        bSn1jYk1hqmAvGNNSXJbM04muxpwO+g=
X-Google-Smtp-Source: ABdhPJzM5h7syHtctxs6f4xxGiRRpZxKgOZbf9O9cmHCTEi7Q60nwgHcVGihvZZB6162OHbc507PXA==
X-Received: by 2002:a17:907:6d11:b0:6df:f38b:b698 with SMTP id sa17-20020a1709076d1100b006dff38bb698mr8473842ejc.711.1647873787183;
        Mon, 21 Mar 2022 07:43:07 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090617d200b006db07a16cf5sm6990179eje.77.2022.03.21.07.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:43:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWJFS-000YKm-07;
        Mon, 21 Mar 2022 15:43:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        nksingh85@gmail.com, ps@pks.im,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 2/7] core.fsyncmethod: batched disk flushes for
 loose-objects
Date:   Mon, 21 Mar 2022 15:41:22 +0100
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
 <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
Message-ID: <220321.86a6dj9xja.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 20 2022, Neeraj Singh via GitGitGadget wrote:

> From: Neeraj Singh <neerajsi@microsoft.com>
> [...]
> +	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT)) {
> +		bulk_fsync_objdir = tmp_objdir_create("bulk-fsync");
> +		if (!bulk_fsync_objdir)
> +			die(_("Could not create temporary object directory for core.fsyncobjectfiles=batch"));

Should camel-case the config var, and we should have a die_errno() here
which tell us why we couldn't create it (possibly needing to ferry it up
from the tempfile API...)
