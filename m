Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E6EC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 15:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349739AbiCOPs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 11:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349743AbiCOPsY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 11:48:24 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34441C12F
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 08:47:11 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 46853184B87;
        Tue, 15 Mar 2022 11:47:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wd3+WCp5DGNInqmaXnGrsiEhaF5vA/pq6E3Hs6
        Oa0Qo=; b=CJhdb75YDox0cj84z82yQIIu2cNCU+rtP0v1fp74IGG7n5TVmKyVjK
        mdMwmpBfInsL7Emg4p48JyHK6SXKbXiOalPzCmyCdfpmZMdxEwbBGxxLh+n1MzAD
        LCcwP9HxTmtqijdWhNMkqzqNGUR66zuNQek2nKFCr6NJWlMLXZfX8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 40E0E184B84;
        Tue, 15 Mar 2022 11:47:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BB69D184B83;
        Tue, 15 Mar 2022 11:47:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] git-curl-compat.h: addition of all symbols defined by curl
References: <20220315131638.924669-1-gitter.spiros@gmail.com>
Date:   Tue, 15 Mar 2022 08:47:07 -0700
In-Reply-To: <20220315131638.924669-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Tue, 15 Mar 2022 13:16:38 +0000")
Message-ID: <xmqqzglrfcas.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BFEBF20-A477-11EC-A93F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> This file was produced from a modified version of symbols.pl
> (https://github.com/curl/curl/blob/master/docs/libcurl/symbols.pl) and
> by manually adding the previous comments describing the dates of release
> of some curl versions not currently reported in the symbols-in-versions.
>
> To do this the symbols are listed in the order defined in the file
> symbols-in-versions rather than as they were previously inserted based
> on release dates.
>
> Most of these symbols are not used by git today. However, inserting
> them all starting from an automatic tool makes it largely unnecessary
> to update this file and therefore reduces the possibility
> of introducing possible errors in the future.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  git-curl-compat.h | 2944 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 2875 insertions(+), 69 deletions(-)

Hmmm.  While the basic idea may be sound, I do not think this alone
would be sufficient out of the box.

> diff --git a/git-curl-compat.h b/git-curl-compat.h
> index 56a83b6bbd..dc9086710a 100644
> --- a/git-curl-compat.h
> +++ b/git-curl-compat.h
> @@ -24,25 +24,1228 @@
>   * doing so is sufficient to add support for it to older versions that
>   * don't have it.
>   *
> - * Keep any symbols in date order of when their support was
> - * introduced, oldest first, in the official version of cURL library.
> - */
> -
> -/**
> - * CURL_SOCKOPT_OK was added in 7.21.5, released in April 2011.
> - */
> -#if LIBCURL_VERSION_NUM < 0x071505
> -#define CURL_SOCKOPT_OK 0
> -#endif

Even though you define GIT_HAVE_CURL_SOCKOPT_OK macro below, the
existing codebase is not expecting to handle the lack of
CURL_SOCKOPT_OK by checking the macro.  Instead, it expects the
macro to be defined to be 0 for older versions, exactly like this.

And you do not give a replacement definition.

> -#if LIBCURL_VERSION_NUM >= 0x071900
> -#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
> -#endif

This is an unfortunate oddball that lacks _ between GIT and CURL.

$ git grep -e '#define ' --and --not -e GIT_CURL_ git-curl-compat.h
> -#if LIBCURL_VERSION_NUM >= 0x071900
> -#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
> -#endif

You define GIT_CURL_HAVE_CURLOPT_TCP_KEEPALIVE but naturally,
existing callers do not pay attention to it.  They care about the
oddball variant GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE instead.

Luckily, these two are the only irregulars, it seems.

$ git grep -e '#define ' --and --not -e GIT_CURL_ git-curl-compat.h
git-curl-compat.h:#define CURL_SOCKOPT_OK 0
git-curl-compat.h:#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1

So, I think you would need a bit of preliminary clean-up patch
inserted before this automated compatibility layer, perhaps like
this.

--- >8 ---
Subject: curl: streamline conditional compilation

Earlier we introduced git-curl-compat.h that defines bunch of
GIT_CURL_HAVE_X where X is a feature of cURL library we care about,
to make it easily manageable to conditionally compile code against
the version of cURL library we are given.

There however are two oddball macros.  Instead of checking
GIT_CURL_HAVE_CURL_SOCKOPT_OK and using a fallback definition for
CURL_SOCKOPT_OK macro, we just defined CURL_SOCKOPT_OK to a safe
value when compiling against an old version that lack the symbol.
Also, the macro to check CURLOPT_TCP_KEEPALIVE (alone) was named
GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE.

Introduce GIT_CURL_HAVE_CURL_SOCKOPT_OK and define it for the
versions of cURL where we used to use our fallback definition for
CURL_SOCKOPT_OK, and use the fallback definition based on the new
GIT_CURL_HAVE_CURL_SOCKOPT_OK symbol at its sole use site.

To better conform the naming convention of other symbols, rename
GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE to GIT_CURL_HAVE_CURL_SOCKOPT_OK
and update its sole use site.

After this, conditional compilation with cURL library is all
controlled uniformly with GIT_CURL_HAVE_X mechanism.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-curl-compat.h | 2 +-
 http.c            | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git c/git-curl-compat.h w/git-curl-compat.h
index 56a83b6bbd..802d11e7be 100644
--- c/git-curl-compat.h
+++ w/git-curl-compat.h
@@ -39,7 +39,7 @@
  * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
  */
 #if LIBCURL_VERSION_NUM >= 0x071900
-#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
+#define GIT_CURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
 #endif
 
 
diff --git c/http.c w/http.c
index 2f67fbb33c..8d9a66b5ca 100644
--- c/http.c
+++ w/http.c
@@ -517,7 +517,7 @@ static int has_proxy_cert_password(void)
 }
 #endif
 
-#ifdef GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE
+#ifdef GIT_CURL_HAVE_CURLOPT_TCP_KEEPALIVE
 static void set_curl_keepalive(CURL *c)
 {
 	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
@@ -537,6 +537,9 @@ static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
 	if (rc < 0)
 		warning_errno("unable to set SO_KEEPALIVE on socket");
 
+#ifndef GIT_CURL_HAVE_CURL_SOCKOPT_OK
+#define CURL_SOCKOPT_OK 0
+#endif
 	return CURL_SOCKOPT_OK;
 }
 

