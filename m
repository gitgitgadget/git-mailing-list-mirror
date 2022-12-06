Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAA4C3A5A7
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 09:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiLFJNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 04:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiLFJNg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 04:13:36 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5171EEF0
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 01:13:32 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 130so13952200pfu.8
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 01:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pkm+2IS2LbNj03fBXy1/dskIGTi42MO+GxwtlD5AobI=;
        b=csl2eest3mG9Rd5OCbMF8DgRbDk7F7TVglT6E9I6fQS2d0RXFghZsD83kHMS3Iha89
         FoH/CF+bne+zr1tDud5xIyv93gGn6NAtCFLeRroFSS4hpCrYAtIopKD1LVawzgtmdvOR
         lxjNPcNpmZpzHgjd+4SAxSjYYWtrlaliDzR3E+bGW/xKw5BQgH/eJWrzlEbgMPtxbnfM
         dni9ZavC1zZH2zRWveRCbGui5NCLnpsKvb9JoEAWgiuN9AsVxEZqm7Fpafl85+5roQR9
         fwtv5I0poXUV2EO2D2RF5O/YtQGl785bG/Am4ov6RfrSp+m7/e4lBq85v6SbT49nvyKD
         zDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pkm+2IS2LbNj03fBXy1/dskIGTi42MO+GxwtlD5AobI=;
        b=E4mjhP7gsX3l7iu5LnmJQBdUu+rvXYd98gtywtdn51K4qdf3kvkzS4ocbKV6bI8L2D
         FAnkbg3XUOQ85xqIOJejvWG6OH9No5qNDN/xazACQMQWnnT/SIimWzQ0LUgI6bKpNilc
         gRlBbRtcfJS6lqvM4Tj5v6q8TfLkZ3mJ59TbqlRIeDaYc/CnOnwz+CYMkWNQL5OfSr+4
         DTz0uuvUxk2OYzjCDe7BHT2YJrAJclRB6FgScYp2qKqqiq6/I1FQXkDoewcQipCx9FuG
         m83MHGSlwlJLkI3JmckGpREUnwmn9TBAvRmcmyYrwf+dnIkLnHLPVIyyp/Trctionh+r
         2sQA==
X-Gm-Message-State: ANoB5pnjnu8oX19WGITM+Lm753n9wwSGrM1IJV0LJaoY1332cY26lbRt
        Ik53ejgsDb/U7Cv3UGP7K2U=
X-Google-Smtp-Source: AA0mqf7FtkJle0vYN1KIm53OjRibRFWz+VrI2DxV7TyJDN06/OeCVmJSJkgszOb+y72oixWw9UmvZw==
X-Received: by 2002:aa7:8d8f:0:b0:56b:b112:4a16 with SMTP id i15-20020aa78d8f000000b0056bb1124a16mr92140100pfr.66.1670318011194;
        Tue, 06 Dec 2022 01:13:31 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d12-20020a170903230c00b0016c9e5f291bsm12129317plh.111.2022.12.06.01.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 01:13:30 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Paul Smith <psmith@gnu.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] Makefiles: change search through $(MAKEFLAGS)
 for GNU make 4.4
References: <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
        <cover-v3-0.1-00000000000-20221130T081835Z-avarab@gmail.com>
        <patch-v3-1.1-432518b2dd7-20221130T081835Z-avarab@gmail.com>
        <006f10e84c9108a7be7315fec753316ca743386c.camel@gnu.org>
        <xmqqpmd4ulnj.fsf@gitster.g>
        <1rq7o244-pos8-rp21-1q49-3210454n89nr@tzk.qr>
        <221206.86edtdc4rg.gmgdl@evledraar.gmail.com>
Date:   Tue, 06 Dec 2022 18:13:30 +0900
In-Reply-To: <221206.86edtdc4rg.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 06 Dec 2022 09:13:08 +0100")
Message-ID: <xmqqv8mo99ol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Which seems to have been followed-up by
> https://lore.kernel.org/git/pull.361.git.gitgitgadget@gmail.com/;
> I.e. you sent a git-gui change to this ML.
>
> Or do you mean that it should have been sent to this ML, Pratyush should
> have pulled it, and Junio would have pulled upstream after that?

The destination of the e-mailed patch was fine.  I think what Dscho
is saying is that the patch for git-gui should have been split into
its own patch that is rooted at that project, i.e. the "diff --git"
line shouldn't have had "a/git-gui/Makefile" but just "a/Makefile"
if the patch were to modify the top-level Makefile of that project.

Then the git-gui maintainer picks up the patch (after possible
review iterations), applies to his or her tree, and tells me to pull
the result with "-Xsubtree=git-gui" option.

At least that was how the world worked, when we had an active
git-gui maintainer.  The same story goes for gitk part of the tree.

These days, neither subtree is very active and I am not sure how
much value we are getting out of this "clean separation".

Thanks.

