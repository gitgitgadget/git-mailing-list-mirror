Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CB0C433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbiKNWav (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbiKNWar (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:30:47 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7216C17E28
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:30:44 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id y6so9353673iof.9
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DnADtERPQFCl+GRoDdNwdmvv0EC/G0rdclSuJT4SWQo=;
        b=ZQE9tjTk3ReZYdDQObx20fjOKImh9WYLw0LG1pUOp1NxhMazVGaboR+JXLsgr9Z8TJ
         eRjm8fOjjO/t26Jcu1rS/tVvBxUvA8zynyT3J2RfCvPL6WQOkaJmioHFzo3sHDsYrFm7
         XpXqmLzoo0Rs39AsakhjAyujXBU1z8qka7ujPQD+u8SBRg+BhsLoQDIx9av5nBpfznyk
         q6xf+G698G1SwtczWtI7xO/9WLPgV/Sa2TaU/PyJ8tdbH7JxEJYvfWwNmVcg7nPx+HQI
         VwhMHfBF9M+woNHZUhxCLEZD5cJ4upyKJQQDwxtEpqhVW2EQkH68SCHAh5VWPkwlquYC
         438Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnADtERPQFCl+GRoDdNwdmvv0EC/G0rdclSuJT4SWQo=;
        b=tIIjiOZE6oQQmlket0IEgwb/bXHejSE16YP1KcejUZhy2FHvcgJM1PnfCxKkPJQhDD
         sd4PfO96E5bEbpFpdVUklKI/PMgRoEcJw84LZn37WOR9vZeDco8EIEF2UH1tBoXExo2s
         cuyiiFfJ/AARZuh8ipshuSgLT2A/Bv+7Xxr6o6eJAfySySOiMu4H173/1p7sT33EhmcJ
         v3gqnMIYof05utL7Ipwc7w4lAUbhzg+4wBgKLPNPAGhMY/S+is3w/vTf5qAtTmJvQED+
         RLza31Qhlk6MEZ/XkxS+GV7YOKGpazGkm3k8eQ3iW4TW0cOcVlqfxvWxZWOcStUDA0Wi
         pD9g==
X-Gm-Message-State: ANoB5pkaW8sDVTVcGYK3PU0//fC80YB1grzGvG26ztNXtQ8i7577MNvx
        T+z+cCds7bo/ba9kF/y4AJ0Ung==
X-Google-Smtp-Source: AA0mqf6NzLu+m69omtoq50WnsTYeNZI2GbOK/pb1BzYlGxfw0t/2toFc/t1ztZYlvjuS1W4w4+9dqg==
X-Received: by 2002:a5d:8893:0:b0:6de:139b:8357 with SMTP id d19-20020a5d8893000000b006de139b8357mr2782065ioo.45.1668465043845;
        Mon, 14 Nov 2022 14:30:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f21-20020a056638113500b00363faa1ea9asm3946093jar.15.2022.11.14.14.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:30:42 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:30:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4 0/3] Add mailmap mechanism in cat-file options
Message-ID: <Y3LBkZI6x9Iz8lgo@nand.local>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221113212830.92609-1-siddharthasthana31@gmail.com>
 <CAP8UFD1nhXnYUj9zsXwvf2tjeK1yimY3AwomU30wor1Vf-QPbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1nhXnYUj9zsXwvf2tjeK1yimY3AwomU30wor1Vf-QPbA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2022 at 06:48:54PM +0100, Christian Couder wrote:
> > = Patch Organization
> >
> > - The first patch makes `-s` option to return updated size of the
> >   <commit/tag> object, when combined with `--use-mailmap` option, after
> >   replacing the idents using the mailmap mechanism.
> > - The second patch makes `--batch-check` option to return updated size of
> >   the <commit/tag> object, when combined with `--use-mailmap` option,
> >   after replacing the idents using the mailmap mechanism.
> > - The third patch improves the documentation of `-s`, `--batch`,
> >   `--batch-check` and `--batch-command` options by adding they can be
> >   combined with `--use-mailmap` options.
>
> So the documentation patch is now part of this small series again.

For what it's worth, I'm fine to include the documentation updates in
this series. It makes it vaguely easier to queue, but I think if we're
close to merging this one down, then there's no reason to separate the
two.

> Even if this documentation patch is a bug fix, it might be better at
> this point to squash this patch into the patches 1/3 and 2/3. At least
> I think that would better follow Junio's last comments about this. If
> you go this way, you might want to squash the documentation parts
> about -s from patch 3/3 into patch 1/3 and the rest of patch 3/3 into
> patch 2/3.

Thanks. I agree with you that following Junio's advice in this instance
is good to do. Let's wait for one hopefully-final reroll and then start
merging this down.

Thanks,
Taylor
