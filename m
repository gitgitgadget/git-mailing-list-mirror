Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EC7C433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 19:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FEA229EF
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 19:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgL1TBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 14:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgL1TBU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 14:01:20 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F34C0613D6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 11:00:40 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id et9so5359083qvb.10
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 11:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=2kzWxK50uj9+3fsOLkBYDQ/vnM8B1HZA3meGLj9v8m0=;
        b=NceDybqnfSpmvJg+z/0YNvHI5JSMs8jV7EC8xQtOrG1HuNpDnvPE25kQQ95Ms0qLkS
         Kn7EPAMqSCIRVtTk7e+QmyGSolK1/VSYED4drvaZav+2yq/8b4YXD3Chgfwz28OeCHnm
         K7SLHl+9rtDI2n/ouq6NOB8Ac62JuTIuHg+kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=2kzWxK50uj9+3fsOLkBYDQ/vnM8B1HZA3meGLj9v8m0=;
        b=qI+jIR7FFd6xm6wMf7hxy8cpWAqqollrWSKDXvdkHvFEbJ1h2qSim6Yp2dOw+oXPqL
         2HgMnlKcTOwZFb9Q1VKdjNVzxB0anyHSbUkc6IDZfJVKpaofQ9istFGk8QlCiypRXLES
         +5hZcUriWGrHaNUN17ojeWb+EUodpKbyWv62nu1xi3u4oMXPMYqfgRKzbU7gVDcZ0+IT
         t/iVnJyF6axSL96zBUd/o7wxZJu8m73V6zc/qqTO8cTQQ2QlyTWy/uIBxLmWunB+TxsL
         FUOvHHPUN1y4SN3y9n5DGOCTmcU6Z8eCEdC5JmzE5lQCqeMVuA7gxLifNRi1mr+fRrXn
         dS4w==
X-Gm-Message-State: AOAM532W4vNrGMfHz2g/0Z2K3kSdnmCYJqgRl5nwuRmJoEh1kWG3Kfj6
        k8w8LdeYZ/cv8sjMhTh4xIZ3GxLy77sL53qH
X-Google-Smtp-Source: ABdhPJxHEcd3BOyREXOey5E9ohEJNaOARgrFk4JjhodcT+CR2k3ycxenFPhNjyt8YE8O8w4/j7DAYg==
X-Received: by 2002:a05:6214:1467:: with SMTP id c7mr48639453qvy.51.1609182039374;
        Mon, 28 Dec 2020 11:00:39 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id w15sm22873789qta.95.2020.12.28.11.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 11:00:38 -0800 (PST)
Date:   Mon, 28 Dec 2020 14:00:36 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Stefan Monnier <monnier@iro.umontreal.ca>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Destructive access to an "objects/info/alternates"
 repository
Message-ID: <20201228190036.vnkgeu6puxmvgt5s@chatter.i7.local>
Mail-Followup-To: Stefan Monnier <monnier@iro.umontreal.ca>,
        git@vger.kernel.org
References: <jwvpn2tdb0r.fsf-monnier+gmane.comp.version-control.git@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jwvpn2tdb0r.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 28, 2020 at 01:50:43PM -0500, Stefan Monnier wrote:
> [ Resending with a subject that clarifies that it's a bug report.  ]
> 
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> 
> > What did you do before the bug happened? (Steps to reproduce your
> > issue)
> 
> I did basically:
> 
>     git clone --reference ~otheruser/nongnu

This doesn't appear to be a proper command, because it's missing actual
repository to clone, only the repository to use as reference. This is the
proper usage of --reference:

git clone --reference ~/some/repo https://some/remote/repo.git

Perhaps you meant --shared?

Without knowing exactly what you did, it's hard to tell what went wrong. You
can try running "find nongnu" to see if what you think is your own checkout is
actually a symlink or some combination thereof.

-K
