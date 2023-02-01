Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DD7C38142
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 18:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjBASyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 13:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjBASyp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 13:54:45 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2F47CCAF
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 10:54:45 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so2946785pjb.1
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 10:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHR8mxJQjtHWq/FmWyX0XvqmHq8u3JJowiJfYydhHVc=;
        b=KW32P3atJpeo7y8HRLcNOmYuWZwtzWvyz7xISN/gOqUuub3dvmZ+IWstfoYRevZy/K
         QreakV4kGqThTzYLNzpEoV7acoZk84bGiwLO7Ooe0BTvBmMO+0ZSyj306qyYW9fLhwpb
         lIwzJEwKaEGIE7dnn7uAQkqbuChvdVuJ6Z+SovY3zp3XrigX+5WCZswplVsxX9cuHRb8
         Ed0DQdUGRgTivjtOgdWl+D8+zLNxC6tUGl4VPK8E7KKhCusbirklESYFic45id46snVE
         NzEhNO08V5V/nA3sDr+uTi+9mcjGZtmUDWlRKuqHOoqOvEW7dsXwcTFBqRgtzMNFWOJL
         go7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XHR8mxJQjtHWq/FmWyX0XvqmHq8u3JJowiJfYydhHVc=;
        b=7+1sN9ZfANHh4bV3a9AH2X5pCWYOutuZdusmr76snWetFfyXwyLYseZMGIHwtqY/Yq
         x20IRYXrOaEa51oa9K3ULSyi4jUxU+FZ/LA+YElx8qGpfPipH7kq3IGOo/txvjFH0fLY
         U/8b2VeXqi8lPd749e7lsyaTGms3SgFRxALUDYXWHcj5Q7+IOlW13CeZic1ROMWr7dmP
         eX6zok9RAniMnILmFlwcVuahSbJxs1fSmRRk+JdvPBNZ+tFIicF2PDq3J0wkm12nJVcL
         Oqnocs7qpT7f3gXGXOgrk4HKegogH5WV4UQ4m954AIxrIbgCFFlePhJdjiMtedm/Gc9+
         ZtyQ==
X-Gm-Message-State: AO0yUKU59higrhP8GElFEhkre3v1q947DxdanyihDhh032YfoET6VG17
        j755uRReQOk7wKrjMP2xglk=
X-Google-Smtp-Source: AK7set/lpmUoQQh6gFL1fhxMFY425ur4iSooKhuA0VKHx8FYVw7+BGUImcOGYnnfuy5zAVkvbNnk1A==
X-Received: by 2002:a05:6a20:440c:b0:be:bf28:b7da with SMTP id ce12-20020a056a20440c00b000bebf28b7damr4961414pzb.20.1675277684406;
        Wed, 01 Feb 2023 10:54:44 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id e185-20020a621ec2000000b0058a313f4e4esm12228118pfe.149.2023.02.01.10.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:54:43 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     demerphq <demerphq@gmail.com>
Cc:     "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: grep: fix multibyte regex handling under macOS
 (1819ad327b7a1f19540a819813b70a0e8a7f798f)
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
        <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
        <CALnO6CDCkuN2XU_AyO66hQSm2ztfpe8Rs_baw_J4uTQZmekREw@mail.gmail.com>
        <CANgJU+WZR56xG+KL3P053aD_qTh+rBhZ01mqNajg2qRt_+RNMA@mail.gmail.com>
Date:   Wed, 01 Feb 2023 10:54:43 -0800
In-Reply-To: <CANgJU+WZR56xG+KL3P053aD_qTh+rBhZ01mqNajg2qRt_+RNMA@mail.gmail.com>
        (demerphq@gmail.com's message of "Wed, 1 Feb 2023 19:23:28 +0100")
Message-ID: <xmqqsffpz05o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

demerphq <demerphq@gmail.com> writes:

> ... I saw some discussion
> recently that the mac regex engine doesn't play nicely in certain
> ways, but i dont recollect the details.

There was a discussion on BRE having and not having GNU-like
extension on macOS, in this thread

  https://lore.kernel.org/git/26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de/

The patch we ended up using avoids touching the behaviour with ERE,
as REG_ENHANCED on macOS affects REG_EXTENDED, but the issue we were
looking at in the thread was about BRE.

