Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A463CC2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798362072C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RA0VFghD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392475AbgAXU35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:29:57 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:34450 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387548AbgAXU35 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 15:29:57 -0500
Received: by mail-wr1-f41.google.com with SMTP id t2so3573995wrr.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 12:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=MRsquq1uDuLP5KLaqGzm6EJX8wJUT2cT0ZiQ5k7ESvY=;
        b=RA0VFghDeVkqUBcKWc5V/njJkAu4bi8z+LlzOyrCaYlLvdJOCPFRXleanh5thkhpdB
         00HJr5B8lhVztp7MkaU0gY2OWHtN27I/4usUHwsJwI457GTZSh6S4iuCIJvw7UbSEm/p
         4nJZMbpcxu/D/QhxuBfxIJ92vFmoh3Wj36QONEvED/tJ899SFEt/3sugPgeDZu2LGyJY
         iLcwI8s7eMaXqgTYNlPRuUWzPvcVCfS8F7rGMzwX92B/IkZuMC0buy55tsBVGm+Rwi2Z
         ENi3cQsgdAlKsIDR//tVKIHxgdi8RhZeC8GJJCYHrczq1G9Xd5THh/WITpZWZAbaCOuy
         iWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=MRsquq1uDuLP5KLaqGzm6EJX8wJUT2cT0ZiQ5k7ESvY=;
        b=mnBXVf65oibp169dOa7FhFKf8SnXEp0Jt68CnbKeOzB8h6lJ9MOQhOJCxJVomEinFf
         JK4uoRf1mWYZho67DFqRoyDNpwn/8e+T1DqcHFTwdAVXLdsLK0uWq02fOFWBngUITike
         9pcfXuz9WTgIOkRe4PVoK3CqbSk8LrTFN8v/sweagY7dszZiAznw1tnmTrB7Bov6SS9Y
         zYqWjKRZdNlTxlWaeqwq/HxYKWd7h8dqlLsuSbPAYZFEv0Uh1nFPZx6tWuhYWJ/tuFLZ
         4AvzOpAKe1dWyU7ij/go0mGzLdECSFCdOT+86/OOq7HnVzCgQVLzq8UeWTp6le+mNIVA
         XRVg==
X-Gm-Message-State: APjAAAWSrFIvs5zieCYGDLMuWed5ypKBo3RFDUtrO2WuNfnBTW6Y6OWh
        95WiB2cEk5pargrKltM=
X-Google-Smtp-Source: APXvYqzBNoTRpjPZNL03o7eJgYezii60e4vuwP4YY8zm/gecuO63/FLPLdkeqQ4KV6ofMNCxmzTkhA==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr5920942wrp.238.1579897794609;
        Fri, 24 Jan 2020 12:29:54 -0800 (PST)
Received: from ?IPv6:2a02:810a:8c80:d2c:1d4:baf0:179f:5856? ([2a02:810a:8c80:d2c:1d4:baf0:179f:5856])
        by smtp.gmail.com with ESMTPSA id y131sm8133471wmc.13.2020.01.24.12.29.53
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 12:29:54 -0800 (PST)
To:     git@vger.kernel.org
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [Q] push refspec with wildcard pushes all matching branches
Message-ID: <ed9a0485-1e6c-79ae-6a59-655105203728@googlemail.com>
Date:   Fri, 24 Jan 2020 21:29:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

I'm a little confused, that a push refspec with a wildcard changes the number of branches pushed.

Here is what I see with Git 2.25:

     $ git --version
     git version 2.25.0
     $ git config --list
     user.email=bert.wesarg@googlemail.com
     user.name=Bert Wesarg
     $ git init --bare bare.git
     $ git clone bare.git repo
     Cloning into 'repo'...
     warning: You appear to have cloned an empty repository.
     done.
     $ cd repo
     $ git config push.default current
     $ echo foo >foo
     $ git add foo
     $ git commit -m foo
     [master (root-commit) 4d0b276] foo
      1 file changed, 1 insertion(+)
      create mode 100644 foo
     $ git branch master-two
     $ git push --dry-run
     To ../bare.git
      * [new branch]      master -> master
     $ git config remote.origin.push 'refs/heads/master*:refs/remotes/origin/master*'
     $ git push --dry-run
     To ../bare.git
      * [new branch]      master -> origin/master
      * [new branch]      master-two -> origin/master-two

Is this expected behavior?

Thanks.

Best,
Bert
