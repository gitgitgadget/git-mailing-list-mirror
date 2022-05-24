Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D87C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 23:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbiEXXEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 19:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbiEXXEw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 19:04:52 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1866F703EC
        for <git@vger.kernel.org>; Tue, 24 May 2022 16:04:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62B7D181EC0;
        Tue, 24 May 2022 19:04:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uPtkzPGxIU5sgsHNz5xANrPlf6UUrPMsAVTFSp
        JGfyU=; b=LgBsGvpfnngA/8z+S4PjpQab0jRtZzTkXEi9EaEBJX7o7GsRpGr+ne
        1YcP1ijalIZkkz4kgo8GHxbmxpKzhyobhAnIubKbnZe9OoSOQNMf5GwwO4baWA3D
        0Qz2mK349Ae/R2coZiSEG1HrKfNSd83ZqsXuw0nHdd+DlEKsQOGNM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B36A181EBF;
        Tue, 24 May 2022 19:04:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 07FEF181EBE;
        Tue, 24 May 2022 19:04:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Yuyi Wang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Yuyi Wang <Strawberry_Str@hotmail.com>
Subject: Re: [PATCH v2 1/2] Fix CMakeLists.txt on Linux.
References: <pull.1267.git.git.1652846305514.gitgitgadget@gmail.com>
        <pull.1267.v2.git.git.1653374328.gitgitgadget@gmail.com>
        <29cb31e5c502149192c6beb56bf8b372a40711e0.1653374328.git.gitgitgadget@gmail.com>
Date:   Tue, 24 May 2022 16:04:43 -0700
In-Reply-To: <29cb31e5c502149192c6beb56bf8b372a40711e0.1653374328.git.gitgitgadget@gmail.com>
        (Yuyi Wang via GitGitGadget's message of "Tue, 24 May 2022 06:38:47
        +0000")
Message-ID: <xmqqtu9ecz1w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6DDC8DE-DBB5-11EC-B9B0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Yuyi Wang via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v2 1/2] Fix CMakeLists.txt on Linux.

Perhaps

	Subject: cmake: fix CMakeLists on Linux

i.e. with a short and meaningful <area>: prefix, no need to
capitalize the first word after the prefix, without the terminating
full-stop.

From: Yuyi Wang <Strawberry_Str@hotmail.com>
>
> CMakeLists.txt didn't follow the grammar of `set`, and it will fail when
> setting `USE_VCPKG` off on non-Windows platforms.

So any non-Windows, the use of set() here was broken.  It is
understandable because cmake support was added primarily for
Windows.  It is nevertheless good to see it corrected.

> When the platform is Linux, the Makefile adds `compat/linux/procinfo.o`
> to `COMPAT_OBJS`, but the CMakeLists.txt didn't add
> `compat/linux/procinfo.c` to `compat_SOURCES`. It would cause linkage
> error.

OK.  I didn't know anybody cared about using cmake on non-Windows
platforms for this project.

Thanks, will queue, together with the other two patches.



> Signed-off-by: Yuyi Wang <Strawberry_Str@hotmail.com>
> ---
>  contrib/buildsystems/CMakeLists.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 185f56f414f..7f333e303c2 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -54,7 +54,7 @@ set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
>  
>  option(USE_VCPKG "Whether or not to use vcpkg for obtaining dependencies.  Only applicable to Windows platforms" ON)
>  if(NOT WIN32)
> -	set(USE_VCPKG OFF CACHE BOOL FORCE)
> +	set(USE_VCPKG OFF CACHE BOOL "" FORCE)
>  endif()
>  
>  if(NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
> @@ -277,7 +277,7 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
>  
>  elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
>  	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
> -	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c)
> +	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c compat/linux/procinfo.c)
>  endif()
>  
>  if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
