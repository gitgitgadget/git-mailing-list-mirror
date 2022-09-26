Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A19C6FA8E
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 08:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiIZIix (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 04:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiIZIit (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 04:38:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0C33AE41
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 01:38:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l14so12462424eja.7
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 01:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=icvju6AgkNc05O+Yz6C+L09hOsudJC7v0H1Mld48ZOk=;
        b=iO/JVTF23Wzw3kSaLy79uNA8JbAlbwyClYq5xY6psCEHA01+hxMJG++BwmSMmdLCrX
         64TcI0m6nvBEY9hhDVudOtDlsy3aXhgWDhT/uJejcYUsgcNiDVVVzLpXU86G0VyW8BJt
         2Ezlf3CJYYPPfqi6cBPAQzJbqMDQwC53WQwmGgt9bSkHQQpSIjsREGIJFJnKbn2tKosy
         1IbfnMr+0nwAsbXVJU6TwYkmz43vZ08S6XdHapB3EO+dJM57Dlmv6VI/b6g3kbYjrz75
         xnYC9rdj+BhhmoJFn8RQryJyIzi2OtX8ImFtMdfvrJi5+CSpj7OsRavML1FcG7KN5eIM
         Li9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=icvju6AgkNc05O+Yz6C+L09hOsudJC7v0H1Mld48ZOk=;
        b=3bztuUgW4eS0/eXlGENL/K+UGy76THKgmGr8zaoSh3ySB+ss9Ewf8BB2gFfjALvuQw
         I7dVDQH3s1BCDMAPR7YzMS/+ap7l2HZcXEvWCLCkUwCAwOHQrk9rRCTX0AtHuoFjv55v
         JaHRSrhSSOvzZIu8uC45D2JDDD36Jil4e3Fqiy4xk0GeU++nidgJXiW/3hNL1/BmEys8
         xmStPb4UBOHMddzLB/3Pd10AGkIcQQv21h9eluMsimNdsYl4Mj8IPgYNOMXmIWwP8F+s
         lQRMk6yobvlgkGjKHTNUbCC2X81jfK4+U3kKHa/IrB47WYRZi51z29QmAXOGrzZiggJ7
         RSAg==
X-Gm-Message-State: ACrzQf3CtbfSl/5f0BlU/QpQGIaskf6NVv9vSwvOmCV4yVL51MnBsl77
        CHWF8Stf0/QGH/Yu8nBaokOhJ8VGEU8=
X-Google-Smtp-Source: AMsMyM5WYH6WMtPLapuOkE1NrQJ+/Kf1tZIJ3TgXUpQUdmQ3ZPrC93XJ7sESO+bclv0DS4JrEdssMA==
X-Received: by 2002:a17:907:72c4:b0:783:4fe0:daca with SMTP id du4-20020a17090772c400b007834fe0dacamr4716189ejc.455.1664181526916;
        Mon, 26 Sep 2022 01:38:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7d50f000000b00457160c3c77sm3703368edq.20.2022.09.26.01.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 01:38:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ocjdV-003mes-2I;
        Mon, 26 Sep 2022 10:38:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Chris Poucet via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Chris Poucet <poucet@google.com>
Subject: Re: [PATCH 09/10] evolve: add delete command
Date:   Mon, 26 Sep 2022 10:38:14 +0200
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <d087d467e3fe3000eb19939c2bb5e5c0723fd908.1663959325.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <d087d467e3fe3000eb19939c2bb5e5c0723fd908.1663959325.git.gitgitgadget@gmail.com>
Message-ID: <220926.86y1u634yy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 23 2022, Chris Poucet via GitGitGadget wrote:

> From: Chris Poucet <poucet@google.com>
>  static const char * const builtin_change_usage[] = {
>  	N_("git change list [<pattern>...]"),
> -	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
> +	N_("git change update [--force] [--replace <treeish>...] [--origin <treeish>...] [--content <newtreeish>]"),

Here you're just correcting a typo in an earlier commit, squash it into that one instead.

>  static const char * const builtin_update_usage[] = {
> -	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
> +	N_("git change update [--force] [--replace <treeish>...] [--origin <treeish>...] [--content <newtreeish>]"),

Ditto.
