Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0808EC64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 23:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjB0XU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 18:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjB0XUy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 18:20:54 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBED820680
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 15:20:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536c8bcae3bso172247807b3.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 15:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HI9pTaiyEdgIeWaFJdguJiLkwY+JUDt28+EdhLcniY0=;
        b=ZUVgv5bSOXHfyDtqQnsAyvPigc+E2iE/jOBobpQCT8jHMUcwviF5lMDedApQLC2fTx
         Hwx98OE6CYgFZdO4eHiuAt4FrRV2u++DUQTbyxTFK8+a8gp8ru2LN6b1ACgt75EcQlL/
         qbHk92ygco5xrm/VzRBbIsU7YY4KyizwJpB7AqF3QT8ddER3VBwEjkSEYBD4mmJItBW6
         7R1ww5Tq4CNgxxvsJ9LOi8HsWi9XpnZtbdx4XwV5oObpbHneXJ0F4J+jWt5Zavh3Jo0g
         WCqqQsvwOECP8R2qh4df1C40O5HKCGQS1lJE6vTGrDT4mx0tzKqLqbTy1Fk65nU4tYVY
         0GcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HI9pTaiyEdgIeWaFJdguJiLkwY+JUDt28+EdhLcniY0=;
        b=zDTVfLT+eEfwTSoFvXDGipfBPGM8QWvzcYr+WJEyJ2YrS4WLOHzA1kcWcQ114Ne2kx
         GdUb1XhMFmJU78jop+NjokRXh1PwFufZ4uc0Sz/r8EzR4Fv5uYcHoNfN7KNGOaPdfbXy
         PPPtlNEMQm38a61HvqWJc1TqkUI7Ti0f5QJrTStKt8is/elj40cYHRaOZH6HMx22hDo6
         tDM46d/CI5HDjcs71oburLneJH3jWmqQ9kcMP4yUubvqeCzLMJcjUzoG6aBZRXp3I92u
         DIHZsU/hNKjQBTkn5OLVoKluCuXTE0zZkR4iq3hiZf8vQFoD7zZd6VbQTbW5oPHhdjpb
         aRDA==
X-Gm-Message-State: AO0yUKVTh/JuW5lCRmhuyUDL4gEaQkXB0w28bVpnkBIeZMMIIrCEAyg/
        ghKk3kCmtHeHdWK8fwI8tAdmv6qBbzox81NENO7m
X-Google-Smtp-Source: AK7set8WgurfpHb6oZKaZb65Cp0oNRmzjdhW0KULLAXOQhUyL5gtp7ntJQsZrDFoiRHRqUk3V7VjkXXDYiTJwnP8erel
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:aadd:81fd:fdd5:bee5])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:158c:b0:8bd:4ab5:18f4 with
 SMTP id k12-20020a056902158c00b008bd4ab518f4mr8735644ybu.6.1677540050039;
 Mon, 27 Feb 2023 15:20:50 -0800 (PST)
Date:   Mon, 27 Feb 2023 15:20:47 -0800
In-Reply-To: <8ffdb6c8a8a3b162c898ba759137d41bbfd44b39.1677511700.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227232047.2441760-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 02/13] unpack-trees: heed requests to overwrite ignored files
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 3d05e45a279..4518d33ed99 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2337,7 +2337,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
>  
>  	memset(&d, 0, sizeof(d));
>  	if (o->dir)
> -		d.exclude_per_dir = o->dir->exclude_per_dir;
> +		setup_standard_excludes(&d);
>  	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
>  	dir_clear(&d);
>  	free(pathbuf);

Thanks to the later patches in this patch set, I only needed to look at
unpack-trees.c to see how o->dir (later, o->internal.dir) is set. The
only place it is set is in unpack_trees(), in which a flag is set and
setup_standard_excludes() is called. So the RHS of the diff here does
effectively the same thing as the LHS. (As for the flag, it is not set
in the RHS, but it was not set in the LHS in the first place, so that's
fine.)

Thanks - all 13 patches in this patch set look good.
