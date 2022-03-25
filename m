Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E29C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 13:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356576AbiCYNuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353003AbiCYNuM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 09:50:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3ED3A183
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 06:48:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id j15so15454966eje.9
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=I9Sa5lYjrIroLTpkt/+4i6g7cbVNwFMxP+NZ30PX3ig=;
        b=H/l9xDyQfzn5dPHtO/j9YBievyz3xZ3xsNkgCeL43G8hmN0Ado64ryoNTD+Ga5SinS
         UAwDRVwEuxJik82S8UASTo3Z1Wlbfy54bfzgjYhQzuoC6OZYRAyJIZk417fim6lVp7a8
         EvbTu6m97j5HwYJWZafXh39ldgeprz2p4ChrgIygVKIosoVoCOg4flEmyWUPKLUAg+Cy
         hEJGLg3FVTpAAWIvPkKVB4XcpnxucwkPuw2ABnheiBZxSus5f5d5Qmg5JF5on22WIQtk
         96/3xgOnU9VCpNHuj1wK/9AbRId5kcy1HTQXlVXbEdgLZbXvjeh2Stk7reeioODumlEt
         yBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=I9Sa5lYjrIroLTpkt/+4i6g7cbVNwFMxP+NZ30PX3ig=;
        b=SnJ1PyHg7KUFNVPruBYNKRBGVK2t2QBdMf4vVa7HbBXQCTEbumwAVsS6ABQ+RidpMh
         kFCj0sPdV/H/9qII98VWTjeJeq+vVyTEGFPGDL73HfSl1nDGCgYQDPcOubMIdkUI1BgG
         JfbcbMzYxn8AYt1aUDUgRc76Yl4t2tVa4NfwyrTEnH+7UfKBcA+lcfgNd+SUvlvvM6f6
         vNoJoO6q9xFN6gFPecRLeomtJDhqEpgkXXNEx7kbOqYQfQ3FiUolLzABlhOmczJtW6KP
         o2PaNydOQZcLz4/UVXvt2ajpZ/7zBrsbhWirt1b0RFrcN4xMyOjtwkiUPbMLJC7xzqFS
         S/YQ==
X-Gm-Message-State: AOAM531eof6giAKZCt8QNDE56o0zbOAa1SkRVj/cuX6BHv+iTT8OPdde
        bPFjn3b3f2jhbozGmaG1iqL705PF3EI=
X-Google-Smtp-Source: ABdhPJxbrsQCmGC5pBYLw94KEfQ//H11OvZixtdT0uRDPqB6mpsOA43Vidf9j1M7X9iVMOSBoIMNGg==
X-Received: by 2002:a17:907:3d91:b0:6df:a01c:f7cd with SMTP id he17-20020a1709073d9100b006dfa01cf7cdmr11580225ejc.255.1648216115375;
        Fri, 25 Mar 2022 06:48:35 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u9-20020a170906124900b006ce88a505a1sm2417554eja.179.2022.03.25.06.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 06:48:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXkIs-0020fb-3L;
        Fri, 25 Mar 2022 14:48:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/commit-plug-leaks (was: What's cooking in git.git (Mar 2022,
 #05; Wed, 23))
Date:   Fri, 25 Mar 2022 14:38:43 +0100
References: <xmqqwngkm4am.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <xmqqwngkm4am.fsf@gitster.g>
Message-ID: <220325.86v8w2kurx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 23 2022, Junio C Hamano wrote:

> * ab/commit-plug-leaks (2022-02-16) 2 commits
>  - commit: use strbuf_release() instead of UNLEAK()
>  - commit: fix "author_ident" leak
>
>  Leakfixes in the top-level called-once function.
>
>  Expecting a reroll.
>  I think UNLEAK->strbuf_release() is a regression.
>  source: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>

Re our earlier exchange ending in
https://lore.kernel.org/git/xmqqczjbj0nf.fsf@gitster.g/ I still think it
makes sense to get rid of the UNLEAK() there.

One reason not mentioned there (but which I do find useful) is that if
we actually free the memory then you don't need to build with
-DSUPPRESS_ANNOTATED_LEAKS to suppress these, which is useful e.g. when
looking at valgrind output, as opposed to SANITIZE=leak where we do add
-DSUPPRESS_ANNOTATED_LEAKS.

And since I submitted this topic our number of UNLEAK() in builtin/ is
down from 29 to 23 with the queued release_revisions() topic.

But you seem to feel strongly that we should keep these specific
UNLEAK() for reasons I don't really understand despite re-reading that
exchange. I.e. the cost of doing the actual release is minuscule, and we
have a lot of such strbuf_release() in builtin/*.c already.

But if you'd just like to drop this topic I understand, but I think it's
ready to advance as is, but either way it's probably good to get it out
of the current status
