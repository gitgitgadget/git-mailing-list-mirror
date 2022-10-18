Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1965C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 12:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJRMZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiJRMZx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 08:25:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3B5B1DDB
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 05:25:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b2so31769297eja.6
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R8iZTKI8neWHAFsMLUiRDk4t0hM3z8vrK8QdgAsLWMw=;
        b=hdSniGOvue5DRNyeMEW1HD05AUClXyH8Q03T3nMHdoUkPfcgOvKp2w5u9gqvJTH1L+
         4depzRVVgPdrEhEEQ7dvgTpnuhwoIc1qJdxCAvw2kiYnMo9nilefR4Yb4A7/StZ/EDdT
         ZUgRoAG7+hp1xV/YgRn6GbICtNl+V6HtHsZv80GzqT13JnEY+HmLmi4wJE07hLYtd1ET
         tgZ4VFJ8DWalOmcveWnqxPf/CIirzVi0e8ysEdRNwZNxDUkYAzGnAKErIrgrHjfsaGJW
         RWw/ODmwIPmvnC2lMZaglC+g3diPDl1IVJ9GtYKOhE0tz7dD3lGEpYByl5jo6iuW2LNB
         Tsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8iZTKI8neWHAFsMLUiRDk4t0hM3z8vrK8QdgAsLWMw=;
        b=5F43YKyRtRFOCv89thXGtW3FvhYuWlblsbQQOmHGDI/SDQEhPevUm8PkU7B/kF/Guw
         byS4x0iEeIvbsg146zOue10V2lqT8qLuvRkKGV/B1/CbO6YnrdrfYfzfw4fWiVRb8+Rt
         9ODKOZgEqCZ/5cnhQzWVnWLdz73Eg+NT71Qd0lJPP6NraEfzaCe4JsXVOCk8hzs1lN6u
         Dgph28B+erAlYWAylX/c0tX1gQAQXFaLzqZmpEmcSNYPBJRaJrsjoE6X13kIgohw5RE2
         fGC+6jxJLyAhWwLA4MBiTnuLk6iTpPlFV5vaGxMO4qdy3eiNBO4F/+DKb1g3C9MvkUFx
         E4eQ==
X-Gm-Message-State: ACrzQf1Qj/C/h+lk2SYTmkjZUebItrlN1tShNuKq4uE2oQFalDabi9H/
        Lk1Rprrleulyi77xppI100X53JlyBf8Zew==
X-Google-Smtp-Source: AMsMyM5rFUIFd+WP9Wj7vkhmdNSHu9aIKeT/B0mnJxhH52sbF09jXRXq45oKB+tOaBzu4iQxLxCVGA==
X-Received: by 2002:a17:907:7e87:b0:78e:2dc3:945 with SMTP id qb7-20020a1709077e8700b0078e2dc30945mr2227943ejc.326.1666095949760;
        Tue, 18 Oct 2022 05:25:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l6-20020a1709062a8600b0073d796a1043sm7401567eje.123.2022.10.18.05.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:25:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oklfI-005jUV-0Z;
        Tue, 18 Oct 2022 14:25:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 02/12] fsmonitor: relocate socket file if .git
 directory is remote
Date:   Tue, 18 Oct 2022 14:12:57 +0200
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
 <21d114bda4b515170ae43f01f9bb14befec611f2.1665783944.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <21d114bda4b515170ae43f01f9bb14befec611f2.1665783944.git.gitgitgadget@gmail.com>
Message-ID: <221018.86v8ohiaib.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 14 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
> [..]
> +const char *fsmonitor_ipc__get_path(struct repository *r)
> +{
> +	static const char *ipc_path = NULL;

Urm, I see some of this interface made it into master already with
6beb2688d33 (fsmonitor: relocate socket file if .git directory is
remote, 2022-10-04), but this is just weird. We already have "struct
fsmonitor_settings" which "lazily loads" these various settings.

So e.g. in refresh_fsmonitor() we might get the hook path, which we
"lazy load" and cache there.

And here we have an extra layer of another type of lazy loading, and
this will e.g. be called from fsmonitor-settings.c.

Is there really a good reason for why the relevant codepaths can't
either not-lazy-load this (e.g. when we get the socket), or why we can't
just use fsmonitor-settings.c's existing caching?

Just wondering...

> +	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
> +
> +	/* Create the socket file in either socketDir or $HOME */
> +	if (sock_dir && *sock_dir) {
> +		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
> +					sock_dir, hash_to_hex(hash));
> +	} else {
> +		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
> +	}
> +	free(sock_dir);

Instead of this init sock_dir to NULL & then check if it's non-NULL
etc. Just do:

	char *sock_dir;

	if (!repo_config_get_string_tmp(r, "fsmonitor.socketdir", &sock_dir) &&
	    *sock_dir)
		...
	else
		...

Note also the *_tmp(), then you won't have to free() it.


> +
> +	ipc_path = interpolate_path(ipc_file.buf, 1);
> +	if (!ipc_path)
> +		die(_("Invalid path: %s"), ipc_file.buf);
> +
> +	strbuf_release(&ipc_file);
> +	return ipc_path;

Why can't we just do something more simpler like this in the *nix case?

I think because you're creating this socket for a NFS-mounted repo, so
of course we might have multiple clients.

But you also seem to be making it "unique" by hashing r->worktree, which
is the path to the repo work tree. At least in my use-cases for NFS
mounted repos (which have been limited) all of those paths would be the
same for me across my systems, because I'd have them at
/home/avar/g/some-git-tree/...

In builtin/gc.c we create a "unique for system" lock file using
xgethostname(), isn't that a lot simpler & closer to what you actually
want?

In any case, some details about motivations, why etc. are sorely missing
in the commit message. We can see *what* you're doing, but not *why*, or
what other simpler solutions etc. might have been tried & dismissed...
