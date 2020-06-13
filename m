Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D53C433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 18:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450AE2074D
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 18:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpjoW3p+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgFMSvp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 14:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgFMSvo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 14:51:44 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0583CC03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 11:51:44 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k8so8715829edq.4
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vAi4eQt2Jur26fbaoHDFwa1qELfnRmbb+jDif0NABsM=;
        b=mpjoW3p+e5qRR0cHthsK58/UA9T5+NILOMy7qdpzSbB6/mrl9cQeJVuGjuQowlbhn1
         FKvJCfztbCNaaDkhivXixgvLuioEG4QMKrzfOgik/MH8QxSLjRbOe8+m9pLa0GwUjuYH
         Mm2Ll3+39VXfGfHG1xpqMou9kBpsw1gL04q/YNYXtugFofkukdvxlHXzBNw5pM2gSQ5u
         cKfe+N1nAnbqnrn7c1yCxYctobASt3VI/LEOHfnX8a7l/IaIixJuixI9HuiYuuopX63D
         EzEueM7G6SjHW/VoOWwU7gNISFvWoU+hM4lYbR1LdhlZZ3mwlOI+hYXMs9ny5bKVx258
         cSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAi4eQt2Jur26fbaoHDFwa1qELfnRmbb+jDif0NABsM=;
        b=dzDetFurpKvaoYzOJ1c62l39x15GlcXY7VFPlardGkiKgUcHmSm2g5VrsAj5MNooTH
         v2b3N92aTfPNjRtaLB/ooSF8JcwkWuMB5OKMJ6QR2qiwfbro5NmhikUGb8nQOlkkwqfs
         ED/TU/NQH03R6y2LcK8jV2NOBPhnxh3MH9PGOt0WXUUD+j8Zoo5WGfv5wht2KbVuvekC
         yzzEISbkakMVxJEXccEojhfiXMq+eb/hQYNxggvwzbeTJY10AMoygbuW6miMErFkbzok
         zeVJUA5sBkEIF5pMKF6bFbgB+rlMkQ3893W6FlD2ed8M258Dhv2XDyFMedQon0F6ul9I
         gT4g==
X-Gm-Message-State: AOAM5337WId8I4mpWTu8glC0vAxxIKi+Z9HFrQbbGu49Lm+MBrS6/Cnj
        cM8jcES39xQl0APPCYpr5VMQ1j6+yCqCYKmbZYQ=
X-Google-Smtp-Source: ABdhPJy8Vpne7amYe0r3r4TGnEryIHTwU6x+eHY7DjpZ7KcWwGVOBVtmU8vd62pDPcGOfb5Co/m/Qlt+CfLoK1P/fTs=
X-Received: by 2002:a50:c054:: with SMTP id u20mr17436901edd.142.1592074302597;
 Sat, 13 Jun 2020 11:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200505104849.13602-1-alban.gruin@gmail.com> <20200505104849.13602-5-alban.gruin@gmail.com>
In-Reply-To: <20200505104849.13602-5-alban.gruin@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 13 Jun 2020 20:51:31 +0200
Message-ID: <CAP8UFD119Ah1S4f8r8SnXwO0TfL7HKNKi=NKVo-aJLEJ9o++zg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/6] stash: remove the second index in save_untracked_files()
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 5, 2020 at 12:56 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> This removes the second index used in save_untracked_files().
>
> This functions creates a new commit with no parents, and a tree
> containing only untracked files, so the tree is reset to the empty tree
> at the beginning (hence the need for reset_tree() to accept constant
> trees).  The environment of `update-index' is no longer updated, and the
> index is discarded after this command exited.

Maybe s/exited/exits/.
