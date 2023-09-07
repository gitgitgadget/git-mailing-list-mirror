Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809D7EC8726
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 17:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbjIGRvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjIGRvf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 13:51:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6620A1FD5
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 10:51:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52e64bc7c10so1682529a12.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694109032; x=1694713832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCFAFls9SIOX0sYO31cofVXl7TI/5H7PX+OHInoANKM=;
        b=VPLTYghOO1XcjRAeKB+tEx5dVs+3MForI6HynckGDFxu7FqONHo28EmC6bzMKnSqnN
         Oma1hiB2UxuLVEKGIh3R7t2WjMiYug/FndaKjbCWOd/LCl8umptVl8fAPa7xA8yHTjBZ
         KS2oQ1eEP9ahvFsQDFTlbm1qwBUQcU1/NsfvvI9M1gLWAIs+281PYQAGenPk0n6Cxdhf
         7ipwiBQInNujbNilkkcNwtlp2m+/MFEK4ap9j3OV6/HbPPTEFyQDYt3beX3PRoYRuFEY
         HAeAXWIJjWJ3ehoM9HtjhPEneh0WYP6RkKidlw220dsMhH/+xHBBgCv69QmCSoHkb4MD
         DU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694109032; x=1694713832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCFAFls9SIOX0sYO31cofVXl7TI/5H7PX+OHInoANKM=;
        b=ki4AqWyrp2vqDtOBh6dSnJg43iX0hgdv82uqWHTNx909aAuH1hdie0roIbJ8tPOBXa
         ZuOthymVqYFNGXRkdTXJ4+IgIiJQvNl40kjRIgYUIZZJdSzBtq4RTuBLw6syUNrbMZ/X
         sH72Gzz+3MCntANDzDiRj2V74xjaoec/7t6qUYbc+nTyOcg4Bb+fXUw7iAQWA0fpR+O2
         suj4SDLCmeAxmGf4GCkg95ybFMNngRcXm/YPaihfyc7CF5FEDr6wbPQThw9in7HVHTHf
         ArYGI5fqyxtiGhE5VCtNYarjoATcfuGTeUwgfHuL0ITMTtC42nQpuCinFTbH+WJDB3Ib
         Go1w==
X-Gm-Message-State: AOJu0Yx8HgKEzz9V3XSffeLrgBJhFspy91WfrkuJzyoGmfe4LSS9PjmP
        KO9pJTraF0OKjm+zsvi/qUPtZo2nI8jYpp0tDzbXpGwr
X-Google-Smtp-Source: AGHT+IGzVVkWtx+jUk6zHaXCM6B/HLJAIj5aOtZkfca2pg8G9tEdJG2A7IilcFZBWRUHeJzEgzcAUi19MJjd9RIP1Cg=
X-Received: by 2002:a17:906:31d2:b0:9a2:2635:daab with SMTP id
 f18-20020a17090631d200b009a22635daabmr4544240ejf.47.1694075611335; Thu, 07
 Sep 2023 01:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com> <20230602102533.876905-13-christian.couder@gmail.com>
 <xmqqy1j3itdw.fsf@gitster.g>
In-Reply-To: <xmqqy1j3itdw.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Sep 2023 10:33:19 +0200
Message-ID: <CAP8UFD0iUGutbN7eLV2kmztXn5SjXMv47B7PTScE5d6sQoKgHw@mail.gmail.com>
Subject: Re: [PATCH v3 12/15] replay: disallow revision specific options and pathspecs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2023 at 11:16=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > +     /*
> > +      * Reject any pathspec. (They are allowed and eaten by
> > +      * setup_revisions() above.) In the future we might accept
> > +      * them, after adding related tests and doc though.
> > +      */
> > +     if (revs.prune_data.nr) {
> > +             error(_("invalid pathspec: %s"), revs.prune_data.items[0]=
.match);
>
> This made me waste a few minutes wondering if and how I misspelt my
> pathspec elements.  If we mean "no pathspec is allowed", we should
> say so instead.

Yeah, right. I have changed this to:

            error(_("no pathspec is allowed: '%s'"),
revs.prune_data.items[0].match);

> > +             usage_with_options(replay_usage, replay_options);
> > +     }
