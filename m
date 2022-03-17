Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CAAC433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 10:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbiCQKGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiCQKGo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 06:06:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980201DC998
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:05:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m12so5858994edc.12
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2RIJZtYGhZqTbbYOIaUcKHy6jGrvGlFVqT/HQLhmDww=;
        b=ew9tUynPJFQCMUO+WiC90hYVDUwq1g8Xbepu4F5w5YAhUjs3FvUj8IQctFIMPzP3KX
         6X06eKfMa7HLGvF913V3QG3cRlyTE0n71tqcB7Hzhl7PZATlSk1FuaFYnUslh9Zvjfce
         ta9AkIDGZib2xHh+Xta1T/HtidfBMkBacqEdgl64fdZ/D0AbSzmMLRHajiegAO2QZxBT
         91NiGe6G5aa1ojDaIRUM/wZwIqYVKtHZEMxUazsUSMrjstxE3DF0aMBhrxCHM6L9cAF4
         j02zMcsw6rHYF7WeIj7V/JBFo2AqI5IQJV/W1vg4e8JXtOy02okNgizmbY32mnyrBNa7
         1mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2RIJZtYGhZqTbbYOIaUcKHy6jGrvGlFVqT/HQLhmDww=;
        b=VKVLVOt0jmDf8kxfyQecedamJjVH6xlmTISmB2OAqi8WNun1346l5Q9i9J2NqvSBs1
         2u9DaCQoo4kBDYiXi3UaTO5T1qN5/2c9qHI8hl9KY40XoNa8o086RoBXKCsgKZl4E57k
         GmFDMRHAsE2djpmPg8kj1H9fggToWMMI+yngmPyIoanxPN+u2avywgf2D4dlm6jvvxmS
         RJs8X/IBklbjRzdOCNR/ylCBp4ZgGDOpNo+iHtql1fkMM+rziUVKswkwFLVsHQ30P9PU
         AAldafHDisfwGgncFAZ1PplxaSJDS7b+hKRu5yNpDS5BKxkHAg+B7S1J6KWkUbtQxsU/
         LGIQ==
X-Gm-Message-State: AOAM531D5YWcNL9rENVFwQxedD5efYEyo2jnSIQUqqOfZckA8PDeqbUw
        pCPkMCaHRc3puNav3Z+NRM4=
X-Google-Smtp-Source: ABdhPJyJRIKT7JqWhM3N0bVESTBVSbGaAAx7BUmZ/Q9BqCc1srrGimX1wEs4wLqzaK5LzaNZX/U5DA==
X-Received: by 2002:a05:6402:34d5:b0:416:201f:c636 with SMTP id w21-20020a05640234d500b00416201fc636mr3491780edc.293.1647511527009;
        Thu, 17 Mar 2022 03:05:27 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i14-20020a50cfce000000b00415b0730921sm2448268edk.42.2022.03.17.03.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:05:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nUn0X-001wWt-Ns;
        Thu, 17 Mar 2022 11:05:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC/REVIEW 0/7] fixups/suggestions/musings for
 tl/ls-tree-oid-only
Date:   Thu, 17 Mar 2022 11:04:10 +0100
References: <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
 <20220317095129.86790-1-dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220317095129.86790-1-dyroneteng@gmail.com>
Message-ID: <220317.86zglodhcq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 17 2022, Teng Long wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote on Thu, 10 Mar 2022 14:56:56=
 +0100
>
>> I don't think all of these need to be squashed or fixed up into the
>> proposed series, but are just various small issues/questions I came=20
>> with while reviewing it. Brief notes=20
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (7):
>> ...
>
>
> I looked these commits in "RFC/REVIEW" and I think each one is a good
> improvement. So next, to make the squashes or keep it alone  I think
> maybe it's like:=20
>
>
> (1) ls-tree tests: add tests for --name-status
>
>     They are new test codes that better than old ones.=20
>
>     Action: Keep it individually.
>
> (2) ls-tree tests: exhaustively test fast & slow path for --format
>
>     They are better test codes for the correctness formatting mechanism.
>
>     Action: Squash into commit 'ls-tree: introduce "--format" option'
>
> (3) ls-tree: remove dead labels
>
>     They remove the dead labels, and you mentioned it should be squash in=
to
>     the commit which brought them in.
>=20=20=20=20=20
>     Action: Squash into commit 'ls-tree: slightly refactor `show_tree()`'
>
> (4) ls-tree: remove unused "MODE_UNSPECIFIED"
>
>     As the subject describes, remove unused "MODE_UNSPECIFIED" and make
>     "mutx_option" to a better name "mutx_option". It's the prepared commit
>     for 'ls-tree: remove FIELD_*, just use MODE_*''
>
>     Action: Squash into commit 'ls-tree: slightly refactor `show_tree()`'
>
> (5) ls-tree: detect and error on --name-only --name-status
>
>     Optimized the incompatible detecting tests codes in "t/t3103-ls-tree-=
misc.sh"
>     and add a new 'MODE_NAME_STATUS'.
>
>     Action: Keep it individually.
>
> (6) ls-tree: remove FIELD_*, just use MODE_*
>
>     Using MODE directlly and make a format-mode mappings for fast-path de=
tection.
>
>     Action: Keep it individually.
>
> (7) ls-tree: split up "fast path" callbacks
>
>     Expand "ls_tree_cmdmode_format" structure for each formats with the s=
pecific=20
>     show function and split up the current show functions name.
>
>     Action: Keep it individually.

All sounds good, or rather. I really meant those as "hey maybe it's
useful, you decide what to do with it". So I'm happy with whatever you
picked here :)

> This is the way I try to continue this work, please let me know if I unde=
rstand you wrong.
>
> I look forward to your reply and I will decide the next step based on the=
 reply. If we have
> a consistent understanding of the next actions, I will try to make a pull=
 request to your
> Git fork first. If there is no problem, I will continue to send patches t=
o the mailing list.

Hi, thanks for looking at it. I think it's better to just post a re-roll
on the list for discussion, with whatever changed you think are
appropriate. Thanks!
