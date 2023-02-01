Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B25C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 21:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBAVfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 16:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjBAVfD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 16:35:03 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB9539BA4
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 13:35:02 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id gr7so486975ejb.5
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 13:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FU4t/gYZ/JEp+ahiXpgh752YFSz1gZ9chE1VmA1z0iM=;
        b=Dh1yvfZtIXQ5JrXPwkSdUeUu3H9vPMN+QKkqfTNJSv5PA8EhTqo4v9OfXOmQjYV/+Y
         asZH9N4ae1qcRaok3MIiJ6mez+/BKi4tUE4rtKiqh6h6sotGyyip9+ZTBOYeVkT6d915
         dcx0bj/1dmFd9YsoEio//B1htSvgJLpi1adcebISTy32hqHrOjlYw10ONlTSh4r4GuaS
         sOzoxXqz5eeqE8BKri4kuxOZnw2PJzoa0V516San7YZ3nZpEN7xcYqr51Og6R/7GF65r
         DtSVzpvSiKUCYJNm65oT8KKt9ZInAMyBdyUXp8r0j9CoCPRusv9Fu2vxil/xJm9koiQx
         d67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FU4t/gYZ/JEp+ahiXpgh752YFSz1gZ9chE1VmA1z0iM=;
        b=4tPGKCyNkdpYSZls1qd4YlB4HmFljOquxd0aERQ9bcAM+Iwb3+DoEAsClGdUl9CAAy
         eu9weeIJTLybTUUpR1qefiP2zBl+yJb61nS0YEi0K3F9TyNxOL0OSBaWjSg6yV82ASZ3
         EiA7gC0mrOF2JSo0Zr3TMwqFYJEoaq6gzrvRms6rz5T4PKSxd/M5oiO3SCrAT686cZJJ
         tNrF+uIve/OXFHuqXYZH07VHKAXDHE3674GFTSAVBqQorq+TvwdXpu+Dv7fMHjNiuNDz
         SUpJLiLhQs6TXdJhxainNFB90Oz55CDZo/rhbOFnxP7yh1piavB2ptfpmdhG4eNSovc2
         gHsQ==
X-Gm-Message-State: AO0yUKXr83t6OPhjALL7a8QUR78HZNpz2r8yLVexc6wkWv4yIGow9URi
        AlLeUDoaJPACDmhWjtqin1XeiDAUK3ki7Gk5jtVTYJBaa6A=
X-Google-Smtp-Source: AK7set95fLsoJOapWxsG7wQpCNZbR1UksZeT4bOqZly9lNkM/ju7ZYqdvELlCdSIk7DfWqBaYN0bQkTacRys0xr6g04=
X-Received: by 2002:a17:906:5048:b0:88a:47d7:3c3a with SMTP id
 e8-20020a170906504800b0088a47d73c3amr1217916ejk.182.1675287301150; Wed, 01
 Feb 2023 13:35:01 -0800 (PST)
MIME-Version: 1.0
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
 <CALnO6CDCkuN2XU_AyO66hQSm2ztfpe8Rs_baw_J4uTQZmekREw@mail.gmail.com>
 <CANgJU+WZR56xG+KL3P053aD_qTh+rBhZ01mqNajg2qRt_+RNMA@mail.gmail.com>
 <xmqqsffpz05o.fsf@gitster.g> <CALnO6CAZ_RMirOwQqJyqJrq2dY1w09eV1h=0JFosYSb7XhyQVQ@mail.gmail.com>
In-Reply-To: <CALnO6CAZ_RMirOwQqJyqJrq2dY1w09eV1h=0JFosYSb7XhyQVQ@mail.gmail.com>
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Wed, 1 Feb 2023 16:34:49 -0500
Message-ID: <CALnO6CA8ZYfQ7pGMAgupJMhwReZVRzVw7KkfqwAF6i+dCMyzJw@mail.gmail.com>
Subject: Re: grep: fix multibyte regex handling under macOS (1819ad327b7a1f19540a819813b70a0e8a7f798f)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        dds@aueb.gr
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 1, 2023 at 4:33 PM D. Ben Knoble <ben.knoble@gmail.com> wrote:
> Are you suggesting that I try with `-P` and/or `-E`?

Er, obviously these don't exist for git-diff.



-- 
D. Ben Knoble
