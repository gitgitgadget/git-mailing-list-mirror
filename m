Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC14FC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 17:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E05561074
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 17:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344324AbhIARLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 13:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344425AbhIARL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 13:11:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D909BC061764
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 10:10:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g135so274983wme.5
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=IANknycxPIkMJHqjvK0sa/EEYgkpwiPz/Pp2lvuFR1c=;
        b=ftlBvXbx7jfabPDakoW0izY/CJn+ChiXGvWLBx2YSPP3l/lwlE2ePJIIcZyFzXf/rW
         WD8cT8FigOh9QlSRQ9VFe505DjSIHprJRehJZOX6iXHS8JH+/XgdWUIYk5C94fSnmQVW
         KxnRBna4GoShbCc09yZEt1VPGmxixWoh+OIFsgsuToi6BGH1zjCmAdufYOxDX4gvInIa
         nKEW8Az3Eis9zwUixgqE7BnwlLHrZ6pjesXZs51huWid6dJ31no+gO2yoC9ksiFs9b1L
         ySmR6doldIvJ4TD/jnz3Rz1xcJYJOD69J22zyTeNImzrquMjJMUyL8L2RlCLMolYegE4
         i/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=IANknycxPIkMJHqjvK0sa/EEYgkpwiPz/Pp2lvuFR1c=;
        b=D2F9jCi5KzSVwr1o6Ez2iyR5Q+JgiyUYWruVcGyBAW2U7ecyPKmTyHz/6TuhHv2Few
         XPj3rzG/TGLyMgciigwWLo8+CNtEwCrbIZfVX882rXB2ItKcHz5AZKAzepnSvitwka2j
         vS63taMTYjp9dXmzwXt0Ld0K8ebiANRlPCLg0jihrC2yVltpj9vvG0/ZhneASfvVWuQW
         hZfIR95giGLNyGYGT+fTsDuYV7OEHR0lflboC8Sjk3vGcxNpB/YIfP8yLv8XduNe/suC
         ZJMlrZFiA2P9pKBtj6fLGYlYxSF/BQsDaSLfzjAo+dldP8y4yYWE+V/5PphuciJ76/IT
         tU5w==
X-Gm-Message-State: AOAM530Wk7KzCTDnHe5Cf+lRcRLqE/KerojtJ6SpOsg2yYU6jzvUhNL3
        mk4M9YsntL3V/B/cxtM57A8=
X-Google-Smtp-Source: ABdhPJzKGWZ94Rlj6glyE5+FPntP1BzA86728ScdZHWO5XnN9AfY4wHUhjRVwEf7qO3/+EPA+gRFLQ==
X-Received: by 2002:a1c:f315:: with SMTP id q21mr491432wmq.76.1630516229883;
        Wed, 01 Sep 2021 10:10:29 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d7sm53877wrs.39.2021.09.01.10.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:10:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Makefile: remove archives before manipulating them with
 'ar'
Date:   Wed, 01 Sep 2021 19:06:02 +0200
References: <patch-1.1-2557117855-20210629T084356Z-avarab@gmail.com>
 <20210818213611.3658076-1-szeder.dev@gmail.com>
 <xmqqk0khxaup.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqk0khxaup.fsf@gitster.g>
Message-ID: <87o89cusqj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 19 2021, Junio C Hamano wrote:

> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> The rules creating the $(LIB_FILE) and $(XDIFF_LIB) archives used to
>> be:
>>
>>   $(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>>
>> until commit 7b76d6bf22 (Makefile: add and use the ".DELETE_ON_ERROR"
>> flag, 2021-06-29) removed the '$(RM) $@' part, claiming that "we can
>> rely on the "c" (create) being present in ARFLAGS", and (I presume)
>> assuming that it means that the named archive is created from scratch.
>>
>> Unfortunately, that's not what the 'c' flag does, it merely "Suppress
>> the diagnostic message that is written to standard error by default
>> when the archive is created" [1].  Consequently, all object files that
>> are already present in an existing archive and are not replaced will
>> remain there.  This leads to linker errors in back-to-back builds of
>> different revisions without a 'make clean' between them if source
>> files going into these archives are renamed in between:
>>
>>   # The last commit renaming files that go into 'libgit.a':
>>   # bc62692757 (hash-lookup: rename from sha1-lookup, 2020-12-31)
>>   #  sha1-lookup.c =3D> hash-lookup.c | 14 +++++++-------
>>   #  sha1-lookup.h =3D> hash-lookup.h | 12 ++++++------
>>   $ git checkout bc62692757^
>>   HEAD is now at 7a7d992d0d sha1-lookup: rename `sha1_pos()` as `hash_po=
s()`
>>   $ make
>>   [...]
>>   $ git checkout 7b76d6bf22
>>   HEAD is now at 7b76d6bf22 Makefile: add and use the ".DELETE_ON_ERROR"=
 flag
>>   $ make
>>   [...]
>>       AR libgit.a
>>       LINK git
>>   /usr/bin/ld: libgit.a(hash-lookup.o): in function `bsearch_hash':
>>   /home/szeder/src/git/hash-lookup.c:105: multiple definition of `bsearc=
h_hash'; libgit.a(sha1-lookup.o):/home/szeder/src/git/sha1-lookup.c:105: fi=
rst defined here
>>   collect2: error: ld returned 1 exit status
>>   make: *** [Makefile:2213: git] Error 1
>>
>> Restore the original make rules to first remove $(LIB_FILE) and
>> $(XDIFF_LIB) and then create them from scratch to avoid these build
>> errors.
>
> Thanks.  I think I've seen a similar breakage around hook.o but
> didn't dig into it.
>
> Will queue.

Thanks both, and sorry for the late reply. This is in "next" already and
scheduled for "master", but FWIW this looks good to me.

The breakage with hook.o happens when you build "seen", and then
"master". Since master..seen contains a change that moves find_hook()
between files we'll get an error like:

    multiple definition of `find_hook';
    libgit.a(hook.o):/home/avar/g/git/hook.c:97: first defined here
