Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0A2C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 06:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C872073C
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 06:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCMbO/iB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfLDG6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 01:58:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45801 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfLDG6u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 01:58:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id w7so2746626plz.12
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 22:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DIEPRz8RdhEQKV5I8CSplycbdExRXj6dcArGnEy1vYY=;
        b=DCMbO/iBBJkzXsX4tBRjg+wzKwqpVRu64gJjit39tPIedUkLupzTvYHVKSIBol05YA
         OGdCIZZJyYZAWVoQdzdGQN0MqeCvKNUkgayJsjRprU92i0RcHjVWCi9CbzgwShvHIg/F
         YSTFRMKRrvm2yOSp2Hy89YVgJHo1icWU5frygNCsnZRzw3NNTfOMnSs6xvqCiXNWHiZD
         3jpK0jw3kNMHSgz2U2apCfSAAjknSqGONLlYgf6d0ah4qULKfw3WV8RMsxbMqe9Ry4EQ
         m2nFQFTj07YL2rF2WG0DbbectTmm9EMnM8yf2O1KbK5cCZOKYztMzWSeQVF2aV8oRLcj
         yAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DIEPRz8RdhEQKV5I8CSplycbdExRXj6dcArGnEy1vYY=;
        b=TmoKkWUv+i6Whew7G40JZpoU3Oqaw7QZEZx6Pe8jnXlGJXYQ+Ihs3yL9HwkdJOKD82
         xSnvrRekORLoSWSXi96bFSaYn69c3wBT6Mi8yg7LS24PDzWMA4lvvHOE1QfIOkphyRFB
         ck0pFFjVugkrk6QcxeIy7mG+8FNv06MJ2YeAfUGvVggs2p64+459IQeaohFIo/NdV+Ij
         YwmT//LZaj1qfqhqO4K8b/+r/Oc5DscHD+2sm+E1uaTyCjrJv31kS1YfaqYIRMSSKR4G
         WWq4aeAUk9LtBO2EXVSkqoNO7rJ7Bqdqm21PHi/ls9JRSLQnvO1ljUN0XfV1yl4q1bdi
         Zvww==
X-Gm-Message-State: APjAAAUNXfVaCpPK8I/f3wrJZXss9B6IBCa5Gmh96IjHy+YPWdk4fRw3
        nv8813mgPHBct1AlfKwLwcQ=
X-Google-Smtp-Source: APXvYqyv+7rc3G6JFPVK5xJPZu0AjvoMySA8AepDjtFp6ih3M0P3/kbJ9+V6Fo3Eoo6mg1ZIezLtaw==
X-Received: by 2002:a17:902:b691:: with SMTP id c17mr1875351pls.252.1575442729266;
        Tue, 03 Dec 2019 22:58:49 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id z26sm5717639pgu.80.2019.12.03.22.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 22:58:48 -0800 (PST)
Date:   Tue, 3 Dec 2019 22:58:46 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] contrib: git-cpcover: copy cover letter
Message-ID: <20191204065846.GA3386115@generichostname>
References: <20191203201233.661696-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203201233.661696-1-mst@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

As others have been talking about in a sibling thread, I'd love to see
something like this incorporated into format-patch itself. I considered
doing something like this myself but my workflow ended up becoming "good
enough" with --cover-from-description that I never bothered to look into
it further.

On Tue, Dec 03, 2019 at 03:13:27PM -0500, Michael S. Tsirkin wrote:
> My flow looks like this:
> 1. git format-patch -v<n> --cover-letter <params> -o <dir>
> 2. vi <dir>/v<n-1>-0000-cover-letter.patch <dir>/v<n>-0000-cover-letter.patch
> 
> copy subject and blurb, avoiding patchset stats
> 
> 3. add changelog update blurb as appropriate
> 
> 4. git send-email <dir>/v<n>-*
> 
> The following perl script automates step 2 above.  Hacked together
> rather quickly, so I'm only proposing it for contrib for now.  If others
> see the need, we can add docs, tests and move it to git proper.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Fixes from v1: support multi-line To/Cc headers.
> 
> Any feedback on this? Interest in taking this into contrib/ for now?

I took a brief look at it and I have one small suggestion. Would it be
possible to grab the last Message-Id and use it to generate the
In-Reply-To header using this?

Thanks,

Denton
