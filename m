Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DAEC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 19:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEEF206DA
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 19:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MClNLewr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKTTNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:13:00 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:38573 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfKTTNA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 14:13:00 -0500
Received: by mail-wr1-f51.google.com with SMTP id i12so1253965wro.5
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 11:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=b2rZ8rw2hmZIepRF8DjXFzXFGfecJFSKk8fe25P65yQ=;
        b=MClNLewrhMhLwpoAdiDTpE6gT5lZyuS/OvWVypuVlkT3CTFgYYxP3XVbrb3CQSmNFX
         /im2aIrzm7ZJzPcz8vU2zqf/Zhwk2sR7G97A41YPppkmcrXQ/zgmZPmZnC83ON3CDz7U
         xO1Iv0C2wLLJDPy4+micf3FcOn7PAp9AKkMtvvdRPJqKvZeVaBlB0RioEr/gwjilYIu3
         hxUn45deCrYCah0ouE1GNHjSYXiTJfcbni4H/bTXlHznE/CQdpzCCNsiwCwQmJm30qpF
         5QP7MPfOGgBHpha+0QDHNM/zejLkAy3BpZPpM30c+SujVWiTWjU+AgihGJM9djcdgp12
         bhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b2rZ8rw2hmZIepRF8DjXFzXFGfecJFSKk8fe25P65yQ=;
        b=kXjVf6HytFl57nZ7bZrn5T1f7phRiy86b8MAupm2uMM4qtXleqGohrifXh8s0fiQW/
         Bjxx0dBJ6r6G9T7yxWNybsKIxOw4pkF669YaCtd2s4YUYK4JgkCssqpmWxzh3faHcs1c
         8Wz77O/8UW5Z+vJl7fMbiqUdEJ1VBZ709iYMJeLipbsnsLHa7F60m7MX94Qa5ErJwMCg
         THFKWCQZ7sT0Cnozxj6Hh39qA1lRKZq+qfurA6QeZDCd6gF/QSLR5GA/mp6oC+CQthTz
         VT2mO/qp5qyPFMwFP7XljEiMI6749yRbNaAOIsNF53N+xf28rUvmMXryWyuqirWxf1Ir
         kjnQ==
X-Gm-Message-State: APjAAAVwIc/T3sFsx1K0zxH8hOcm0tiA5iZyRe8egbZay4mnxYQxdkLR
        rBXb4VgwiGB4jcJDnUb9XPFEjwp4
X-Google-Smtp-Source: APXvYqxtFws6PEM6IYC1mtf+NYpUUO425hUJPzIbcex14GoBfxDqg1+lluvCFBca4p4eTaofwhBrKg==
X-Received: by 2002:adf:e80d:: with SMTP id o13mr5805056wrm.73.1574277178456;
        Wed, 20 Nov 2019 11:12:58 -0800 (PST)
Received: from szeder.dev (x4d0c5363.dyn.telefonica.de. [77.12.83.99])
        by smtp.gmail.com with ESMTPSA id v128sm283040wmb.14.2019.11.20.11.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 11:12:57 -0800 (PST)
Date:   Wed, 20 Nov 2019 20:12:52 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     John Sockwell <John@plasticcircus.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug report: git stash
Message-ID: <20191120191252.GA13575@szeder.dev>
References: <3F47D50C-4E1C-4BAC-AFB9-3E908B123278@plasticcircus.com>
 <DB3F5927-76A4-43F1-8A09-EEB7D0B6F720@plasticcircus.com>
 <B173575D-E845-498A-A3E4-5AF894215475@plasticcircus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B173575D-E845-498A-A3E4-5AF894215475@plasticcircus.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 20, 2019 at 05:26:12PM +0000, John Sockwell wrote:
> > I’ve encountered unexpected behavior using the `git stash pop —quiet` after the pop the all the files in the repo are untracked.
> > 
> > My software versions: 
> >> macOS Catalina 10.15.1
> >> zsh 5.7.1
> >> git 2.24.0
> > 
> > Steps to reproduce:
> >> Create an empty repo: `mkdir /tmp/git; cd /tmp/git; git init`
> >> Commit an empty file: `touch sample-file; git add sample-file; git commit --message "Initial commit”`
> >> Modify the sample file: `echo "modification" > sample-file`
> >> Stash the dirty tree: `git stash push`
> >> Pop the stash: `git stash pop` — working tree returned to dirty state with modified: sample file
> >> Stash the dirty tree again: `git stash push`
> >> Pop the stash using the —quiet option: `git stash pop —quiet`
> > 
> > Expected result: Same behavior as without the —quiet option. Working tree to again be returned to dirty state with modified: sample-file
> >> `git status`
> >> On branch master
> >> Changes not staged for commit:
> >>   (use "git add <file>..." to update what will be committed)
> >>   (use "git restore <file>..." to discard changes in working directory)
> >> 	modified:   sample-file
> >> 
> >> no changes added to commit (use "git add" and/or "git commit -a”)
> >> 
> > Actual result: working tree is dirty with a different set of changes deleted: sample-file, untracked files: sample-file
> >> `git status`
> >> On branch master
> >> Changes to be committed:
> >>   (use "git restore --staged <file>..." to unstage)
> >> 	deleted:    sample-file
> >> 
> >> Untracked files:
> >>   (use "git add <file>..." to include in what will be committed)
> >> 	sample-file

Thanks for the bug report.  It's a known issue that was indeed
introduced in v2.24.0, and we already have a fix for it in commit
df53c80822 (stash: make sure we have a valid index before writing it,
2019-11-13).

The previous bug report and related discussion can be found at:

  https://public-inbox.org/git/20191113150136.GB3047@cat/T/#u

Perhaps the fix will make it to a v2.24.0.1 soon-ish.

