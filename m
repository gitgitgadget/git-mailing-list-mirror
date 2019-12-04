Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133FDC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75522073C
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJa1fFVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfLDW3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:29:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41713 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDW3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:29:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so538483pfd.8
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gLjviuHZWumRZuKqrIY3orpRe0ZLQX7kuQn+hIhNN+8=;
        b=OJa1fFVyMVGpU7iwqvPZ24s0seiNdHqDs7w4+auR546YrD4euoMJn6oMIie+koFBnB
         XLLznssAYKF/8zFKzO6YjGUHpEnScn/KtHHIILRI3nu0rDz09Q9mAA2da7232u8dV8ET
         58eHmpnEpYCi68zTy5JCRd25eiG66DhfvbsiVUzmb1dwSvfSrki82kzOnjUMHnvbJ/8x
         Nj4LgvV9LdTqfeLuJbv7qAnpYAe+IwgXBEIUA6mIW5OvJjTgYJ7BxO9Z9gkhLkbEjsRg
         FVTqTOHYCwYfxkwEYp0uhpZANfRsGu33WVo6F1YMq5Di0DwKOP2v+IEtR+mFHHJq/J+C
         CdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gLjviuHZWumRZuKqrIY3orpRe0ZLQX7kuQn+hIhNN+8=;
        b=HvNb1olUjnSGEyUVT8R/Z6BZITz+mIasL1IPw4FlGR8LJpxgTda/yQ2Nwfwx9QAd4W
         Me7GiACThABy+KUs+itz4kus7WiCo2qXJIKzvLJDCpCthGEZCpNaAauIxKl5FbFqqVjM
         hyv01NUSXagzxEaPdeW1sjx+Q5t1wMXSDYbKOquYZsgvyn3NiDwQ4Pge4YteG9XsIqQB
         qNiiBFr4J5mxD+fAQaMmr+4EPH4LTH5LNj7n467Kv/4C/qNrgTbqImFB6yJbuiulBdR/
         BeaOLWriZuTOGKeIIJBZljQKhJaVlb3YL4g/QOP5CaJdbC28VONGnf4kh5aIpfXbJQkP
         GNuw==
X-Gm-Message-State: APjAAAXE/6eGS1E8wXuGJrNr1C+qUB1tDMSOFpX69QEUzd6a8cYdqAL1
        56FnO8Yqx6zkraALqo/1eoj860fJ
X-Google-Smtp-Source: APXvYqzm3wEm5aPnGa+eBJHsxobNgTDBbonhE30M6rpUZdlbBSP8EfmdaMjVlxXVNj3PHfE2CfBkfw==
X-Received: by 2002:a62:d444:: with SMTP id u4mr5799943pfl.153.1575498563644;
        Wed, 04 Dec 2019 14:29:23 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id i127sm9828091pfe.54.2019.12.04.14.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 14:29:23 -0800 (PST)
Date:   Wed, 4 Dec 2019 14:29:21 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?5Yqg6Jek5LiA5Y2a?= <kato-k@ksysllc.co.jp>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH] gitk branch name encoding utf-8 probrem
Message-ID: <20191204222921.GB195537@google.com>
References: <TY2PR01MB24271C32E2FD9FD8C27CA8C2CA5D0@TY2PR01MB2427.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY2PR01MB24271C32E2FD9FD8C27CA8C2CA5D0@TY2PR01MB2427.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc-ing Paul, gitk expert)
Hi!

加藤一博 wrote:

> Here is a patch to gitk branch name utf-8 probrem.

Thanks for reporting it.  Can you provide a short summary here of
the problem that we can use for a self-contained description in the
commit log?  See
https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html#describe-changes
for more on this subject.

May we also have your sign-off?  See
https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html#sign-off
for what this means.

Thanks and hope that helps,
Jonathan

> See issue
> https://github.com/kkato233/gitk/issues/1
> and fix it 
> https://github.com/kkato233/gitk/pull/2
> 
> 
> ---
> 
> diff --git a/gitk b/gitk
> index abe4805..3f61a5b 100755
> --- a/gitk
> +++ b/gitk
> @@ -1780,11 +1780,15 @@ proc readrefs {} {
>      global otherrefids idotherrefs mainhead mainheadid
>      global selecthead selectheadid
>      global hideremotes
> +    global tclencoding
> 
>      foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
>         unset -nocomplain $v
>      }
>      set refd [open [list | git show-ref -d] r]
> +    if {$tclencoding != {}} {
> +       fconfigure $refd -encoding $tclencoding
> +    }
>      while {[gets $refd line] >= 0} {
>         if {[string index $line 40] ne " "} continue
>         set id [string range $line 0 39]
