Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEE8C6FA83
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 19:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiILTJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 15:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiILTJV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 15:09:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BC440E14
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 12:09:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id go34so22461389ejc.2
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 12:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=nM4oDq1CTUz0WvuZYVGSJESbj+beOQ9kZVcsnkgyVVw=;
        b=akqr46gx71TJgnHDYtSmws7TYslMqJ/5qxdyvbpOO2sD79Bbxk4GdvmLSuTJvP0Yhb
         6e4vkf3oUtoEqA9Zjv1jJI0da1XgbvhIudVfPowLdmZ+YgF0karmDIaW9tESdA92OuIO
         N1j5UxM6+d2wbp+4efYGtPUQt6h/C5oSs8J8NVHzK/cgNGg0BpUOjGoBRUrMJ2Eh3sm7
         NcUJRa7+tZr+SydrHjKEdx2W3L8JYKqQA5P8dyo718FGgoRl+JglwJJh0V8UpNzbR2/y
         KH/V1G+4Jze9HWsR+WCZIP+PTK/qaXgv6DEcI+WZ3iXzrOPso7VPyqgiRE2YKtIDldSZ
         GgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nM4oDq1CTUz0WvuZYVGSJESbj+beOQ9kZVcsnkgyVVw=;
        b=0DQjqlGGgILW8WoevxnbNOaiEIwjmp/c5DIbR9Flg4qEht2SqZ/LNyGIUp4ncpsgzX
         F8pdKtg45FU1MAkkvskwfrSCEWbJws07TUOf34zkedasJ6tgS2hF2seV8DlorZUOssHp
         Y8pETnKcucOosPuzJpSbChqFjS2gkIpFeFDx8nnWy78CuJnTItgAbdnBbd6Ab4pCItXe
         53atcSKzQ9i+ydF5r/wILsQOP4dXl+pjjAhgCvO56nCqbxeAyHxyi9hWBO+4m3+60irC
         XnJToASlJwV9Pt4axg4Sp6OP1jvhFvIRGcyW/a4IT5ZdcqbcoTQJJ6Z7JKCEJ1z1bga2
         H1dA==
X-Gm-Message-State: ACgBeo3ATAPuB40Ds6tbmGmNMaNIZoEtlbY+kg5mGCZSMYwxqz9QPMkU
        KVl0ZoHsAhOSh/sjYJ7HuPXWdkdBMhNGdHyG40jpgriFHU4=
X-Google-Smtp-Source: AA6agR7mJ8PJNkRoVKsQePAG0b5cmD7Mqu6K9OPb8rXZtnGmuwtdw0DmgPt9m9W3nse4AKccWS8zV16kLmBYb5h3LaY=
X-Received: by 2002:a17:907:75c2:b0:770:7bb7:9412 with SMTP id
 jl2-20020a17090775c200b007707bb79412mr19770912ejc.638.1663009759359; Mon, 12
 Sep 2022 12:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <6f729c8c43c4409faf6a11a69791f45a@garz-fricke.com> <9e0c1a2c-542b-156f-4c70-371d3a9b452d@web.de>
In-Reply-To: <9e0c1a2c-542b-156f-4c70-371d3a9b452d@web.de>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Mon, 12 Sep 2022 12:09:07 -0700
Message-ID: <CAPx1Gve=BZ3J7KH0FA_BbAnYMEFXyDyiD=tX1vBiKCfHS0JfFg@mail.gmail.com>
Subject: Re: git diff ^! syntax stopped working for stashes in Git 2.28
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Tim Jaacks <tim.jaacks@garz-fricke.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2022 at 4:16 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 12.09.22 um 11:57 schrieb Tim Jaacks:
>> I noticed that the following syntax to show the changes of a stash stopp=
ed working in Git 2.28:
>>
>>   git diff stash@{0}^!

> Bisects to 8bfcb3a690 (git diff: improve range handling, 2020-06-12).

It's not really clear to me what `git diff stash^!` (and similar) *should* =
do.
That it worked before was at least in part an accident of implementation.

> A stash revision is a merge.  With "stash@{0}^!" it ends up in
> ent.objects[2] and its parents (marked UNINTERESTING) in ent.objects[0]
> and ent.objects[1].

Right: the ^! suffix produces a negated list of the children as additional
revs (with the stash itself as the lone positive rev).  Note that a stash
made with `-u` will list *three* such revs rather than just two, since such
a stash is a three-parent merge.

You're advised (in the git stash documentation) to use `git stash show`,
not `git diff`, to get a diff from the stash's parent commit to the stash's
working-tree commit.

It's certainly possible to detect a single positive rev and two or three
negative ones as special cases here, but it's not clear that this is a
good idea.  Note that in commit bafa2d741e I made one
of the tests stop using `git diff HEAD^!` on the grounds that it's not
defined behavior.

Chris
