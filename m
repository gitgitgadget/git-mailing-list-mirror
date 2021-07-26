Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C39CC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7F160F6C
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhGZVYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 17:24:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63761 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhGZVYw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 17:24:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02F89D19F1;
        Mon, 26 Jul 2021 18:05:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cBTICY56f7RkAemADoovd2R9O7K3hggdq7oZbE
        0AN14=; b=nsD/kQCpAEzdiqx8MqhgglTSEKUhmWibIcGWbj1o8Q6TosWPclwUjm
        2qfTO5onxahP2RleDeO2QDYyS4WB8BQEUD/v+5pycE6JPEq341P8IYwF6gzCOGSk
        PUs8XJHlrBgNy/uYec/B6GsVyzHrkf9sl4oH1WSt3RnSJjNXPNnDg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED1F1D19EB;
        Mon, 26 Jul 2021 18:05:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30512D19E8;
        Mon, 26 Jul 2021 18:05:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 4/5] Use a better name for the function interpolating
 paths
References: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
        <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
        <19fd9c3c803a300b586c76736301a7379c4c6226.1627164413.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 15:05:18 -0700
In-Reply-To: <19fd9c3c803a300b586c76736301a7379c4c6226.1627164413.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Sat, 24 Jul 2021
        22:06:52 +0000")
Message-ID: <xmqqh7gghgtd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90C865BC-EE5D-11EB-84B4-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It is not immediately clear what `expand_user_path()` means, so let's
> rename it to `interpolate_path()`. This also opens the path for
> interpolating more than just a home directory.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> ...
> diff --git a/cache.h b/cache.h
> index ba04ff8bd36..87e4cbe9c5f 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1246,7 +1246,7 @@ typedef int create_file_fn(const char *path, void *cb);
>  int raceproof_create_file(const char *path, create_file_fn fn, void *cb);
>  
>  int mkdir_in_gitdir(const char *path);
> -char *expand_user_path(const char *path, int real_home);
> +char *interpolate_path(const char *path, int real_home);

This of course breaks any topic in flight that adds more places to
use expand_user_path().

I think Fabian's "ssh signing" is not as ready as this topic, and it
can afford to wait by rebasing on top of this topic.  By the time
"ssh signing" gets into testable shape (right now, it does not pass
tests when merged to 'seen'), hopefully the "expand install-prefix"
topic may already be in 'next' if not in 'master'.

In the meantime, I am adding this band-aid at the tip of this topic
to help these two topics play together better.

Thanks.


diff --git a/cache.h b/cache.h
index 87e4cbe9c5..679a27e17c 100644
--- a/cache.h
+++ b/cache.h
@@ -1247,6 +1247,8 @@ int raceproof_create_file(const char *path, create_file_fn fn, void *cb);
 
 int mkdir_in_gitdir(const char *path);
 char *interpolate_path(const char *path, int real_home);
+/* NEEDSWORK: remove this synonym once in-flight topics have migrated */
+#define expand_user_path interpolate_path
 const char *enter_repo(const char *path, int strict);
 static inline int is_absolute_path(const char *path)
 {
