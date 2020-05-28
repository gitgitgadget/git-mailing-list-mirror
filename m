Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B533C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6121D207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEsIm8Wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404675AbgE1Pzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 11:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404834AbgE1Pz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 11:55:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905D6C08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 08:55:26 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 185so5426820pgb.10
        for <git@vger.kernel.org>; Thu, 28 May 2020 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cnoNxGR5KNmo+ayOmFQ6smOcTc1ntaievNl3iupEvog=;
        b=WEsIm8WmgeLES8ue4oXsvy97aEsNMlqLsdQ30DmLjiG0ABHS5Wes+k5pOMGegIayy4
         rB1xL+gzbrDwCKD0SFgYhq4QT7CwVKVopEdZkDnHVLAZOC0H7iHytdqP7Yj9Bd2FVUOU
         haxJr7/nNnIUDFlAW1b/mBq0tJGdc39Lnagknnr1i/1N9a0vNCi48wVZUisdHH2WVQQU
         7Qw2D7PT5AEbdKFYFhEJYmOsGAW6/GtynSVbz7dkOl1jeIQsKC5Vd2rOSJDhmpJHEM6O
         p3RNDwe4gxWXVIhm0sGORm0yj+o3Ri58L0m+2JJe0k9A9y/C/zA4uA4tOLDd/wj+qvmh
         6URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cnoNxGR5KNmo+ayOmFQ6smOcTc1ntaievNl3iupEvog=;
        b=amxmvJfiMFJsVIlP9aaemPaIYol1thNDz1nVllxVEIz7sciH/D9r1/2bPJCNhipbRk
         L5PqhOG9Lnb/j0rTXcYlenFCnE5SrMsa0ztcrkd8CW/7w8YlUiZX6nhihlG7zWRwFYDz
         bUWa7bzthQs9lpNnmPZdxcvLeX0Um6sHac0JQbv/iGhRikq0JCw9gBUbt3t8fAfwsRWE
         aTe0ow9/PkPFdxLkN9AVHXiBmK/m1dvadE4KsZVf3gWYkWVske4tNLTDV80ZHK4v0NLT
         eaUYGwJ86lb2HjAFZtLBfE17hCa602+Zd4vbvSfRxUydx3pCdwvJjr+D5rfiNV1YRnXf
         l9wA==
X-Gm-Message-State: AOAM532bbQtvoqO+amHa7WTcAZTPjUe8jjs/qoyQ3hdGaIMa5IhIZ73w
        3uVbVNhvrxyqTQzvjMKIH/o=
X-Google-Smtp-Source: ABdhPJweGIKWFrSQ7ZmhaiMb9xAvaNI7TbqPjqhs2mAHqvGEPF+cuK0DZfDIkRhlzJpGD7hZZsgDCg==
X-Received: by 2002:a62:8487:: with SMTP id k129mr951120pfd.296.1590681326059;
        Thu, 28 May 2020 08:55:26 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id i17sm5109163pfq.197.2020.05.28.08.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:55:25 -0700 (PDT)
Date:   Thu, 28 May 2020 22:55:22 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4] submodule: port subcommand 'set-branch' from shell to
 C
Message-ID: <20200528155522.GA16787@danh.dev>
References: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
 <20200523163929.7040-1-shouryashukla.oo@gmail.com>
 <33127873-fb19-2bd5-3028-bcd1757e92e5@gmail.com>
 <20200527171358.GA22073@konoha>
 <20200528122147.GA1983@danh.dev>
 <20200528140142.GA1951@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200528140142.GA1951@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-28 21:01:42+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> On 2020-05-28 19:21:47+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> > On 2020-05-27 22:43:58+0530, Shourya Shukla <shouryashukla.oo@gmail.com> wrote:
> > >  > +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch $branch} ${default:+--default} -- "$@"
> > > 
> > > > Danh questioned whether '$branch' needs to be quoted here. I too think it
> > > > needs to be quoted unless I'm missing something.
> > > 
> > > We want to do this because $branch is an argument right?
> > 
> > We want to do this because we don't want to whitespace-split "$branch"
> > 
> > Let's say, for some reason, this command was run:
> > 
> > 	git submodule set-branch --branch "a-branch --branch another" a-submodule
> 
> Anyway, after typing this.
> I'm thinking a bit, then re-read gitcli(7),
> I think git-submodule is quite broken regarding to Git's guidelines:
> 
> -----------8<----------
> 
> Here are the rules regarding the "flags" that you should follow when you are
> scripting Git:
> 
>  * it's preferred to use the non-dashed form of Git commands, which means that
>    you should prefer `git foo` to `git-foo`.
> 
>  * splitting short options to separate words (prefer `git foo -a -b`
>    to `git foo -ab`, the latter may not even work).
> 
>  * when a command-line option takes an argument, use the 'stuck' form.  In
>    other words, write `git foo -oArg` instead of `git foo -o Arg` for short
>    options, and `git foo --long-opt=Arg` instead of `git foo --long-opt Arg`
>    for long options.  An option that takes optional option-argument must be
>    written in the 'stuck' form.
> ------------>8--------------
> 
> Current Git, with and without this change, this command will fail:
> 
> 	git submodule set-branch --branch=a-branch a-submodule
> 
> Thus, a script conformed with gitcli(7) will fail.
> (And our git-submodule(1) doesn't conform with gitcli(7), FWIW).
> 
> After this change, those commands will success:
> 
> 	git submodule--helper set-branch --branch a-branch a-submodule

This should be read:

 	git submodule--helper set-branch --branch=a-branch a-submodule

> 	git submodule set-branch --branch "a-branch --branch=another" a-submodule
> 
> (The second one was written for demonstration purpose only,
> I don't expect it will success)
> 
> This isn't related to this change, and git-submodule(1) will be
> rewritten in C in the very near future.
> Just want to make sure it's awared.
> 
> > 
> > This version will run:
> > 
> > 	git submodule--helper --branch a-branch --branch another a-submodule
> > 
> > Which will success if there's a branch "another" in the "a-submodule".
> > While that command should fail because we don't accept refname with
> > space.

It's me being noisy again.
I'm still puzzled by this idea (and I drank too much coffee, today).

I think the day of conversion of submodule from shell to C finish,
we can use current git-submodule--helper as the new git-submodule.

With that idea, I think why don't we passed all arguments from

	git submodule set-branch

into git-submodule--helper.
(Yes, the idea is wrong because the usage output will have
git submodule--helper as $0)

I tried that idea and run the test.
To my surprise the test failed :(.

Turn out git-submodule--helper set-branch doesn't do its advertised job,
git-submodule--helper set-branch doesn't understand short options -d and -b

We'll need this fixup regardless of the agreement on my other concerns.
----------8<---------
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 305c9abb3b..64636161a7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2291,9 +2291,9 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&quiet,
 			N_("suppress output for setting default tracking branch")),
-		OPT_BOOL(0, "default", &opt_default,
+		OPT_BOOL('d', "default", &opt_default,
 			N_("set the default tracking branch to master")),
-		OPT_STRING(0, "branch", &opt_branch, N_("branch"),
+		OPT_STRING('b', "branch", &opt_branch, N_("branch"),
 			N_("set the default tracking branch")),
 		OPT_END()
 	};
------8<-----------



-- 
Danh
