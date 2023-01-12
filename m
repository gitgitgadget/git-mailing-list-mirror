Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2644C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 09:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbjALJ4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 04:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjALJzO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 04:55:14 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F655DF1D
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:52:40 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id u9so43463092ejo.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nMgTl9j+A8WrwrrRoZLIRAb6KHTE5pAl8JPmqX3bciw=;
        b=m9GDj8tD1545VtEbjaAay0Aqz1r+ZuFAT1W2GlFopX+uTvb3/vwlIna7Es+ImZO9dW
         qHIYdaVy9EHtbfAnITpVDWL3PKiBBUjC17tqc17xD/wTg++KlkkLWTLxBe29jE+w0Cx8
         N0CueYTjz2y3zsJHiLj95zsAoVTW45jaAxyCoIgQzGwZ9XAOh+4vqB5y/H0Pfv2QcJKX
         Qsxwt6j4iwqFMRGjPE2cw9g1k1A1yJwOaWji5KFvGGQfxwRU0dYJI8kurh5rgchh3f6i
         0nX8wrFAzrH24FP7lGC9HyW88w6OKvnsYuZ42ckRibNa7fwpqLOqmmYgb/+4+gvtPCa2
         4quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMgTl9j+A8WrwrrRoZLIRAb6KHTE5pAl8JPmqX3bciw=;
        b=60UfH0y500Ya8ims5u1T+oPcZihqucOgQyqs+T9FEkzONb9vpT9yim8S9n6IGbNlGL
         DY5YU0emzWQgm+8EaAEun/5drMU+TCXkmoiNXR7/1lOaYLgJwsjIaLIfHkxf5fYehbNM
         B9CYbYoRldcYMIgwsjr4EMGqU5mT0C2qz4qVrn+qgbOVNQN/CHQfZONLJNUMqs4OYEzn
         n+m+YQwCvkjyyxMBNIWDT2WQ8exnCSicFmeTaxZq6FkNgoOAFNqaGRn+YOQFWgIM7kPV
         IQNhETltUp1cCxMEP493PFmN9VSbeiEYNWr0ANHlenq4Kwxl71c60HeuwfPFObDVaTkf
         7/GQ==
X-Gm-Message-State: AFqh2kpDUzmUymFBlCSZxfmvgYhBeRG0hi2UMMc3zHdYfE1EM4tKSalC
        xmHPKf5kpfNW52Ayvts+N3MtOJHNojA=
X-Google-Smtp-Source: AMrXdXtkuqjRIsdEoQTLVUeV4qLE2xnMFSRMwbCDm9FrgzrupPLudPShUhkIznbKEHyLWqT8Gn5maw==
X-Received: by 2002:a17:906:f19a:b0:860:2150:a298 with SMTP id gs26-20020a170906f19a00b008602150a298mr5381055ejb.56.1673517158988;
        Thu, 12 Jan 2023 01:52:38 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ov38-20020a170906fc2600b0084d4733c428sm4772165ejb.88.2023.01.12.01.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 01:52:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFuGE-0006y6-0H;
        Thu, 12 Jan 2023 10:52:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v4 4/5] notes.c: provide tips when target and append
 note are both empty
Date:   Thu, 12 Jan 2023 10:52:01 +0100
References: <cover.1673490953.git.dyroneteng@gmail.com>
 <d41ba140505aa3459330afd652ff6a0f456222a0.1673490953.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <d41ba140505aa3459330afd652ff6a0f456222a0.1673490953.git.dyroneteng@gmail.com>
Message-ID: <230112.86358g2i6x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 12 2023, Teng Long wrote:

> From: Teng Long <dyroneteng@gmail.com>
>
> When "git notes append <object>" is executed, if there is no note in
> the given object and the appended note is empty too, we could print
> the exact tips to end-user.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/notes.c  | 5 ++++-
>  t/t3301-notes.sh | 5 +++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index b71a81bff1..f2efb3736c 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -631,7 +631,10 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  			BUG("combine_notes_overwrite failed");
>  		logmsg = xstrfmt("Notes added by 'git notes %s'", argv[0]);
>  		commit_notes(the_repository, t, logmsg);
> -	}
> +	} else if (!d.buf.len && !note)
> +		fprintf(stderr,
> +			_("Both original and appended notes are empty in %s, do nothing\n"),
> +			oid_to_hex(&object));

Style: This arm should have {}-braces too, see the CodingGuidelines.
