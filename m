Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ACCC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 11:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiGOLBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 07:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiGOLBe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 07:01:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0A186891
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 04:01:33 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k30so5803604edk.8
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 04:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=5eoj/uVgCwtaQoYerGXczC90ewpk3CDrdvGeb4XnMXc=;
        b=ITw3xaBjkDg8I8kmleD6+I9O79ICo3/0gJ14LE1ahzzDfCjN60eEob/co9Ngsubpj2
         nQSuztPlWLnt4WRFbQqUMNlw8AbyaN7/q0Sp2sSCwX+3lX9JaXH85bNiRNocV5dqny9U
         FvKaLakHxP3HLuw2O/jEKj8xjrCkKsFkOmFW/U++8TkOudYjl3ii4wkGt5ahocULk9fa
         hnMRE8e2pGJj98VrH9QZwIE9XvAdybwe3+MOUDF6D/XMr2L/3cT0ox2dnJ9l73KJjbya
         HccaPpOmAUxRYAgKy1jWa7L2VLUrew3/vovv4TYLiL9BaP5Jj88ApikRr4iEvNKqTkwr
         9KCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=5eoj/uVgCwtaQoYerGXczC90ewpk3CDrdvGeb4XnMXc=;
        b=X7z1gPfM3LlWe53VFxEM/8AkPpJMkarBQzuwZA+6KjlhRyFwvOLk4gqpvL12DiMeCX
         br+3CfwSuTBgvlQkB5Pmx92mLWW9/tSgavA8xn/Goq91M700erDwkATbWgixirU+r9xK
         fz09AoL3CEhVBMTbpxQxp/2HGdmwZeFsKthHPN214hFnwvQZr9g8Z93QvKf2zX42pIo/
         ziGutucthaYS1JNpYF+6enatttkj/aL2b5qh/jYmm2pblhST6t32hXZ4OoAoUNmAGc4g
         xK5kPKiha5itfoIwti7Ryy2LSZuOpj7dJ/LAUtc9EV2F1WnT4qENDQTN3GbLwuk+wMB2
         lLxQ==
X-Gm-Message-State: AJIora9Y2v36iYZ8+BI+SHVVmwrzCTJVJuH6XajcswOWpXVgJuYQyb5n
        rN45KO1CJGcEEtZ1WpFGBl4PD/51LaCkig==
X-Google-Smtp-Source: AGRyM1tMMbS2dLw52z0oXK6kV+Cp/edIEO5rdL5FNyWrngYv7RGHDD0ghrIkClW4GHYNgOlxX8pV5A==
X-Received: by 2002:a05:6402:3488:b0:43a:e33d:7d26 with SMTP id v8-20020a056402348800b0043ae33d7d26mr17939737edc.279.1657882891453;
        Fri, 15 Jul 2022 04:01:31 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a9-20020a05640213c900b0043b0951f7b1sm2653279edx.41.2022.07.15.04.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 04:01:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oCJ4b-002fbF-Nn;
        Fri, 15 Jul 2022 13:01:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/3] Documentation: remove use of whitelist
Date:   Fri, 15 Jul 2022 12:47:48 +0200
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
 <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
 <19632a2d2459114484dcdaddd4db0d22dfd64fa7.1657852722.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <19632a2d2459114484dcdaddd4db0d22dfd64fa7.1657852722.git.gitgitgadget@gmail.com>
Message-ID: <220715.86sfn2zlkm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 15 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index fdc28c041c7..7a0539cb411 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -32,8 +32,8 @@ that service if it is enabled.
>  It verifies that the directory has the magic file "git-daemon-export-ok", and
>  it will refuse to export any Git directory that hasn't explicitly been marked
>  for export this way (unless the `--export-all` parameter is specified). If you
> -pass some directory paths as 'git daemon' arguments, you can further restrict
> -the offers to a whitelist comprising of those.
> +pass some directory paths as 'git daemon' arguments, the offers are limited to
> +repositories within those directories.
>  
>  By default, only `upload-pack` service is enabled, which serves
>  'git fetch-pack' and 'git ls-remote' clients, which are invoked
> @@ -50,7 +50,7 @@ OPTIONS
>  	Match paths exactly (i.e. don't allow "/foo/repo" when the real path is
>  	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
>  	'git daemon' will refuse to start when this option is enabled and no
> -	whitelist is specified.
> +	specific directories are specified.

Structurally this series should be changed so that like changes are
coupled together, this would be much easier to review with the daemon.c
changes in 3/3.

But that also shows that this change is needed, but really lacking
compared to what we could do here, which is that both the the SYNOPSIS
and the heading here should be, respectively:


    [--strict-paths=<path>...]

And:

    --strict-paths=<path>...:

I.e. all we're trying to get across here is "this option has a mandatory
argument", so let's just say something like that explicitly? I think in
this case we don't need the prose at all, the synopsis + heading + error
would be enough.

More generally: As I noted on v1 I think the underlying motivation for
the series is mistaken, but I'm also happy for any excuse people can
find to improve our documentation.

But as I pointed out on your similar earlier series to expunge gendered
pronouns from the docs I think best practices in our docs just happen to
align with what you want.

I.e. in that case we prefer a style that isn't introducing "actors"
anyway, so even without that motivation the prose could be improved.

And ditto here, I think the use of the term "whitelist" is fine in and
of itself, but in this case we can clearly improve the docs anyway.

I just think that the origin of the change really shows in this case, I
haven't yet reviewed the rest but suspect I'll find something
similar. I.e. there's a clear improvement to be made, but since it was
first made with s/whitelist/allowlist/g, and now an attempt to
s/whitelist//g in some form we lose sight of the larger picture.

Which in thihs case is that perhaps the sentence isn't needed at all,
and that the synopsis & title is the real thing worth fixing.

So, if what motivates doc improvements in your case is working on your
local dictionary black^Hdenylist :): great, we can probably improve our
docs in any case. But please spend a bit of time eyeballing the change
without an eye to that motivation, sometimes we can improve it much more
without much effert...

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 302607a4967..dd5061563eb 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -886,8 +886,7 @@ for full details.
>  	`protocol.allow` is set to `never`, and each of the listed
>  	protocols has `protocol.<name>.allow` set to `always`
>  	(overriding any existing configuration). In other words, any
> -	protocol not mentioned will be disallowed (i.e., this is a
> -	whitelist, not a blacklist). See the description of
> +	protocol not mentioned will be disallowed. See the description of
>  	`protocol.allow` in linkgit:git-config[1] for more details.
>  
>  `GIT_PROTOCOL_FROM_USER`::

I agree with Junio's earlier feedback about "in other words" being a
telltale sign of prose that needs improving.

But the point of the previous prose (such as it was) was to elaborate on
th existing "allow" to say "oh, allow means the same as whitelist",
surely?

So I think we really could just delete this "in other words" entirely,
i.e. it's basically saying "you are allowed to eat ice cream (in other
words, you are not disallowed)", it's not adding anything anymore. The
"(...)" can just be removed.
