Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B97AA1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 04:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeKCN56 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 09:57:58 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53969 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKCN56 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 09:57:58 -0400
Received: by mail-it1-f195.google.com with SMTP id r12-v6so3147380ita.3
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 21:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGIdbGeWHAo4nvwOOh3hsBWAJUPbO8uzn6qVKWO9TXo=;
        b=iQb1io1RuIV5Xoxp+aza23JXX+GFQA/1P9Pia9hKuuUOCiVoYwV+80P1EWoc28yBSQ
         nop2B+yzm2Bmrb9wAAL3ZfJ/gAl9uC2xuabx68lJHTKpTErHJR70Xv/UORFm5/24TNeK
         0JUCOffdK4xOUJfhHfsi9FOnKPeL3uDIkas4BoQfZVJMXw7s2166y9NabcwpEzJ8ckbV
         Al+hSPS4K/hMSnTrfufkLd/n3X5IFFhzqmn7r0IX7lEQJHaIFXjzl44Q86GY/TCplZTt
         MZv9nzLHJHohZA0HDJrsGP6ZionVNKTKt26RwZAgWUYz52S39doNQcKzpMD+DoNP5CpW
         7zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGIdbGeWHAo4nvwOOh3hsBWAJUPbO8uzn6qVKWO9TXo=;
        b=f87y2xcbGsoQ0uDyvaqCKnpdBESoW1/iKJFGoJ+cnHGvW1m7SC3SXHBM3YloFhkkDB
         aYaX7+qaHSyIe3jdiRsrphVgYdL6BzqzuBK1GHQk/jRlNydwEgsh0Ff2jRKKUqvJGj+i
         dhnBKg7eDKHEkMSVBIeRs6M+MQS3OOtJbi8oVLPTmoT60QyGCd9apXL88W3I66TeL/Ke
         Bn81FcuekGaPZbTe6gAuIO7GRdnrBriFgnUHxtlnJ0MSnsUAuG5jCR2aD29bcyowuOB7
         vrtBvcwC7jGUae9uZ6ThwSSAhANmSdU3t1QlsOwFrGPUA7JhZnycoiYQHkTOY+vNihhx
         1S2A==
X-Gm-Message-State: AGRZ1gJLI5+8akV8JZTF664EUjKWkN/HB77tmfPwsGw+ChZ2Qgc0jZzU
        Fp7gdS511TtOeFznAmFjzX/sXD9tYXz5AjbiH2A=
X-Google-Smtp-Source: AJdET5eYAvqjGOe4SpCgYJaZxGQA65Un46SUZ1bD/z1J4rcxCDuL1Qbbp+YeWXz9GUYUIxib91vO7v1cNUETFLFamhA=
X-Received: by 2002:a02:3446:: with SMTP id z6-v6mr4914383jaz.130.1541220479286;
 Fri, 02 Nov 2018 21:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181102133050.10756-1-peartben@gmail.com> <CACsJy8CVPSe8TWYMrK9MiRCaG36qyWfd42cEPo5844XWuTmqew@mail.gmail.com>
 <xmqqmuqrngfu.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmuqrngfu.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 3 Nov 2018 05:47:33 +0100
Message-ID: <CACsJy8AZ4kxrpttfsHOWKP=Xg3HaTLySy7sepC5691mGzfgO5g@mail.gmail.com>
Subject: Re: [PATCH v1] add: speed up cmd_add() by utilizing read_cache_preload()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 3, 2018 at 1:38 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > On Fri, Nov 2, 2018 at 2:32 PM Ben Peart <peartben@gmail.com> wrote:
> >>
> >> From: Ben Peart <benpeart@microsoft.com>
> >>
> >> During an "add", a call is made to run_diff_files() which calls
> >> check_remove() for each index-entry.  The preload_index() code distributes
> >> some of the costs across multiple threads.
> >
> > Instead of doing this site by site. How about we make read_cache()
> > always do multithread preload?
>
> I suspect that it would be a huge performance killer.
>
> Many codepaths do not even want to know if the working tree files
> have been modified, even though they need to know what's in the
> index.  Think "git commit-tree", "git diff --cached", etc.

Ah. I keep forgetting read_cache_preload is loading the index _and_
refreshing. I thought the two had some different semantics but failed
to see it last time.
-- 
Duy
