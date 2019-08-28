Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300811F461
	for <e@80x24.org>; Wed, 28 Aug 2019 20:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfH1Uc1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 16:32:27 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:41534 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1Uc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 16:32:27 -0400
Received: by mail-qt1-f178.google.com with SMTP id i4so1091723qtj.8
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=BR+upNUH+qi8UT3YTdvTU4eHCMPIuuVz12iwvrT5+Sg=;
        b=iePV0S8irgJ/aDc8ZgM7BOKaJazeUrtTVyEBFGdlAV8R7qNcgbbG1upCWJ/iOsXtxQ
         YVHC3HZcdOuXZxSztvnzGJmcG1bD4NZ/Zd4YJTpo1Of9bCJ2G234OgkRgAgVl7DtaRc9
         AtECiiL+cz/r2xzcX5sw5xUpapqxfrHluR+Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=BR+upNUH+qi8UT3YTdvTU4eHCMPIuuVz12iwvrT5+Sg=;
        b=R2ZQN/uU+3w1p5N6walAEYY9ZOBeYIp3lNskGBOSmqC3yJHo2dos6JOMfhDlLQVj5P
         2nN1fEziNhkVWfPK7JI7Vc84Z/IbINc5IBZaMfO5NsxgLf9Bhc6SozWmKCwmIAm0KuXo
         mvwrpnGHCdIsgswJ2ScpFmFhQsSljNiTCkv7pWaZnpj0P4wvvXU5kb6ayIE6Un6T9GTR
         vGE0RlMGfh2oAYrHkVhbQLm8+vY6dVLhVOGhESRVUXCFClPsoFksr+R7ZJNor8GMh6zD
         bWn7BnTtPHuBL1H6iyi/miWBGAIiy0Pn+ZxoiKBZaG/XHmy37tjv/cKtKeXYSX1Xpd8+
         iocQ==
X-Gm-Message-State: APjAAAX3SeJP/X9IG4UYHglG2lg2ETOvEFQbf7xXm/VaqAttP9JlfX6C
        4KjQ75998BeCN2w9CRuX3m7/xxd5x68=
X-Google-Smtp-Source: APXvYqzv1Ikt7gRfEhyh3j2Bo14jJL+B2wUGCF10TYQE4VKytQ+d810NUQBikGetakkvOD1GQKBnpQ==
X-Received: by 2002:ac8:364a:: with SMTP id n10mr6614922qtb.148.1567024346193;
        Wed, 28 Aug 2019 13:32:26 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id l8sm198047qti.65.2019.08.28.13.32.25
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 13:32:25 -0700 (PDT)
Date:   Wed, 28 Aug 2019 16:32:24 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: Is git clone followed by git verify-tag meaningful?
Message-ID: <20190828203224.GE26001@chatter.i7.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, all:

If I know that a project uses tag signing, would "git clone" followed by 
"git verify-tag" be meaningful without a "git fsck" in-between? I.e. if 
an attacker has control over the remote server, can they sneak in any 
badness into any of the resulting files and still have the clone, 
checkout, and verify-tag return success unless the repository is fsck'd 
before verify-tag?

I assume that it would break during the checkout stage, but I wanted to 
verify my assumptions.

Thanks,
-K
