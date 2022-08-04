Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C1EC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiHDQbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiHDQbT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:31:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A2222B7
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:31:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dc19so197324ejb.12
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=z8ka0QzNO+iRTyveOE35aYKEnyBcjonGpt+lM+40ygA=;
        b=Ve48L/uaLnUzVhT8Tf5+RK9wCl/J26ACpIhcX2RifmKuSNIG+MzOszBXCA0DYKF9kh
         P0dOrxz3Mj7Fm9XPCze/iQ0daJOUQNNPzR3d2CFwTlmthmQxsz5YXPjtq3+ONAHRKy5H
         Ag5RRjey1VnA0BjjVaN95XHSIsDq/7tzW0edps8eh7RWTKicOdMPgOmnN1SY65jUKZNT
         FMVXneEV3m1MWjEOJ/24rkDodsd6LGleqpFqMc4/ElBUYmUvFHqdMEuAABcv24UiRsbU
         nakGXaYJIjphW5R96dmifCcdyO+edZ3q5+zO/rkrepGUo5euJtLA5iJwMAX9txALyLkF
         VPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=z8ka0QzNO+iRTyveOE35aYKEnyBcjonGpt+lM+40ygA=;
        b=aojKR/u1h2h/F5F34wniATF4qVzhT2sepqrgoOeEOYTRUFhi9O1dvT1LSfCkFV11VU
         El8kjxL/Gh/HTqsWVzLkrQ6giPLEh31qYuzPpt/cmDqvpA9LoFT4C+dZqVh3Nm2alIkm
         gyiv4E7GSSK+P8y7RqDzL+PPTyDJNPkESK8vSoGhJeexeUAe4ELJgyumHWS1Hd/tRveF
         BzW5LA5AgxUgzdsdt9l8eNQix8dw1S0pjO/nlTF60ONqWBD9WqosuysYB4xkXotnuwqL
         6KqmnTp1LNIiooc3NpOo7u/AXuVo+4yHoUIQgsX1pNF3TvUF9xaJpo+BVaQSuydrNCwP
         qDHw==
X-Gm-Message-State: ACgBeo2I+2gCPbmxzWzg84LONIrGH/qqz6+HB6alKxCkojgOMXuy/RAm
        ChcKIw0OVN66aX42PUycgXE=
X-Google-Smtp-Source: AA6agR6Fmz1sf4q7wsTdp6s9RD3d0KCXsZzcW4QyM1EIazLrEq2qgtd563kCpQHClFpk0AnzXf/KyA==
X-Received: by 2002:a17:906:1dd2:b0:730:9a59:3894 with SMTP id v18-20020a1709061dd200b007309a593894mr2015495ejh.485.1659630675801;
        Thu, 04 Aug 2022 09:31:15 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v13-20020aa7d9cd000000b0043d06d80d27sm896835eds.86.2022.08.04.09.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:31:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJdkg-0003AP-1K;
        Thu, 04 Aug 2022 18:31:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v7 07/10] docs: move protocol-related docs to man section 5
Date:   Thu, 04 Aug 2022 18:29:39 +0200
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
 <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
 <patch-v7-07.10-cfd1b0afb53-20220802T125258Z-avarab@gmail.com>
 <xmqqbkt1cohu.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqbkt1cohu.fsf@gitster.g>
Message-ID: <220804.867d3ot1gt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 03 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Continue the move of existing Documentation/technical/* protocol and
>> file-format documentation into our main documentation space. By moving
>> the things that discuss the protocol we can properly link from
>> e.g. lsrefs.unborn and protocol.version documentation to a manpage we
>> build by default.
>>
>> So far we have been using the "gitformat-" prefix for the
>> documentation we've been moving over from Documentation/technical/*,
>> but for protocol documentation let's use "gitprotocol-*".
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  Documentation/Makefile                        |  8 +++---
>>  Documentation/config/lsrefs.txt               |  2 +-
>>  Documentation/config/protocol.txt             |  2 +-
>>  Documentation/git-upload-pack.txt             |  5 ++--
>>  Documentation/gitformat-bundle.txt            |  2 +-
>>  ...ities.txt =3D> gitprotocol-capabilities.txt} | 28 +++++++++++++++----
>>  ...ocol-common.txt =3D> gitprotocol-common.txt} | 23 +++++++++++++--
>>  ...pack-protocol.txt =3D> gitprotocol-pack.txt} | 24 +++++++++++++---
>>  .../protocol-v2.txt =3D> gitprotocol-v2.txt}    | 25 +++++++++++++----
>>  Documentation/technical/api-simple-ipc.txt    |  2 +-
>>  Documentation/technical/http-protocol.txt     |  6 ++--
>>  .../long-running-process-protocol.txt         |  2 +-
>>  Documentation/technical/packfile-uri.txt      |  2 +-
>>  Documentation/technical/partial-clone.txt     |  2 +-
>>  command-list.txt                              |  5 +++-
>>  refspec.h                                     |  2 +-
>>  t/t5551-http-fetch-smart.sh                   |  4 +--
>>  17 files changed, 106 insertions(+), 38 deletions(-)
>
> OK, I see nothing unexpected.
>
> There is a silent "oops that is a screw-up in the previous step that
> can be buried in this patch that renames 4 files and hopefully nobody
> would notice" included, which should be removed by fixing the original
> screw-up in the previous step, though.

I tried to address all your other concerns in the just-sent v8, but I
don't think there's any rename fix-up here, but maybe I'm missing
something. These files are all being moved to their new
gitprotocol-*.txt homes (and weren't moved in preceding commits).
