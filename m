Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F99C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 10:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhKWKyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhKWKyG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 05:54:06 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA925C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 02:50:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w1so90354099edc.6
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 02:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=+sEkBKGe1we2rDd/+i36JECRC3hZ4xhNYHWPP8KLZfU=;
        b=g+Ez4DoO9HFaTtLCkgK8T+GILJUQGe02g1zDltIlzpsNOFpMTZUIoRAWxthfpXRXYS
         jVSL3KXu7R0zYcsPFhIw/BNEcAAwKQh1W9elLfRPcb0o2g3z+FsJEHKs//rNp9qsNwWd
         7OplCmsXk+6XQ4o+4toeKUgMtFdhk9ITOc2AXf0oco2+5MD8siudWP5B1YgvgtkHBDfR
         2aD2fmhY1W/GzmqgqVAhn6fqLWGjBXlZjC+jn4yzhl6SBe0sztsnCC8C8lj6Y/RhEyvO
         zjUg+TzuiBooEXMsamgioUh0rjpB8/HiMG06Op21+EQR0xisHNC7T6F7A4p5Km5WP4W4
         F7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=+sEkBKGe1we2rDd/+i36JECRC3hZ4xhNYHWPP8KLZfU=;
        b=6SuPacnou/tmLhMzOBf+9zPM3ThFA+EP1li/0iRoQKPBc66QDA8EmjTAjeObXNslwP
         mkvVhR1rb1aLOekDdCH0U6ExER14xbBNowhvrgi9vXb8SLAteyrMjch5R4ouvgU9Q5or
         YwaCSnnb0/u2+jK97oZyzqHwsA/yoEyGQEym5BCFeJCF23i7HZPDakxXfujs2q+xA0rH
         E/Uo6vktap1qGUEaTiMfI6nYqKs+BQ1+2oGxEdjzWZ1PHJBrEln3slNr/lXDw9X18cdb
         NLJq++fUx+VcgaOLsHdcUZTsDeTGsaZ01b/uDi8BtG8yIB7eXPFqQVQWUIvpqU2TMyTJ
         m16Q==
X-Gm-Message-State: AOAM530Ldcke2AHX1dLq3zYt09CahsGV7GVLR/uB12h7VeihyuoAmrmg
        wR/gCl4iG/S6opGOnCAJ5bJp6kABjbpqRA==
X-Google-Smtp-Source: ABdhPJwoyZP1RRiw0gK0Rc8ho3su3oxJeUPb/yUOX20WcrM6Oa63/wI+y+liJl/XViVweKQsaVHQtw==
X-Received: by 2002:a17:906:5d0b:: with SMTP id g11mr6220764ejt.295.1637664657181;
        Tue, 23 Nov 2021 02:50:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d1sm5810563edn.56.2021.11.23.02.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 02:50:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpTO4-001K45-5h;
        Tue, 23 Nov 2021 11:50:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 4/4] branch: add --recurse-submodules option for branch
 creation
Date:   Tue, 23 Nov 2021 11:45:06 +0100
References: <20211122223252.19922-1-chooglen@google.com>
 <20211122223252.19922-5-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211122223252.19922-5-chooglen@google.com>
Message-ID: <211123.86v90juovj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Glen Choo wrote:

>  	submoduleAlternateErrorStrategyDie::
>  		Advice shown when a submodule.alternateErrorStrategy option
>  		configured to "die" causes a fatal error.
> +	submodulesNotUpdated::
> +		Advice shown when a user runs a submodule command that fails
> +		because `git submodule update` was not run.
>  	addIgnoredFile::
>  		Advice shown if a user attempts to add an ignored file to
>  		the index.

Does it need to be submodule*s*NotUpdated? I.e. the existing error is
submodule.. (non-plural), and we surely error on this per-submodule? The
plural would make senes if the advice aggregates them to the end, let's
look at the implementation...

> [...]
> +	for (i = 0; i < submodule_entry_list->entry_nr; i++) {
> +		submodules[i] = *submodule_from_path(
> +			r, &super_oid,
> +			submodule_entry_list->name_entries[i].path);
> +
> +		if (repo_submodule_init(
> +			    &subrepos[i], r,
> +			    submodule_entry_list->name_entries[i].path,
> +			    &super_oid)) {
> +			die(_("submodule %s: unable to find submodule"),
> +			    submodules[i].name);
> +			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
> +				advise(_("You may try initializing the submodules using 'git checkout %s && git submodule update'"),
> +				       start_name);
> +		}

Uh, a call to advise() after die()? :) That code isn't reachable.

It would be good to add test for what the output is in the next
iteration, which would be a forcing function for making sure this code
works.

One thing I find quite annoying about submodules currently is the
verbosity of the output when we do N operations. E.g. I've got a repo
with 15-20 small submodules, cloning it prints out the usual "git clone"
verbosity, which isn't so much when cloning one repo, but with 15-20 it
fills up your screen.

Operations like these should also behave more like "git fetch --all",
surely? I.e. let's try to run the operation on all, but if some failed
along the way let's have our exit code reflect that, and ideally print
out an error summary, not N number of error() calls.

That would also justify the plural "submodulesNotUpdated", if such an
advise() printed out a summary of the N that failed at the end.

