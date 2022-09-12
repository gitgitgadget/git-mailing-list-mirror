Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21611C6FA82
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 14:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiILO7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiILO7c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 10:59:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AA2DFA
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 07:59:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso7413705wmb.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 07:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HZOMOJcn7aLGX07NZg9H56P/BsY9sd2OP4EkjY81mF8=;
        b=HgLulnD6+AwDdg73CPPEi0YKcOdoR0hsQVZK2wr+SngWiOv6BYUFXCWcIWqgtqRwIg
         6+/UonSsRMCpmzczjNKAx+5NMAkDBh6NnamuN6Cr+7SYWh6p29MvF9w/wR6gwbRsF1Dh
         Oa81PbboDzr/WCAmBjrUc2WROHWYbCP3YuojsnHlcXa8JFkcSNlC7TFXI0YVXcH5FaC9
         KMMfNtgOf8hpiGhlsOkODrqfF7YYCv+QibDc35Zt4HIv9tSj9mhHUOj33J7lKocJ+Tgm
         ILJ/QMVCy1o49+Ivjx/aN+qXMjtVhIp3wLwUTr0l77sZ58BKD43iaqi2HVR8WIDDOSw7
         j6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HZOMOJcn7aLGX07NZg9H56P/BsY9sd2OP4EkjY81mF8=;
        b=H1ebVFz+dV7kp01KH1x95zh1Ma0HkOhKgEiVnRBVXTOcqZr64UasBa7ciqqQT7TAPO
         JWUIXp0naVJObV6Dvlu+O5G3seMsVHpN5uygnX9TGWepdw2mDSOuny4T+/pqXanJnn2G
         sx1l5cc2qd8xf87EHH9unzN+nt1DO5GdRu6ZLyLrsiD82YxrmxWlod8GAHJVhSXybXX6
         T1NszxFa3xQQDgrhocdsy7kes1lXvqnDWorwY7zgKZVnVbrqeXb0a8pocsVV28Pn96YA
         7BxAspj+0hU9kML3TOeK3+DGInsagvwFn8xQL2nf5inxOls4Hom5j2jzaEva1LXv9BAG
         M/ug==
X-Gm-Message-State: ACgBeo2+PCIbW6STlE3LT9XJVY0FinEwZ10w55/syUtojmmKFKq+Vas7
        seKR0Z867DEss7NRU1/7C/SbNFRIu6wf7yzcpMw=
X-Google-Smtp-Source: AA6agR58/DLdXUWTrrnV4dMFfb6bNe2Nwhus3NnG9BREyTeiRUcW/iGFLKY8PlVMzwN8XgT6PmTnUK1lfrhvo4qeJ6w=
X-Received: by 2002:a05:600c:657:b0:3a5:e4e6:ee24 with SMTP id
 p23-20020a05600c065700b003a5e4e6ee24mr13777114wmm.68.1662994769308; Mon, 12
 Sep 2022 07:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <YxKo2l5nBoOa9Jfa@coredump.intra.peff.net> <CA+4x=b-GYMnZygHXOfNb3CdSRoxUeT80n=gSCLyfCA9WsB0wEw@mail.gmail.com>
 <Yxf9yETBi3k6Wasl@danh.dev> <CA+4x=b9M+HRWdDx-Mr4q0NiRQESwJ5uEkOBL_nVPPPHhXs7i_g@mail.gmail.com>
 <YxjhQ8xVI4YtA7xb@coredump.intra.peff.net> <CA+4x=b9upd2uTihZK5hXDULkCz6y+CX-dS7p65Pfhn0zh0eMiA@mail.gmail.com>
 <YxkI2zqCheqTv/wc@coredump.intra.peff.net> <CA+4x=b-SqzGfeTu4c8akk3quYF7ORZ5jYCpey5221H8=+_PfRg@mail.gmail.com>
 <Yxow7zrYF/xOijVr@coredump.intra.peff.net> <CA+4x=b_eOO=ThnSkMARPXBH6cJLeuYPfF-PZNy4Vjpbk=BWQYw@mail.gmail.com>
 <xmqqr10kjtcu.fsf@gitster.g>
In-Reply-To: <xmqqr10kjtcu.fsf@gitster.g>
From:   Lana Deere <lana.deere@gmail.com>
Date:   Mon, 12 Sep 2022 10:58:53 -0400
Message-ID: <CA+4x=b8kqc=_osrghenGU96jGRGX=NKbpCjheRS4yjgom8t8og@mail.gmail.com>
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the info.  That sounds kind of like this fix, even if
accepted, would miss rc0 but would be not unlikely to make rc1.  Is
there any way to "watch" the issue so I can know which git release
gets the fix?  I would like to be an early adopter of that release
since I would want to test the change works for me.

Thanks.

.. Lana (lana.deere@gmail.com)



On Fri, Sep 9, 2022 at 2:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Lana Deere <lana.deere@gmail.com> writes:
>
> > I can use a workaround to continue testing 2.37.2, but I saw in a
> > different mail that there has already been a patch for this problem.
> > I'm guessing that will be in 2.37.4.  When would that be likely to be
> > available?
>
> It is unlikely we would have 2.37.4 in the first place.
>
> The patch was already discussed and I expect it would take a few
> more days before we agree it is a good approach to take, at which
> time it will be merged to 'next'.  And then it will be cooked for
> about a week, before graduating to 'master', to be part of Git 2.38.
>
> Usually topics for fixing bugs are downmerged to 'maint' and lower
> after they get merged and spent at least a week or so on the
> 'master' branch.
>
> But by that time, the tip of the master branch would be already
> tagged as 2.38-rc0 (see https://tinyurl.com/gitCal) and it is
> unlikely that we would issue more maintenance releases for the 2.37
> track at that point, especially given that there are not that many
> other topics to downmerge to 'maint' remaining on the master front.
>
> You can see when Git 2.38 is scheduled to become available from the
> same calendar.
>
> Thanks.
