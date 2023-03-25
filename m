Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841ABC6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 16:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCYQ7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 12:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYQ7i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 12:59:38 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33CF4C19
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 09:59:36 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id by8so4790372ljb.12
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 09:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679763575;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mKZw0SFclYNOyI+aSeyybeVHvdvdT57L97SJ3WMqAb0=;
        b=Y5ZbD9WwBtWCDte3Lgi93xD9CxOJVmHQo+KzQWVW6l9onPP0rOi6fwDMbWs521N6sx
         hiN7o4tgm74vISGlmQHDVhRZDAabgGioIIYg+fJ4kWLTH+JTAc3ASQENsa8bg24R0rEy
         2064+vvJi7rH9PVKzFieQxW1Uh8xqK9G66hft0aTh7NhaGeTIEEj1YmUD8kyLWoXzSkH
         H5IHlv9WGTWzGkt7UkqR6d5Mjq46D065s7BBN5uhIMYYPBJiCMrcO2NvgOjS9hRt3s8x
         TbdHfDiTDa20FvZvjkoKidEvz0fPTAW53rpasHAO5jC0eB9yUYvzKw5e+kqVmvZsqyPe
         fsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679763575;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKZw0SFclYNOyI+aSeyybeVHvdvdT57L97SJ3WMqAb0=;
        b=hRvlhSi2fjysjNrb0FkwXSsMF8IXbBzfqp6PN2JeQide5lT/CEbaTCeuCTlb8Z8jD+
         EnVlI8jjj2veQnIFXW0s3sDmsWLyuJmQQBXo0c/hjA9vQSH24i0XroIgk6v83+TaWcYj
         t8eNI2oWR5V9J60pDpimvlg+DeU10EkO0hsDZzbsxru1El3WqEp+tGE2sJ4pYGFlaotx
         nXr7mN4UnrK+/OI5vqUnM3QwU5uQ/eChiaS6NQm7+L7Q7M/GOrKQx+RWJU0p3MO6v4/J
         c/1uQ4yIgVZUUmU5Q7O26C2BTojjOg+150KkXUbntSSSJxb6ywNwQ42PkIt3wvIMIpwg
         yigg==
X-Gm-Message-State: AAQBX9de16wT08K6RQm0+z+e1WraY/vziTFTa+pwDTYYGtRoFDn1dDf2
        FwaiaOA0oT/3spjnHmuY2rk=
X-Google-Smtp-Source: AKy350aV1JQBOgEeNkeuwLDbFAsyuQPfEbiMMHODJxBH0012NyHhOA8M2idVXMtu3XI2RESwIaoDyg==
X-Received: by 2002:a2e:7c10:0:b0:298:b333:4267 with SMTP id x16-20020a2e7c10000000b00298b3334267mr2249282ljc.18.1679763575255;
        Sat, 25 Mar 2023 09:59:35 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r21-20020ac252b5000000b004eb0b11726fsm285947lfm.291.2023.03.25.09.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 09:59:34 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        calvinwan@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
        <20230305050709.68736-1-alexhenrie24@gmail.com>
        <20230305050709.68736-4-alexhenrie24@gmail.com>
        <kl6l7cvsi006.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CAMMLpeRGEETraueJTTV0tJSsycNYF24YX8n6h-pMp87VcCRJtQ@mail.gmail.com>
        <kl6lzg8cvby2.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CAMMLpeR4x0_u=JGnWQ1xvBeVBXBw7VAgLTWgvHdMFDZLrcy1pA@mail.gmail.com>
Date:   Sat, 25 Mar 2023 19:59:33 +0300
Message-ID: <87o7og6a2y.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

[...]

> Let me ask a different but related question: If we add a
> rebase-evil-merges mode, do you think that would be orthogonal to the
> rebase-cousins mode?

This is the question that I considered as well. To me they look
orthogonal, and I'm afraid we will have hard times extending
--rebase-merges gracefully in a backward-compatible manner.

The set:

--rebase-merges=remerge
--rebase-merges=rebase
--rebase-merges=off

looks natural to me, but "cousins" that affect what is to be rebased (as
opposed to how, if at all), will apparently get in the way. Besides, I
recently ran into similar problem with --diff-merges (when|how)
dichotomy, and there was no elegant solution found, even though a
working one has been implemented, and then there were some discussions
around.

Also, I'm not quite sure that these "cousins" options make no sense when
we in fact flatten history (--no-rebase-merges case). To me it looks
like there should have been separate --[no-]rebase-cousins option,
provided we do need this choice in the first place, but I definitely
might be wrong here as well.

As a side note, it sounds both unfair and confusing to use
"rebase-evil-merges" term to describe a mode that will actually rebase
(all the) merges, as neither a merge needs to be 'evil' to be the object
of rebase operation, nor dedicated mode is necessarily needed to rebase
specifically 'evil' merges (whatever they actually are.)

Thanks,
-- Sergey Organov
