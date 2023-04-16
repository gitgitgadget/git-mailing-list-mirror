Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FAEC77B73
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 13:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDPNw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 09:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjDPNw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 09:52:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B430210E
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 06:52:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sz19so457339ejc.2
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681653139; x=1684245139;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TtwxYfNtCtw3imETzGCpcOTsf3reQDTJMQZOstCKCRk=;
        b=bCaD/Tz/g0bgA2Kk8vOBFodO0Ludy2UwT5aTavRP73prPPQ41NKEBNhyLfe0OxWjC2
         jNHDJHUFXNZ4F41pimyRuKS4pY3jWXenSFOnWNcCyASMaAbXXJG5k0qyBHLyB4Wj79PM
         3FXhEA1WNnD3aE5dWkOb1jDkpye5m3I5ZhP5XXiF+GzlJC8iYXin0S/dAPDPfzYFPXpo
         JbofU/JcSKrm93h4KccDM9gBXQ+L0oogDXoUom2VqAzcLWADTzHwlHYFSHmd1H17CD01
         fWQhjsJOm0dfffeDwhcBYxo4j3d58fzyYFmViyndiH2nfMensG47yOrFqGaYe5AfvPvl
         RHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681653139; x=1684245139;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtwxYfNtCtw3imETzGCpcOTsf3reQDTJMQZOstCKCRk=;
        b=CS6hpSGeY0bC4hj2VAQ1F7LfWNvATf8aAgb6Gqs2MPuCCNXas4brOX277wMe9grCfS
         CRNYp2BR0HRpAlggUVsEtzlsbJplfkh3eCupzvprO8AgzZHVflVZ/H96Cptwn9keN/ol
         OeKTjMv0kvLyuoe/zK32lwRo1L/tbEyO2vPwNdLPb7bmiBYgez77xWeW8j6+JJI5gZ4w
         C4xqj//T7z+kJgHpF3zURzFoYQWbTeHmt/kar9SXzAyrLjdNeEr5hQcNgsp7lTk+Myxp
         NtYLOsLGlwZ0J+vJpi52O7lF7s1X/+Krcxe9NDTAYQxef0oB4wzfr+Ru4G7PoOupunUW
         BHng==
X-Gm-Message-State: AAQBX9e7IS71xGaD2bfb4boqQuZ9uoKD8FwPuKXoGQCrB8zHxCvocBCE
        iJ4CURl2TR4eB+YL71TkK3yOhKXZroI=
X-Google-Smtp-Source: AKy350YX0C1qVtIsIl+JUYd/rzP3UI7r86bqrACrwcOw4oFO0PtSMATHbu8JNzvt+89WYu8DolJTxA==
X-Received: by 2002:a17:906:6d15:b0:94e:5708:a1f9 with SMTP id m21-20020a1709066d1500b0094e5708a1f9mr5323474ejr.39.1681653139140;
        Sun, 16 Apr 2023 06:52:19 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906314200b0094bb4c75695sm5040158eje.194.2023.04.16.06.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 06:52:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1po2ni-005d7B-0f;
        Sun, 16 Apr 2023 15:52:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 2/2] cocci: codify authoring and reviewing practices
Date:   Sun, 16 Apr 2023 15:37:22 +0200
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
 <75feb18dfd8af03f5e7ba02403a16a0ed4c2edaa.1681329955.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <75feb18dfd8af03f5e7ba02403a16a0ed4c2edaa.1681329955.git.gitgitgadget@gmail.com>
Message-ID: <230416.86mt38rl2l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 12 2023, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>
>
> This isn't set in stone; we expect this to be updated as the project
> evolves.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  contrib/coccinelle/README | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
> index 9b28ba1c57a..055e3622e5c 100644
> --- a/contrib/coccinelle/README
> +++ b/contrib/coccinelle/README
> @@ -92,3 +92,26 @@ that might be useful to developers.
>  
>     The absolute times will differ for you, but the relative speedup
>     from caching should be on that order.
> +
> +== Authoring and reviewing coccinelle changes
> +
> +* When introducing and applying a new .cocci file, both the Git changes and
> +  .cocci file should be reviewed.
> +
> +* Reviewers do not need to be coccinelle experts. To give a Reviewed-By, it is
> +  enough for the reviewer to get a rough understanding of the proposed rules by
> +  comparing the .cocci and Git changes, then checking that understanding
> +  with the author.

Maybe it would be useful here to add something about how you can
reproduce the application of the coccinelle rule(s).

I sometimes do this on an ad-hoc basis, something like (untested):

	git checkout HEAD^ -- ':!contrib/coccinelle' '*.[ch]'
	make coccicheck
	<apply any suggested patches>
	git add -A

Then see if I ended up with a no-op, or if there's suggested changes.

With changes that modify both the header & source files this can be
tricky with the default of SPATCH_USE_O_DEPENDENCIES=Y, but disabling it
will take care of any potential circular dependency issues. I.e. when
the header doesn't contain a required construct that we're replacing.

> +* Conversely, authors should consider that reviewers may not be coccinelle
> +  experts. The primary aim should be to make .cocci files easy to understand,
> +  e.g. by adding comments or by using rules that are easier to understand even
> +  if they are less elegant.

I agree that simple things should be kept simple, but this seems to come
quite close (or perhaps past the line of) suggesting that we use only
the simpler features of the language when a more elegant solution would
be available with something less well-known.

I think we should clarify that that's not the intent. Just as with C,
shellscript, Perl etc. we should aim for simplicity, but ultimately we
should expect that we can target the full available language available
to us.

> +* .cocci rules should target only the problem it is trying to solve; "collateral
> +  damage" is not allowed.

I think what you mean here is that you should be able to apply the rule
and still build the project.

I think that's correct, but I also think that rather than define this in
prose, how about we just modify the current CI job to apply the result
of non-pending rules, and do a build at the end? Wouldn't that assert
this going forward.

> +* .cocci files used for refactoring should be temporarily kept in-tree to aid
> +  the refactoring of out-of-tree code (e.g. in-flight topics). They should be
> +  removed when enough time has been given for others to refactor their code,
> +  i.e. ~1 release cycle.

Maybe s/should/can/? E.g. for my recent "index" and "the_repository"
patches I think they can, but we often keep unused code in-repo for
longer than that. If e.g. that code stayed in for more than one release
until someone cared to remove it we'd also be fine.

I also don't know if some long-running forks (e.g. GfW?) would benefit
from the rules for longer than that...
