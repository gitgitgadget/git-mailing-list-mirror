Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91D131F60B
	for <e@80x24.org>; Fri, 28 Dec 2018 19:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbeL1T7t (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 14:59:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37417 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbeL1T7t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 14:59:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so20467054wmd.2
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 11:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xu1SIF66aiqd1+Qz6UbxqTtXF+nCMnJ5owHPtUE61as=;
        b=PfEWa88vLU8Co/DTe+KsdZ2eJ6wxLaeD73A0/kmsxvykZHvKxN3t/lzLSXQm8xUC3m
         1BYzrYOcuQlXj7V3cnXTZES0h3gkJ3vFvNo48YjlHCKR0GSSi9Kril75GU3Nv61n3+39
         /YcktRRhAlMEah4ALKU2S81iOH57WKYNWCg5cScbUxAglpXP8emhOKb5MbhEX7PPW9uG
         TnTw17zFwbFlfvt0u/zVQPXW7DHC+TurILB/nrOSvJvuPMI5aeKkoVx8cOYm0IXSuNEE
         YbdFCqSlpoNycqSF/hbsHdxF4Sj4ViOsHeq3pbapVddOLm7nAVZmxxvIMkrMLvJd4Ui1
         SCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xu1SIF66aiqd1+Qz6UbxqTtXF+nCMnJ5owHPtUE61as=;
        b=q5qWVGbwSrkA8M54HEZ1A37peXsx4qRiuZ0g5HccIJBYSexJPdZhH6/TX/Gi2mysDA
         TGxBLtb0OjtJysUvQUkQ1EhfZyx4pOOHRbyJlhfSYHAKtgLFoGbU43Bj/DG4tb4HaI92
         GEVrYW3+S139Lry4oqmdr0h+DTJkbUr7j0/B4yJYJZ4HP8hCdthxWR+Z7aWLBQserNH/
         VQYkTPEcuyBzbi9QGnFNUfkF+8P57htxbkPRSM+wqwXaMmUztJw9Kv0zDd+JdgsJ+63k
         f7D8kOeTy1AAsSF63i/cZrwe8AbN/wvPkroXUuCnQRcHQ02Xk7Y3B0y4oMuBlZgNDdsX
         pq/Q==
X-Gm-Message-State: AA+aEWZBrRSiBITFYL8GkEPDjigPTU2x4Am2z3016DAvIiIXM0j7YxGq
        m7hJSbu16ayvD7MVyxqCTLY=
X-Google-Smtp-Source: AFSGD/UTeNI818YPQYjMJ++d4u01HVmmGLs+bn3hZ0xmyCZKwMRxfYGk5KoagSESdHm4L8bgD7QGog==
X-Received: by 2002:a1c:e488:: with SMTP id b130mr25627676wmh.124.1546027187261;
        Fri, 28 Dec 2018 11:59:47 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 10sm32222897wmy.40.2018.12.28.11.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 11:59:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stan Hu <stanhu@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] sha1-name.c: Fix handling of revisions that contain paths with brackets
References: <20181223233736.10306-1-stanhu@gmail.com>
        <20181223234058.5834-1-stanhu@gmail.com>
        <20181224080651.GA12708@duynguyen.home>
Date:   Fri, 28 Dec 2018 11:59:46 -0800
In-Reply-To: <20181224080651.GA12708@duynguyen.home> (Duy Nguyen's message of
        "Mon, 24 Dec 2018 09:06:51 +0100")
Message-ID: <xmqqtvixo219.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Note that it also shows another corner case we need to be careful
> about: master^{/regex} syntax _can_ contain colons in regex. I suppose
> doing strchr to find the closing '}' here is better than what I did
> below.

Yes, the posted patch breaks master^{/foo:bar}, I suppose.
