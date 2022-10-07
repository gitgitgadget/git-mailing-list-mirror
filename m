Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCEEC433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 11:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJGLJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 07:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJGLJK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 07:09:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AF7634A
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 04:09:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kg6so10513204ejc.9
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 04:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A3xp3XWOy5OrMXrvJygxwUrnuFPHnvIOdNtVPDQWIp0=;
        b=p6qNJpLSCaJ9okzdAj4CEH7lHaYfMQg+k5OZ1ES/EYqFks0CwvHA0WW3eb07M21nwO
         tYDHILfOCvfr1N7l4M7FNdIgI7i1J42nt3QIPN2FogIY69T57pmcqvbt6Nkhjyj9bRGd
         9StyUUltkvbXltreMbDarYyswCB99gGhSx+S74njMWOWj5H8wV/bKow90W4xQBbzzdOm
         sbFIW2+8yUA9mf1tPV/Gupkudn1rvmju6jwWlsVJAx0jOPl5OmRTwmaiVwnziOvlBSmp
         DlDi6Va7MbOY3HHKU2mEY3CMGqB54a7ezqHvDyvAAFTZAuTNujgnZ3vRAE5iPaJ1oWYy
         MHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3xp3XWOy5OrMXrvJygxwUrnuFPHnvIOdNtVPDQWIp0=;
        b=6metZ6KdN73ASKcTUIRuXeEozNU+kYjHJeH4MLXkRuH87CGw8/aNdj4F7Shl7pohfa
         ggQr2ygQwbO11bbWQOkxD0PKRqfSBGEwZPeSXW0wCybH83UA0mWLbHj7lwK95xc8xes5
         MmDRyuKYRfUF5rY6j5+XxIy4qp57/PTK0et1JBxMPfOgY15IQ11Cb4bWfiCFb8OM3Iu/
         nOg8PI11f5ZsVjfLLxeE+oE19W/xpuh4y2i2+JBkuIjtBEj+SlcBfrh/TlzA9CdmvO3p
         aFDLv8sXfuIdLYvvrzs7mUAPu3ujZ59IwXPAkZX1mW2fnXbX4LICZEvTrj9Lq7RpqptG
         svmQ==
X-Gm-Message-State: ACrzQf2w2cHh2xbaA5ZnOQ6kOCzyPWvkNJpobWdmCbv0rtdPQLayK2m8
        XIfqZx9qRpnr6wPimrDgggY=
X-Google-Smtp-Source: AMsMyM7QwYZZfODKzUtlx3LDDxn6LLkwN0V/8nPmdIuRpK1K1VcI9cFSWOx3XFzyngRfL+pXF2hqJQ==
X-Received: by 2002:a17:907:320c:b0:741:1e55:7a69 with SMTP id xg12-20020a170907320c00b007411e557a69mr3680632ejb.740.1665140948197;
        Fri, 07 Oct 2022 04:09:08 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o11-20020a056402038b00b0045467008dd0sm1252573edv.35.2022.10.07.04.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 04:09:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oglE2-003OMA-0j;
        Fri, 07 Oct 2022 13:09:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 0/2] Fix syntax errors under clang 11.0.0 on MacOS
Date:   Fri, 07 Oct 2022 13:02:39 +0200
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
Message-ID: <221007.861qrjriul.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 06 2022, Jeff Hostetler via GitGitGadget wrote:

> This patch series fixes three syntax errors that caused compiler errors w=
ith
> clang 11.0.0 on MacOS. I've included the error/warning messages in the
> commit messages. The offending statements did compile successfully under
> clang 14.0.0 on MacOS, so I have to assume that this usage is newer than
> what clang 11 supports.
>
> I originally sent these changes in my "Trace2 timers and cleanup and some
> cleanup" series on Tuesday, but pulled them into a separate series based =
on
> feedback. I'll omit them from the trace2 series in the next version.

The expanded commit messages really help, thanks :)

So, to summarize, these don't fix compiler errors, but warnings, but of
course they're errors with DEVELOPER=3D1.

We already squash these for an older GCC, per the discussion at [1]. I
think we should just replace this series with something like (untested
on OSX, but it's just copy/pasting a template above it).
=09
	diff --git a/config.mak.dev b/config.mak.dev
	index 4fa19d361b7..9b7bccd154c 100644
	--- a/config.mak.dev
	+++ b/config.mak.dev
	@@ -69,6 +69,14 @@ DEVELOPER_CFLAGS +=3D -Wno-missing-braces
	 endif
	 endif
=09=20
	+ifeq ($(uname_S),Darwin)
	+ifneq ($(filter clang10,$(COMPILER_FEATURES)),)
	+ifeq ($(filter clang11,$(COMPILER_FEATURES)),)
	+DEVELOPER_CFLAGS +=3D -Wno-missing-braces
	+endif
	+endif
	+endif
	+
	 # https://bugzilla.redhat.com/show_bug.cgi?id=3D2075786
	 ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
	 DEVELOPER_CFLAGS +=3D -Wno-error=3Dstringop-overread
=09
Or, we can just say that for a <=3D clang v13 we'll use
-Wno-missing-braces, per:

 * The comment from Ren=C3=A9 at
   http://lore.kernel.org/git/36cd156b-edb2-062c-9422-bf39aad39a6d@web.de
   that older vanilla clang is affected.

 * You having tested Apple clang v14, but not clang v12..v13.

I.e. to emit the whole uname_S bit.

I think it's not important that we try really hard to opt a given
compiler into some maximum set of warnings, we generally want to catch
most things here. As long as some compiler (particularly if it's in CI)
still covers these we should be good.

1. https://lore.kernel.org/git/220712.864jzm65mk.gmgdl@evledraar.gmail.com/
