Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8B0C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B04820709
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgENWo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 18:44:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37584 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgENWo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 18:44:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id z72so185886wmc.2
        for <git@vger.kernel.org>; Thu, 14 May 2020 15:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpD3p7Do8ppP+Ihv3VThulAdvUJrMVeJSZI4P+BXp5U=;
        b=N1QGcInCbLJHr+aK7pp/rKpqNg4ZyFHJ5cZJY/JXmtJ8SiG0npVAVd4mfsOL+DOYK2
         N9vFZmEK+O+YvkZRnV0M0FRgcti+NO/LrzBdfKhvurNlUbriMEM8OfrVoB82NpFEo8vo
         cA7N2U35sZ3i16y34TlmOCBZX2WCYpVbWWnDDaaEUjakCG/CnDV9PkJ3VfxE4Pbxjxlg
         +2hvEOCuOAZBEDK8kxjzdcw0V1TNZ2WykbSRaoOOv/NyyoejQW7ONIrnZufl5tvp7oQB
         6lBIuA64c2OPS6vuj9aD2G/0oqT6y5dXJgikyCdYwivhL6DiLQNTr4QlI4fg9pXcu5Kw
         +6ew==
X-Gm-Message-State: AOAM533rPDW/Nojl7b2dNFawhc0fAz8F6SpR8EofXCCTKdaP2bH5f4Ew
        OZWp0yY6c+qBzjY5SLQWlIOvCru4hGxfBHTy6tYvGg==
X-Google-Smtp-Source: ABdhPJw7AIrzCMyhuAM8CdaVUxbp1h8PiO8NTEo6D+uSyBi06CNgY26iN5o0VxlH5/XP4XNH4uDcSmLLLutsUa4hVIo=
X-Received: by 2002:a1c:7e4f:: with SMTP id z76mr576788wmc.177.1589496293822;
 Thu, 14 May 2020 15:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200514210518.56101-1-carenas@gmail.com> <20200514220346.GA3074610@coredump.intra.peff.net>
In-Reply-To: <20200514220346.GA3074610@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 14 May 2020 18:44:42 -0400
Message-ID: <CAPig+cTEO--BCE_hMsWNowx7R9pP-oag2_ugEPDTPAizqOMDsQ@mail.gmail.com>
Subject: Re: [PATCH] t0300: workaround bug in FreeBSD < 10 sh
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 6:03 PM Jeff King <peff@peff.net> wrote:
> Just to be clear, if you run:
>
> foo() {
>   for i in "$@"; do
>     echo "arg:$i"
>   done
>   sed s/^/stdin:/
> }
> set -- outer
> foo inner <<EOF
> $1
> EOF
>
> do you get:
>
> arg:inner
> stdin:inner

That is indeed the result with the FreeBSD 9.3 shell. Seems buggy.
Assigning $1, $2, ... to variables (local or not) as Carlo's patch
does seems to work around the buggy behavior.
