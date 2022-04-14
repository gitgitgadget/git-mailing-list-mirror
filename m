Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDECC433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 07:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbiDNHZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 03:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiDNHZe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 03:25:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A131A329AA
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 00:23:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t25so5201271edt.9
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 00:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=LXrY8Y5/PuvhhHoeOC2wVldQBg6AwL3J4b+usgy+SCc=;
        b=herqYEkVWRnNzvph3Kdnl7+Edf1WuUR+WvD5WZJ5gxEKaZqaNZYOXXhapPeM5Pc5+v
         loQBtDuMmpYADAln2Dvrudr5I3rPHeIqEwl8sph0Yd85oK78jgmeSZXh3hHi+KHs/1E8
         PCFXIwlv+UwK2chgVBbJ5S0gDp/pbP+kEgtxKTqVy7o31O0bXU7uAEX/N5y3Kwyl3NYS
         6MWGqeFhARMFZfCne1ahH1GovL/kFFOuwT6HuWU1YNm8yATufvbK4HooWacSIB90NFUn
         7PcNPnSnP06lsrcopydNxN21BaqNg897qnWvWtJFWuRmzunJlV5/gtQuL168e8Lw5joC
         Q/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=LXrY8Y5/PuvhhHoeOC2wVldQBg6AwL3J4b+usgy+SCc=;
        b=0fNG7EKWAuq+3vtiyJbOncYR8+D7WJvNBhKDt03ThI7nGgSNIC8OXg2iOWpz/TUAC+
         1t98o9sAtrhMCUe1gZax6/P52HnEVgF19RojXNsA5lR0VhhEvla+FM9alqTpqtsoxGH8
         M7eQgL3+LL7cnK8XE306aFZeatarIuwIImwKiMTYcJj/IqG1IjN4kCYCmXWAEM1FkUG+
         I87TorwJE2IXjx8zXwKcJgxyhS+L4EW+TDo+9iTul8PsvGs/U3MgpTXnfnpIXSxU3ZeS
         jlvEUxLB8XH/bxtws/ZRTX+yfXCXpAgcZK4jLdJm6yzYv/JL/qrgx95nrIKs0f0d+zNs
         1z5Q==
X-Gm-Message-State: AOAM530Y88qFk50uBUeQzmCSkLJnwo8jXGg3iCWqEeROyNElTnwF3T+4
        F9FzkfcGWnczHDM+FFVsbhNo+FU8hXECkg==
X-Google-Smtp-Source: ABdhPJxyNFVvUlSQCR9tdTv97BdNc6/sdMZEmry/xVuMy15SP6CIo7jWlNp/Z6zLfRAGX5Zlk4TP8g==
X-Received: by 2002:a05:6402:d4:b0:418:7193:da1 with SMTP id i20-20020a05640200d400b0041871930da1mr1532905edu.57.1649920989091;
        Thu, 14 Apr 2022 00:23:09 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ce21-20020a170906b25500b006e89869cbf9sm364022ejb.105.2022.04.14.00.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 00:23:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1netoq-005G59-4Z;
        Thu, 14 Apr 2022 09:23:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: ab/plug-leak-in-revisions
Date:   Thu, 14 Apr 2022 09:22:31 +0200
References: <xmqq8rsab5do.fsf@gitster.g>
 <220413.86bkx4eobr.gmgdl@evledraar.gmail.com> <xmqq35ig5zlf.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq35ig5zlf.fsf@gitster.g>
Message-ID: <220414.86y208cen7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 13 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I think it should be ready with my just-submitted re-roll, which fixes a
>> trivial nit spotted by Phillip Wood by removing a useless NULL check:
>> https://lore.kernel.org/git/cover-v6-00.27-00000000000-20220413T195935Z-=
avarab@gmail.com/
>
> Last time I checked, the last three patches haven't made to the lore
> archive yet.  We have other things to do while waiting for them, so
> there is no need to rush or resend ;-)

git-send-email died at the end of that send, I picked up where I left
off and sent the remaining three.
