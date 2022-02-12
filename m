Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CD8C433F5
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 14:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiBLOld (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 09:41:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiBLOlc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 09:41:32 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153FD214
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:41:29 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id h8so1956511ejy.4
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SUtLXWOvJ6HFfti1WB/GZmCkP5ryPpERkxn95UlxK+8=;
        b=a3+sTwIFWgH5cJPtk4qgO/i/ECpjKmEltdZfhSOGM2dW7fv1z0EoqHGs3EdACTDG28
         kpps+U6L9h/eWNILwutyoPPdOxaCA+HkeScOCswmpmocrbZcqTQf+m9oKozPT00oJ18C
         xvSrnkHMsTc5hbKIjJIHKEQmLmQjf+rT/ThYOHRzniNRAoFs3UXHNAM7lpAaQB51DZRV
         5U0lZ2/k0ra0tcPnJhDLBxbKQvrKm9FFLJkKA1PVjqQBRqBCaiJZNTvdMTRnDy42tHPX
         vZU8TAAzLS9ynVCJkehSTMP6ZR6lDJBrpbteLGCqPH1Q4deeaaQqW9b2K+E7qkDuenuZ
         V9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SUtLXWOvJ6HFfti1WB/GZmCkP5ryPpERkxn95UlxK+8=;
        b=6nUueot1n08u+v21P0F88wDalG1HOwGUMgKgTI7pFB0/XXyiMERujgZV8+y9C7OW7j
         vWRS+3OpOMUzqS9K5kygUyhjo9Ae9iitf1RRFfNwC6/Jx//UlSrVMYkVC0O0MtXLhaF7
         JVY+VW/rNI0uklsk1gV8aY4WcQmkT1oOJN3DayevzsIhbOFuPKtOEPrK2fAIyxPd5TpD
         vdYmi5OLfz8XO2qVcoBsJUtkvcVQzGymuFAo8V/HKnCo9rZHAHq2aFamvN7EbSBw37IA
         Yo+U5Kvn3y08B2oUcLZSkMrAtu/Ox9ZqTk2oXcacTHOoGD9nSuNDrINq1cbwAP/DB5nI
         XccA==
X-Gm-Message-State: AOAM532vEzjDGezsEWCcTbG8ym+XOcU7gS61bW9ebL3xN2tGNaZDpzDe
        YKi+k9X77uufCiiiaIXU0UnGELITd2q+gw==
X-Google-Smtp-Source: ABdhPJyMNLzcQAIleaIF0lD3GjfUNWOlxtZX7MRYBqMU6W65QI0KKzKOqk0hPwtsBq+SQC5gPE4zTg==
X-Received: by 2002:a17:907:94c7:: with SMTP id dn7mr5297007ejc.299.1644676887384;
        Sat, 12 Feb 2022 06:41:27 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g9sm8844662ejm.152.2022.02.12.06.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 06:41:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nItaY-000RvW-Cl;
        Sat, 12 Feb 2022 15:41:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v7 15/20] submodule--helper: move functions around
Date:   Sat, 12 Feb 2022 15:41:07 +0100
References: <20220208083952.35036-1-chooglen@google.com>
 <20220210092833.55360-1-chooglen@google.com>
 <20220210092833.55360-16-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220210092833.55360-16-chooglen@google.com>
Message-ID: <220212.86leygxi3t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 10 2022, Glen Choo wrote:

> A subsequent commit will change the internals of several functions and
> arrange them in a more logical manner. Move these functions to their
> final positions so that the diff is smaller.

Shouldn't we do this earlier & avoid the FIXME comment in 10/20? (maybe
a subsequent fixup addresses it, haven't checked...)
