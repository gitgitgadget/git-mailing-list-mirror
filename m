Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A82DEB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 22:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGRWUW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 18 Jul 2023 18:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGRWUV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 18:20:21 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37816BD
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 15:20:17 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-566e793e0a0so3856286eaf.2
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 15:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689718816; x=1690323616;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RP/OrSIi8V8zEF5oUlDVZZYXlKjkXtNL+UCf7kAqDe8=;
        b=foOtNyNqob+c0y7HVoKAqNIuQbtLxCAhc8RCtLabZcodbn3y7iTBID5lsS+hORwKvS
         qQVFA3zm8JQjvtlZ1MPyerFjHc0ZY+GvNCuzh1TfkGK9Mfq41BkQILArXcbUXwyL4FG8
         QUeeKk5E+OJLjQEc50HC9kYrFEn1PdlLlzlVMGQitd7azAtyBbHJASz9N+sQ4LV/e1bU
         R5x0l9SkyGeThr3+aZcfq9hjs3KUBEER3aoRSRi/KpU9Z3FqOyOc0dSak26pOoQ1z9r5
         tle0xIXFM/mObUpoNip8jSCFXdbcknyaEP+ypkSVjKNNq4K2ACHNODt5sn4YDHgW/8Hg
         CDSQ==
X-Gm-Message-State: ABy/qLYxRQq7ucZtbbVtsjPapBebnAlvuV/fkq9nT3ieSBqjFqc8TbmE
        c6RBBOc3IYsYXiSZWUDm9lm5+OEWC7rg8Xay+L4i1CU7jHRuCy/9xioFjA==
X-Google-Smtp-Source: APBJJlFkkPG/J8DKNhyJJQ+BNdM1T7a0kitUgH7QUp01Bvmwf4myhKgvMr/O6yXn6DA+PyQroVw91N1vM/CbSp47aVA=
X-Received: by 2002:a4a:9d56:0:b0:566:fcc8:5b6e with SMTP id
 f22-20020a4a9d56000000b00566fcc85b6emr695420ook.6.1689718816320; Tue, 18 Jul
 2023 15:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAGE71k3Ccm3hBrfNgXFqO9Zk0V9FkoskgD1ViJ6eSakxdBuqQQ@mail.gmail.com>
 <xmqqfs5mgs8v.fsf@gitster.g> <CAGE71k2bdy2aYy7speu=OOStopgjzVNOPQ_-V-63aCURLibFWw@mail.gmail.com>
 <CAGE71k3c+CGT=42cfkh+2Z-BcvefojNwpzWfc_XHPkBK8psJfA@mail.gmail.com>
In-Reply-To: <CAGE71k3c+CGT=42cfkh+2Z-BcvefojNwpzWfc_XHPkBK8psJfA@mail.gmail.com>
From:   =?UTF-8?Q?Adam_=22Sinus=22_Skawi=C5=84ski?= 
        <adam.skawinski@sinpi.net>
Date:   Wed, 19 Jul 2023 00:20:04 +0200
Message-ID: <CAGE71k3tMOtyFVrmGW33RuQ3GufJg8X6ORKCwHQgg6RmXbRCQA@mail.gmail.com>
Subject: Re: receive.denyCurrentBranch=updateInstead won't update the repo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct me if I'm wrong, but I'm looking at receive-pack.c and can't
grasp one thing.

In receive-pack.c:1452-1453,
> if (!invoked_hook)
>   retval = push_to_deploy(sha1, &env, worktree->path);
... push_to_deploy is reached only if... hook didn't get invoked?

I have now re-tested and, indeed, once I got _rid_ of the hook
entirely, deployment proceeded!
So, shouldn't that be a check for retval instead, perhaps..?

On Tue, 18 Jul 2023 at 00:26, Adam "Sinus" Skawiński
<adam.skawinski@sinpi.net> wrote:
>
> (I seem to have responded privately to the helpful Junio C Hamano,
> instead of to the list, sorry about that.)
>
> Well, there's progress. Indeed I must have borked something with the
> hook, as I can now confirm that the hook works and fails as intended.
>
> Still, local-to-server pushes fail to checkout on the server, without
> any indication as to why. The server clearly recognizes the
> updateInstead option, as it runs the push-to-checkout hook, but then
> it silently fails to update the remote worktree.
>
> Any idea what could be causing this?
>
> Pushing to ssh://*hostname*/home/uuuusername/domains/mywebsite.com
> Enumerating objects: 5, done.
> Counting objects: 100% (5/5), done.
> Delta compression using up to 8 threads
> Compressing objects: 100% (3/3), done.
> Writing objects: 100% (3/3), 284 bytes | 284.00 KiB/s, done.
> Total 3 (delta 2), reused 0 (delta 0), pack-reused 0
> remote: HOOK UPDATE: 1=refs/heads/mywebsite
> 2=650585f1c2abdbbd68de71acfb31b5d66ee1d0f3
> 3=adc4a555cfc23e037ad026a405a13e7a468188c4 GITDIR=
> HOOK PUSH-TO-CHECKOUT 1=adc4a555cfc23e037ad026a405a13e7a468188c4 2= 3= GITDIR=
> To ssh://*hostname*/home/uuuusername/domains/mywebsite.com
> 650585f..adc4a55  mywebsite -> mywebsite
> updating local tracking ref 'refs/remotes/myserver-mywebsite/mywebsite'
>
> --
> Adam "Sinus" Skawiński



-- 
Adam "Sinus" Skawiński
