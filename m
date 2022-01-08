Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27A3C433EF
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 01:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiAHBCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 20:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiAHBCi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 20:02:38 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DE3C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 17:02:38 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id q25so19777912edb.2
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 17:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jK2xRUmKwpDUd7n8lKoOAUKgFlSdI19/8IJ+6ijg0JM=;
        b=ZOs6S9z1ocRZErLwZdOgVKPDu/M4mcNwdS4h2QO7TteoX7V2PXlrQKcRfvRNXWgO33
         cowckaVB5WVuh0a4OEvmi7VUypQRrVRTFSd5HBxMzDP0U5XXBwlVSzCpz3jNpbZWCkM1
         PeArqRv0bJs/JTmTkIB/JSWXpTqaBzwEkSbB3L3bAB3Wvq7pTuazK7xDdWZtya7ys6JC
         ya5uZmS8PM5tY7+c+OQeBXWqIeQr/ft9Puo3NmGiw1d282jcLhKf5a/T2k24N3QZOUo4
         4RLJ2VliVbxg9jEwoAOU9tZbKLvw7LQIa2/llERSqkiraYJOrMwZzeQAcYNMI4MZsCW4
         KpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jK2xRUmKwpDUd7n8lKoOAUKgFlSdI19/8IJ+6ijg0JM=;
        b=sGzgGO6GIwOZ4KqQ3hvrqNs6gzpxAlBsVq9XBPCdltPJI+FTJRWVlXPkUesuyoip1V
         aGqFDd2cOVP6WIn6zcS3lHVY+miGdO/CrRE0AgpOKSLkraHHGD35LItLIPFNenp6kwEr
         IyZ3aKLsEWvuHHmrZwXQ+JQuNumMqMPJDz7sT02ZqZt9APhHZw4+hkbjIuE+ibRplMzn
         ZAWXOJ/toD502dcABfx2vTaqaAsCKjQMtSN7Ms509Wit2yXgbK8b7i6b+rL9t7e6fUme
         L5ZAgZsN0+VuttD9P861JRlGvv3z6t/Z4L1t3GlIRciTXWmkNpynZune44csZ3hlWUMM
         2M2Q==
X-Gm-Message-State: AOAM533xmnU0OeNasWo/Nzo08PBlhGobjwMS5eQsYj/MYTfvu/gmQoE4
        lBiurLvdzblvK/mt+5wtuWPdq3aM9IyTF2k8IUA=
X-Google-Smtp-Source: ABdhPJwxMbnE1RYlC2wS0fKZoqE4GuDUtBcOAJMeXhF27w0eJH/GXJy8JwZecpPvAsLoa95zd1rrud+HkGuL8+OJt7U=
X-Received: by 2002:a05:6402:34ca:: with SMTP id w10mr66163191edc.359.1641603756952;
 Fri, 07 Jan 2022 17:02:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <4b513a6d696b8e6ff2c1b669059fcd8747bfa10d.1641403655.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201071906050.339@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201071906050.339@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 Jan 2022 17:02:25 -0800
Message-ID: <CABPp-BFQTTakkeDkwbiq41ie++dKeje3nGKWMp1Gm-YmvrevJA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] merge-tree: support saving merge messages to a
 separate file
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 7, 2022 at 10:07 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Wed, 5 Jan 2022, Elijah Newren via GitGitGadget wrote:
>
> > diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
> > index f7aa310f8c1..5f3f27f504d 100755
> > --- a/t/t4301-merge-tree-real.sh
> > +++ b/t/t4301-merge-tree-real.sh
> > @@ -78,4 +78,22 @@ test_expect_success 'Barf on too many arguments' '
> >       grep "^usage: git merge-tree" expect
> >  '
> >
> > +test_expect_success '--messages gives us the conflict notices and such' '
> > +     test_must_fail git merge-tree --real --messages=MSG_FILE side1 side2 &&
>
> Since we discern between exit status 1 (= merge conflict) and >1 (fatal
> error), we should probably use `test_expect_code` here.

Good point; will do.
