Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E638DEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 22:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjFZW4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 18:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjFZW4j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 18:56:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1924F10CB
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 15:56:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c17812e30b4so2959998276.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 15:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687820193; x=1690412193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DWzpeKVvZvAsLpMc7Q/CtGpAgAt5tiHivr8hS1HZVNw=;
        b=Um2Pl6f7YwlBA6HfsdmhVEj5nE9D3xCNg/5zD4QzJfPgEQsWjTDazjIcVrFp40ruuq
         Xh3zHE/yAbV5E0I10rlkLBlNl5PnaIGpXB8viUipwggQs/a8ea7GlmsErYC0XeXuBHgg
         wFUKg+W1nIilLWjEwr38PkFiRTbnFPhcnZnYiE5pRLC4xxoX0fKVZZb+1WrbnZ7jEolf
         wippQcqWg4JXR7pw3Zx9P7xYbPBkrwgEtGysf1Lk0xJM0ohLnJefN+L6/SSr6+9tCoTW
         1ILBVSJgpgKfR81SG50p+lmwv6SxoSKb5wuS4U8Y9ggkHhAWvWLK1uIAhzp92jopaVdJ
         Yhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687820193; x=1690412193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWzpeKVvZvAsLpMc7Q/CtGpAgAt5tiHivr8hS1HZVNw=;
        b=Zwg1vpSld0PAVW5ZwN4Qpqk+6IkxbuBXOrYcTwDUGL2dubnTu1O+6LG8GknB/7ctA4
         RQf+U0mzX7Fv4F6hkfP3l277uUfrhVACTjaPYGOgIEJF/FGTQUzgvkDKQcrqjHeGZlns
         szHleFRWn+6zXjenqKoHafC14uUcyPaJXs1IJvlKJ6LAFPY17jszcCOu0hZf98cY5b0w
         DktRaCqZm6MiTZKFVyGQmQJ4bh9coJMQo1gNIRzswX9b2QpvWTKLCt7pMqHucfzScFcZ
         jxoA87LmlNITvnhpHVq2R/N+rbrp2ZrA0wK+pcM76hmG4XUohvK5AkQQ+sYn0pp8MGnJ
         YC3A==
X-Gm-Message-State: AC+VfDxGHce6nzBE75r5YSL8zjny3Bb1qtH1oKAFKa4zMzf+ZP/fGjed
        pB7kN+syR6XxwiqirNSTYu2NRW4qvdJZ0Q==
X-Google-Smtp-Source: ACHHUZ45VWNv0W+fFCgj8w3RvPs/Ge9S3U0bNsGjf3eb89kWBvymvNGynQzOMgjhyNtGtyvB2DWPNGRjLkbgEA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:b13:b0:c17:4115:620a with SMTP
 id ch19-20020a0569020b1300b00c174115620amr2097837ybb.11.1687820193341; Mon,
 26 Jun 2023 15:56:33 -0700 (PDT)
Date:   Mon, 26 Jun 2023 15:56:31 -0700
In-Reply-To: <xmqq352e59h9.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1535.git.git.1687801297404.gitgitgadget@gmail.com> <xmqq352e59h9.fsf@gitster.g>
Message-ID: <kl6l7crpsuhs.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] config: don't BUG when both kvi and source are set
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jesse Kasky <jkasky@slack-corp.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Therefore, fix the bug by removing the BUG() check. We're reverting to
>> an older, less safe state, but that's generally okay since
>> key_value_info is always preferentially read, so we'd always read the
>> correct values when we iterate a config set in the middle of a config
>> parse (like we are here).
>
> I wonder if the source being pushed and config_kvi value at this
> point have some particular relationship (like "if kvi exists, the
> source must match kvi's source" or something) that we can cheaply
> use to avoid "reverting to an older less safe state"?

Not at all. In this case, the source should reflect .gitmodules, but the
config_kvi should reflect the promisor config (aka the full repo
config). config_source implements stack semantics, so we could co-opt it
by e.g. converting config_kvi into a fake config_source and pushing it
onto the stack (at which point, we could just get rid of config_kvi
altogether too), but that's really way too much work for something that
will _hopefully_ go away soon.

>> The reverse would be wrong, but extremely
>> unlikely to happen since very few callers parse config without going
>> through a config set.
>
> Sorry, but I do not quite get this comment.

Ah, I meant that this bug occurred because most users of config use
git_config()/repo_config() (a wrapper around config sets), so it's very
easy to accidentally read repo config, e.g. in the middle of parsing
config (config file -> config set). I'd imagine it might also be quite
easy to read repo config while reading repo config (config set -> config
set), which would make current_config_* return the wrong thing, but at
least it doesn't BUG().

The "reverse" case (config set -> config file) is very _unlikely_
because very few places need to know about config files, so it's
unlikely that we'd have an explicit call to parse a config file,
especially in the middle of reading repo config.
