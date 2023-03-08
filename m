Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218FCC678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 17:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCHRUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 12:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjCHRTd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 12:19:33 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CB73BDA5
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 09:18:22 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so2386230pjz.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 09:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678295856;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugyxlg5hUoErRCLdWc+ac8QZcWDwO5u8sodHUI0qFgo=;
        b=P7sEIUzrFQzNx+EpPEply0SsJdcc4RpH5HHv9pFm6jf0uFsFTiavsvelP8XhgGcqzz
         MbbeJ3kSSxoJq8HjbUbq4gBEfk6h+4PlxdqppdN4XDzqRAjrg9k0Q9X/m1/YtKWQsI4+
         0AV7BJza9Kxhwhbhxv5zGpngLSAaAXzG5DLoChHrAnuvLr08XIu94jjNEhXVR/s5+V40
         hprJlMZSaa0gvw0bUnpquS3lSIKslGBnuOEWpXbp4CxYzTB4wRZA62OIy1vMvb82fvDs
         v99yemccP3QkMZHjJiubNfvAzn77MHuV7w2NNHIFuFPn/9n5ZbvdAfj9zEFJGTgj+z15
         TkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678295856;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ugyxlg5hUoErRCLdWc+ac8QZcWDwO5u8sodHUI0qFgo=;
        b=M51W1ldbVIz+Tk5JPFHksHTVkiUeNRbE4uhoCn4LJsyqxfcQpJXf+vX8qVu90z4Hup
         JdlNphWotVScK00XLT0l/kTv2nbiQtL/HwLxMtgLzjpm+G8BpwAFfq6pwh/A0cJXFoCt
         7HsexsaHZU+MMFH1zG0sztxGtDPBVQQPf8+Kml/lsCMe+kO0C7hcCGlTzv7PU1v2UVf0
         bwwajY1dHGLpfALUVaV3y8OA0zaPTnVnc35iCRnOL8XCYHmiwovYKiNsnY6xUYnx/M7l
         H0LtizetLnbDQwa8Tfcdqfr1XNv5MZmsxWAW9SLZHkMwZFaXJaOIZo/VBro2XhsrDG0L
         qehA==
X-Gm-Message-State: AO0yUKUtSz74+kHKaMzZqrsG4OtD/Fef0lX9c1Lqsk77xoqVEDkHaDbF
        iHKg84uTYlI65g5Z6JwEWo0=
X-Google-Smtp-Source: AK7set+AIEq1pl4xKJ1RvcSX+nZ2HHtUR+f9ZlxeCZu5m5gjmH+0uBHSz6eGb9f/aoWV0QdE1HL8qQ==
X-Received: by 2002:a05:6a21:3292:b0:cd:4ad1:cffb with SMTP id yt18-20020a056a21329200b000cd4ad1cffbmr21863607pzb.51.1678295855887;
        Wed, 08 Mar 2023 09:17:35 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id 8-20020aa79208000000b005ccbe5346ebsm9621739pfo.163.2023.03.08.09.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:17:35 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Alex Henrie <alexhenrie24@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Matheus Tavares <matheus.tavb@gmail.com>
Subject: Re: [PATCH 0/2] advice: add diverging advice
References: <20230308024834.1562386-1-felipe.contreras@gmail.com>
        <ZAix68A9e6RHz69y@nand.local>
Date:   Wed, 08 Mar 2023 09:17:35 -0800
In-Reply-To: <ZAix68A9e6RHz69y@nand.local> (Taylor Blau's message of "Wed, 8
        Mar 2023 11:03:55 -0500")
Message-ID: <xmqqjzzrupqo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I don't think that splitting it into two separate patches was strictly
> necessary. If I were queuing, I'd probably squash the two together, ...

One advantage of sending a topic like this as two patches is that,
if the review discussion leads to a consensus that the new help
message should be given unconditionally to everybody, only [1/2] can
be queued while dropping [2/2].  But the point of advise() is to
serve as a training wheel that can be disabled by users who no
longer need it, so need for such a "flexibility" may not appear in
topics that add new advise() calls all that often, I would imagine.

I am willing to do the squashing on the receiving end.  The effect
of two patches combined together is a good improvement, and the
proposed log message for the first one covers why we want to do both
of these two.

Thanks, both, for writing and reviewing.

