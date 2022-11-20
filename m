Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67C0C433FE
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 02:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiKTCPR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 19 Nov 2022 21:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiKTCPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 21:15:16 -0500
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B29B10FE
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 18:15:14 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id d3so11118238ljl.1
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 18:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yyxvclCaNzOguovxMmcxZTJ/xKBuGYr8I/SQJ+WfZ0=;
        b=mzWGWSox+ThKAdWvu2t1382JmUSiyDBFbxugfOmLiNN49zuVRqYrCC645w5TaP+37W
         xiz4j6QrDyfBmuN0YDrEaoQrhspP/KaK4i65Hnla1hSu/jMY4HFdmNLwQREKG9KxPgYx
         V2UNYSRhGv+AuXwNm+9Gwb3xLYgMz3WC7PMdsE1fRLy+98c5JTEKp/3IOmTIOa82Te1Q
         a8yWT8Bbo7xpZQJI4mJk7ExUf5L7g6Kyy3Hwu1wHBA8zZO+lz92HnzzHDv0cjlmMYcb+
         wEUXeu/h3Gjkb2SBMoVS9zJllso+oGTwiQceDt/Hv98E2S0cnrsJq8jNd4teHVDkORNW
         P4ZQ==
X-Gm-Message-State: ANoB5pmM4uvy9cc2jjbwOA+AFtK1pZrncmXsj0Iuap79/HXHbLJUPp67
        qXp8dSKjR4mMqGCOeRl1qKPIKo04jBYfQHUtGhXHYPBTLGa/TQ==
X-Google-Smtp-Source: AA0mqf7h5ESuYERkOG5h9tQgRShbgMT9OiGsvSkEzu3N0cKmLU/w4+OxWzQZy2Nufr424Ja83I6h27IsJwft+R+v5y8=
X-Received: by 2002:a05:651c:39b:b0:26e:90a5:1521 with SMTP id
 e27-20020a05651c039b00b0026e90a51521mr4478360ljp.39.1668910512712; Sat, 19
 Nov 2022 18:15:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.1422.git.1668888407433.gitgitgadget@gmail.com> <a3cfe081-1e68-edda-b797-e68356988046@gmail.com>
In-Reply-To: <a3cfe081-1e68-edda-b797-e68356988046@gmail.com>
From:   Stefan Sundin <git@stefansundin.com>
Date:   Sat, 19 Nov 2022 18:14:36 -0800
Message-ID: <CAMDaVWGFi6CD+MMbWG=N57yyb8=k6AouB5h33NkKvs2q4UxRmQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: suppress macOS deprecation warning
To:     git@vger.kernel.org
Cc:     Stefan Sundin via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 19, 2022 at 5:48 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 11/20/22 03:06, Stefan Sundin via GitGitGadget wrote:
> > From: Stefan Sundin <git@stefansundin.com>
> >
> > Compiling git on macOS 13 emits the following deprecation warning:
> >
> >         CC compat/fsmonitor/fsm-listen-darwin.o
> >     compat/fsmonitor/fsm-listen-darwin.c:495:2: warning: 'FSEventStreamScheduleWithRunLoop' is deprecated: first deprecated in macOS 13.0 - Use FSEventStreamSetDispatchQueue instead. [-Wdeprecated-declarations]
> >             FSEventStreamScheduleWithRunLoop(data->stream, data->rl, kCFRunLoopDefaultMode);
> >             ^
> >     /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreServices.framework/Frameworks/FSEvents.framework/Headers/FSEvents.h:1138:1: note: 'FSEventStreamScheduleWithRunLoop' has been explicitly marked deprecated here
> >     FSEventStreamScheduleWithRunLoop(
> >     ^
> >     1 warning generated.
> >
> > Setting a minimum macOS version will suppress this deprecation warning.
> > Using a version lower than 10.13 will cause other warning messages to
> > be emitted.
> >
>
> Why don't instead follow the suggestion on the warning message
> (FSEventStreamSetDispatchQueue) instead?
>
> --
> An old man doll... just what I always wanted! - Clara

You are right, Bagas. I assumed, without actually looking it up, that
the new function had a higher-than-acceptable minimum macOS version
requirement. It turns out that the new function was added in 10.6
which is far better than requiring 10.13.

Please disregard this patch and I will attempt to update the code to
use the new function instead.
