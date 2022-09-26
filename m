Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB28C6FA82
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 16:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIZQiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiIZQia (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 12:38:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAED6130700
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:26:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sb3so14827783ejb.9
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=UVWo9N5ApWFQNoThECwzfTpgw/vzxqIQ57Boclujs0I=;
        b=QvJ84JFJf6SynobK5jUwlmHN4MjNuYdeKNWhNxI3Vpl5nPacSTaQ+jZn9ldleSNvib
         02ewJin0HNq0nFUEHDGy9GLoUo2PFkpwMauKssiMyhullHPXB40vX476NmnlsOmCMCA5
         fwSKqWLPcaPEzPR5WvxWfqmuICNXI/Wux3cZ+wn9+jv45NhlFte1amYkOZ+h5P4+K6nX
         LhPDeA+ACURofXjS/p9jAb4u24wOatnJeBI2GKDVkGW/H3PRpLq9vyyMp/994I7eTbst
         ByggP+6k4auPWb+Swz7NU4B4QoA9JHGCxfyASKjPlXpGwATWQ+OL5ep1dO3hIkW28dAf
         XTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=UVWo9N5ApWFQNoThECwzfTpgw/vzxqIQ57Boclujs0I=;
        b=ag2lZ/yK2O0s/fZKOkqxm5yyuVNlyiYRy7wdL38zwFq6vE92imq6Dj1xx0YZUlAOMc
         2wBPSz3ETt2M4m0bdgGuVTsF9LLd262cRv+yWITob4LdAdmU5T62/Qm+RNIWQKwLXDmP
         NbjzPB1ygRn46qH9I0XL58ipdOVKLnW7BhHQj2+ylGJ1Qz4++4C/QHa7yADc82eivlNn
         gFJ/12qALT1WsMjUA/p80/6djTpM5CX66B+cQfzxWGcCowwOClizo7eo23bWIH+UVFAE
         H2oRwbbD20ts2/8bnFy+edMuWmw3KnpZIBoWYBf83Hc7LjvbRyT8DwNtc33HA9CTHNnb
         dizw==
X-Gm-Message-State: ACrzQf3aOlL5aKosk6GwI5GhjblGmmqCZQ73X0DzxMk8OhHwxVC2h+79
        vfQM5AkIy0AtLjlKR9CwgT3saE5izY8=
X-Google-Smtp-Source: AMsMyM7rD+foRWveF8yeqYa/jGeJ9HWJAN9PEtdqoKwdNJ4ooJbTgHJ+fqgTCSYVHFyS/zoHGMTixA==
X-Received: by 2002:a17:906:974f:b0:780:4a3c:d179 with SMTP id o15-20020a170906974f00b007804a3cd179mr19093491ejy.289.1664205951833;
        Mon, 26 Sep 2022 08:25:51 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id m2-20020a170906234200b0073d753759fasm8477064eja.172.2022.09.26.08.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 08:25:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ocpzS-000AIa-0y;
        Mon, 26 Sep 2022 17:25:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v12 5/6] fsmonitor: check for compatability before
 communicating with fsmonitor
Date:   Mon, 26 Sep 2022 17:23:56 +0200
References: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
 <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
 <421d77775dc24e52ab26336a1a82ed0e7b15ff5a.1664048782.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <421d77775dc24e52ab26336a1a82ed0e7b15ff5a.1664048782.git.gitgitgadget@gmail.com>
Message-ID: <220926.86v8payx6p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 24 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
> [...]
> @@ -281,9 +283,11 @@ char *fsm_settings__get_incompatible_msg(const struct repository *r,
>  		goto done;
>  
>  	case FSMONITOR_REASON_NOSOCKETS:
> +		socket_dir = dirname((char *)fsmonitor_ipc__get_path(r));
>  		strbuf_addf(&msg,
> -			    _("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
> -			    r->worktree);
> +			    _("socket directory '%s' is incompatible with fsmonitor due"
> +				  " to lack of Unix sockets support"),
> +			    socket_dir);

Could do with less "while at it" here. We are:

 * Wrapping the string, making the functional change(s) harder to spot.
 * replacing r->worktree with socket_dir
 * Adding " support" to the end of the string, and replacing "repository" with "socket directory" 

AFAICT the continuation of the string isn't indented in the way we
usually do, i.e. to align with the opening ".

