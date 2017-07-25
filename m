Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 221961F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 19:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751395AbdGYTGP (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 15:06:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58044 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750897AbdGYTGO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 15:06:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDAB371F29;
        Tue, 25 Jul 2017 15:06:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r71JplsPNRPaY8S8+sonwrIryBs=; b=QuQtCG
        HadDOVBL3OxjtGwGjYslvzgI3uJUKFeNpdRxCgsmw9k5i19oz9I0RQRwSQwnOxc+
        Vjx1Gsg8lsP1+H2EqAxMQcnQlctbWrMy85/3BTpU1hWnwi3mMX36nAy/hoIacTfT
        JjsiSSVtWXbsBTNuyv40lQJ2gV5eJlSOID4xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iW011dx/1MSJ2EURK1B//h/yv7gAhjfL
        v3yGxB7JtHdDSSZOKDdbQ8KY4D49iUgzFIBz42xfxf6zueFq/kuJmxsrz3j1TEGs
        lrkV5Dsc8x7dEC3mxMLRgmUFD+xONQ1vxe8QTbSd3yuKa6Mozi7O/M8PvEW4klzg
        KNzrCMmgLFs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C56A371F28;
        Tue, 25 Jul 2017 15:06:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25DDC71F27;
        Tue, 25 Jul 2017 15:06:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     git@vger.kernel.org, Andreas Stieger <astieger@suse.com>
Subject: Re: [PATCH] hash: Allow building with the external sha1dc library
References: <s5hh8y19hyg.wl-tiwai@suse.de>
Date:   Tue, 25 Jul 2017 12:06:11 -0700
In-Reply-To: <s5hh8y19hyg.wl-tiwai@suse.de> (Takashi Iwai's message of "Tue,
        25 Jul 2017 07:57:43 +0200")
Message-ID: <xmqq60egbal8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53A31604-716C-11E7-9E4D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

> Some distros provide SHA1 collision detect code as a shared library.
> It's the very same code as we have in git tree, and git can link with
> it as well; at least, it may make maintenance easier, according to our
> security guys.
>
> This patch allows user to build git linking with the external sha1dc
> library instead of the built-in sha1dc code.  User needs to define
> DC_SHA1_EXTERNAL explicitly.  As default, the built-in sha1dc code is
> used like before.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---

I do not have such an environment to test this patch, but it looks
like a very sensible thing to do.  Will queue; thanks.

>  Makefile         | 12 ++++++++++++
>  hash.h           |  4 +++-
>  sha1dc_git_ext.c | 11 +++++++++++
>  sha1dc_git_ext.h | 25 +++++++++++++++++++++++++
>  4 files changed, 51 insertions(+), 1 deletion(-)
>  create mode 100644 sha1dc_git_ext.c
>  create mode 100644 sha1dc_git_ext.h
>
> diff --git a/Makefile b/Makefile
> index 461c845d33cb..f1a262d56254 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -162,6 +162,12 @@ all::
>  # algorithm. This is slower, but may detect attempted collision attacks.
>  # Takes priority over other *_SHA1 knobs.
>  #
> +# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
> +# git with the external sha1collisiondetection library.
> +# Without this option, i.e. the default behavior is to build git with its
> +# own sha1dc code.  If any extra linker option is required, define them in
> +# DC_SHA1_LINK variable in addition.
> +#
>  # Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
>  # sha1collisiondetection shipped as a submodule instead of the
>  # non-submodule copy in sha1dc/. This is an experimental option used
> @@ -1472,6 +1478,11 @@ ifdef APPLE_COMMON_CRYPTO
>  	BASIC_CFLAGS += -DSHA1_APPLE
>  else
>  	DC_SHA1 := YesPlease
> +ifdef DC_SHA1_EXTERNAL
> +	LIB_OBJS += sha1dc_git_ext.o
> +	BASIC_CFLAGS += -DSHA1_DC -DDC_SHA1_EXTERNAL
> +	EXTLIBS += $(DC_SHA1_LINK) -lsha1detectcoll
> +else
>  ifdef DC_SHA1_SUBMODULE
>  	LIB_OBJS += sha1collisiondetection/lib/sha1.o
>  	LIB_OBJS += sha1collisiondetection/lib/ubc_check.o
> @@ -1492,6 +1503,7 @@ endif
>  endif
>  endif
>  endif
> +endif
>  
>  ifdef SHA1_MAX_BLOCK_SIZE
>  	LIB_OBJS += compat/sha1-chunked.o
> diff --git a/hash.h b/hash.h
> index bef3e630a093..dce327d58d07 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -8,7 +8,9 @@
>  #elif defined(SHA1_OPENSSL)
>  #include <openssl/sha.h>
>  #elif defined(SHA1_DC)
> -#ifdef DC_SHA1_SUBMODULE
> +#if defined(DC_SHA1_EXTERNAL)
> +#include "sha1dc_git_ext.h"
> +#elif defined(DC_SHA1_SUBMODULE)
>  #include "sha1collisiondetection/lib/sha1.h"
>  #else
>  #include "sha1dc/sha1.h"
> diff --git a/sha1dc_git_ext.c b/sha1dc_git_ext.c
> new file mode 100644
> index 000000000000..359439fc3d93
> --- /dev/null
> +++ b/sha1dc_git_ext.c
> @@ -0,0 +1,11 @@
> +/* Only for DC_SHA1_EXTERNAL; sharing the same hooks as built-in sha1dc */
> +
> +#include "cache.h"
> +#include <sha1.h>
> +#include "sha1dc_git.c"
> +
> +void git_SHA1DCInit(SHA1_CTX *ctx)
> +{
> +	SHA1DCInit(ctx);
> +	SHA1DCSetSafeHash(ctx, 0);
> +}
> diff --git a/sha1dc_git_ext.h b/sha1dc_git_ext.h
> new file mode 100644
> index 000000000000..d0ea8ce518db
> --- /dev/null
> +++ b/sha1dc_git_ext.h
> @@ -0,0 +1,25 @@
> +/*
> + * This file is included by hash.h for DC_SHA1_EXTERNAL
> + */
> +
> +#include <sha1.h>
> +
> +/*
> + * Same as SHA1DCInit, but with default save_hash=0
> + */
> +void git_SHA1DCInit(SHA1_CTX *);
> +
> +/*
> + * Same as SHA1DCFinal, but convert collision attack case into a verbose die().
> + */
> +void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
> +
> +/*
> + * Same as SHA1DCUpdate, but adjust types to match git's usual interface.
> + */
> +void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
> +
> +#define platform_SHA_CTX SHA1_CTX
> +#define platform_SHA1_Init git_SHA1DCInit
> +#define platform_SHA1_Update git_SHA1DCUpdate
> +#define platform_SHA1_Final git_SHA1DCFinal
