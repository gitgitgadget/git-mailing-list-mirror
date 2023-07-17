Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D43C0015E
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 23:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGQXrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 19:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGQXrL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 19:47:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE719D
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 16:47:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57704aace46so44028367b3.2
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 16:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689637626; x=1692229626;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aJT5H4SeZJ3Pn+ODt+vYaoN1pBpyaPBoIqmbVm612lo=;
        b=DtiP6dlWPKoOMmGK2VsDMxImcX9lncV/w+WYDOWjEFUJCNvXSd0raWpb2LZ9prkP9N
         vsjtVgA5yTi+atIaMoK/KhZoViErNP9tjtZkiSjCprSvWc2y9naa8XEdlWqLkpA+n5lc
         XhSggVfHnJrM3TtC3x+2/UDQ2r8PiKoIzTq459ycgw2Ac4yB58OJq6QkOGDAL+f8Wdf8
         fSPo1/pxm/gZtFN9wRrAljn5BSd/9LgnMpJBOe0lR9SZ/NWwEa9JM1m2yEXYumImb14k
         OEqn/KJT+qSFdOoTCog7O6K1IKlHOaoE4TtJsrBGey1CmOiDJwMhNvMDCLyHShOy4Cdt
         vsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689637626; x=1692229626;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJT5H4SeZJ3Pn+ODt+vYaoN1pBpyaPBoIqmbVm612lo=;
        b=QamNS83XpmhE89iljuGWPaZZ6yqy5C50Kq8RnrCcn0xWPFeJl+MAPnrxtZj9Kqw4IW
         4OR/V+vzy+qTDHe5qaKMLyUo2pegRI+V1J5ZhgSn5EI5iIg6mPkrESTogFcOV1NVDinU
         wI8HluwzmU7Yc+rNrbNS3RQ66ohESjBC5P0GhstE1MSwHqt3JltvON7HsWJu+C1/6xsl
         61PLVOmGU53EQhQ1X4sHCdiHN+EmtinsQ8XoL1vPhgqooiUIepZFwpdcabB7XKZvhasO
         CZ9e/9qLfLz1VYObZILH60nDDqINiaEBV/8Jb1ltlu9dSRLpAEHp1tGoet8XMbJNnc6g
         v7iA==
X-Gm-Message-State: ABy/qLYG5gEJMxoz5yQ93wlmAK/Hu2+uvdlhde7d5Gh0SANTty70EobM
        K/GG1R674G0O2rMsEHd5UuAM26w+Aq1FSj9VogHb
X-Google-Smtp-Source: APBJJlG2jjSexr5gen9w0Z7Ljru76mYchUSqXoSdKCxsvpGes8AncjGL0OBWMQR9jN6SUmIwBXf9fQzvzRFzZ4HZP3pf
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:952b:2f28:e948:26e3])
 (user=jonathantanmy job=sendgmr) by 2002:a25:50d4:0:b0:ca7:8c92:4f62 with
 SMTP id e203-20020a2550d4000000b00ca78c924f62mr126128ybb.9.1689637626694;
 Mon, 17 Jul 2023 16:47:06 -0700 (PDT)
Date:   Mon, 17 Jul 2023 16:47:04 -0700
In-Reply-To: <87edl6bx7o.fsf@iotcl.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717234704.1906465-1-jonathantanmy@google.com>
Subject: Re: Teach git-fetch(1) to use a quarantine directory
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Toon Claes <toon@iotcl.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Toon Claes <toon@iotcl.com> writes:
> Hi,
> 
> I've been looking into making git-fetch(1) to use a quarantine
> directory, but I'm a bit stuck on direction.

Thanks for looking into this!

> I took git-receive-pack(1) as an example how it uses a quarantine
> directory. It seems it sets the environment variables
> $GIT_OBJECT_DIRECTORY and $GIT_ALTERNATE_OBJECT_DIRECTORIES so the real
> object db is used as an alternative, and a temporary is set as the
> default. Then a sub-process is spawned to uses these. In case of
> git-receive-pack(1), it calls git-unpack-objects(1).

From a reading of the source code, it may call git-unpack-objects or
git-index-pack, I think. (unpack() in builtin/receive-pack.c)

> At the moment git-fetch(1) does not spawn any similar subprocess, so if
> we want to take the same approach to use the quarantine, we'll need to
> split up that command.

It calls get_pack() in fetch-pack.c, which actually may call one of the
two commands above in the same way. (The calling may happen in various
ways. IIRC in fetch protocol v2, get_pack() is invoked directly by git-
fetch, whereas in earlier protocol versions, it may be the remote helper
that calls git-fetch-pack that invokes this function.)

> But then we run into another problem as well. git-fetch(1) updates
> references, and that is something that's not allowed when using a tmp
> object directory.

execute_commands() in builtin/receive-pack.c has this:

          /*                                                                                                                          
           * Now we'll start writing out refs, which means the objects need                                                           
           * to be in their final positions so that other processes can see them.                                                     
           */                                                                                                                         
          if (tmp_objdir_migrate(tmp_objdir) < 0) {     

which seems to be a solution to the same problem. I think Taylor wrote
something similar [1].

[1] https://lore.kernel.org/git/ZLVK5nzVZU48uvYE@nand.local/

> As far as I can tell from the code, fetching packs and updating refs is
> heavily intertwined, so I'm not sure this approach is the best way
> forward. So a few questions:
> 
> 1) Does it even make sense to make use git-fetch(1) use a quarantine
>    directory?

I don't know off-hand if this will work, but this sounds promising.

> 2) When making git-fetch(1) use a quarantine directory, what is the
>    recommended way to achieve this? Is this by calling a subprocess?
>    Maybe git-fetch-pack(1)?

I also don't know off-hand if this will work, but replicating what git-
receive-pack does makes sense to me.
