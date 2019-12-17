Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89487C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 13:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7BD21739
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 13:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsSkqqqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfLQN76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:59:58 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:34775 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbfLQN76 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 08:59:58 -0500
Received: by mail-pj1-f45.google.com with SMTP id j11so4637983pjs.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 05:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VhmqFL3It1Sda39yVVecutYBawtF/aGa7S0wRDC77Pk=;
        b=qsSkqqqA9sib0Ttxy3cPjpCGuiMmTdF6gfEsdjayPFbBl0+8OmdyHN2f/uF2TLBUBQ
         5FDoagElLz9U7uFa/DhD9E24OR6DnwGMF82MnP6qnRVDaa/8BFzK9M44vbpdbxjcQdMw
         Dw119JhBxfjDiz6/WntjQuhl/vDrPLpHz5eAX8+g2oCb+CVRwfHiNGMdznGtCq3JXxVn
         82fMcGHmahXBNQr6xbYz6WCRx9yJZIL6MY3+QHlpSCmslvaHY9q2A7FQO7hFPDq32T3v
         3sz0brlaTw2TqnAIAbfAFEILCOcW4I/bxu6r2Ot/+RV9Z5WUdKtf2rd/SmNN4OGy6WRj
         tC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VhmqFL3It1Sda39yVVecutYBawtF/aGa7S0wRDC77Pk=;
        b=aIm9GpLVaRezXWe7YnqQMvIyAtKVCAmTlGjwdLd9KHqCAzVmaXySfHtQo78VHqZprj
         ehdjNokdBQIVivwASjqmrwnuezdti3MjUuDE0TsiIXS1uHkTaIQYIwDsBmhxEuFX6ISk
         koPiyLzaDHy8P3TcoI7F959ON7yVjLFQJ8bofNoYazK3HTSxAiwec28dn3hmIzgRJNtX
         cOCw3EZpW98racYDd/sn4465Pp2o/t20JHDvDDL8isOpWTY1zbEbRPO+G6hCr3HgPGsL
         k2QlZ3Sjr4pJ56BTzoWMWYnMnDfV1Xhcg8uj2abx67r3U5qs18GcxCgEuj2CJEnwwoyF
         WdRw==
X-Gm-Message-State: APjAAAUkqoUq8NJpsINviZm6MZJNptKN2boyR6F69C07fuWx1QAGEfGc
        JQyhtReK2iJo4eumQDYu5sCT5K8m+Ic=
X-Google-Smtp-Source: APXvYqy532pQtTkIF/Fx9pd7M9h0RBPjS1QwakZZmEcvhkIR9G4urZTGS1MgoA8R6NFm6bGY6vqpqg==
X-Received: by 2002:a17:90a:3aaf:: with SMTP id b44mr6314172pjc.9.1576591197353;
        Tue, 17 Dec 2019 05:59:57 -0800 (PST)
Received: from localhost (189-24-235-46.user.veloxzone.com.br. [189.24.235.46])
        by smtp.gmail.com with ESMTPSA id l15sm3647304pjl.24.2019.12.17.05.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Dec 2019 05:59:56 -0800 (PST)
Date:   Tue, 17 Dec 2019 13:59:45 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Marce Romagnoli <marce.romagnoli@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Fwd: `git stash pop -q` is deleting files.
Message-ID: <20191217135945.GA5103@cat>
References: <CA+0NiBEFssPJsQ8UV6vRNBxzUEsJddF4Q-=-xVq-xgNUtFbHUA@mail.gmail.com>
 <CA+0NiBGcYwu1Gyyv3AQEbfQCMiE0rrurzgkQzwsjHgi9cEj4wQ@mail.gmail.com>
 <CA+0NiBFU46YRBFEbngK+Rc0e4uE_nSqQkYak9a-_UoTaCCb1Jg@mail.gmail.com>
 <CA+0NiBEifgam1xVJw7F=mO_DtLgfqK9g7eHJMK5dt3yc1JpaAQ@mail.gmail.com>
 <xmqqd0cojd7r.fsf@gitster-ct.c.googlers.com>
 <CA+0NiBGQHK_bVdH11zRErxNTjvyU-SqJYj=CHZy3afm47+reYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+0NiBGQHK_bVdH11zRErxNTjvyU-SqJYj=CHZy3afm47+reYA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[please don't top-post on this list]

On 12/17, Marce Romagnoli wrote:
> But it seems is still happening to me in 2.24.1 -latest-

It being in master doesn't mean it has made it into a release yet,
though it means it will in the future.  So you have a couple of
options in the meantime:

  - Compile Git yourself from the 'master' branch
  - Go back to an older version of git.  v2.23 didn't have this
    problem, but it had a different issue that I was trying to fix in
    34933d0eff ("stash: make sure to write refreshed cache",
    2019-09-11), but where this bug was introduced.
  - set the stash.useBuiltin configuration option to false, which will
    make you use the legacy stash written as a shell script.  This
    also shouldn't have this bug.

> El lun., 16 dic. 2019 a las 20:13, Junio C Hamano
> (<gitster@pobox.com>) escribió:
> >
> > I think this has already been fixed with
> >
> > http://lore.kernel.org/git/20191113150136.GB3047@cat
> >
> > at the tip of 'master' a few weeks ago.
> >
