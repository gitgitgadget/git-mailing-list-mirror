Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C983C433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 03:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1098964E1F
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 03:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhAaDfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 22:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhAaDfq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 22:35:46 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AB0C061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 19:35:06 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 70so10436119qkh.4
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 19:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qr1+AX34/Ys3Ckax2EMKqXFeIDgTlDHBsQHSWF6O6OY=;
        b=aunO7WG9c67ppgyJxX72g43ml/UNx4LXMpQqPZTJ8cRAmepgYxlh4Kv5Q+Veo1IXwD
         6gjz/DBNC7qCgvj3iG0IS/mQCkSygGtSZgbD5InyNgBStoc9lIjR/Jlc0gXBTx/CSwI7
         B9+cvlel8sSq0Sr7nGMKcmNRRjD6UHDTAunOjiz3IJ8A47fGHYFDopKQVC3iDB1qAGfp
         5RUlFfeV80c1PNYlNyN07ocq5hnI6nR3EwxQT+5cBsL8GdClq8OjdWqGoDU5iuJxKqKx
         +Uh+APo9/YCo/+Stng8fvaktLD1YsXjHfFBZV+CBgKDfMxJbvSfo7LjX8u9ZbFSiC6tT
         zhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qr1+AX34/Ys3Ckax2EMKqXFeIDgTlDHBsQHSWF6O6OY=;
        b=tnskA6NDPpS1B2t9nytn6l578ih3g1VmaQqo8UKmAZ6xPiyedKGUM/eVA2x8LU68r4
         8JxgNnoHFdq9mZj85K/AoMJ/WvNGehVUFLe0UAx9zG9MT25EG7q8cPFiNH+xaa1xVtur
         5X9axtziOY4hvA8lDQ1WrjW7nUmQldfC50v49jaZhyisC2mJ0DW0t2i89vfBZwmovLin
         wji+1omiJQLZ05NbeIqiM/RB4UKCYKkg+5HkWgFlaqyV5hsXCT5Yy7o9Lt6BxCKKmPkj
         FBZ+IfMgM5KEmCJ3GxZQexXzA6H3KBdiLasRGEBgb0MU66h2a6G9TJsFkqgrF97/UdRo
         5QRw==
X-Gm-Message-State: AOAM532C+J60bwp374JPBhqwrrWf25PC1yKUpRZ6hy20gHMlEgvOq04b
        EhJGVj7Mh0XPJ1zvE/YnYrZFjepeZ4L8bgkIJany
X-Google-Smtp-Source: ABdhPJwlnmjxm7neq8Q0lhbnZO/Wd1gEgkxaI0oDcFShVim2vqx/iD7V/5OKJ5Ybs1BfGxNC3TEQ0ko+bGv3UJoKUK72
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:c3c9:: with SMTP id
 p9mr10141795qvi.49.1612064105259; Sat, 30 Jan 2021 19:35:05 -0800 (PST)
Date:   Sat, 30 Jan 2021 19:35:03 -0800
In-Reply-To: <20201222000220.1491091-6-emilyshaffer@google.com>
Message-Id: <20210131033503.1022138-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-6-emilyshaffer@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v7 05/17] hook: respect hook.runHookDir
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Include hooks specified in the hook directory in the list of hooks to
> run. These hooks do need to be treated differently from config-specified
> ones - they do not need to run in a shell, and later on may be disabled
> or warned about based on a config setting.
> 
> Because they are at least as local as the local config, we'll run them
> last - to keep the hook execution order from global to local.

This commit message doesn't seem to match the code change. Firstly,
we're teaching hook.runHookDir, not respecting it (since it did not
exist before this commit), and it's about showing it in "list" and not
about running it at all.

Perhaps just "hook: teach hook.runHookDir" as the subject and as the
body:

  For now, this just affects the output of "git hook list". In the
  future, this will affect the behavior of "git hook run" and when Git
  runs hooks before or after its operations.

> +	switch (should_run_hookdir) {
> +		case HOOKDIR_NO:
> +			strbuf_addstr(&hookdir_annotation, _(" (will not run)"));
> +			break;
> +		case HOOKDIR_INTERACTIVE:
> +			strbuf_addstr(&hookdir_annotation, _(" (will prompt)"));
> +			break;
> +		case HOOKDIR_WARN:
> +		case HOOKDIR_UNKNOWN:

Hmm...UNKNOWN is the same as WARN? This doesn't agree with what is said
in patch 1:

  +In case this list is expanded in the future, if a value for `hook.runHookDir` is
  +given which Git does not recognize, Git should discard that config entry. For
  +example, if "warn" was specified at system level and "junk" was specified at
  +global level, Git would resolve the value to "warn"; if the only time the config
  +was set was to "junk", Git would use the default value of "yes".

But having said that, I would prefer if Git just errored out in this
case.

The rest looks good.
