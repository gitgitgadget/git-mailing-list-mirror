Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FA6C54EBD
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 00:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbjAGAAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 19:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbjAFX73 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 18:59:29 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3357FEF5
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 15:59:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso3472376pjf.1
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 15:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/RMRrooLJ1zaHqtOzpS+B9hln852DpSORLCQ3lwGxM=;
        b=QxcF8TLwwFMwG1zN8I/bTWymFdr1TGqR/URlC64ILfr371adbCSLQQ0CH4/SKcB7+a
         jzM0VRBQJCnN9yc4lKyECAB7d/w3AbnTMUyCU8y87ojmc28zv1S1S6iZ7mZeHFzPoj96
         +9dJCE4g6BVFJ2cloZMQKfRtg2Z+iksKChWNWoOvk5WLIa/d+pPisywX37SNXuYE3mcZ
         /WkrvqF4wJF+GreMfHSeUGvDK6utYGbFNMilXNAc/rC5bN+s0FVRxqqzt59q+hfUinBg
         NNRxTwOSB5pJLZ+S9UK32B3wfC3cPw9LZqKKf/qadnXLdTNTp8FPAmFRIF6uIM9KcSWI
         Qg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/RMRrooLJ1zaHqtOzpS+B9hln852DpSORLCQ3lwGxM=;
        b=XulUBwM/W+MIjmP84QQfjxyNS23jUl8jnu2o7vavFeNH1c7s7auJKaJQdgGmzuvT2X
         XbvkiXPWPla22Ze0BNbF0jGKRXXSGMC25cwSB9LnxPi4ezXfVrFE7dbpA///9Js1CImH
         0/vNLzM/d33LXv4dR/uqbpmjI5NIRwXc6AhDK5LhbVZuwSMiUGpOln+p0BBlTqrPpQK6
         50tpq0jB7Oi1H9gTv3DmTC+28hUAwroX/O40ZlZO7t0dA0FYO9Bbt7zSGGzZGRbEpxsy
         7/wI1r12sf607rU53uf4lPTz7iTezjpAloMmj187zPWSKJJI/2mAolyKLw87qmG0a+TO
         xBGw==
X-Gm-Message-State: AFqh2kprzAeWBP/TnGU2hjHWygjHzaDDtHg+sXjDzijdGiY+9+vlxsKE
        xoEZrw7SLjBRO1tITBSOaCU=
X-Google-Smtp-Source: AMrXdXvjSwIPZrzeFrCNybBL7jQkh6iVyrMlYke6qbDmEgYDsOUCH1KZtMumpVs2JD6ndmdCvD6mNg==
X-Received: by 2002:a17:902:d4d1:b0:189:c322:df3a with SMTP id o17-20020a170902d4d100b00189c322df3amr81062854plg.43.1673049563579;
        Fri, 06 Jan 2023 15:59:23 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e5d000b001871acf245csm1512328plf.37.2023.01.06.15.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 15:59:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/2] branch: description for orphan branch errors
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
        <dd86016b-3232-563b-940e-03bc36af917a@gmail.com>
        <xmqqy1qmhq8k.fsf@gitster.g>
        <18ca1e65-3e26-8352-cabd-daebdd0cf7f2@gmail.com>
        <xmqqr0wau6px.fsf@gitster.g>
        <db348ac3-571c-f6ba-c889-9f476f4ae04b@gmail.com>
Date:   Sat, 07 Jan 2023 08:59:22 +0900
In-Reply-To: <db348ac3-571c-f6ba-c889-9f476f4ae04b@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sat, 7 Jan 2023 00:39:16 +0100")
Message-ID: <xmqq8rifp63p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> Thinking of this as a whole, perhaps after this series we can add:

Why "after"?  If we already know that the existing patches are
making things worse and need to fix the regression with a future
patch to make it usable again, why introduce a regression in the
first place?
