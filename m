Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735F3C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 21:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347744AbiATV6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 16:58:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50424 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347676AbiATV6q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 16:58:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4ECD1100623;
        Thu, 20 Jan 2022 16:58:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gJ/TGk4zmzXT14k4g4sDTABeVeAJQX5jCNDyif
        MkGag=; b=pb7thfoRcY20/7N5QuQDZn5VUCaHiip7GurRVnmnaa1I/iR9v7hH0n
        O0TN74HuQKFSkjESwEvbCLUC3w50S86fls3F++Du5flfNkjTpq82wBhuzax6JIIE
        +EtH/c5g9d5T6/4vzKqTZSYe75zH2iPZwWI/oWHy1D5XHuaovTH7A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43C4B100622;
        Thu, 20 Jan 2022 16:58:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1748100621;
        Thu, 20 Jan 2022 16:58:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re* [PATCH v7 0/3] fetch: skip unnecessary tasks when using
 --negotiate-only
References: <20220119000056.58503-1-chooglen@google.com>
        <20220120174942.94231-1-chooglen@google.com>
Date:   Thu, 20 Jan 2022 13:58:43 -0800
In-Reply-To: <20220120174942.94231-1-chooglen@google.com> (Glen Choo's message
        of "Thu, 20 Jan 2022 09:49:39 -0800")
Message-ID: <xmqqk0eugjcc.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23141A5A-7A3C-11EC-AF34-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Changes since v6:
> * use standard message format introduced in 246cac8505 (i18n: turn even
>   more messages into "cannot be used together" ones, 2022-01-05) (thanks
>   Jiang Xin!)

As v6 is already in 'next' since yesterday, let's make it an
incremental update.  It would give us a place to spell out why we
consider this change is desirable.

This is a tangent, but I recall there was a talk about "reviewer
checklist".  Things like:

 - check if we can reuse existing and identical message to reduce
   load on translators

 - when we are creating a file in a subdirectory of $GIT_DIR, be
   prepared to see any directories other than $GIT_DIR itself
   missing and create them as necessary

 - use safe_create_leading_directories() and adjust_shared_perm() on
   things under $GIT_DIR but not in the working tree


may belong there.

I am not sure if it is feasible to create and maintain such a list,
though.

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] fetch: help translators by reusing the same message template

Follow the example set by 12909b6b (i18n: turn "options are
incompatible" into "cannot be used together", 2022-01-05) and use
the same message string to reduce the need for translation.

Reported-by: Jiang Xin <worldhello.net@gmail.com>
Helped-by: Glen Choo <chooglen@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/builtin/fetch.c w/builtin/fetch.c
index dc6e637428..5c329f9835 100644
--- c/builtin/fetch.c
+++ w/builtin/fetch.c
@@ -2014,7 +2014,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			break;
 
 		default:
-			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
+			die(_("options '%s' and '%s' cannot be used together"),
+			    "--negotiate-only", "--recurse-submodules");
 		}
 	}
 
