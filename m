Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44807C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 22:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjCOWTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 18:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjCOWTA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 18:19:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B557E051
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 15:18:38 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nn12so20440930pjb.5
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 15:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678918711;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1OMKQQn76xT+fEu6Zd7Q+4Zk8Z8n/QXB/2YLd36sko=;
        b=Gs4QiUy7Wh2vqaQ9gZ2qgAc3xw7FwdXsZ5QTNCc7bfWfUTR1OXBySaQ7YK8sFonQ0L
         ehKjSnD7MCuH8Q2Y9OWTgJTtXm5DqmTYZKKNG+EYjafgl28oeUOJvNDbXeZrzpTOOtKU
         NfBaY1xYIsganM+o6K06BvMc65iiouO85TJSwlSLlXvrCK3d7Q+wcKzU13xsfVt8WLkk
         VW6Wxbax3Yh0rZ0TcmkUBdlhueG2VrCs55SILoRcAw6JXAVh3SOurrOSrfhp1+6qYCuk
         sX106nV0hXrex/iHu8jgQCTiyi1OrnYoPyg5PLvAnvXwvEL912f0YmzLrefeVy+PD2IG
         aoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678918711;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T1OMKQQn76xT+fEu6Zd7Q+4Zk8Z8n/QXB/2YLd36sko=;
        b=kb5weqHM0OK66SIL+o0UjU4oCFlc9s2ZYzKw2d3LvFl2uepy1EhymtZynwV7uGGay4
         IuBl19Ktm30AdTgpF51MhjUE0PVSrKX6jmJpXwJBvihCvLssYuoy9x4/KVA2Spw5WcT/
         Lcnd8GQmSw+Mfk7+PLV6njelbHf8GgOmNmHa6xqWuUuulSy1lAqK4du4LYiLxvvKxjBB
         O806/7ZpbOlfDYO9GUE78i4KbI+nMHJLI7HOyxQEkgsvyvZXK5NTeH6bC0sGVdyzj2db
         g/1VkAoZheXMGRZCfi2ue7cTT6R0vu85gPPTwKBk4aUwoDnbBkVafuM0CKfOJ1NIWrkn
         Lxrg==
X-Gm-Message-State: AO0yUKXIQC9oN7k86cLd9VMMaSU4DQO2cJ/gsV4gUAoCDq/s/JHxyepF
        J3FQCtsZFganLAtRZ/W6P4J/XEAwaXM=
X-Google-Smtp-Source: AK7set98Epvq7vZ08yVZGUEZd59fCn0hM3EJorWLl1lhmBOdgnRQkkzAJOW9qrWZGevsTwHqvZRkhg==
X-Received: by 2002:a17:90b:4b10:b0:237:373e:9dfa with SMTP id lx16-20020a17090b4b1000b00237373e9dfamr1378528pjb.20.1678918710888;
        Wed, 15 Mar 2023 15:18:30 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id o10-20020a17090a678a00b00230b8402760sm1840334pjj.38.2023.03.15.15.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:18:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/8] fetch: pass the full local reference name to
 `format_display`
References: <cover.1678878623.git.ps@pks.im>
        <0998173b57e8d7aea7a77673fa8e54dc54538a9b.1678878623.git.ps@pks.im>
Date:   Wed, 15 Mar 2023 15:18:29 -0700
In-Reply-To: <0998173b57e8d7aea7a77673fa8e54dc54538a9b.1678878623.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 15 Mar 2023 12:21:19 +0100")
Message-ID: <xmqqa60dodze.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Before printing the name of the local references that would be updated
> by a fetch we first prettify the reference name. This is done at the
> calling side so that `format_display()` never sees the full name of the
> local reference. This restricts our ability to introduce new output
> formats that might want to print the full reference name.

As long as the prettify at the caller is *not* done to avoid doing
the same prettifying multiple times, this change makes perfect
sense.

> So let's refactor the
> code to pass in the full local reference name and then prettify it in
> the formatting code.

Good thinking.
