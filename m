Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB19C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 21:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCVVYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 17:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCVVYh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 17:24:37 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510E32472C
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 14:24:35 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d22so11433888pgw.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679520275;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IjjJNqy3qsS10SQC92cSTY6eTOFyNCATyptaibGIfI=;
        b=Y5+ngG043XDI0/sbCE7MpEVMm0OxpJH+2inZRR96hcfaPLGTm3uZiZoPuxjZgQ8Gay
         WsZM03S7s1q0/M9kvdBaPfbh3h7XSZMbb2endie3Xh3W6ESuFF5tm6Ap2jmiomwJ8NO7
         uUVoPIUUkrYBbs5EKHBqnLCOo+/g3MIKaQBr7l0xqdOQzPsEhntwpa2CwJDLbf3hjaqX
         Nz+sdZgNl90uVh9ivyQ9LDBMz+uSH6VtK+v92aWdJ+ezKOz9RohXE9BAn/PUuANacw05
         Y/koBz/WVqybGNfLsluYNi1OTeL4KyfQX84I8W0xbJmtTl9cfDtrmMsV/bSVc4tUM4nM
         MKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679520275;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+IjjJNqy3qsS10SQC92cSTY6eTOFyNCATyptaibGIfI=;
        b=dufavA11zk57Y4gHwjZb6r4qGu+gAp4RP2hQCPjFH5Lp1eAAOSij4D5qP/OGYnqfrQ
         rM8YZ5EWrjuDd0MtRpCjteOCKzSRuzy8jqfyW/pCWufUliKLWytuOT1IohYv190ImVd0
         f1+sNyVF2FjnKrG6IW/5DV6YE7pJEg2lmTqGTeuHhQ8HkaihZTBImgTQg5j32HJH3RUC
         sqII/XyAlG7z1FsNw7qtoGemk+LdLTYUVY1DLhwjjvlAhgGGsAc3hp5YO5sdq6opTAui
         YW5KsyJWLidvg38vzDhetXs4qMsA33tgZRfLMtdEtN9LKzaz60knwg9VvBM17nUqAqJQ
         UELw==
X-Gm-Message-State: AO0yUKUX4A/r3wPtISZrdAdgUh79IzVparb11Ere5u2ZN54wTYastP3h
        QzxbwWy06vi0Pk9hZzroqAo=
X-Google-Smtp-Source: AK7set8icFXaU6B2vdlWe82db/f0w7vr5jzdimauuYeWbuRuRBr6XsIDVq1veiGKA0pfS6btpIZNGg==
X-Received: by 2002:aa7:8f18:0:b0:627:effd:71ba with SMTP id x24-20020aa78f18000000b00627effd71bamr4050717pfr.6.1679520274640;
        Wed, 22 Mar 2023 14:24:34 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c26-20020aa781da000000b0062578514d6fsm10532221pfn.58.2023.03.22.14.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 14:24:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] split-index; stop abusing the `base_oid` to strip
 the "link" extension
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
        <f1897b880729b649ab24da14cbc3432d44b7c731.1679500859.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 14:24:34 -0700
In-Reply-To: <f1897b880729b649ab24da14cbc3432d44b7c731.1679500859.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 22 Mar 2023
        16:00:57 +0000")
Message-ID: <xmqqjzz8cwdp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When a split-index is in effect, the `$GIT_DIR/index` file needs to
> contain a "link" extension that contains all the information about the
> split-index, including the information about the shared index.
> ...
> Let's stop zeroing out the `base_oid` to indicate that the "link"
> extension should not be written.

Nicely explained.

> One might be tempted to simply call `discard_split_index()` instead,
> under the assumption that Git decided to write a non-split index and
> therefore the the `split_index` structure might no longer be wanted.

"the the".

> +enum strip_extensions {
> +	WRITE_ALL_EXTENSIONS = 0,
> +	STRIP_ALL_EXTENSIONS = 1,
> +	STRIP_LINK_EXTENSION_ONLY = 2
> +};

We do not need to spell out the specific values for this enum; the
users' (i.e. the callers of do_write_index()) sole requirement is
for these symbols to have different values.

Also do we envision that (1) we would need to keep STRIP_LINK_ONLY
to be with the largest value among the enum values, or (2) we would
never add new value to the set?  Otherwise let's end the last one
with a trailing comma.

Looking at the way strip_extensions variable is used in
do_write_index(), an alternative design might be to make it a set of
bits (e.g. unsigned write_extension) and give one bit to each
extension.  But such a clean-up is better left outside the topic, I
would imagine, as we do not have any need to skip an arbitrary set
of extensions right now.

> +/*
> + * Write the Git index into a `.lock` file
> + *
> + * If `strip_link_extension` is non-zero, avoid writing any "link" extension
> + * (used by the split-index feature).
> + */

Not exposing "enum strip_extensions" to the caller of this function,
like this patch does, is probably a very safe and sensible thing to
do.  We do not have a reason to allow its callers to (perhaps
mistakenly) pass STRIP_ALL_EXTENSIONS to it.

>  static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
> -				 unsigned flags)
> +				 unsigned flags, int strip_link_extension)
>  {
>  	int ret;
>  	int was_full = istate->sparse_index == INDEX_EXPANDED;
> @@ -3185,7 +3197,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
>  	 */
>  	trace2_region_enter_printf("index", "do_write_index", the_repository,
>  				   "%s", get_lock_file_path(lock));
> -	ret = do_write_index(istate, lock->tempfile, 0, flags);
> +	ret = do_write_index(istate, lock->tempfile, strip_link_extension ? STRIP_LINK_EXTENSION_ONLY : 0, flags);
>  	trace2_region_leave_printf("index", "do_write_index", the_repository,
>  				   "%s", get_lock_file_path(lock));
>  

OK.

Very nicely done.
