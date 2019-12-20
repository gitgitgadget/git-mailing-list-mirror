Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918F1C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 21:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E88E206D3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 21:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOsq3fP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLTVjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:39:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38146 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfLTVjd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 16:39:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so5932047pfc.5
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 13:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ph4Ae4uZUYGgFdwRZK2A+yfBzwvz7ycih7+qj+630k=;
        b=nOsq3fP12ulbebvjtmkl6y0A6R7wbFyMfk9TIytOEg20mTaAdgXAhR1yUOD2IeN/tK
         eIIskls7b9vXeodqR38SWE+NXzow1s+UUvSeJUd7OHA33cJOpXCarGGu5nNb3Wy25Amp
         2jBW2FsK1S0LKvSyghLlnIlRzmTjBrjY4NDZwl11LNo41fuwBTo7hSBtPfEkxh2oHV9e
         j6z8ZclyIulVGAWGBP3BoW5FbamnIYiIGqAWMzeKuleMrgN3ku/ploLuzdpqsLTqpCO4
         aSbRND+tUlSruA2n6ZHyAnQwVufKn2ZJv/yhNZ5sa5mno4GsaqrzEZXYwrqCD7HgmRkH
         +pxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ph4Ae4uZUYGgFdwRZK2A+yfBzwvz7ycih7+qj+630k=;
        b=GfAFsVScTzs6q3cizLPQAcktqPOkOgQU/yjleL5f0VPBbzWVj7vOSg/LdDdR+2bMfY
         2duYVjHC28zxumpEjI5RkEPfRQyK+uDhYKG5a5ZY+LJAfFIOZCDeyNj309SxWJ5f5X88
         nMnhcYAQ4wgbDgzRl8X/360JQVek/RQipmFOutChp2sxDkaeG+igK7tp81+Z5A3RiqEc
         TnlPWrTFLMXDeuPpUMODsxPYBR+GpBujL2JYRinfMDrjh/gRiVKU7apLHlc69MpcPhbK
         /5YzXM5gxGqRTKBt9dGFpfyAkIBD487mZk44v9S7d9qRvJSsvYs3axbECgUjxHE5D8u5
         rdEg==
X-Gm-Message-State: APjAAAV6OFsOwIwjPbxZvXcO1tPmxBAlKsQIzCe7fwFdIMPWcyU2FC0I
        EDZw0ojIAlOeXtv01T7owhlsBw==
X-Google-Smtp-Source: APXvYqxgwpAjEMPvbXPJcKQmMX490nEZTM1ArmH8of4OSiGTrWc1Nlxd2DgixKNOy02irklpHfvIDA==
X-Received: by 2002:aa7:848c:: with SMTP id u12mr17885382pfn.12.1576877972466;
        Fri, 20 Dec 2019 13:39:32 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id n7sm2066052pjq.8.2019.12.20.13.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:39:30 -0800 (PST)
Date:   Fri, 20 Dec 2019 13:39:26 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 1/1] commit: display advice hints when commit fails
Message-ID: <20191220213926.GA1876@google.com>
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
 <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
 <ebec2379207681152c6e5196a1418aca03da113a.1576746982.git.gitgitgadget@gmail.com>
 <xmqqfthgb01m.fsf@gitster-ct.c.googlers.com>
 <xmqqbls4aznl.fsf@gitster-ct.c.googlers.com>
 <20191220023125.GD227872@google.com>
 <xmqqbls2alsb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbls2alsb.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 10:34:28AM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Hm. I'm surprised to see this feedback come in the form of a local
> > change when making the topic branch, rather than in a reply to the v1
> > patch. What's the reasoning? (Or is this scissors patch intended to be
> > the feedback?)
> 
> You haven't seen a suggestion in the form of counter-proposal?

I actually have only seen the scissors-patch as a "yes, and" in
practice. I think this is a sign I should be doing more reviews ;)

> 
> > I ask because out of all of us, it seems the Outreachy interns can
> > benefit the most from advice on how and why to write their commit
> > messages - that is, part of the point of an internship is to learn best
> > practices and cultural norms in addition to coding practice. (Plus, I
> > find being asked to rewrite a commit message tends to force me to
> > understand my own change even better than before.)
> 
> It's something Mentors can help doing (I do not necessarily have
> time for that myself), and you're welcome to use the "tenatively
> queued" version as an example.
> 
> > I'll go ahead and look through the changes to the commit message so I
> > can learn what you're looking for too :)
> 
> Nice.
> 
> One thing you missed in your review of the "tentatively queued"
> version is the reversal of the order of presentation.  Instead of
> starting with "I decided to do this" without explanation, give the
> picture of status quo to set the stage, explain what issue exists in
> the current behaviour, and then describe what approach was chosen to
> solve the issue.

Thanks for explaining this - that's a good point for me to take home.

> 
> > For me, I don't particularly see why we'd want to be rid of it - it sort
> > of feels like "a picture is worth a thousand words" to include the
> > actual use case in the commit message.
> 
> Output coming from commands and/or options that are used only in a
> bit more advanced workflow and the ones that are rarely seen, I do
> agree that showing example is a good way to illustrate exactly what
> you are talking about.
> 
> On the other hand, for behaviour of basic local commands like "git
> add", "git commit", "git diff", ..., I do not necessarily agree, as
> these should be obvious and clear to all the intended audiences,
> which would be "anybody who has used Git for say more than two
> weeks.

Hm, I see. Thanks for clarifying.

 - Emily
