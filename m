Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BC8C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 19:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiCCTzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 14:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiCCTzp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 14:55:45 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C989F154D35
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 11:54:58 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id w1so5599105qtj.2
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 11:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GJhmh48DqOKHd1wKyEuHLVc2C+GyGZN4MIig0fNtLOs=;
        b=xFPvfcI7Zg2wbuyOxBu25DKB8eOnRSFeXu0aRjHDvl3Jtn7mq3u4MI3Yqx7bl6HFnw
         ul/c4LOpBCOS/XXt5FbVXKi94v5esPpBIgVbtf5xm9PoF1vZn0/3T4dxeepxmWaPbmNC
         wtTqF5vy7fBtmYIDR0uC74ssmOmNvVdz7DgkIeMuHhhRHJeuavW1IO1s5zeCcxG6dbum
         QCQuGR7JPSSQkl7tvMK2WLnvAfh3bGVOpFuqHcX8m+fp1F/uK75I7fe/2TfJX2l1tPMk
         9o+f5TwurVau/8OtXwMrRCvdj19R7vXZ7r0WF8ycqgSATqcj56UCh5jFfY/sVKntVL8b
         p+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GJhmh48DqOKHd1wKyEuHLVc2C+GyGZN4MIig0fNtLOs=;
        b=tOknNJbrJ03XjM2bXoMEwkn9x/syPzpiFHAUNT+aFPWSf1Sl1acePPvFMoenAASYQE
         ZJ4qOPVqtn81sNKdeHJGvWO85TW9e5KWRmdi81KgkO+C0Aa3wwm+5GIq8wzqOm2sBdEn
         X25wkSO5b1+akyPZhnKBAgwetw7kUbHpplT9CLZUzhV7EfQ8c5h0qImINhhKTgMsakP4
         MfS3AEmXkqnOp/IQQPiEV+bQxxRvYWs52nhDxR3BtkUTTcfMjUPuxljLSeLBTQIbTi8i
         1PMF2rXyFCS7yDBiLIc6hq1ofzmKapE2RJT+OC1WwhP4eRqoWJaWhAbZ7Ff/qfokDYeN
         OutQ==
X-Gm-Message-State: AOAM530RjF1WRot65OYfRS0DUT0/6GZB4YO568Y3DiVWICtJQ4XLyZ6T
        9Mfl+9nD+xNVi459ssalZ5otIg==
X-Google-Smtp-Source: ABdhPJwRECaQf3kEcQgJOZQyKdrPFHj5wJyiS7n80y8qI96j0cH4mx1/Ge2xlXEfNeCCu3gRorUx5Q==
X-Received: by 2002:ac8:5716:0:b0:2de:5070:9883 with SMTP id 22-20020ac85716000000b002de50709883mr28747929qtw.456.1646337297859;
        Thu, 03 Mar 2022 11:54:57 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 192-20020a3704c9000000b00648d50e398asm1516054qke.109.2022.03.03.11.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 11:54:57 -0800 (PST)
Date:   Thu, 3 Mar 2022 14:54:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        gitster@pobox.com, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] builtin/remote.c: show progress when renaming remote
 references
Message-ID: <YiEdEDN8D0MqnElC@nand.local>
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
 <220302.865yow6u8a.gmgdl@evledraar.gmail.com>
 <Yh/1zFChEXz7r1vN@nand.local>
 <220303.8635jz5mcz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220303.8635jz5mcz.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 03, 2022 at 11:51:08AM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Wed, Mar 02 2022, Taylor Blau wrote:
>
> > On Wed, Mar 02, 2022 at 08:00:59PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> So please have this by "int progress = 1", and have a "PARSE_OPT_NONEG"
> >> "no-progress" option instead, there's no reason we need to propagate the
> >> existing UX mistake in "reflog expire".
> >
> > Yes, I agree that `git remote` is unlike other commands where you have
> > to opt _in_ to see progress, not out.
> >
> > But I deliberately avoided doing anything about it here, since this
> > patch is more about making an existing set of arguments (`git remote -v
> > rename`) do something more useful than before, and not adding a new
> > option.
> >
> > In other words, I felt that because you could already run:
> >
> >     $ git remote -v rename old new
> >
> > that it was better to punt on any changes to the option itself until
> > later.
>
> So first, I must say that I was just entirely confused when I wrote
> this. I managed to somehow read this code and also mentally mix up that
> you were patching git-remote and not git-reflog, hence linking to those
> "reflog" patches.

No problem, your response below jogged my memory on the "should
`--[no-]progress` be accepted on either side of a sub-command or not?"
discussion we had a while ago.

> But in any case, for *this patch* I think that also means that using
> --verbose here makes even less sense, because --verbose for "git-remote"
> is:
>
>     Be a little more verbose and show remote url after name.
>     NOTE: This must be placed between remote and subcommand.
>
> Although reading it over it seems that was written for "git remote -v
> [show]", but we don't entirely hold to it already, but in any case let's
> not also conflate it with what should be a "--no-progress" here.

Thank you for pointing that out. I agree that between the documentation
(which I agree is over-fitted for `git remote -v`) and my (admittedly,
foggy!) memory of our earlier discussions, I think that `git remote
rename --[no-progress]` is the right way to go here.

> So just doing:
>
> 	diff --git a/builtin/remote.c b/builtin/remote.c
> 	index 6f27ddc47bd..047bcda57c5 100644
> 	--- a/builtin/remote.c
> 	+++ b/builtin/remote.c
> 	@@ -674,7 +674,9 @@ static void handle_push_default(const char* old_name, const char* new_name)
>
> 	 static int mv(int argc, const char **argv)
> 	 {
> 	+	int progress = 1;
> 	 	struct option options[] = {
> 	+		OPT_BOOL(0, "progress", &progress, N_("show progress")),
> 	 		OPT_END()
> 	 	};
> 	 	struct remote *oldremote, *newremote;
>
> Would be consistent with [2] and not mix up --verbose and its (probably
> somewhat inaccurate already) documented promises with this new output,
> and improve the UX by turning it on by default.
>
> 1. https://lore.kernel.org/git/87zgsad6mn.fsf@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/cover.1631980949.git.me@ttaylorr.com/

Agreed, thanks!

Thanks,
Taylor
