Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD68C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 12:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbiCVM2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 08:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbiCVM1z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 08:27:55 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9607DA8C
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 05:26:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r13so35827700ejd.5
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 05:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KPmZ/33nLtYv6jWGwznYU/90JqQCk4m/PV4mJRM9Ngw=;
        b=UuPCpSoQbrYpTZCpZzqCeCRO5Ff2RTgUHNpyvq3TJhG9CaAcYmlPH49brNMD2qc0Vl
         71hg+UyQqYM83dg7vHm4u3L+wBlN5Jr5mrGc0xxsR3x8Z6nMkEvM5MYXv/BJ/eSeJ1Qf
         GvtDPjBY2J/gmiA8iXpb1e6OQSfRnRAlGhPTLzD/9fdzP5kWYgIDA7JNXXx0YRq+sI6m
         rajr0gQqejATGtZArYo5vsAFQN5KcXB/RNZmBDWUtOlYcfuT1oUzsPp+Qnr1efqlJNzW
         ZUavN5LukBdQkzXeN5d6kKYAnkUQvSE7YxsmtuizJ23EV2Ll1vNIy2hOncdX4P7/UWCC
         oNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KPmZ/33nLtYv6jWGwznYU/90JqQCk4m/PV4mJRM9Ngw=;
        b=n2AEENKY4zhEgMJANiPuJSpVHNA2h4euCXKMi4/o3XyqZu11ldfPiG+mPElwX0sSiG
         L8Bx0jvRWugVdzzXl8rD0l52jAWu8kug0jX+V6D21rcRc5l5mycc3SfSMw/JUZpWLM/s
         ncRD/0FGlICVsphVXfXNrxHGbuqrO6O7biLHuWqcRRqIpiB0q20Ee2JiJ0NDYABkpXPk
         I/lXMlNYZ0dZY7hmLO5s0gsplikb0wvSy/Kn4zznrIuvwMYTJ8NjWaubiKf7JUjAnocJ
         +1p//EKGVBaaS7sK4jHNmpwPMUf/tKCJt602Zuo87z4dMsP5Bdon7A5M9l5R08ULHZzo
         h2NQ==
X-Gm-Message-State: AOAM531gp+GATYJqd9vFtz3Mxdird7xUMts0fEqjcmTC/BvoIFCJPxRG
        /w4CnC92uoMXOds0TAGQubnlgXu6tCRQpg==
X-Google-Smtp-Source: ABdhPJxWyN+GREwOYwA8ugwMHfAxdBSg9jIQD/dWqiV+gRNGDroeDwPCQ+3yFwdDyA83wiGQDKOK8g==
X-Received: by 2002:a17:906:b155:b0:6c9:ea2d:3363 with SMTP id bt21-20020a170906b15500b006c9ea2d3363mr24765878ejb.729.1647951985762;
        Tue, 22 Mar 2022 05:26:25 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gn1-20020a1709070d0100b006e012aaa918sm2485794ejc.139.2022.03.22.05.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:26:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWdad-000LNi-LH;
        Tue, 22 Mar 2022 13:26:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH v2 0/4] In PS1 prompt, make upstream state indicators
 consistent with other state indicators
Date:   Tue, 22 Mar 2022 13:25:35 +0100
References: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
 <pull.1162.v2.git.1645991832.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <pull.1162.v2.git.1645991832.gitgitgadget@gmail.com>
Message-ID: <220322.865yo6npg4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 27 2022, Justin Donnelly via GitGitGadget wrote:

> These patches are about the characters and words that can be configured to
> display in the PS1 prompt after the branch name. I've been unable to find=
 a
> consistent terminology. I refer to them as follows: [short | long] [type]
> state indicator where short is for characters (e.g. ?), long is for words
> (e.g. |SPARSE), and type is the type of indicator (e.g. sparse or upstrea=
m).
> I'd be happy to change the commit messages to a different terminology if
> that's preferred.
>
> There are a few inconsistencies with the PS1 prompt upstream state indica=
tor
> (GIT_PS1_SHOWUPSTREAM).
>
>  * With GIT_PS1_SHOWUPSTREAM=3D"auto", if there are no other short state
>    indicators (e.g. + for staged changes, $ for stashed changes, etc.), t=
he
>    upstream state indicator appears adjacent to the branch name (e.g.
>    (main=3D)) instead of being separated by SP or GIT_PS1_STATESEPARATOR =
(e.g.
>    (main =3D)).
>  * If there are long state indicators (e.g. |SPARSE), a short upstream st=
ate
>    indicator (i.e. GIT_PS1_SHOWUPSTREAM=3D"auto") is to the right of the =
long
>    state indicator (e.g. (main +|SPARSE=3D)) instead of with the other sh=
ort
>    state indicators (e.g. (main +=3D|SPARSE)).
>  * The long upstream state indicator (e.g. GIT_PS1_SHOWUPSTREAM=3D"verbos=
e")
>    is separated from other (short or long) state indicators by a hard-cod=
ed
>    SP. Other long state indicators are separated by a hard-coded pipe (|).
>
> These patches are to make the upstream state indicators more consistent w=
ith
> other state indicators.
>
> -------------------------------------------------------------------------=
---
>
> Changes since v1:
>
>  * Added __git_ps1 examples and before/after tables to commit messages wh=
ere
>    applicable. This should make it clearer what the behavior is for other
>    (not upstream) state indicators, and how the patches make the upstream
>    state indicator more consistent.
>  * Removed some extraneous information about long state indicators from
>    patch 2 commit message. This wasn't really helpful, and was a
>    distraction.

Since this was all in reponse to my review: I've looked this over again
and this all LGTM now:

Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
