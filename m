Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FF7C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 10:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiFBKX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 06:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiFBKXW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 06:23:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2C4215E40
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 03:23:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x62so5647142ede.10
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=IEph0e+xxtFLayitwHJZjqZwvOuWOf9D2Hg1SctPgmE=;
        b=j0q3lz5deSWB37ktpiMYzS3d2xzFn/eWqQ+ERmFSSJKRQfXCi0tt2xFg8BaZk3DJwF
         KC8umWebdt8Y/lyWiHI+w2hinph9Ca+X0m9IllC6ekYu3MXgkDb80w0cONwSuRPOL4Aa
         cioKc1TNz2E0VlM56lTdedXlUzK3QJgtYqZp6SlyeWFGABF7CqEv8sDlDIhU90tiLsB7
         XCKkRozgugfhHBXTyYl7q2zoIvJXjuBAU4gNAt6odu8gwj01Vqsc4iSOR2Qo5My3RKfB
         ZdD2YMPWVZUBtKmdL0WEAlqN1uc55AlecKpn9kn29gCNimzlA13of/IgVu6seuZxi3YG
         3keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=IEph0e+xxtFLayitwHJZjqZwvOuWOf9D2Hg1SctPgmE=;
        b=tpeNnzm0wJbnyjp3GngrifVnyl46Eu7njN7zdkjMiUASXDcrDr8qnVL8rbGUrGG+B0
         vfQAyR/bCAyfYljY8Emq5q1n7FAakG3LA++JJoraq9rVeNUzty81I6g6QqapHWKx/5sN
         6tJskDEZMClKlvkYAyjbeD/pMH8Aas1DocY674CwLFrrElAhgsZxEx/o9ceNn59InRv8
         3Pes64mvKecmFa4e3GdSG2HXp8EUasBByjqgcpZUF/g0QPMBqL7jhHSTj5WEniZe7+TE
         dG6YkkyjcRWgxIP8n0dhbv/FNc0BbzwXy56jAULJTHga5eP3+0S9Zi58qC31Mb2Cy/g3
         bKvQ==
X-Gm-Message-State: AOAM530q4Y9rCsu3cKnNB5TNISf/nRo4/j1EEIo2NAQStPSMMYgqBcBk
        sP6X0YivQNWcE22Iu6GOBMc=
X-Google-Smtp-Source: ABdhPJwWwA2PkwLkOd2SMgMHiGVIrOIYBe18DV1wqGrzncCiczD6wMkO6P/16apByHSaqas0QwkoHw==
X-Received: by 2002:a05:6402:1907:b0:42d:e90e:337 with SMTP id e7-20020a056402190700b0042de90e0337mr4558614edz.405.1654165398602;
        Thu, 02 Jun 2022 03:23:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w14-20020a170906d20e00b006fed93bf71fsm1661838ejz.18.2022.06.02.03.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 03:23:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwhz2-001QSG-K7;
        Thu, 02 Jun 2022 12:23:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] cmake: optionally build `scalar`, too
Date:   Thu, 02 Jun 2022 12:18:21 +0200
References: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
 <c155cadfa309e856f13ea7d005870dab706a74ce.1654160735.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <c155cadfa309e856f13ea7d005870dab706a74ce.1654160735.git.gitgitgadget@gmail.com>
Message-ID: <220602.86ilpjz7mz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 02 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Unlike the `Makefile`-based build, the CMake configuration unfortunately
> does not let us easily encapsulate Scalar's build definition in the
> `contrib/scalar/` subdirectory: The `scalar` executable needs to link in
> `libgit.a` and `common-main.o`, for example.

Are you using "encapsulation" here synonymously with "[mostly] lives in
a different file"? If not I don't really see what distinction you're
trying to draw here.

The contrib/scalar/Makefile "shells out" to the top-level MAkefile to
build libgit.a & common-main.o, as well as scalar.o itself.

> To alleviate that lack of encapsulation somewhat, we guard the Scalar
> parts in `CMakeLists.txt` via the `INCLUDE_SCALAR` environment variable.
> This not only allows the CMake-based build to exclude Scalar by default,
> but also gives better visual cues as to which sections are related to
> Scalar.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/buildsystems/CMakeLists.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 185f56f414f..c8a802463ba 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -753,6 +753,13 @@ if(CURL_FOUND)
>  	endif()
>  endif()
>  
> +if(DEFINED ENV{INCLUDE_SCALAR} AND NOT ENV{INCLUDE_SCALAR} STREQUAL "")
> +	add_executable(scalar ${CMAKE_SOURCE_DIR}/contrib/scalar/scalar.c)
> +	target_link_libraries(scalar common-main)
> +	set_target_properties(scalar PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/contrib/scalar)
> +	set_target_properties(scalar PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/contrib/scalar)
> +endif()
> +
>  parse_makefile_for_executables(git_builtin_extra "BUILT_INS")
>  
>  option(SKIP_DASHED_BUILT_INS "Skip hardlinking the dashed versions of the built-ins")
> @@ -980,6 +987,13 @@ string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
>  string(REPLACE "@@PROG@@" "git-cvsserver" content "${content}")
>  file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
>  
> +if(DEFINED ENV{INCLUDE_SCALAR} AND NOT ENV{INCLUDE_SCALAR} STREQUAL "")
> +	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
> +	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
> +	string(REPLACE "@@PROG@@" "contrib/scalar/scalar${EXE_EXTENSION}" content "${content}")
> +	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/scalar ${content})
> +endif()

We've been over this before direction we should take to fully integrate
scalar (see [1]), but leaving that aside this seems by any definition to
be more "encapsulated" than what we have in Makefile &
contrib/scalar/Makefile. I.e. this is isolated in its own sections,
whereas in the Makefile case we have the top-level building scalar,
contrib/scalar/Makefile shelling out to it, and then adding its own
behavior etc.

I don't think there's much point to re-visit the discussions around the
time of [1], clearly you feel differently,

But just on the commit message it seems to have been drafted from some
earlier version.

Perhaps it was based on the earlier version of the scalar series before
I'd pointed out the Makefile dependency issues around scalar.o (which
led you to have contrib/scalar/MAkefile "shell out")?

1. https://lore.kernel.org/git/patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com/

