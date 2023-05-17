Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA0AC77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 20:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjEQUEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 16:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEQUEi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 16:04:38 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A169E
        for <git@vger.kernel.org>; Wed, 17 May 2023 13:04:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6438d95f447so886165b3a.3
        for <git@vger.kernel.org>; Wed, 17 May 2023 13:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684353876; x=1686945876;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrxqhnaNraPg/ERYeq2Vgyg1zEyu08VPhO3GEWllei8=;
        b=ssvuQG1Dw6qIpfhp7ivJM7FTL/EG8T4NW7btYohl2E463Dl3vYyFRkh8qojK5Bp6eZ
         VLqpX/zQQVZGY15ybIghYY7HD/ZdXm3GF9oNUVBMBS0RR6DDg8Ix8oTFusrhJHrKIkN1
         qb2EKXr9AhuC206qOZC86uw5HA1wRzZmMmcVXJc3uaOU7uqG3OrxLkKHPiGiWViTrn2L
         UsIEIPLeQtAAB31UOT+nMtk9XWfrJDvO4mRT8odtIYwjI+Vz6pU2hJfP6OWovhje0loU
         7IxbVqCx2/tTqT2iba6fRawPYwl5fDuUfSn6EQdYRBNaHFYA+tz7HotP1TteClK1zFFx
         BuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684353876; x=1686945876;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jrxqhnaNraPg/ERYeq2Vgyg1zEyu08VPhO3GEWllei8=;
        b=QPXt9dsRJF2SpQvl/ysKXzrElw9RYHn6xfUvHvfx3Zm6RzzfiZ4TBh2pMQvNjOQX86
         EVMpkhlVbxKPBLvCruoqyPnXj60/nWAlj+jQq75oowDRQZ8SvMtTiKxygBmfRD3RIAT1
         sorgQfgjYceHqO+vUE1XR2Qt1Zadxnuf9Zi9bESz3n+S6tc5JKfV05TYDUljT0lfXYRg
         JyXPix4ycFJWPebgVv+WeOSEA9A8wKr2bhPBj82z+LM0gIkQB6+MUq+Dl8DQzTC/lyUR
         DbfLrSuqpYvNfu3rjKP13/OUoFwIMNktkbnnG6QB8I10zs/LMPpQn21CepGEGv142rqw
         G3rw==
X-Gm-Message-State: AC+VfDxJao/wfoh3PT8nCCnUKoMoJFar1Ou+/koHtr9Qky8oTewo1XwO
        0ml4PCSTicpMNBFP9RMahBg=
X-Google-Smtp-Source: ACHHUZ4rOvAKQsRG8ncf8DH9Tw1aROTvzZwjdK7jeL7nOK5/gGTKmCkiFVDjk6+GlRTNWmzqxrjPqA==
X-Received: by 2002:a05:6a00:b4a:b0:63d:2680:94dd with SMTP id p10-20020a056a000b4a00b0063d268094ddmr1179568pfo.6.1684353875940;
        Wed, 17 May 2023 13:04:35 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id g4-20020a62e304000000b00627ed4e23e0sm15545025pfh.101.2023.05.17.13.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:04:35 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>, michael.strawbridge@amd.com
Subject: Re: bug report: cover letter is inheriting last patch's message ID
 with send-email
References: <CAJoAoZ=GGgjGOeaeo6RFBO7=6msdRf-Ze6XcnL04K5ugupLUJA@mail.gmail.com>
        <xmqqo7mipyt0.fsf@gitster.g>
        <CAD=FV=XnzFrczC1dvsHYgNabZMhC7-K1uG8=MH20qNE25o0CEA@mail.gmail.com>
Date:   Wed, 17 May 2023 13:04:35 -0700
In-Reply-To: <CAD=FV=XnzFrczC1dvsHYgNabZMhC7-K1uG8=MH20qNE25o0CEA@mail.gmail.com>
        (Doug Anderson's message of "Wed, 17 May 2023 12:24:35 -0700")
Message-ID: <xmqqfs7upvvw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doug Anderson <dianders@chromium.org> writes:

> Yes. It exists in all of the patches except 0000-cover-letter.patch.
> ...but when the mail gets actually sent the cover letter and last
> patch (0006 in the case I reported) end up sharing the same Change ID.
> With older versions of git send-email the cover letter would get an
> auto-generated Message-Id.

Yeah, I think the patch I sent in the thread should help; I'd
appreciate it if you folks can test and verify.

>> I suspect that
>> is the root cause of the problem; if 000[1-6]-*.patch already has
>> their own Message-ID: because --thread is used when running
>> git-format-patch, they would also have In-Reply-To: and References:,
>> but there is no way for them to reference 0000-cover-letter.patch
>> (because format-patch did not get a chance to generate Message-ID to
>> it), is there?
>
> The patches were generated with git-format-patch but the Message-ID
> was added by patman [1]. The Message-ID encodes the local Change-Id
> which can make it easier to associate one version of the same patch
> with another (same reason gerrit uses Change-Id) [2]. There is no
> Change-Id associated with the cover letter so patman doesn't bother
> adding one there and has always just let it be auto-generated.

> We
> could certainly change patman to make up a Message-Id for the cover
> letter, but there is no real need.

This is a tangent, as I think the earlier patch should fix the
regression, but wouldn't a recipient of such a series have a hard
time to locate and group the patches in the same series with the
cover letter, without having In-Reply-To: or References: that links
the later message back to the initial message (i.e. cover letter)?
Assigning a Message-ID to the cover, and referencing it from the
patches via In-Reply-To:, is what is commonly done, I think, for
that kind of threading.

Thanks.
