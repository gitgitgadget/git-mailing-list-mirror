Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D6AC43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 23:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiF1XII (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 19:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiF1XIH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 19:08:07 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55A6DFF9
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 16:08:05 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 59so22357271qvb.3
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 16:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ipwX4wqNbKRxH3WlDA+tS3/7kLPOv0QAIU449uynnXU=;
        b=vdX+Q+6qLTYDo0gdi6p4SSpViBH+duSpvyD08ggB1X+txcsBMrrIfCZPx/hdI/Y3+V
         Ns3+vO7kAAzvcpARJFQNPkOBtwVO6ypY58d7ErDuL6RQLQQ+HHxXrmn0KzHf55VzHInQ
         2SkCdlqPouSB81REYvQCFU+THMkRr3KALTPWTOgnp4igMp03LkpCSk7/htv2blfoQbBG
         /6Z9fm/Yj2exNnuqIO3dgEGikmWs+EEOQGqXdR7vKJW9f2DgRk78luo5Zo58vhxFyA/5
         MaKOQcrwfwsDgWgiThzrl9Fusc3rSI0Nim2nldEaJiBmPGO4QSqypBubVY0GsFltqJAr
         ADtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ipwX4wqNbKRxH3WlDA+tS3/7kLPOv0QAIU449uynnXU=;
        b=lBfewtV+f1CO8LE+dkeA/6l20iRasl7XtbdKv0Q4AbTA0lJ9pDmhf2/Pse3CS6s5vM
         A/pDZ9g043zIDGNbqWrbPF/581HBacp7sIRhfD5EAZe68fpHt9dseN7B3jbjyOhP9XQd
         IlXheDTi0/U5aaIkPGN/q7+APu+wFXAtcA9elK6X6mZVXI86LxRFffizaeBRaUQ+XjTf
         fQ4SmFSjOx6IxzFa0kVvcnC/m1oBHLUzc2U6UDxx94sLVLlgUv8erhwdlnlo1YEkUHJg
         g2/FATxEbPZiyb2ToDtYZ6EpAiZUfwWRK0d7BugyZQ6A+6gch/3Y2ZXnpv7pShtcC/fS
         fZfw==
X-Gm-Message-State: AJIora8ZlPslwajLEzz6ofmNuDmYYHGPQvRWYOI6O05CSDCmdSZhOilQ
        MEEkVOFBk0EJQm92Nlx5o8ON1mEM6DYcCg==
X-Google-Smtp-Source: AGRyM1uLmDm/4zeMf1B8FtG3xFausmLtUrAhtsmZqNqeUOlArIrh2jQJ8DtH1gBCVdTXpZ7K0eNDoA==
X-Received: by 2002:a05:622a:1705:b0:306:74fa:c2d5 with SMTP id h5-20020a05622a170500b0030674fac2d5mr330079qtk.387.1656457684766;
        Tue, 28 Jun 2022 16:08:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c4-20020a05620a268400b006aee03a95dfsm11844194qkp.124.2022.06.28.16.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 16:08:04 -0700 (PDT)
Date:   Tue, 28 Jun 2022 19:08:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christoph Reiter <reiter.christoph@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] add --interactive: allow `update` to stage deleted files
Message-ID: <YruJ06odaXmTOyjM@nand.local>
References: <pull.1273.git.1656454964378.gitgitgadget@gmail.com>
 <xmqqr138h0wn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr138h0wn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2022 at 03:35:20PM -0700, Junio C Hamano wrote:
> The fix looks quite straight-forward.  It is somewhat disappointing
> that it was caught after this loooong time, but as they say, better
> late than never.

I had the same thought, but I think that it points to something I've
suspected privately for a while which is that we don't actually get many
users to opt-in to features early when they are hidden behind a
configuration.

I had hoped that things like feature.experimental would cause more users
to try features that weren't quite ready for prime-time more often, and
that we'd get more and better feedback as a result.

But I think that this proves that is generally not so. I think we
should probably err on the side of enabling new features by default so
long as there is sufficiently low risk, rather than hide them behind
config. Or at least, not hide them behind a config variable for so long
(though I am guilty of this myself with the pack.writeReverseIndex,
which I have been meaning to flip the default on for a little while
now).

In either case...

> Thanks for a quick report and a fix.

Yes, indeed. This fix looks good to me.


Thanks,
Taylor
