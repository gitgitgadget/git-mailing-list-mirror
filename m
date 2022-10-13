Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56DFC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 08:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJMIQO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 13 Oct 2022 04:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJMIQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 04:16:12 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28466E4E77
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:16:11 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id sc25so2187405ejc.12
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NybbH8W6Qi0W63vaqisBcFoN0w2EDwLLIH5hIhrwBA=;
        b=7OaD9lCrUBpBCNP0+gZQ+iaytcAEvdQbyD62a6raZXIDBwlsypjUJ2hqcEhvexYfki
         ZHEDRx0R5VqPpQZ86ojevWdXXVAG8vyqQRzeNzWTQ5rc3Sy6ghSBmMHNOmluWW8l2pER
         fcsAWxHILmwluiEHrKjYDRTB35RDZRNR0VaTz3ExBYc9dSFJGt62PnDx9iDsomVddyPC
         JrT2MumJufjjUYd2KQmNGQbiSfB81ATDgZ4Pz/nr6NCmmRkMYgyDZfKT+DFQrDaTK6C2
         AcGeh6i1yO7zKpTvyrUWRj+c9CsKTzo7B8ZIM13CwafAYOO0bPwI63jYooXan+chLy36
         1vLg==
X-Gm-Message-State: ACrzQf05gMwFumj28aIVKQCHH4XzL0T6iq+DUOPseB3ftmAGbyU11Q+D
        wVZ7v9VGmo1N5lMgKi1Lvf1WlM/W1KNanei97us=
X-Google-Smtp-Source: AMsMyM7RYd7URyLO6txkBNuz9JJsnCk+X5A0se7tvqY2dUAsNFq7hnTSejRSYNvfvRsc/ps4/Nwkbh9aX8ypzhoObVw=
X-Received: by 2002:a17:906:5dac:b0:78d:fc53:7db1 with SMTP id
 n12-20020a1709065dac00b0078dfc537db1mr4073136ejv.99.1665648969560; Thu, 13
 Oct 2022 01:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <CA+JQ7M-CN0UnHQDDDVz0kPcU1AcoL9+WFOeR8eiw_B=Yiyc-CA@mail.gmail.com>
 <221012.86mta1mmli.gmgdl@evledraar.gmail.com> <CA+JQ7M-y9d=c3GbpAs+Y4qtimtVs9oQ6BU1YL8nmFmF=rZxKag@mail.gmail.com>
 <221013.865ygomybw.gmgdl@evledraar.gmail.com>
In-Reply-To: <221013.865ygomybw.gmgdl@evledraar.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Thu, 13 Oct 2022 10:15:33 +0200
Message-ID: <CA+JQ7M-YptXOT0jynaT3Lwka9cR3P-WFLeh7R1U=gEz+86Q-sg@mail.gmail.com>
Subject: Re: [BUG] git fetch fetches tags matching negative refspec
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2022 at 1:11 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Oct 12 2022, Erik Cervin Edin wrote:
>
> > On Wed, Oct 12, 2022 at 11:13 AM Ævar Arnfjörð Bjarmason
> > <avarab@gmail.com> wrote:
> >> I.e. it got stuff you asked for, but also tags pointing at the main
> >> history, --no-tags will stop that, at which point you can *also* fetch
> >> tags, just with the refspec.
> > I tried but
> >   git fetch --no-tags
> > with negative refspec did not fetch any tags.
> >   git fetch --tags
> > does.
>
> Because your refspec doesn't include refs/tags/*:, try e.g.:
>
>         git fetch https://github.com/git/git.git 'refs/tags/*:refs/tags/*' --no-tags --dry-run
>
> That's what "--no-tags", i.e. it's per-se (and confusingly) nothing to
> do with whether you get tags or not, it's to do with whether we to tag
> following.

Kind of, adding the tags refspec with --no-tags excludes tags matching
the negative refspec but it also clobbers existing tags.

>
> > I'm going to set
> >   git config remote.origin.tagopt --tags
> > and then that's going to do what I want.
>
> Isn't that going to give you also the tags you don't want?

No, it excludes them fine. It also doesn't clobber which fits my use-case best
