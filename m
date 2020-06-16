Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E692C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 18:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9FEF207C4
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 18:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXgCDLoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgFPSfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgFPSfn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 14:35:43 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149B7C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 11:35:43 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z9so24791363ljh.13
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 11:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2IW4f+ZhU7eS918nzbNM+16odyeyuZbWTQ4HEzVaMA4=;
        b=FXgCDLoU16qLa9/oB+ScaVvJctEt78WQmxNM6+ycW7JniB1a/4JoJCSckj/ch7XvgS
         60XXVLp2j2/sE5Z09BHs4xFR1DRQvbe7q1XtJWkhGI0Y3PZ0vMyK8u7dbjLj9xEfJlaT
         B5/Rflk8axHQ6rj8o+d3/BVspcElvgWOX+uV724ddRrKkggazqMteOCijFOnSriWTebN
         Ey3S+1CXbq+6ZULFoZIcnLW+XMfw2NiIOcamW0fqpcnbBwDpFVtOR8xc9ruLxeUd/bEU
         9ppPXndcg+N/4YZ45QJq8uS3DV6fGeDa5yFsu2eamlDkyaDhnFXNe5kqiRSw7yoKmrNS
         DUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=2IW4f+ZhU7eS918nzbNM+16odyeyuZbWTQ4HEzVaMA4=;
        b=tDQw+fjjsD8CnVkQQcQNkYIEQNbyg7VwwGc/8vJJ+iVD7PQX97mPWvhMHk6WwZjy6Z
         46XK1q6IesIgkdyEQfN/YwjqX5SU1gP+3CBkpg55hJUWUwh26eKSrF6JHZEaigNDMQjP
         0/PRB5oe8YRPzGHEAMCRMjeT+1d9B9sswhB2C21Fy4wsviqbOY6nCMUXz739EAKrD3kZ
         8Shu+uhjlMYuxyFuai0wFw1sriT3er9YApzgjSuvXUmBgG8R+n1BaTZhWAOGoSdjURgc
         yPuBPB5L+9MdZX0zsfkav9+UlsEpuYnsQr7HgSILVjNmhuZ+AzDF4HTgENyPjG67iZLk
         eeOA==
X-Gm-Message-State: AOAM532k0d62sj8wOuJzGJag+r4CyBoFWDg/0FSjUK/9pZpD88rv85fF
        gAy0NN3JHbwnpA4+hqjxyN1e5Ik1z4FkonM6BVg=
X-Google-Smtp-Source: ABdhPJyOzv8cj2Qzi0n3ZKzpUwFhr3b9q1ok/op3yF/HhdRl71ogSS6Dxy3t8dxFcZZ8Gt1FeWTqyAq8pUkeDDf3KAI=
X-Received: by 2002:a2e:2f0f:: with SMTP id v15mr1880015ljv.219.1592332541470;
 Tue, 16 Jun 2020 11:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200616100424.39718-1-alexsmith@gmail.com> <c0c2d9ad-1d67-8ebe-0063-524005ca97fe@whinis.com>
 <3cd5d8b9-a9f8-fbd1-f218-622f70e45566@whinis.com> <20200616133054.2caiwqwp5mlmb54a@chatter.i7.local>
 <20200616142651.GA27946@legohost> <20200616160349.t65we3jkpq7hqwra@chatter.i7.local>
 <20200616172749.GB18874@legohost> <20200616174206.oana33736jkemyqs@chatter.i7.local>
In-Reply-To: <20200616174206.oana33736jkemyqs@chatter.i7.local>
From:   Sergey Lapin <slapinid@gmail.com>
Date:   Tue, 16 Jun 2020 21:35:29 +0300
Message-ID: <CAFZPMoYKSPsP2Q35UW-5Fxjye6PEioS3DGY6aXa3zbc5jg4HRA@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Oleg <lego_12239@rambler.ru>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

But politically-charged events in Russia do not affect people outside much.
Also most of it is totally ignored inside too.

On Tue, Jun 16, 2020 at 8:43 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Tue, Jun 16, 2020 at 08:27:49PM +0300, Oleg wrote:
> > > Russian sites use .=D1=80=D1=84 domain names. If someone wants to mak=
e all
> > > their branch names in Cyrillic, why should we prevent them from
> > > doing so?
> >
> > Because there are no such people. You try to fix non-existent problem.
>
> We can reasonably expect that there will be a government decree coming
> out tomorrow that will make it illegal to use non-cyrillic terminology
> in government projects. You know this is entirely possible.
>
> (Heck, every time we promote "pu" to "master" it can be seen as
> politically charged commentary on current Russian events.)
>
> -K
