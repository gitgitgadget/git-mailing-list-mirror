Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B77C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A78064D73
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhBPS0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBPS0P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 13:26:15 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D441C06174A
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 10:25:35 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id e9so5109004qvy.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 10:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g4D0tgArwtSRv+ImsnoRdhUOgw1mNfabFigH5DhGPvQ=;
        b=MUX0TvDJVM5W2SdAg9JzGQuRrGcEIl0qKX8jIW636HpoX/YjWzWmefO8PxHa7bwZwZ
         wVQTdNuFlizZPxYaneNiKfOJiXxpuus342Z1W/Gd9+vYh3RroRye6KPk4/T3f4szzidD
         8MIJRhDaKG22CG77OtTfdBu7Q9WckQq2gTGy+utEJsiFlcIw6KEpvrdb9/4Q4jU32vDx
         q43hQdDOpih0ZaD+evJtamdmuPea1EABTdZzvG+IeoGLW9S/0LDz2DV38ic2mjlbv+fA
         vDrHI/0/uUGP3k7nyTR2TgK9bwEOENMPJo8cNLwk5uv2W5U6gU+EWTtkCAHx0Fs+A9hr
         934Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g4D0tgArwtSRv+ImsnoRdhUOgw1mNfabFigH5DhGPvQ=;
        b=JS5QIJ0xODS6WyVORZRw60IMLrQNX+BWhdfhiols0JPtOtkgHIhQqVoLQCD8Zzxy41
         QsFSobd1nMbYArmh9FSjpoUhnBhX32grDqiLXPQqKvDjnO6DB+EGvMLRSk+f5dOtDeX9
         lBBLmtWgMNy9O9kTOZoPdSe/RWNg1Vxqj1CXh9sP17fIDxUkVXBws2w79DJJWYrwprw5
         lairzuWEBzZf5v56cyHsdvjeZ8aqET1G2sru/woMZQ+SQGD1GjvX0F9Tubukq7eBeFd4
         HMdzoPmPLrJFh8qqvxQQee+fmHapUJSVAIKTFbtnpwwycA3UgS5O9ZGhlp9NSyLW2uxB
         wc7Q==
X-Gm-Message-State: AOAM533cuYu9THhobhuMajMtPUSkCeisSpfiDD/gFepqTE3lyaWXsSgy
        ZwC2EshoXhHt23iTF/BYIen1vA==
X-Google-Smtp-Source: ABdhPJwSroLjQz5Sl9SQHFIrI3m67v9IQyVmPSDRazOl7hXTWOGjUX/4bzYMbff4gSVHEy7nqLpO3A==
X-Received: by 2002:a05:6214:2b:: with SMTP id b11mr21128436qvr.3.1613499934529;
        Tue, 16 Feb 2021 10:25:34 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:c1ff:146e:b5:8cba])
        by smtp.gmail.com with ESMTPSA id c143sm8168711qkg.83.2021.02.16.10.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 10:25:33 -0800 (PST)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Tue, 16 Feb 2021 13:25:32 -0500
To:     janek <27jf@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Short status ignores --show-stash option
Message-ID: <YCwOA/CcPEA/he1X@nand.local>
References: <5ofQpdi3EmG_V-LqPrL6ZttzenOKG9xQ9MCdQ1OK7b_NcFZX0hqqmwr8mr2KByFwRa8ljzX4vj-_34Q6aPcXdZ8_qDahZfFSyJKj5cfyAjc=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ofQpdi3EmG_V-LqPrL6ZttzenOKG9xQ9MCdQ1OK7b_NcFZX0hqqmwr8mr2KByFwRa8ljzX4vj-_34Q6aPcXdZ8_qDahZfFSyJKj5cfyAjc=@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 15, 2021 at 08:02:24PM +0000, janek wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> git status --short --show-stash --branch
>
> What did you expect to happen? (Expected behavior)
> The status shows info about the stash, e.g. next to the branch infos
>
> What happened instead? (Actual behavior)
> --show-stash is ignored when using short format

Hmm. It's certainly possible to do something like:

diff --git a/wt-status.c b/wt-status.c
index 0c8287a023..397d36544d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2013,6 +2013,9 @@ static void wt_shortstatus_print(struct wt_status *s)

        for_each_string_list_item(it, &s->ignored)
                wt_shortstatus_other(it, s, "!!");
+
+       if (s->show_stash)
+               wt_longstatus_print_stash_summary(s);
 }

 static void wt_porcelain_print(struct wt_status *s)

and that would cause 'git status' to do what you expect:

    $ git.compile status --short --branch --show-stash
    ## tb/empty-trailer-continuation
     M wt-status.c
     Your stash currently has 16 entries

But it may not be the right thing to do, since that explicitly breaks
the --porcelain format. We may want something like this in addition to
the above:

diff --git a/builtin/commit.c b/builtin/commit.c
index 739110c5a7..ef855896a2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1414,6 +1414,12 @@ int cmd_status(int argc, const char **argv, const char *prefix)
            s.show_untracked_files == SHOW_NO_UNTRACKED_FILES)
                die(_("Unsupported combination of ignored and untracked-files arguments"));

+       if (status_format == STATUS_FORMAT_PORCELAIN ||
+           status_format == STATUS_FORMAT_PORCELAIN_V2) {
+               if (s.show_stash)
+                       die(_("--porcelain is incompatible with --show-stash"));
+       }
+
        parse_pathspec(&s.pathspec, 0,
                       PATHSPEC_PREFER_FULL,
                       prefix, argv);

Thanks,
Taylor
