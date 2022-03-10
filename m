Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC4DC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242391AbiCJN0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiCJN0A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:26:00 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9307214D275
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:24:59 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a8so12047358ejc.8
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=UEtGqlNeyRS9DJFQuWRhNnpHZ9bNcx84nUkxTsJjntw=;
        b=IpzTRllL2q4yG+GyolOLiBmV2JM/bmJzbHgv+CVlS+AL4ph1KJXCLkto20A1/g/IY7
         YIs/JvZBOjrZuGVtAAGkJaNw6IDK7yKXSHdJvK+J9+61AUGKC91vMcd1AhUtkbMn9iDJ
         n3Rmi89gnVtK32ge9yC5t6j1OQ8hjFrX9e19u2ROR4xlKDYpse2ykDEtstGbjJduus3m
         Awiva2MwnQFiDOareyhcEAtXYj3zKiWJmQndHAyKrZFXnK2mxVGjVRmNVm5xS+UnSyKH
         BPFllcpr/+FGR9LOWqm63tSUdfj3qBmOdnTLeRm671jLyWMHBhtod0fxQQRDsW2D8B2t
         Yyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=UEtGqlNeyRS9DJFQuWRhNnpHZ9bNcx84nUkxTsJjntw=;
        b=OQkVT1TzYI+F5M+sPlktBFijb+ULwcXtkfL81G1luUqYr636B2cbZ8A8fG6+R+ark4
         S+9/yJRrxriJB0xc015/1X/Kn9vTq89HQuxbtZ1c1QdopBvA/TGIOgLSbKy8yA/gEjRc
         bav8TwLEwqyJPlMePgKhHtSzTqRMvgX82KgUfwBmO3p0/5sqTaTS/8uq3PvhnenBSb9Y
         llB7ItGyuyI+jCWlsfHriWJygrCgAk9QyYwHozVRtTXSPMCM7uHBQuw4kfjLhzbjQ1L2
         VynoAkhvzl2Ay+PdUHuNqTTkuPPAybbqt06ZvMnHcCIPqVvtQN1RQbvCkZRWOdog+0s4
         +hmw==
X-Gm-Message-State: AOAM533dwmL9gQyTq2HFQcb9M3yLLUHTg0SWFLE7UNj7znT85CoR27Ra
        D6Z20IYAP0n+SBHEopUML9zKE25Md4Q=
X-Google-Smtp-Source: ABdhPJyB7dq5agxeqOsjfrOOB4lUpFziFmdg/LYJE1007KJ7EY4dgo2RlzyBKAeySWvaDCVssuB6bw==
X-Received: by 2002:a17:907:1b20:b0:6da:649b:d99e with SMTP id mp32-20020a1709071b2000b006da649bd99emr4219339ejc.712.1646918697556;
        Thu, 10 Mar 2022 05:24:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e19-20020a056402105300b004162d0b4cbbsm2013570edu.93.2022.03.10.05.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:24:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSImm-000UE5-7B;
        Thu, 10 Mar 2022 14:24:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 04/13] pack-objects: use rev.filter when possible
Date:   Thu, 10 Mar 2022 14:11:18 +0100
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
 <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
 <ed22a77782bee97ef50fe1ff1a12fa2fa1470805.1646841703.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <ed22a77782bee97ef50fe1ff1a12fa2fa1470805.1646841703.git.gitgitgadget@gmail.com>
Message-ID: <220310.86zglyj5xz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> In builtin/pack-objects.c, we use a 'filter_options' global to populate
> the --filter=<X> argument. The previous change created a pointer to a
> filter option in 'struct rev_info', so we can use that pointer here as a
> start to simplifying some usage of object filters.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/pack-objects.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index ba2006f2212..e5b7d015d7d 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3651,7 +3651,7 @@ static int pack_options_allow_reuse(void)
>  
>  static int get_object_list_from_bitmap(struct rev_info *revs)
>  {
> -	if (!(bitmap_git = prepare_bitmap_walk(revs, &filter_options, 0)))
> +	if (!(bitmap_git = prepare_bitmap_walk(revs, &revs->filter, 0)))
>  		return -1;
>  
>  	if (pack_options_allow_reuse() &&
> @@ -3727,6 +3727,7 @@ static void get_object_list(int ac, const char **av)
>  	repo_init_revisions(the_repository, &revs, NULL);
>  	save_commit_buffer = 0;
>  	setup_revisions(ac, av, &revs, &s_r_opt);
> +	list_objects_filter_copy(&revs.filter, &filter_options);
>  
>  	/* make sure shallows are read */
>  	is_repository_shallow(the_repository);
> @@ -3777,7 +3778,7 @@ static void get_object_list(int ac, const char **av)
>  
>  	if (!fn_show_object)
>  		fn_show_object = show_object;
> -	traverse_commit_list_filtered(&filter_options, &revs,
> +	traverse_commit_list_filtered(&revs.filter, &revs,
>  				      show_commit, fn_show_object, NULL,
>  				      NULL);

Re your
https://lore.kernel.org/git/77c8ef4b-5dce-401b-e703-cfa32e18c853@github.com/
I was looking at how to handle the interaction between this and my
revisions_release() series.

This adds a new memory leak, which can be seen with:

    make SANITIZE=leak
    (cd t && ./t5532-fetch-proxy.sh -vixd)

I.e. this part is new:
    
    remote: Direct leak of 1 byte(s) in 1 object(s) allocated from:
    remote:     #0 0x4552f8 in __interceptor_malloc (git+0x4552f8)
    remote:     #1 0x75a089 in do_xmalloc wrapper.c:41:8
    remote:     #2 0x75a046 in xmalloc wrapper.c:62:9
    remote:     #3 0x62c692 in list_objects_filter_copy list-objects-filter-options.c:433:2
    remote:     #4 0x4f70bf in get_object_list builtin/pack-objects.c:3730:2
    remote:     #5 0x4f5e0e in cmd_pack_objects builtin/pack-objects.c:4157:3
    remote:     #6 0x4592ba in run_builtin git.c:465:11
    remote:     #7 0x457d71 in handle_builtin git.c:718:3
    remote:     #8 0x458ca5 in run_argv git.c:785:4
    remote:     #9 0x457b30 in cmd_main git.c:916:19
    remote:     #10 0x563179 in main common-main.c:56:11
    remote:     #11 0x7fddd2da67ec in __libc_start_main csu/../csu/libc-start.c:332:16
    remote:     #12 0x4300e9 in _start (git+0x4300e9)
    
Of course it's not "new" in the sense that we in effect leaked this
before, but it was still reachable, you're just changing it so that
instead of being stored in the static "filter_options" variable in
pack-objects.c we're storing it in "struct rev_info", which has a
different lifetime.

I think instead of me rebasing my series on top of yours and tangling
the two up a better option is to just add a change to this, so after
list_objects_filter_copy() do:

    UNLEAK(revs.filter);

Or, alternatively adding this to the end of the function (in which case
Junio will need to deal with a minor textual conflict):

    list_objects_filter_release(&revs.filter);

Both of those make my series merged with "seen" (which has this change)
pass with SANITIZE=leak + GIT_TEST_PASSING_SANITIZE_LEAK=true again.

You could do the same in your later change adding
list_objects_filter_copy() to verify_bundle(), that one also adds a new
leak, but happens not to cause test failures since the bundle.c code
isn't otherwise marked as passing with SANITIZE=leak, it fails in
various other ways.

Obviously we should do something about the actual leak eventually, but
that can be done in some follow-up work to finish up the missing bits of
release_revisions(), i.e. adding list_objects_filter_release() etc. to
release_revisions().

So I think just adding UNLEAK() here (and optionally, also to the
bundle.c code) is the least invasive thing, if you & Junio are OK with
that approach.
