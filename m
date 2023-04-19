Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143AFC77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 15:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjDSPoT convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 19 Apr 2023 11:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjDSPoH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 11:44:07 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A71A5CB
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 08:43:47 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id u37so8561802qtc.10
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 08:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681919026; x=1684511026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSyjInoXNO6jciTAd2zfCpY2gJQEMtaHUJLztKyzS1Y=;
        b=kbGnQ2AThiBqVAT2vEKdC074YaGIIqikWMvEETJFXy5o4PqS8iAd2tKfEaaShZBy31
         7fSQ43I/R4qWoAL1KIP9Jed77lI0a+dMdGXyqGp1giUtQiaeLAj5vs4niE3DfB+TmhKt
         YVntb1dgBFyblYoI5SOcfcKIDriaOcrqU1XwiRTTXoEuTooJCg3y13vy/kney2rC3fSF
         EFb/anl1tdXRCzDhjiVr2YxfnH2lFaqcY/zed3omXreM+qDBJhtkRnGUo0YJUvptRI28
         NTxfH/4/u3IAZu/Vns9JQLd6bJIBOkC+GtS4FTWuEkOGBSEyHduoNZDo3jVqg7qHh1o7
         JHCw==
X-Gm-Message-State: AAQBX9etrKJeL8GJQOIxYHKBHMo6gCqEVO1LvvKroaj29J15198HiX1x
        urZ8fGhas1qilr+tZYLngMuQw+3IawptpqveP1/MchDc
X-Google-Smtp-Source: AKy350YYfqZG2CnzG/+oDTyWk37oRRpYdop00zLGYJ0ydDUSFqp7xdKdqK/qsvby5QKp0zWhEFhiR+RuUJNE5TJqWcs=
X-Received: by 2002:a05:622a:1889:b0:3bf:db77:8d47 with SMTP id
 v9-20020a05622a188900b003bfdb778d47mr7685068qtc.55.1681919026259; Wed, 19 Apr
 2023 08:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <CA+JQ7M_KuDXBaVTzVwLTx+R4-6-3TOuUOpcchkS26iiosc85Hg@mail.gmail.com>
 <CAGrwipO7odTbuKgwDmU+3hY0pEeTdjxx-_9=oufUdBzyQ_eRvQ@mail.gmail.com>
In-Reply-To: <CAGrwipO7odTbuKgwDmU+3hY0pEeTdjxx-_9=oufUdBzyQ_eRvQ@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 19 Apr 2023 17:43:10 +0200
Message-ID: <CA+JQ7M_XP6fjdut10ry9db9M3pEhp3-+zToJ93gnbHo-4p_8uQ@mail.gmail.com>
Subject: Re: Git rebase no longer defaults to upstream after force push
To:     =?UTF-8?B?Q2VtIEfDvG5kb8SfZHU=?= <cscallsign@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 5:54 PM Cem Gündoğdu <cscallsign@gmail.com> wrote:
> > If <upstream> is not specified, [...] and the --fork-point option is assumed.
>
> The --fork-point option does this:
>
> > Use reflog to find a better common ancestor between <upstream> and <branch> when calculating which commits have been introduced by <branch>.
>
> Since the parent of a is still in the reflog of origin/a, it is not
> being rebased (the rationale being that the commit *was* in origin/a
> at some point). If you want to disable this behavior, add
> --no-fork-point option:

Yes. That's it, thank you for pointing out --fork-point. That's indeed
what's causing the unexpected behavior.

Do you happen to know when such behavior is desirable? I'm tempted to
change the default to --no-fork-point but usually when something is
default there's a valid reason.. 🤔
