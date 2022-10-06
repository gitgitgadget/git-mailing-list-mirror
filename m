Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6287C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 08:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiJFICM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 04:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiJFICJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 04:02:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C260E88DE7
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 01:02:08 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id o21so2697017ejm.11
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 01:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Es+l65fxcex8u0b3BQYNdbM0dGTfiUsz1h/mX2g/E2U=;
        b=f3BzLRBnASahtwFY6DvKtpBv99tNGdkifRTWeYGgSdV2tBV2XuqaQziJdFtZ4PBMbq
         girWIha5jmMPyZ3vE6hOiVwkoIU1e6ByHDLhWdjt/Bi1tPYig5qfZwq5au4iaZlvyjLt
         GfSxIGzS9QxNLFSfxroXgwF1fcUSb7fuiPMIwfqPINLO1WBurpGkxOAQl/vAdEZPhCNJ
         AG7zRC2dqEgg0pItEz0W1gzq6Pz3MCfZ3ECq+vpPZ6oozZrSCxJKp28lKcQaIJYwJ16+
         XSBHMLCwnd7qdU8GJscCQXYC/vfm/CZyrBIIQ9JBK9nN8zujjntfWNPRL0FEuY9LobQI
         8/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Es+l65fxcex8u0b3BQYNdbM0dGTfiUsz1h/mX2g/E2U=;
        b=pMMGOUBsWs9K94aFE4ezMUPdtfzTaeKfGgJX+xHOCfSXsX5DxLh99Uyx57+cUgkOpF
         vHlTEzi3t+UQW+syowFBdXV7GwCP2AmIdt+jH35XWFQr4ykoGtlCO7quuqgXP6sk/fTv
         KXBPXVMDsHtq7Kdb2cjtiVr7noh/Sq9xTwmJfxkEDaoYvmsFAZKgzOEXLyYcxZ0UbCLe
         /1NtUxWWGD/3kpJ1OzzwbcVGybCihv7x1rCTI+2BJgcl2DXlvc76BXKhSipYb6oMRVnT
         wyZrYMmj8RcdxHPhNA9ILiGOE0vKyvaftBu2gUB/3UdTRXenAUZ4hIS7pWkdUswJUZ9m
         77fQ==
X-Gm-Message-State: ACrzQf173F8AgjI89pA+fzsnkD7Ij5K+PQ59YI7DxT7vmqHNMf3jwerm
        vNW20715VBtlKZzaYFbzgTdAFBMC2LY=
X-Google-Smtp-Source: AMsMyM6VGLxtQQu0gEqCNgUM1VYC7CxZM0tNNDNv5/Fa1c/Jb+aaZv4ij9g9eDUIbG/E1EeUV1UE4w==
X-Received: by 2002:a17:906:ef8f:b0:77e:44be:790 with SMTP id ze15-20020a170906ef8f00b0077e44be0790mr2909467ejb.409.1665043327176;
        Thu, 06 Oct 2022 01:02:07 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id i26-20020a50fc1a000000b00458e73fe1c1sm5286746edr.8.2022.10.06.01.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 01:02:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ogLpV-002gpL-2H;
        Thu, 06 Oct 2022 10:02:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Aleajndro R =?utf-8?Q?Sede=C3=B1o?= <asedeno@google.com>,
        git@vger.kernel.org,
        =?utf-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Subject: Re: [PATCH] git-compat-util.h: GCC deprecated only takes a message
 in GCC 4.5+
Date:   Thu, 06 Oct 2022 09:33:47 +0200
References: <20221003212318.3092010-1-asedeno@google.com>
 <YzthTugwy+eaIUxr@tapette.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <YzthTugwy+eaIUxr@tapette.crustytoothpaste.net>
Message-ID: <221006.86czb5s7lu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 03 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2022-10-03 at 21:23:18, Aleajndro R Sede=C3=B1o wrote:
>> From: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
>>=20
>> Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
>> Signed-off-by: Alejandro R Sede=C3=B1o <asedeno@google.com>
>
> It might be helpful to explain what system you're targeting when you see
> this.  CentOS 7 has GCC 4.8, and I'm not aware of any systems with an
> older compiler receiving publicly available updates still.  We've fairly
> recently only been testing and targeting GCC 4.8 for that reason.

We've had some friendly disagreements in the past about what our policy
should be for supporting such "EOL" software[1][2]. I'm not replying to
repeat any of that discussion, just noting it for context and that I'm
*not* raising that point here :)

What I do want to say to provide others context is that I think you're
conflating your own views & project policy here, e.g. if you run:

	git log --grep=3D'gcc [0-9]' -i

You can see recent patches that have been accepted where we're adjusting
things for GCC's older than 4.8, so it's not the case that we're "only
[...] targeting GCC [versions >=3D]4.8".

I think you might be mixing up the oldest software we're taking patches
for with the oldest version we run in CI, although I didn't find if we
actually run GCC 4.8 in CI anymore. It appears to have been used with
ubuntu-18.04, but as of ef465848312 (ci: update 'static-analysis' to
Ubuntu 22.04, 2022-08-23) I don't think we pin that version anywhere.

Anyway, however us "in the know" work out what versions we support I
don't want someone to search the ML archive & come to the conclusion
that a patch for a compiler older than whetever IBM's bundling wouldn't
be welcome.

I think it's fair to say that we've taken e.g. major IBM/RedHat releases
into account in the past, e.g. for what libcurl version(s) to support,
per [2]. But we've never considered distro releases to be a hard cut-off
for support.

The actual "policy" has been some fuzzy combination of:

 * What OS's / distro's are used by anyone, for which e.g. RHEL releases
   are a very useful heuristic, and on some platforms (e.g. Windows?)
   vendor EOLs matter more than on others.

 * How much of a hassle older software or a platform is to support,
   e.g. this project has usually happily taken trivial patches such as
   this one, but in the case of PCRE we moved more aggressively from
   PCRE v1 to v2, as supporting both required duplicate code (see
   7599730b7e2 (Remove support for v1 of the PCRE library, 2021-01-24)).

 * That someone cares or sends in patches for. I know of various current
   breakages with software that's "supported" (bits of Solaris, AIX and
   HP/UX userland come to mind), but nobody's cared enough to fix it (in
   those cases, many/all of the "official packages" simply use GNU
   userland/libraries instead)

1. https://lore.kernel.org/git/YPimBp+TkaJ9ycuM@camp.crustytoothpaste.net/
2. https://lore.kernel.org/git/YPimBp+TkaJ9ycuM@camp.crustytoothpaste.net/
