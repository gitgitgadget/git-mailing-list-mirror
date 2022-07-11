Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0177C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 13:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiGKN3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 09:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKN3t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 09:29:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E90CB28
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 06:29:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x91so6259136ede.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=xRJ54cN6Ml60J/tMqq3AfemsP3mx2XTYVyBQGCKDsIo=;
        b=AM/EbPW9/RDuA4e7Ri/XYlUWeY+QPKZSBoLNuQPQBWZUujE4Bhtc2sIbM6PhXq0KnM
         I7oHH3upmGSOy5wM74XzdcX5Zi79spLIPBXuLF/pejelR/1XOhu8SJjWrEihRdTW46Q5
         4egbpS4CmBEEla/2WREC+Mkr9qH5k77TUsnCqEmy9dzLnd6qVCmzJZoxZojc6XvNlU8p
         HHf+HjLM7jSAUt3oa+hU9/+rOt0imxJfSS7Io+iHkk1rqJDCpnuDAz8pjDXjZcNBLGY5
         wkYsF7fFja/X3cuRK5JXtWSLC9Y/WZx3AVRzcxgHy+4Yjb9i1ri3hwEmbJH02VYdOy1I
         E7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=xRJ54cN6Ml60J/tMqq3AfemsP3mx2XTYVyBQGCKDsIo=;
        b=FDvbkDGz68BwoI9Dphz3xL05vheomASJw5UfBDgyIobHI/nN3N1gV9Kt3pbaQG5L6m
         iCk5Oc61l6sMp59xIXpcYLoe2GnOJ/X/p3/M5YIP8hK8tWNmCW+akUVVv1Iho1c9Wipj
         VY/jJCKpTNl8nemY8UZ1lUndVbP9W5LY8CGzzY3jRb9jyGdEtR/gnHPxKR1lyzm5LSHI
         BAwYojKvNhjhPqyFarPc1BP3ZP3EH4UxurW7ZDTSQTPUhIZx1nqUFfwH9ZuRZFmGsfzT
         NsK0OpoDCsJR3dc0vjr9iVeXCv81O8Xu7Rwp/l6d90yN5zFz79V75PX+IjPM9NDXW6kC
         p/9A==
X-Gm-Message-State: AJIora8tlHhVbOYuOsZ31uEve6z/7cOU2gq+UXtMhWZyjMf1LVYzSkB3
        keOCjIH7h34kfl5ZjAipdDM=
X-Google-Smtp-Source: AGRyM1s71kfGt3PsrGoI+JsOByrLNdwBS8wO3N3M9AhY+m7jGrXJNtANomFlaPcS49P60YJ1Yftb+w==
X-Received: by 2002:a05:6402:5186:b0:43a:b43a:40bc with SMTP id q6-20020a056402518600b0043ab43a40bcmr20890341edd.388.1657546186869;
        Mon, 11 Jul 2022 06:29:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ej24-20020a056402369800b00438a13508c4sm4323189edb.51.2022.07.11.06.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 06:29:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAtTt-000sCf-1M;
        Mon, 11 Jul 2022 15:29:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: Automatic code formatting
Date:   Mon, 11 Jul 2022 15:21:58 +0200
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
 <0c07f6ca-d52a-f285-56cc-1b673f7d98fb@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <0c07f6ca-d52a-f285-56cc-1b673f7d98fb@gmail.com>
Message-ID: <220711.86o7xv7p6f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 11 2022, Phillip Wood wrote:

> Hi brian
>
> On 10/07/2022 22:50, brian m. carlson wrote:
>> Most projects written in languages like Rust or Go use an automatic
>> formatter.  In Go's case, the formatter is specifically stated to be a
>> fixed style that is nobody's favourite, but because there's an automatic
>> formatter, everybody just uses it.  Personally, I don't love our coding
>> style now (I'm a 4-space person in C), but I would love it a lot more if
>> I didn't have to think about it.  I am substantially less picky about
>> what the style is than that we have an automated tool to tidy our code,
>> and I'm okay with us producing the occasional slightly suboptimal style
>> for the improved efficiency we get.
>> [...]
>> I should note that we already have a .clang-format file, so we can
>> already use clang-format.  However, we cannot blindly apply it because
>> it produces output that is not always conformant with our style.  My
>> proposal here is to define our style in terms of the formatter to avoid
>> this problem.
>
> I agree it is lovely not to have to think about the style rules when
> writing code for a project that has an automatic formatter. As Junio 
> said I think it would take a bit of work to persuade clang-format to
> match our style and I'm concerned that adopting the style it produces 
> now would lead to a lot of churn. Below is an example taken from [1]
> that shows one area for improvement. At the moment its struct
> formatting seems inconsistent (one struct ends up with one field per
> line and the second has more than one field per line with a completely
> different indentation to the first) and I'm not sure we want it
> reformatting the whole definition when a new member is added. When
> Han-Wen Nienhuys submitted that patch I did have a brief play with the
> clang-format rules to try and improve it but didn't get anywhere.
>
> [1]
> https://lore.kernel.org/git/2c2f94ddc0e77c8c70041a2a736e3a56698f058c.1589226388.git.gitgitgadget@gmail.com
>
> @@ -3173,30 +3282,31 @@ static int files_init_db(struct ref_store
> *ref_store, struct strbuf *err)
>  	return 0;
>  }
>
> -struct ref_storage_be refs_be_files = {
> -	NULL,
> -	"files",
> -	files_ref_store_create,
> -	files_init_db,
> -	files_transaction_prepare,
> -	files_transaction_finish,
> -	files_transaction_abort,
> -	files_initial_transaction_commit,
> -
> -	files_pack_refs,
> -	files_create_symref,
> -	files_delete_refs,
> -	files_rename_ref,
> -	files_copy_ref,
> -
> -	files_ref_iterator_begin,
> -	files_read_raw_ref,
> -
> -	files_reflog_iterator_begin,
> -	files_for_each_reflog_ent,
> -	files_for_each_reflog_ent_reverse,
> -	files_reflog_exists,
> -	files_create_reflog,
> -	files_delete_reflog,
> -	files_reflog_expire
> -};
> +struct ref_storage_be refs_be_files = { NULL,
> +					"files",
> +					files_ref_store_create,
> +					files_init_db,
> +					files_transaction_prepare,
> +					files_transaction_finish,
> +					files_transaction_abort,
> +					files_initial_transaction_commit,
> +
> +					files_pack_refs,
> +					files_create_symref,
> +					files_delete_refs,
> +					files_rename_ref,
> +					files_copy_ref,
> +
> +					files_write_pseudoref,
> +					files_delete_pseudoref,
> +
> +					files_ref_iterator_begin,
> +					files_read_raw_ref,
> +
> +					files_reflog_iterator_begin,
> +					files_for_each_reflog_ent,
> +					files_for_each_reflog_ent_reverse,
> +					files_reflog_exists,
> +					files_create_reflog,
> +					files_delete_reflog,
> +					files_reflog_expire };

As my RFC series in the side-thread notes there's a lot of little
outstanding issues with its formatting, but this in particular isn't one
of them.

This one was resolved in my 32bff617c6a (refs: use designated
initializers for "struct ref_storage_be", 2022-03-17), and clang-format
currently has no formatting suggstions for these assignments on
"master".

And in general I think all such large assignments we wanted to convert
to designated initializers anyway, and/or have already done so.

With that series try:

	make style-all-diff-apply &&
	git diff

There's lots of outstanding issues for sure, for structs we lose some
borderline ascii-art alignment in some cases (e.g. the one in tar.h),
but I'd think those would be OK to either just format consistently, or
use "/* clang-format off */".
