Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E591FC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 14:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71821206B7
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 14:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="OsOh1N/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbgFSOAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgFSOAg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 10:00:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD339C06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 07:00:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l10so9789567wrr.10
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 07:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxGXwr1mMeJUlfm4E73Hew+mH1wHuuO4i/CzXkxdeD0=;
        b=OsOh1N/fkLAK3VaKweR2pFwTFivQm0Tg77ra/giJFQuesvxud5N9pEziiCPIkiRmqC
         QkkMMhAUxL8cri5YgwvLFjkO6wIVIqieu5ZABfrN3TGxvUPinD9f6lKUalr2kvoHcZiJ
         Kl6gUF1d8iw2bJgsn8jVIHcvKwgKyKiRzM80Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxGXwr1mMeJUlfm4E73Hew+mH1wHuuO4i/CzXkxdeD0=;
        b=m07R9i9yAghYgzMs4WluKNVwdvCKwX+JFGgf9LKKvLCmrV76DfK1YmK4S1WXNfNSBm
         5m8fanln6dl2kBCnnR8KlCUA5fBlixYFOvZrmAgmeStMlOQm6H4eaPBXUl+1gRszwC/w
         kLfHHYqj1Dr55O2kl4pqaRQTg2ilMFEqkIzjzkBAMR5Kw5RP50B2rqJD+dMYbf6hA5Gu
         FGFrqkDb+4HfeNpdkvJUPTGy+hOGst/FDQ7oAR3DAg6r3aR052KYnUojX0Ok9o1w9LC8
         iQg1GtDAt6Jr/K3D/nMtH+HUpfWe3RQH/N23sx7My2LwnQ51tKScWuwPfbWaBXtxuO1U
         KPLg==
X-Gm-Message-State: AOAM5334HLynhzAXlzmLn7kgLvDGZAgwuWm2KPcJ2SIPbqhV9/BSQka6
        EtR6uDS64H2stcFFcWBvLgbTyyX/DS9NHC2TcjokzXTo2pk=
X-Google-Smtp-Source: ABdhPJw7cAv57yVMlF6ANPx+p9jCoGeQJ68IpKn22ZW66ct09jPFz7jYgLWghNBTb1PG29hOKBQR6ZGSMa+XqJCUFwQ=
X-Received: by 2002:a5d:408c:: with SMTP id o12mr4239931wrp.412.1592575234113;
 Fri, 19 Jun 2020 07:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5ih79vZDzKQ1TSNTrL_64XjZH-DJTPqdPH5NMwOrsbaH=n+g@mail.gmail.com>
 <20200617232018.148877-1-jonathantanmy@google.com>
In-Reply-To: <20200617232018.148877-1-jonathantanmy@google.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 19 Jun 2020 15:00:23 +0100
Message-ID: <CAE5ih79Rf3Zygr3mJ30Xew2AWfHs2c67qxjBNBZ=Vpo7raUTeg@mail.gmail.com>
Subject: Re: git clone --filter=blob:limit=X interaction with submodules?
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Users <git@vger.kernel.org>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Jun 2020 at 00:20, Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > I noticed that if I do git clone with submodules, using
> > "--filter=blob:limit=whatever" that the filter is applied in the super
> > project, but appears to be ignored in the sub modules.
> >
> > Is that expected behaviour? Or am I just doing it wrong?
> >
> > I'm using git 2.27.0.90.geebb51ba8c.
> >
> > Thanks
> > Luke
>
> Yes, that's expected. The main technical reason is that a lot of the
> subsequent submodule operations may read objects from the submodules,
> and those could trigger on-demand fetches (if the submodules were
> themselves partial clones) - but right now the fetch code is designed to
> run only on one repository.

Would this also explain why I get errors when syncing my superproject:

$ git pull --rebase
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 2), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (3/3), 844 bytes | 844.00 KiB/s, done.
Resolving deltas: 100% (2/2), completed with 2 local objects.
From ssh://whatever/somerepo
   7a9c9e1eeee..3325285b122  master     -> origin/master
fatal: git upload-pack: not our ref edcedb543a8b85c659ab7cb507bdb0211fb21bdf
fatal: remote error: upload-pack: not our ref
edcedb543a8b85c659ab7cb507bdb0211fb21bdf
The SSH command failed, please check the server logs for details.

This happens consistently when pulling from a repo that was originally
cloned using --filter. The same repo without the filtering does not
have this problem.

>
> For those who would like to improve this state of affairs, one step in
> the right direction would be to update the fetch and transport code to
> support an arbitrary "struct repository" passed in, and not just operate
> on the_repository.
