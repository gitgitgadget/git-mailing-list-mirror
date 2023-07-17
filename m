Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EC3EB64DC
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 22:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGQW0z convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 17 Jul 2023 18:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGQW0y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 18:26:54 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BE399
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 15:26:51 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-560b56b638eso3115774eaf.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 15:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689632810; x=1692224810;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAwwEM1ybB3nIXprXFV8hYAdF/40X98UKkvVHy4Bzp0=;
        b=KXDeyNbQLScywlpygG7gSX/SbkBxkhNtdFWR7lz1L5ZeNT/+xZ4yMNnqd0sCuk4/97
         x15BSOnmJ1hGM5J9/gDnZ83ez0BlT2rryoJV6duxpRyUgXxBqa9nsgVCAw9AjrTyMMaM
         iYsNwv7Kl3CPwEIekFPuDqVvi7L9qKSTa0BWZD1rjTjqH96vkloa5L8NmAPPAWzAWX1q
         S9DsgysowHQfPCdHLR2vj8WODzPq3cpKDQggud4TRa722OLsaajSRFWvqRegYGPtalJm
         uZsjjKU+XtOrRCUVZEQ9ryshp4QnTGQSI25ObDmFIS8jDGGJTVwyLOdu5AHhB8+G0xIs
         +6bA==
X-Gm-Message-State: ABy/qLZuEhv4mlwTSP+lCOFUF43MmDQcCWx+Nrb7985v9YIllHrmrbKG
        3zfklmQfy10wyv1kzbmAUY7W2zFrG4Ivyaow+9ac6FpbEJnFxjZLNx4=
X-Google-Smtp-Source: APBJJlHsfgUylUcLGBDReriapZqII3cANdTKcyo+ypnpxYf9nuVUTUt5bojzmnK4uGR1I5A8N3LwV/z3CLUBb0FMtTc=
X-Received: by 2002:a4a:df0c:0:b0:560:c558:b6f9 with SMTP id
 i12-20020a4adf0c000000b00560c558b6f9mr5390791oou.2.1689632810096; Mon, 17 Jul
 2023 15:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAGE71k3Ccm3hBrfNgXFqO9Zk0V9FkoskgD1ViJ6eSakxdBuqQQ@mail.gmail.com>
 <xmqqfs5mgs8v.fsf@gitster.g> <CAGE71k2bdy2aYy7speu=OOStopgjzVNOPQ_-V-63aCURLibFWw@mail.gmail.com>
In-Reply-To: <CAGE71k2bdy2aYy7speu=OOStopgjzVNOPQ_-V-63aCURLibFWw@mail.gmail.com>
From:   =?UTF-8?Q?Adam_=22Sinus=22_Skawi=C5=84ski?= 
        <adam.skawinski@sinpi.net>
Date:   Tue, 18 Jul 2023 00:26:38 +0200
Message-ID: <CAGE71k3c+CGT=42cfkh+2Z-BcvefojNwpzWfc_XHPkBK8psJfA@mail.gmail.com>
Subject: Re: receive.denyCurrentBranch=updateInstead won't update the repo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(I seem to have responded privately to the helpful Junio C Hamano,
instead of to the list, sorry about that.)

Well, there's progress. Indeed I must have borked something with the
hook, as I can now confirm that the hook works and fails as intended.

Still, local-to-server pushes fail to checkout on the server, without
any indication as to why. The server clearly recognizes the
updateInstead option, as it runs the push-to-checkout hook, but then
it silently fails to update the remote worktree.

Any idea what could be causing this?

Pushing to ssh://*hostname*/home/uuuusername/domains/mywebsite.com
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 284 bytes | 284.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0
remote: HOOK UPDATE: 1=refs/heads/mywebsite
2=650585f1c2abdbbd68de71acfb31b5d66ee1d0f3
3=adc4a555cfc23e037ad026a405a13e7a468188c4 GITDIR=
HOOK PUSH-TO-CHECKOUT 1=adc4a555cfc23e037ad026a405a13e7a468188c4 2= 3= GITDIR=
To ssh://*hostname*/home/uuuusername/domains/mywebsite.com
650585f..adc4a55  mywebsite -> mywebsite
updating local tracking ref 'refs/remotes/myserver-mywebsite/mywebsite'

-- 
Adam "Sinus" Skawiński
