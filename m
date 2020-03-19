Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EF0C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2855C207FC
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd2Pmt97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgCSRQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:16:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33176 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgCSRQf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 13:16:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id g18so1342441plq.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HZ6tppwYg8I1h+CJXaFJIGvD/ByEZ9SAU5YrMFupkY=;
        b=Wd2Pmt97c8KJFPT9zowa/s8BPOE/GAxkv+7f4Ezz7Kh913Oq9sdi+Ym5UexHMfp5YK
         Ac+iuTxQQPRmxtVOIDEQXvq44706n8usprTuCR7Fmgytjt+d5cb4Dl3eNhoBm3s4dL8j
         R44G0qSMBRwZmzcpUv0Ssjw5y594DJSo9RT/Be/dztRRX08UA4JK/NZf8hrQG031D8jh
         5hPqLNePRX7ak+pcYJsz+LXcF+V2TXpRZwwDD7dzj98st5+g1AltMjKYTv9FjK5mpvH1
         f6aLEc2yyW6l3GHYNPMuRwmFh9eQyrip7PMYnWWO4aPls9cAsKBDPR1LOPI4CCk4r5I+
         MSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HZ6tppwYg8I1h+CJXaFJIGvD/ByEZ9SAU5YrMFupkY=;
        b=V9d/9rX3gp9yVklVpXRrYr0awMCRDmv2gid6uxZS1vqOVlOYqQRBlnf7COJR0UOUz2
         X3EBmL+7OZ4ER+Zqyz6CVKy2BMgpWlDhzMsFvP40m+pd1YPtOt2XS8IYbjsr3nd9pKXl
         oxhScuwHW8PVwprsBALhrzJqyjAEW91YhH47mSvA8h3UkEsQnzDzwCbEBxTPL9iLO0+D
         9iviwPFNgCHGdTY5HxwBsxM2qTyfU41qu2feYhErtoIlO0GS1v2xF8GnefLprOHLjN0D
         G/xeEQIhFh9EiibHapOlGZYlAsoD/klHkJyAlgR/vNc0Odo2XjGLJUMFz7/alUYuQsvE
         9mZQ==
X-Gm-Message-State: ANhLgQ3aUK6QDD4iqdcM7EtBrVJMfztLvlR2FiWLU55lcauv0tENZHeZ
        wBuQw0XpmlaMVfoMmX57Ww4=
X-Google-Smtp-Source: ADFU+vtNpbvQU203u6nubcOniRQ6XmCqLhUm7csckJcf8cDcQeTPJbTH/UiIoSZeh7LGQfWmKDj0ZQ==
X-Received: by 2002:a17:902:aa04:: with SMTP id be4mr4501687plb.41.1584638194586;
        Thu, 19 Mar 2020 10:16:34 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id 8sm3132888pfv.65.2020.03.19.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:16:33 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     gitster@pobox.com
Cc:     chriscool@tuxfamily.org, git@vger.kernel.org, jnareb@gmail.com,
        johannes.schindelin@gmx.de, newren@gmail.com, peff@peff.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: Re: RFC][Feature] submodule
Date:   Thu, 19 Mar 2020 22:46:26 +0530
Message-Id: <20200319171626.5723-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqqh7ylfnqi.fsf@gitster.c.googlers.com>
References: <xmqqh7ylfnqi.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Junio,

> If "git submodule summary --recursive" errors out with today's code,
> no sane user would be using it for any useful purpose, so I would
> think it is OK to add such a feature.

Sure thing! I will try to plan some makeshift implementation.

> If it makes a usable UI for large projects that you can only choose
> between "include no subsubmodules" (i.e. with --no-recursive) or
> "include all sub(sub)*modules" (i.e. with --recursive) is another
> matter, though.

I think discussing this idea may be a good approach right now? What
you are saying for large projects does provoke thought though..
Also, what do you think may become a problem for large projects in
here?

Thank you so much for the feedback BTW :)

Regards,
Shourya Shukla
