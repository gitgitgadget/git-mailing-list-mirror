Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97736C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 14:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiKGOl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 09:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiKGOls (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 09:41:48 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779201A217
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 06:41:37 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so30594106ejb.13
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 06:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+cwhN7fOzcOYh2X4NBXzCAwkgaiumtuGswjPcxlIiEk=;
        b=Qo2EfFl2yW1OHOAPKumoga/olKrYRLmbsGPeaf2jM67TWohWEBwpcipmIalQX39R/i
         zLcMh99lxnxDiKJQt/7TBDXbgxqdObLSax+el+xU1SkB9NmTfE//toxBZwWKz3A/UNda
         xhazpKOQqGKHVe5qV0TrJwBDGDF/Lv6t9KnKSNXycsjriTGhmykLG24JWKJRnh8ekQcJ
         oxy45jgUZwfF6RES5gnvIWKzZ+yJEDFbD+7luJt3oa7FbRGmNaW3hpbrth7nfTgmoFLd
         VfkwsxMflJAppOY8+YJviLEQ4Nx3E24SlX6Wppp89+kTWyta7rKtHm+yzwbVXftMObY2
         7jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cwhN7fOzcOYh2X4NBXzCAwkgaiumtuGswjPcxlIiEk=;
        b=fHrT87fhv9mCB24eobk6rc4eUi2Jv97442aWVpwwPMSn6BQTMuwIig5CdXAu6RDn8C
         2rc3UswN44+2vD84xsqoQfGvK/nAH111l4JtbbXLx+BrMbDAlrJp5vZdwBg44GKwxdv/
         KRynOPW4GAC1JS6isFtWE4bqzHzqovWsDmLrdEoosUG6P+eH/yuZ4Km5U3qGZV9SJRG9
         bO4PhwpDRfIaVLXgewv5Ww6rajq4EnqBX3TiVB52OgyWn6chCgmQfnZjoVf6sxhg+oBd
         XuMajN97gzWMhT0gS89Y4S5cKQL4VpQ1h0S3gNxwKNhGJI4Syy6PilQAYQBX0Y+GuHkQ
         7hRg==
X-Gm-Message-State: ACrzQf0AjjXDTMDCFcD+KUH9aUCztBodnh47CtwaHyf0SV6OZwyotq7B
        Cs9d0QIDP5T3Vw4qcHpiNFzO++UZBSk=
X-Google-Smtp-Source: AMsMyM5O8JcM4CyZxCkDVh+BG0rTbdeODRB2d65VcJV85tAytjVBYlDLwxlxRX9CAGf7wF0KQWfjAw==
X-Received: by 2002:a17:907:c27:b0:7ad:be77:561e with SMTP id ga39-20020a1709070c2700b007adbe77561emr42798233ejc.314.1667832095505;
        Mon, 07 Nov 2022 06:41:35 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id s8-20020a056402164800b004642b35f89esm4363534edx.9.2022.11.07.06.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 06:41:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os3Je-0007kj-1j;
        Mon, 07 Nov 2022 15:41:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 2/3] notes.c: fixed tip when target and append note
 are both empty
Date:   Mon, 07 Nov 2022 15:40:03 +0100
References: <cover.1667828335.git.dyroneteng@gmail.com>
 <5dbe014a09cca6ffa01dc9f61d0ddc095d31d518.1667828335.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <5dbe014a09cca6ffa01dc9f61d0ddc095d31d518.1667828335.git.dyroneteng@gmail.com>
Message-ID: <221107.86cz9yx1wh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, Teng Long wrote:

> From: Teng Long <dyroneteng@gmail.com>
>
> When "git notes append <object>" is executed, if there is no note in
> the given object and the appended note is empty, the command line
> prompt will be as follows:
>
>      "Removing note for object <object>"
>
> Actually, this tip is not that accurate, because there is no note in
> the original <object>, and it also does no remove work on the notes
> reference, so let's fix this and give the correct tip.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/notes.c  | 17 ++++++++++++++---
>  t/t3301-notes.sh |  3 ++-
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index f0fa337e8c..02b88e54d8 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -567,9 +567,15 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  	struct notes_tree *t;
>  	struct object_id object, new_note;
>  	const struct object_id *note;
> -	char *logmsg;
> +	char *logmsg = NULL;
>  	const char * const *usage;
> -	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
> +	struct note_data d = {
> +		.given = 0,
> +		.use_editor = 0,
> +		.edit_path = NULL,

Most of this is an unrelated "use designated init" cleanup, which is
good, but let's do that in a different commit if we need it. And then
you can drop all of these...

> +		.buf = STRBUF_INIT

...and only need to keep this one.
