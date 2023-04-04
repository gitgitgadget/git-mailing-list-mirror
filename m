Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE1EC76196
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 03:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjDDDaZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 3 Apr 2023 23:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjDDDaX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 23:30:23 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8DF19AB
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 20:30:17 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id k37so40690267lfv.0
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 20:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680579015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxLvDywim81BDoQlVW2zTMwgbTw8PpwLQvG0B7AxiqM=;
        b=lRMV1ypLTF73A9hLY4gAJd9rIeReDtp2yjjVQ4PvMVLfPiqkLg/qDW56iE8SU87OuV
         o/gOCIRXDXedsgpY9m7Kp1FLArHkYmpL1EnixeqTqSof6qx9/0Tp8W9gWr/hzVji+91W
         kHVyPkOuSlc93Px162gvH48N/JqbOBxde632LLMn1RVrb0FihjIYqqVj1ki26m9h1YRx
         a2Kaduxzqiwxte5B5MF6Tryi804LqEnpsIrujB2scaEzhlEXhYlOLwisqHDxgpzpRSDr
         38gLcekRfoXJssiwMTqL97/lePjsk+qdBKkRYYz/veTzXPbyZ8f57i1GutXs5y73LzJF
         4bUQ==
X-Gm-Message-State: AAQBX9cDVjTkUUPS6M6mP12xArn3gFTCgNRRz2lWa8nZ91NQ/tBXdzLT
        1gW9GjZUeXr5G8qkTewUne4UQhAIHK1CDjYlFKA=
X-Google-Smtp-Source: AKy350buA7U1HUotqrdLUjYZ0ef4wICYwOpKaxxNkWrBVNxWp/yfxQR+dKDIjFqxCeAk36IpJF1epjCYQUTvgBWJolc=
X-Received: by 2002:a19:f607:0:b0:4d5:ca32:6ed5 with SMTP id
 x7-20020a19f607000000b004d5ca326ed5mr388039lfe.3.1680579015313; Mon, 03 Apr
 2023 20:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <230109.86v8lf297g.gmgdl@evledraar.gmail.com> <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
In-Reply-To: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
From:   Jim Meyering <jim@meyering.net>
Date:   Mon, 3 Apr 2023 20:30:02 -0700
Message-ID: <CA+8g5KHuE-kQqmi9cVjeJbpyt54v9m9omh9A9we1zmR0+aTDHg@mail.gmail.com>
Subject: Re: bug#60690: -P '\d' in GNU and git grep
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     60690@debbugs.gnu.org, demerphq@gmail.com,
        mega lith01 <megalith01@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?Q?Tukusej=E2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        pcre-dev@exim.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 3, 2023 at 2:39 PM Paul Eggert <eggert@cs.ucla.edu> wrote:
> I've recently done some bug-report maintenance about a set of GNU grep
> bug reports related to whether whether "grep -P '\d'" should match
> non-ASCII digits, and have some thoughts about coordinating GNU grep
> with git grep in this department.
>
> GNU Bug#62605[1] "`[\d]` does not work with PCRE" has been fixed on
> Savannah's copy of GNU grep, and some sort of fix should appear in the
> next grep release. However, I'm leaving the GNU grep bug report open for
> now because it's related to Bug#60690[2] "[PATCH v2] grep: correctly
> identify utf-8 characters with \{b,w} in -P" and to Bug#62552[3] "Bug
> found in latest stable release v3.10 of grep". I merged these related
> bug reports, and the oldest one, Bug#60690, is now the representative
> displayed in the GNU grep bug list[4].
>
> For this set of grep bug reports there's still a pending issue discussed
> in my recent email[5], which proposes a patch so I've tagged Bug#60690
> with "patch". The proposal is that GNU grep -P '\d' should revert to the
> grep 3.9 behavior, i.e., that in a UTF-8 locale, \d should also match
> non-ASCII decimal digits.
>
> In researching this a bit further, I found that on March 23 Git disabled
> the use of PCRE2_UCP in PCRE2 10.34 or earlier[6], due to a PCRE2 bug
> that can cause a crash when PCRE2_UCP is used[7]. A bug fix[8] should
> appear in the next PCRE2 release.
>
> When PCRE2 10.35 comes out,

Thanks for finding that.
It's clearly a good idea to disable PCRE2_UCP for those using those
older, known-buggy versions of pcre2.

The latest is 10.42, per https://github.com/PCRE2Project/pcre2/releases

> it appears that 'git grep -P' will behave
> like 'grep -P' only if GNU grep adopts something like the solution
> proposed in [5].
>
> [1]: https://bugs.gnu.org/62605
> [2]: https://bugs.gnu.org/60690
> [3]: https://bugs.gnu.org/62552
> [4]: https://debbugs.gnu.org/cgi/pkgreport.cgi?package=grep
> [5]: https://lists.gnu.org/archive/html/grep-devel/2023-04/msg00004.html
> [6]:
> https://github.com/git/git/commit/14b9a044798ebb3858a1f1a1377309a3d6054ac8
> [7]:
> https://lore.kernel.org/git/7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com/
> [8]:
> https://github.com/git/git/commit/14b9a044798ebb3858a1f1a1377309a3d6054ac8

Thanks for all of the links. However, have you seen justification
(other than for compatibility with some other tool or language) for
allowing \d to match non-ASCII by default, in spite of the risks?
IMHO, we have an obligation to retain compatibility with how grep -P
'\d' has worked since -P was added. I'd be happy to see an option to
enable the match-multibyte-digits behavior, but making it the default
seems too likely to introduce unwarranted risk.
