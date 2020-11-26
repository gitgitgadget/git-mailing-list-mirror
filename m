Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96700C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 07:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3562620578
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 07:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci448KWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbgKZHHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 02:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732858AbgKZHHs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 02:07:48 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68260C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 23:07:48 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id bo9so1308204ejb.13
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 23:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h9KWmCDaP+gaHJLVf9B14Cz/caBFQM6zH7BA0ZK5ILY=;
        b=ci448KWSV/K9kQdnfm1u0yPsimYAPT1gf/7OAJIHppIDeQZuCEaZOi+Hc3ILJqJy+w
         ojSZtP7887MjjhE+HEJLvNlLq1SoVH7wP8GSiFzoMxt5EpPLev31iRTuEiJENJZy9NjR
         TvcMw+Bk8rijdR+YS6cKRlVPMdhFHxCUslLaLcr6zwTQ7RqzmGPfGLB4mDkc3rh5C1/h
         K0aKtzI6QO/dFJ4I2WcUE1uYwSSk7GxKuCOJTXTU55gSZiSam67w+AEJI6u0Dsl3cYnq
         xozIETmmUXgnCJjpczYUjcl5riGJc4gdUE9jAlGMHcC93ZxlAic88sCOdu8ZTojwgL8/
         zWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h9KWmCDaP+gaHJLVf9B14Cz/caBFQM6zH7BA0ZK5ILY=;
        b=r6gYchvWtTimo45ou7sj6v9n7rUgdRUarqaB6sSzvBOlqweBkOq/aIc2Hd+hd6ugCp
         VNcmF9Qdw94BP5W9HNuZFg4mwW77lCrQ3/6nkTJ7/+BCjtzCZJ01DbBAnnqFmTedNsP6
         VjLBMoUBOka8ZWAxhh32EvNzgvQ3byS/s11RFC5Pza6uKpYrluZixCC/fhD/J95BPv/K
         FMSPGhzH65HISQHowFdE8CeuB+eEfrDjlAbCF72L7mCCGkB6V4bvzdTXSdSoyBtQJvxR
         PgWqy7UnMvjnjsNQlU1T4HRPqMwfcVHUZLXqGxErS94wEQ1+6XwcxLeg+sdL4/jX5giA
         Lv0g==
X-Gm-Message-State: AOAM530Jkt4MuvOR4Gb+LEDeNMGobe1XUyweqcW+3yjs/15MCOnQLRh4
        DAQSAVRkTaz0j3L6BGYk5Pc=
X-Google-Smtp-Source: ABdhPJyhno9MPN/Hw3ky9PFmrbR6qd2ujWzYTRAcJvMpKLAG4eG3kRZbyGT4CED8RuGNAPGIdpoklA==
X-Received: by 2002:a17:906:46d6:: with SMTP id k22mr1402516ejs.542.1606374467144;
        Wed, 25 Nov 2020 23:07:47 -0800 (PST)
Received: from contrib-buster.localdomain ([79.140.115.35])
        by smtp.gmail.com with ESMTPSA id pk19sm197123ejb.32.2020.11.25.23.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 23:07:46 -0800 (PST)
Date:   Thu, 26 Nov 2020 07:07:44 +0000
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] maintenance: fix a SEGFAULT when no repository
Message-ID: <20201126070744.4vwesc5dpnnl7u5v@contrib-buster.localdomain>
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
 <20201124164405.29327-2-rafaeloliveira.cs@gmail.com>
 <CAN0heSpjYEZbjXcX-XSvwwBKOEQ=Dtk=Nnr3T+BOqB+fd7x4sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpjYEZbjXcX-XSvwwBKOEQ=Dtk=Nnr3T+BOqB+fd7x4sQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 08:03:33PM +0100, Martin Ågren wrote:
> On Tue, 24 Nov 2020 at 17:47, Rafael Silva <rafaeloliveira.cs@gmail.com> wrote:
> > @@ -1265,9 +1265,14 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
> >  {
> >         int i, found_selected = 0;
> >         int result = 0;
> > +       char *lock_path;
> >         struct lock_file lk;
> >         struct repository *r = the_repository;
> > -       char *lock_path = xstrfmt("%s/maintenance", r->objects->odb->path);
> > +
> > +       if (!r || !r->gitdir)
> > +               return error(_("not a git repository"));
> > +
> > +       lock_path = xstrfmt("%s/maintenance", the_repository->objects->odb->path);
> 
> s/the_repository/r/
> 
> (The preimage uses "r" and you check using "r".)

Thanks. will revise this in the next patch version.
