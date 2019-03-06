Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E59820248
	for <e@80x24.org>; Wed,  6 Mar 2019 19:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfCFTwl (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 14:52:41 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:33033 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbfCFTwl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 14:52:41 -0500
Received: by mail-pf1-f180.google.com with SMTP id i19so9456504pfd.0
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 11:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=z2giIkcR5yNUAEux2tgME8c+c7hJW7vYqC1UrbevdqE=;
        b=n75R2orjoHbtftHIUEuSX6lFGbVvHMHlVl7LQBw6aVwuUiYs4Z47Cg0jHFSrOx3PMf
         FPqz5RdHSwt0tFflayR7EKCiUw+6cL408MjXk9Wzz2U3DMC5x7zjozGK8usUgNithraj
         yQ9xx64KzQAFUCf/UnJltIR2U+qMVxfTqTzNESZ+K5Leh/E7o2CzzaTLUdo6EK9J+yeX
         Am25pRjxYEIx4f5+XXawPLscWgRYBlijaVor8w5hUR3MGLjZMzbaiCLZMrj+z2FptiOl
         Ia63CZsPJM2SeCicGIIyCiwVaRUWqvCNQfKFwPgbemqx2F6vqz/0Ed5JyDT92LVFt4e8
         wRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=z2giIkcR5yNUAEux2tgME8c+c7hJW7vYqC1UrbevdqE=;
        b=qJiz05NvrNyra5IFU+TR6Irl+Ox7mtz3HshYmm2Be2RW1FmLzGbw+V8Euvt4C/h2tU
         Be+AsdT8vzQeM/1bcvfnfVjTfZu/D0xCToI7kTCMK84MsVOPk38pVcR67u24EXY0lbX8
         n9LoQspn4W4J5QDLd/WTqczXknn5HAfORSgV7/jUtdwIbMZWYerES53VYq8BKitFJBFp
         7gDyscAy7ZHLpogYL4UY87NimUHZkgF8nGrD35f4DfaAgZljupbmheetnVJgsycv0eSv
         xWVW+uB+Uy+UzmO2emU437gfqw1/qz9DAoOMKadg7eFqyGI6LFPx8YNofla5ne3AuRTW
         47pg==
X-Gm-Message-State: APjAAAXTfG3q18CEsN1XwKneur+RD7z7TtPoa/eFxKKWFf5JEinKmK+/
        a9Yvt/sYbVAxHB0n8FaeJyJmashh
X-Google-Smtp-Source: APXvYqzzGuopYJg693l09HMSYglr0MBXjt+5oVr+jBS8qezwisQ+HVbuscsKis8UtNYa/zqJ5wAp4Q==
X-Received: by 2002:a63:4962:: with SMTP id y34mr7968510pgk.425.1551901959726;
        Wed, 06 Mar 2019 11:52:39 -0800 (PST)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id m24sm3384517pgv.1.2019.03.06.11.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 11:52:38 -0800 (PST)
Date:   Wed, 6 Mar 2019 11:52:36 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, t.gummerer@gmail.com, gitster@pobox.com
Subject: [BUG] GIT_AUTHOR_NAME was checked before prepare_fallback got called
 (ps/stash-in-c)
Message-ID: <20190306195236.GA22872@dev-l>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I've been on "jch" for my daily use and I noticed today that git stash
isn't working. I managed to debug it down to "ps/stash-in-c".

To reproduce on git.git, it's simply the following:

	echo // >>dir.c
	git stash

This gives me the following error:

	$ git stash
	BUG: ident.c:511: GIT_AUTHOR_NAME was checked before prepare_fallback got called
	Aborted (core dumped)

I haven't read through the branch's code so I'm not too familiar with
the changes but please let me know if you need any other information or
if there's anything I can help with.

Thanks,

Denton
