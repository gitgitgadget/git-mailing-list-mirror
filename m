Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A053DC4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 03:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiLUDyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 22:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLUDyR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 22:54:17 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A0F1CFDE
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 19:54:15 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 186so15172540ybe.8
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 19:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OTedeXISPqHKRXbkuUETo2MlJSXglhzV03SM9O3jUmI=;
        b=Jnbr/5PA1W1FmF6nrYexFaYKNuYg6lkuMjGbI+Adq4bf42QJbCZrT4IGNXIYl5t9xw
         lIAS37gn/aYURsJsVZd1dRxEklXMXXt9KqnmQ6Bk/TLy1aAvwAEg8OnuJlTMqu5ROtRt
         fbnQA7pvMCxyG9CWPs5boO1bAqIJ3qXHcXfhK2zCHXpoYf+2afFRm0gSN8RxfoeqKioy
         +ih1NaxmiwnVPfkRb2UQPf9JkC7yjjhzdreB4umWRHrbro/mAIcm0PZ87uObjAPcYejb
         5LkcyLtpwCslBI47AerFZ5liW3B/iIPemnvJN4KPH25JRJCREQ/Mi9qY5AqYoOlMO3n+
         M+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTedeXISPqHKRXbkuUETo2MlJSXglhzV03SM9O3jUmI=;
        b=G5E43F2wvabCvVF45yh5VmiusMz8ZFAj5vYvg9UtvQZwQ8QVxxum+YGkzE5DiUuLUl
         CLofYO26N9xwoCm8cR5ATKqC7NSFm5nz1Qg4w45xaUGL2raK/EPy+Vsp6fw6JIRpP4SN
         EKCci9F7xAL6e998dYdz23Sw4C0CtozYZTjApBcHcBxVFaX0VtlVRqAcuBn3V+2ALY6i
         b00W3lbhjzNqEFIEbSljIcPbu0eAyrojsdnbrRxgnDJtQo0bRGsjkpnnaBYpM86Vzwtp
         0sHHxosiRSVVKIcwWzURhJm4pT75L2QPLyj8zKOQmevdlM9wQcRlE8+MJ3VDvEbPQob1
         tfVg==
X-Gm-Message-State: AFqh2kq54foN+rsAYGNoWYlqf+A7D1vVinArzBpT2KRG0KmJZNsdq/rN
        abfQkBYo5OG0hZ1Or+vxgOAKWnbv1xwXJVv8Hks=
X-Google-Smtp-Source: AMrXdXsKQt6mwFteZvNeEnfEruT6SGt83sNRHJRK+zMuwTr39cm5lVFSW5Ws/CTsrcLzZf98v4jfvdmc9nvhFJ1g1cA=
X-Received: by 2002:a05:6902:1365:b0:741:41be:2f03 with SMTP id
 bt5-20020a056902136500b0074141be2f03mr51637ybb.242.1671594854740; Tue, 20 Dec
 2022 19:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20221025122856.20204-1-christian.couder@gmail.com>
 <20221122175150.366828-1-christian.couder@gmail.com> <xmqqa64ipl4r.fsf@gitster.g>
In-Reply-To: <xmqqa64ipl4r.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 21 Dec 2022 04:53:50 +0100
Message-ID: <CAP8UFD2_ZbrOh4Tto2V80wn4ki+3j6Giegx+QyrLqd7uH6U4GQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Implement filtering repacks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2022 at 1:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > In the discussions with Junio and Taylor following the first and
> > second versions, Junio suggested adding `--filter=<filter-spec>` to
> > `git gc` and I am still Ok with doing it, either later in a followup
> > patch or in a v4. I haven't done it yet, as it's not clear how to
> > implement it efficiently only in `git gc`.
>
> Did I make such a suggestion?  I only said --filter=<filter-spec>
> does not seem like a good option to surface and stress at the
> end-user level for "git pack-objects".

In https://lore.kernel.org/git/xmqqilkm9wv6.fsf@gitster.g/ you wrote:

-> Unlike prune-packed, pruning objects that could be refetched has
-> negative performance impact.  So adding an option to enable/disable
-> such pruning is needed.  If the frontmost UI entry point were "gc",
-> it needs an opt-in option to invoke the "filtering repack", in other
-> words.  "pack-objects" should not need any more work than what you
-> have here (with the "terminal" and "force" discarded), as "--filter"
-> is such an opt-in option already.

I understood the above to mean that you would be Ok with adding
a "--filter" flag to `git gc`.

> The similarity of "git prune-packed" with this new operation was
> brought up to illustrate the point that users of "git gc" do not
> want to even know about having to remove redundantly available
> objects via "prune-packed" by giving an extra option to "git gc"
> (hence --prune is the default), and honoring the filter spec when
> objects are known to be available via the configured promisor remote
> is likely what users at the "git gc" level would want to see happen
> automatically.  IOW, adding more options to "gc" would be the last
> thing I would want to see.

I still think that users should be able to control if `git gc` performs
such a filtering when repacking, and I don't see how it could be done
without any new option at all. I think that for example only checking
the 'remote.<name>.partialclonefilter' config variable to decide if it
should be done or not is just too dangerous for people already using
this variable.

In the v4 I will send really soon now, I tentatively implemented a
'gc.repackFilter' config option for the purpose of telling `git gc` that it
should perform filtering repacks with the specified filter. I hope that
this will help move the discussion forward.

BTW in the latest "What's cooking in git.git" emails there is the
following about this patch series:

-> Seems to break CI.
-> cf. https://github.com/git/git/actions/runs/3560918726

I took a look at the failures in the different failing tests and they
don't seem related to this patch
series and seem quite random:

=== Failed test: t3106-ls-tree-pattern ===
The full logs are in the 'print test failures' step below.
See also the 'failed-tests-*' artifacts attached to this run.
Error: failed: t3106.3 combine with "--object-only"
failure: t3106.3 combine with "--object-only"
Error: failed: t3106.5 combine with "--long"
failure: t3106.5 combine with "--long"

=== Failed test: t5601-clone ===
The full logs are in the 'print test failures' step below.
See also the 'failed-tests-*' artifacts attached to this run.
skip: t5601.60 clone c:temp is dos drive
skip: t5601.101 colliding file detection
Error: failed: t5601.110 auto-discover bundle URI from HTTP clone
failure: t5601.110 auto-discover bundle URI from HTTP clone
Error: failed: t5601.111 auto-discover multiple bundles from HTTP clone
failure: t5601.111 auto-discover multiple bundles from HTTP clone

=== Failed test: t5556-http-auth ===
The full logs are in the 'print test failures' step below.
See also the 'failed-tests-*' artifacts attached to this run.
Error: failed: t5556.2 http auth anonymous no challenge
failure: t5556.2 http auth anonymous no challenge
Error: failed: t5556.3 http auth www-auth headers to credential helper
bearer valid
failure: t5556.3 http auth www-auth headers to credential helper bearer valid

=== Failed test: t4203-mailmap ===
The full logs are in the 'print test failures' step below.
See also the 'failed-tests-*' artifacts attached to this run.
Error: failed: t4203.66 git cat-file -s returns correct size with --use-mailmap
failure: t4203.66 git cat-file -s returns correct size with --use-mailmap
Error: failed: t4203.67 git cat-file -s returns correct size with
--use-mailmap for tag objects
failure: t4203.67 git cat-file -s returns correct size with
--use-mailmap for tag objects

etc

I tried different build flags but can't reproduce locally.
