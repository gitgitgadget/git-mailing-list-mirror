Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F59BC11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 20:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C0861CCE
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 20:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbhF1Uxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 16:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbhF1Uxf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 16:53:35 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FE1C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 13:51:09 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so20317549otl.0
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=mNedtBTcj1zXctlKkbl0vcfEg0LBf4nNcooOh/O3NmE=;
        b=aUe4qT8nWyb+yQTkq5HpAVVWuRgjytAKDg2qOwEorGTnqGu03gtIMcjQ3/5QOA7cq6
         BvvHqjULOdi4mNU8eDXxfwA8FhAfg/PmcQV+hY0mqtFxdH6JAbACfPvdv5ffeBASKyzw
         FJGSL9S5DyBNiD2xMUN/Ph8kH5FnJYzO0cFAGgq2wYMy/l927BaMrEyC40M/Qq4zjRRl
         K+LU1TKlQ3uP6tUFcFcQKnJFnRRhyXsZoxgnxhIJk7MQQIfpw/fnlA6Emd5fHcZW0ocq
         l06u//leNrNKGtGfNccwNwPE8gil7w1E7MESD4rKrU7ZaVmXYLW0BYTKapZCh33fGZp1
         LFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=mNedtBTcj1zXctlKkbl0vcfEg0LBf4nNcooOh/O3NmE=;
        b=Ckndg3jn4Xy7LWsTtX2yQyowsJjQnZtrFGP2TQTNZLA5ZnVVyrEBMgaMnlf5AJcoD/
         G/8YM8mCpSsCugSXlDJlIiIDNdJvGyDhNI1Da+Yz7Wnbppw3pq9gQVLClOA44cPS3vOF
         e8py95ZhtdVmM9bAX0BGvFd9r3PZB5YEy4MLwwapOHKw+rzkshvcmFRwyfycpuTmamyO
         t6H69PtqOI/RVYVq+Bkd1cf1f5MdxCxi76Eru4wtmKlm2h8trXh+yYnPLRW/ekMQ2VC8
         AJnoMKIuOjJRGx/vT45hYnKiiKp7kj2v8pRRTXSg2vpM4klYCMldF5U/rJPMCDQlP2zF
         M8IA==
X-Gm-Message-State: AOAM532CGTyjyQCVol+BYPsXW/Kifa9eC7PbOjdmiStxtX3+RuPnt8+p
        7BmxtYsG9n801W68Flzk2ms=
X-Google-Smtp-Source: ABdhPJz6wyaZKXyWBXwp4ieZk6d0md2PVqmeDCT192Ko25Y0PF0rECrCIRpOc80ocJYWFLKXZBVMBw==
X-Received: by 2002:a9d:4e03:: with SMTP id p3mr1290902otf.214.1624913468906;
        Mon, 28 Jun 2021 13:51:08 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id w132sm3424018oig.38.2021.06.28.13.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 13:51:08 -0700 (PDT)
Date:   Mon, 28 Jun 2021 15:51:07 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>, 'Jeff King' <peff@peff.net>
Message-ID: <60da363b3c532_1dcf420821@natae.notmuch>
In-Reply-To: <029901d76c5d$6137bc80$23a73580$@nexbridge.com>
References: <60bfadc0aca09_1abb8f208fd@natae.notmuch>
 <60da10df509f0_1b95d2089c@natae.notmuch>
 <029001d76c4d$f3277550$d9765ff0$@nexbridge.com>
 <60da1c8de0ca7_1cdb420832@natae.notmuch>
 <029101d76c54$9f713c50$de53b4f0$@nexbridge.com>
 <60da2692e8029_1d6fc20855@natae.notmuch>
 <029701d76c57$f4d42f60$de7c8e20$@nexbridge.com>
 <60da2e775c3fb_1da1f2086c@natae.notmuch>
 <029901d76c5d$6137bc80$23a73580$@nexbridge.com>
Subject: RE: How dow we educate our users to configure less?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> On June 28, 2021 4:18 PM, Felipe Contreras wrote:
> >Randall S. Becker wrote:

> >I'm saying the **opposite**. I'm saying this should be done in builtin/help.c *not* .profile.
> >
> >> Admittedly, I am in a highly complex situation, but it is a real one
> >> (ok, two because of a diverged path between NonStop and MVS) and there
> >> are hundreds in a similar situation.
> >
> >My patch [1] should work in all your environments.
> 
> Your patch will work in the environments but not in the use case I
> tried to explain. I do not want a single configuration of less colours
> in .git/config or ~/.gitconfig. That is not going to work in my
> situation. I have multiple less colour values that would apply within
> a given arbitrary timeframe. The configuration depends on the specific
> terminal type set in the environment, either dumb, vt220, t653x,
> xterm, cygwin, all of which may happy in short succession. I do not
> expect it to be practical to change my git settings to conform to this
> patch, so I am trying to point out that I do not see how it can solve
> my issue.

Are you talking about color settings? If so, what are the values of
LESS_TERMCAP_* that you have configured?

> The current support, using the TERM environment variable, which is
> passed to git in all situations either by the system itself on through
> scripts as is the case with Jenkins, is mostly sufficient for less and
> git to find its appropriate termcap on all platforms that I use on an
> ongoing basis (Windows Cygwin, NonStop OSS, NonStop GUARDIAN, Ubuntu,
> MacOS, MVS, USS, Jenkins). The NonStop GUARDIAN environment does
> present some paging issues that do not work correctly in some cases
> with some terminal emulators, but that's the emulator's problem, not
> the termcap specifically.
> 
> So what am I missing?

You still have not explained why this would not work on any of your
environments:

  setenv("LESS_TERMCAP_md", GIT_COLOR_BOLD_RED, 0);
  setenv("LESS_TERMCAP_me", GIT_COLOR_RESET, 0);

-- 
Felipe Contreras
