Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3FDC0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 18:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA70B20674
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 18:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbgCPScu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:32:50 -0400
Received: from vps.thesusis.net ([34.202.238.73]:48348 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731967AbgCPSct (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 14:32:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id 17CBA2AEA6;
        Mon, 16 Mar 2020 14:32:49 -0400 (EDT)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (ip-172-26-1-203.ec2.internal [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id obTaFkHoRKA0; Mon, 16 Mar 2020 14:32:47 -0400 (EDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id C9C3B2AEA5; Mon, 16 Mar 2020 14:32:46 -0400 (EDT)
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au> <5B2FEA46-A12F-4DE7-A184-E8856EF66248@jramsay.com.au> <20200315221940.bdgi5mluxuetq2lz@doriath>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Phillip Susi <phill@thesusis.net>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 3/17] Obliterate
In-reply-to: <20200315221940.bdgi5mluxuetq2lz@doriath>
Date:   Mon, 16 Mar 2020 14:32:46 -0400
Message-ID: <87lfo0881d.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Damien Robert writes:

> My situation: coworkers push big files by mistake, I don't want to rewrite
> history because they are not too well versed with git, but I want to keep
> *my* repo clean.
>
> Partial solution:
> - identify the large blobs (easy)
> - write a replace ref (easy):
>   $ git replace b5f74037bb91 $(git hash-object -w -t blob /dev/null)
>   and replace the file (if it is still in the repo) by an empty file.
>
> Now the pain points start:
> - first the index does not handle replace (I think), so the replaced file
>   appear as changed in git status, even through eg git diff shows nothing.

Instead of replacing the blob with an empty file, why not replace the
tree that references it with one that does not?  That way you won't have
the file in your checkout at all, and the index won't list it so status
won't show it as changed.

