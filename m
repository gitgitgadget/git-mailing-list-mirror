Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A521BC433E1
	for <git@archiver.kernel.org>; Wed, 27 May 2020 12:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85AE0207CB
	for <git@archiver.kernel.org>; Wed, 27 May 2020 12:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzEBI3ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgE0Mot (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 08:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgE0Mot (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 08:44:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CA2C08C5C1
        for <git@vger.kernel.org>; Wed, 27 May 2020 05:44:49 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id n18so11778893pfa.2
        for <git@vger.kernel.org>; Wed, 27 May 2020 05:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6VLCC6fxsJjsmmoOLn4RsT2hJENkGHZcnehcwOXtSrI=;
        b=bzEBI3ahpt27qchgPM570lL4t2gQE8LE3BZpcnWwpF8o+kLDxhJOlnhNUUvlDexxpz
         0N43jyivXXJf6kCrpPnhlP2xw2H5RuZCmIHydRzexIDPRKSwIxB51LYagjs6+chx2FyK
         PO/CVDwUFBo5DklsFwm8Ud3j2rhuWL9PhN5/jmwsmF5Lv7yg6HN6omqgJPqoPtd17x60
         SeUASsT5D+ZZ5MRmzIJaDcg9Sb1RnTIHl3zwP1VminWbjP3pZAcXR/j26FXPN7bkrNYC
         EQr3KKSsOTJFKgdlLzId1Jt3rYDa91Yf53RuyOItzignC9gi8HNVRcfLbOL4ehI/QXX3
         H2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6VLCC6fxsJjsmmoOLn4RsT2hJENkGHZcnehcwOXtSrI=;
        b=KCzuLoB2NKLahmrAS29xy7+1lj3W8htHAZlIFrHWkFnHJeLNuP3C4pvgZfuBALPCqg
         5TZ+Fm6V0dihLSxdkoyxW/urWAtwi+1cdY/H5O+De59ULYe9BeWUPAF72PajisBinJAj
         fCHlycx09cGjMlA+FKoQyzEeVbSyCyTasxB3eVLFEmPqaDUbY6mXnTott2vDEIo2h1Y/
         WtTBSkxQoc/QMwxlhJZaD2HYtdOWIZYBZRtFnA8Z9+t8gI+6q2sUS1rZ1wJYJIP3K5F4
         +A5CzAlPyabKNOU0c+9XjxhYEpmXw4a6Mji990cPCVA0zp/9zviN9YqD3Kte85zlakKg
         XPzA==
X-Gm-Message-State: AOAM531pml/aFUNFPwwipgk6N1hNoLvvraZQX7gHVsfXpenLZJ8JJEUc
        ngy9r6wwsXS0iTjYqET2TFzhlnmE
X-Google-Smtp-Source: ABdhPJzpwClLaVP+k3IgPxNm9CD/XzlsZvzFxMRGW0wtLJBPLJDRQxfkcEstjk8tvFvB6kLpQpON8Q==
X-Received: by 2002:a62:e305:: with SMTP id g5mr3927189pfh.144.1590583488457;
        Wed, 27 May 2020 05:44:48 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id ep10sm2251739pjb.25.2020.05.27.05.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 05:44:47 -0700 (PDT)
Date:   Wed, 27 May 2020 19:44:45 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Erik Janssen <eaw.janssen@chello.nl>
Cc:     git@vger.kernel.org
Subject: Re: [Feature request] Add -u option to git rm to delete untracked
 files
Message-ID: <20200527124445.GB2013@danh.dev>
References: <1098602171.79502.1590528083387@mail.ziggo.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1098602171.79502.1590528083387@mail.ziggo.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-26 23:21:23+0200, Erik Janssen <eaw.janssen@chello.nl> wrote:
> Would it be feasible to add a -u option to git rm to specify that
> I also want a file deleted if it is not tracked by git?
> Currently, git rm -f can remove files in whatever state it seems,
> except when it is untracked. 
> By allowing a -u option (-u: also delete untracked files) I would be
> sure that the file is gone while it would also make sure that it
> doesn't break past behaviour where people perhaps rely on git rm to
> leave untracked files alone.

I _think_ remove untracked file is pretty much risky operation,
and it should be done separately/independently (via git-clean(1)).

Let's assume we have -u|--untracked,
nothing (probably) can stop our users from:

	git rm -u src
	git rm -u .

Even git-clean(1) requires either --force or --interactive
because it's too much risky to begin with.

If we think Git as a FileSystem, its rm should only care about its
tracked file. I prefer to just rm(1) instead of "git-rm -u".

-- 
Danh
