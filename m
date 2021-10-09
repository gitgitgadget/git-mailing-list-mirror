Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549F9C433EF
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 02:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3194F60F51
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 02:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhJICKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 22:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhJICKh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 22:10:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C03C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 19:08:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g10so42083986edj.1
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 19:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=s9gLHvP1QZj+iVsVQbkkXGZb0PxOkg+nTKNyn2pAmYI=;
        b=EDK19SRTw4PO3CBtdrpWKMHvAYpCkwKmFpb54FI/yv+6oi0wS9vBAOND27HlKxxtBo
         B7XXVSXQ9D3ZgSiTCTZwDDJe9bmsVli206wsh67119lB6qtgRb4aL6pl6VjFhnfiuoQi
         S7516VuidmpiBoded7CGjd7/84Io2x57CZ/Y4igIazvwvb+A47TEfK4M9jrugA1oyyhg
         s/vraYUh+NxHE/4kC+2KgVwqyTO4MT4XdtjptRS0p94188Um60neYbZL1B9NEWxyZ6F8
         jz2KSKfIpE5r6BGwbjp5G/bUELLCN5qUqh6rKN3eKMbuYaTyzAEwO1JbA8Td3vgiMjNz
         glXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=s9gLHvP1QZj+iVsVQbkkXGZb0PxOkg+nTKNyn2pAmYI=;
        b=MnVhFcX3GwssjwdqMtZakf/ZwDJ9FdbaLGr+CdLZQq95IinjS+6Ymt+ANzSfbjJf7P
         HFDAwKgha5H4brUtmecAvVkAyvlSQn178m8XS8BjguhuMcITNtF6V/BEz4EFOcO3Ai1q
         9gKhjD1Ij0srbtNZgHndz9iI6j76CKqlq5ZuTJX8R/le/UNGwgJqvWsvxPvTuFCH6zoO
         gkRo1guT6DUQXH+hcxbdNCOPYvEOAbXtqDTGHO55hn/GYC24toq5USjeDvMsmMGz13k/
         8XkJiwpQYZXhgSIP2tS8HYTseAQNqUu+w5C81mT4lVG9AIMVPHwx8XfnXAAAr27Eao5T
         O51w==
X-Gm-Message-State: AOAM531C8GDFlRQcFSnXAqZqrd6uJKDPsy0SQGHLQEWYxoHn1t47HIxd
        lTMU3g2a1Tz0tHJj/jhvigw=
X-Google-Smtp-Source: ABdhPJwQBSnT3JloBqgZsOADIle7DONXR3J3mMX5Sd572bpHFpyrZU90BxnhR/GECdKW8ZTqrnNDsw==
X-Received: by 2002:a17:906:7250:: with SMTP id n16mr8448539ejk.147.1633745319959;
        Fri, 08 Oct 2021 19:08:39 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v6sm419924edc.52.2021.10.08.19.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 19:08:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        dstolee@microsoft.com, jeffhost@microsoft.com, peff@peff.net
Subject: Re: [PATCH 4/4] midx.c: guard against commit_lock_file() failures
Date:   Sat, 09 Oct 2021 04:07:16 +0200
References: <cover.1633729502.git.me@ttaylorr.com>
 <ed7407cefa89b973d1085973f4ddb39397597036.1633729502.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <ed7407cefa89b973d1085973f4ddb39397597036.1633729502.git.me@ttaylorr.com>
Message-ID: <875yu7lzkp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 08 2021, Taylor Blau wrote:

> When writing a MIDX, we atomically move the new MIDX into place via
> commit_lock_file(), but do not check to see if that call was successful.
>
> Make sure that we do check in order to prevent us from incorrectly
> reporting that we wrote a new MIDX if we actually encountered an error.
>
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  midx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/midx.c b/midx.c
> index 137af3fc67..e79fb4427d 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1434,7 +1434,8 @@ static int write_midx_internal(const char *object_dir,
>  	if (ctx.m)
>  		close_object_store(the_repository->objects);
>  
> -	commit_lock_file(&lk);
> +	if (commit_lock_file(&lk) < 0)
> +		die_errno(_("could not write multi-pack-index"));
>  
>  	clear_midx_files_ext(object_dir, ".bitmap", midx_hash);
>  	clear_midx_files_ext(object_dir, ".rev", midx_hash);

As an aside I've wondered with this API whether something like this
wouldn't make sense (obviously with a better message):

diff --git a/lockfile.c b/lockfile.c
index cc9a4b84283..6632a634f00 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -175,6 +175,7 @@ int hold_lock_file_for_update_timeout_mode(struct lock_file *lk,
 					   long timeout_ms, int mode)
 {
 	int fd = lock_file_timeout(lk, path, flags, timeout_ms, mode);
+	lk->flags = flags;
 	if (fd < 0) {
 		if (flags & LOCK_DIE_ON_ERROR)
 			unable_to_lock_die(path, errno);
@@ -209,6 +210,8 @@ int commit_lock_file(struct lock_file *lk)
 		int save_errno = errno;
 		free(result_path);
 		errno = save_errno;
+		if (lk->flags & LOCK_DIE_ON_ERROR)
+			die_errno("noes");
 		return -1;
 	}
 	free(result_path);
diff --git a/lockfile.h b/lockfile.h
index db93e6ba73e..40a9d91a6c5 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -119,6 +119,7 @@
 
 struct lock_file {
 	struct tempfile *tempfile;
+	int flags;
 };
 
 #define LOCK_INIT { NULL }

But a quick grep of the users reveals that some die on lock failure, but
are happy to ignore commit_lock_file() failures, or maybe those are also
bugs similar to the one you're fixing here & we could fix the API more
generally.
