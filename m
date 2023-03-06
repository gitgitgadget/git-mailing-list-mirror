Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACD5C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 19:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCFT7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 14:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCFT7N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 14:59:13 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EE667009
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 11:58:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n203-20020a25dad4000000b0091231592671so11573587ybf.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 11:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678132679;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gQqEwnSJrttmZlvSZYcCa7u2mFFyL+rjyPzdCvWLwcM=;
        b=SdQ+8NGNLWO8F0f3jVvzBmzFqn7/m0mRUX1Cwn3r4AkUPy41idB79+ZkYIG4CWbA9y
         mb22w9Sj+35/hp5dX7JJ3XWdIQGvjOHPKTwvmQT9PYljT9cclU6L9ADRF6hnUnC3nVQi
         nCeFpL5O+5McT//A8lUNlvI1WeYvlJ/ftu0zGEPjE+/1Qy4nxeXtNF5Ii2nvUhWm7IiT
         o/s5NwPbTF0WQL4vJ5jXT0JIPZuV15OYVoGDSv/NXz555tB9WSASckCasA5PmGTV7dXG
         hFoOBW2BvUkUnn+o08Z5nqoolHBR7WEOwt7zhpcRFUd3OWrgjughwdpKgTBXKGzGylRa
         2ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678132679;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQqEwnSJrttmZlvSZYcCa7u2mFFyL+rjyPzdCvWLwcM=;
        b=Vw0I13tuL2YzSit26UajKNwbEzyvoSZXGTkkwIcILhg7Fe4eMu9qvWg+IwgmdN9zcG
         4tB6Ty/ywydnj0khitQC83lGIoacEYh+n+vKM3vS4qQdtPuBF30gKgZsf2L61EYsTeaq
         diuks0jNpUafsQ09LqoYPZ8trY3wDc7yd3VKmh80ElQNkiSKdnxxePuSYI6ObR8FxET7
         SqQgycXGYViGKpPce2S3PiVUbSZQeuZLgJrMVOfG8+ECfNIhiwA3juzkUNo/TKPhrpAt
         rJg9A50bUxb9BA/EyyGCSmOM03enq2Rm+WkaJEVKB4+PbYXNMGC6rEeFud4xBZusKjSP
         4Twg==
X-Gm-Message-State: AO0yUKXWcfA/lpno1gYwsIIUZPa/9wypTt1Bj35dSceyqCuKDVDUwoe8
        NHVwbyocSmuSDsGupNmo5BF5Qhnqze2Bz+xfM16n
X-Google-Smtp-Source: AK7set+1d2mzdrXu1MONtV4Wbn/KC+tFVOe90T+vzveo/Q+8LYHOrM3ow146kmhy/2OKNyUNrMYX4LF0wz5IrWSXt6PU
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:37b6:a998:138:7714])
 (user=jonathantanmy job=sendgmr) by 2002:a81:af62:0:b0:533:9b00:dd0b with
 SMTP id x34-20020a81af62000000b005339b00dd0bmr7831706ywj.2.1678132679079;
 Mon, 06 Mar 2023 11:57:59 -0800 (PST)
Date:   Mon,  6 Mar 2023 11:57:56 -0800
In-Reply-To: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306195756.3399115-1-jonathantanmy@google.com>
Subject: Re: [PATCH 0/6] [RFC] config.c: use struct for config reading state
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>  * We could add "struct config_reader" to "config_fn_t", i.e.
>    
>    -typedef int (*config_fn_t)(const char *var, const char *val, void
>    *data); +typedef int (*config_fn_t)(const struct config_reader *reader,
>    const char *var, const char *val, void *data);
>    
>    which isn't complex at all, except that there are ~100 config_fn_t
>    implementations [3] and a good number of them may never reference
>    "reader". If the churn is tolerable, I think this a good way forward.
> 
>  * We could create a new kind of "config_fn_t" that accepts "struct
>    config_reader", e.g.
>    
>    typedef int (*config_fn_t)(const char *var, const char *val, void *data);
>    +typedef int (*config_state_fn_t)(const struct config_reader *reader,
>    const char *var, const char *val, void *data);
>    
>    and only adjust the callers that would actually reference "reader". This
>    is less churn, but I couldn't find a great way to do this kind of
>    'switching between config callback types' elegantly.

To reduce churn, one thing that could be done alongside is to convert
config-using code (which is...practically the rest of Git) to start
using the configset interface (we seem to be using configsets internally
anyway, as evidenced by repo_config()). That way, we would reduce the
number of implementations of config_fn_t.

>  * We could smuggle "struct config_reader" to callback functions in a way
>    that interested callers could see it, but uninterested callers could
>    ignore. One trick that Jonathan Tan came up with (though not necessarily
>    endorsed) would be to allocate a struct for the config value + "struct
>    config_reader", then, interested callers could use "offset_of" to recover
>    the "struct config_reader". It's a little hacky, but it's low-churn.

Indeed, although we should probably use this as a last resort.

> = Questions
> 
>  * Is this worth merging without the extra work? There are some cleanups in
>    this series that could make it valuable, but there are also some hacks
>    (see 4/6) that aren't so great.

I'm leaning towards merging it now, but can go either way, since the
cost of churn is limited to one single file, but so are the benefits.
If it was up to me to decide, I would merge it now, because this opens
up a lot of work that other contributors could individually do (in
particular, converting individual config code paths so that we don't
need to reference the_reader as a global anymore).

I don't see 4/6 as a hack. It is true that the nature of the config_fn_t
callback could change so that passing the reader would end up being
done in yet another different way, but firstly, I don't think that will
happen for quite some time, and secondly, it might not happen at all
(right now, I think what's most likely to happen is that the rest of the
Git code moves to configsets and only a fraction of the Git code would
need to do low-level parsing, which would not have a problem passing the
reader through the data object since they would probably need to pass
other context anyway).

>  * Is the extra work even worth it?

Depends on which extra work, but I think that eliminating the the_reader
global would really be useful (and, as far as I know, the whole reason
for this effort). From the Git codebase's perspective, doing this would
(as far as I know) eliminate the need for pushing and popping cf, and
make multithreaded multi-repo operations less error-prone (e.g. we
can spawn a thread operating on a submodule and that thread can itself
read the configs of nested submodules without worrying about clobbering
global state...well, there is thread-local storage, but as far as I know
this is not portable).

>  * Do any of the ideas seem more promising than the others? Are there other
>    ideas I'm missing?

Hopefully I answered this in my answers to the other questions.
