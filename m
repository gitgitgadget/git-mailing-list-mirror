Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6658BC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 16:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCFQ5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 11:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCFQ53 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 11:57:29 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3179936FD1
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 08:57:01 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so13792665pjb.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 08:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678121802;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//mc+FzxWKn61qSHTZsXDGFzg2yU3vN3M4C2PTyXCB0=;
        b=gcP256C2A+X8u3SGXNcebh//5GMdrM8z1MWoWik/UY9X/kahakJ6wjUIFfI1ZzbEcF
         1UTL3+Hn/P/ojvn5Xc2ezqCL2JRtXcUa+jDepwqebPX0R+ADCbbjAVutZJK0GhfoIrkf
         ZXsyPuz7vd8Wqy5nfOKn4UsdsRWVQnJ7ypFgdD880QqjHOEDx02Tbacw6Ba5c7s0aQP4
         VbZTBo6TOwZOLPXFbkQF5eMPP64bfAS+DAYQKnd/iOLPE0MAo+xDlY7Zf0kkMe85UURD
         QTP6IQzm5GqoEardNCRrpp6gFCQM6456rnT53st868QijYBJN4XqVlRf6SPfoXlOI9Ko
         6zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678121802;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//mc+FzxWKn61qSHTZsXDGFzg2yU3vN3M4C2PTyXCB0=;
        b=BhgQC/wgyA+Cs1nP7HKhzUbN5JumB95a4rnD2+5t+/2ZjOLSDo8TFdCZXZUc55KTJM
         T03nGwhFi92mjSeH1LkkuQotPRSZJOmieqPc1Cnj/qAQA9z+pop1lRSy9MdRVj2qPhDR
         gPcA4vKk8DiBhziQHaBnSlmsi3IW06kqOYwQH8Ao6cNpoucZbOawsI9oU9KOPWjNnLEC
         cdqLWpvMUMlrAU4o2D8Fb+CZWUrUd9aaZMB8V4zfVVF6y8Y7WXcepJxGKaNoHxKTyf+H
         XXFMnjj0ETAquS4qDZ66ryiC84/AzdrDyeXy7rmgpuskFK82D7QQVXhdpW8wAHQwcdGI
         Um1w==
X-Gm-Message-State: AO0yUKUoPmuf7m+JcIAVmbT0tqr6ee928PDkegEfZSMZYM+gAYWXCK54
        vSGZAwmllq6VqmWHdtFtifgOT4TsyRc=
X-Google-Smtp-Source: AK7set+ww38Wj4T524fKz8K9XZDgO/lFEHnUK8/CJVYWRoE2LG7k1OTJzojin0aeYyPAeC5RFikTAA==
X-Received: by 2002:a17:902:c14c:b0:19d:74c:78e4 with SMTP id 12-20020a170902c14c00b0019d074c78e4mr10550810plj.55.1678121802163;
        Mon, 06 Mar 2023 08:56:42 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id kr8-20020a170903080800b0019ac7319ed1sm3093983plb.126.2023.03.06.08.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 08:56:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Cristian Le <cristian.le@mpsd.mpg.de>, git@vger.kernel.org
Subject: Re: Bug in git archive + .gitattributes + relative path
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
        <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
        <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
        <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de>
Date:   Mon, 06 Mar 2023 08:56:41 -0800
In-Reply-To: <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 4 Mar 2023 14:58:40 +0100")
Message-ID: <xmqqy1o9byye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>    $ git archive --strip-components=1 HEAD sha1dc | tar tf -
>    .gitattributes
>    LICENSE.txt
>    sha1.c
>    sha1.h
>    ubc_check.c
>    ubc_check.h

What should happen to paths that match the given pathspec that do
not have enough number of components?  E.g. "cache.h" when the
command is "git archive --strip-components=1 HEAD \*.h"?  Should it
be documented?

> The new option does not affect the paths of entries added by --add-file
> and --add-virtual-file because they are handcrafted to their desired
> values already.  Similarly, the value of --prefix is not subject to
> component stripping.

Very sensible.

> diff --git a/archive.c b/archive.c
> index 9aeaf2bd87..8308d4d9c4 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -166,6 +166,18 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
>  		args->convert = check_attr_export_subst(check);
>  	}

We probably could save attribute lookup overhead by moving the new
logic a bit higher in the function?

No, that would invalidate the path_without_prefix variable by using
strbuf_remove() on &path, and will break the attribute look-up.  The
variable is used only once before this point and never used later,
but as an independent future-proofing, we may want to remove the
variable or narrow the scope.  It's totally out of scope of the
patch, though.

> +	if (args->strip_components > 0) {
> +		size_t orig_baselen = baselen;
> +		for (int i = 0; i < args->strip_components; i++) {
> +			const char *slash = memchr(base, '/', baselen);
> +			if (!slash)
> +				return S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0;
> +			baselen -= slash - base + 1;
> +			base = slash + 1;
> +		}
> +		strbuf_remove(&path, args->baselen, orig_baselen - baselen);
> +	}

Nice to see that the core logic of the new feature is surprisingly
small.

>  	if (args->verbose)
>  		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);

By having the verbose output after the path stripping, we won't show
the leading components we stripped, making it similar to what we
would see when we piped the resulting archive to "| tar tf -".  I
guess this makes sense than showing the original path.
