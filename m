Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CEFC4332F
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 10:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKFKR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 05:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiKFKR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 05:17:27 -0500
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0271085
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 02:17:25 -0800 (PST)
Received: from desktop (unknown [211.86.152.151])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id C683D80010C;
        Sun,  6 Nov 2022 18:17:22 +0800 (CST)
Date:   Sun, 6 Nov 2022 18:17:06 +0800
From:   Wu Zhenyu <wuzhenyu@ustc.edu>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: Can git send-email support neomutt?
Message-ID: <20221106101706.jvgfnzn2jlk73i3f@desktop>
References: <20221105154600.hbrqs74inmvpebie@desktop>
 <Y2anAijZxu9QEX4M@tapette.crustytoothpaste.net>
 <20221106085820.m53mwajd5yfsyri4@desktop>
 <Y2d7B4mUPegaNPU6@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2d7B4mUPegaNPU6@tapette.crustytoothpaste.net>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTk9KVkMaSh9PSU8eTk1LSFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlKSlVDTVVKTklVSk5KWVdZFhoPEhUdFFlBWU9LSFVKSkpDSE1VSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORg6KAw6SD0eSFEBHTIZAzE*
        C0IKCypVSlVKTU1MTElCQ09ISU1JVTMWGhIXVQwOARMeFQIOOw4IDxhVHh8ORVlXWRILWUFZSUpK
        VUNNVUpOSVVKTkpZV1kIAVlBT0JCTzcG
X-HM-Tid: 0a844c71e29eb03akuuuc683d80010c
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> That program just has to implement a sendmail-compatible interface,
> which neomutt doesn't.  If you want to wrap neomutt in a
> sendmail-compatible interface like you've done, then this can work just
> fine.

Good.
The compatibility is important.
I'll ask neomutt can them provide an official sendmail-compatible interface.
Thanks!

On Sun, Nov 06, 2022 at 09:14:47AM +0000, brian m. carlson wrote:
> On 2022-11-06 at 08:58:20, Wu Zhenyu wrote:
> > Thanks for your quick reply.
> 
> Hi, please keep the list in CC.  It's helpful that everyone can benefit
> from seeing the replies, and it's possible someone else might have a
> thought on a good way forward.
> 
> > > You can also use `git format-patch --stdout | neomutt -f -` and that may
> > > provide you the same functionality you were hoping for with
> > > `sendemail.sendmailCmd`.
> > 
> > It cannot use `git send-email -1` I like.
> > 
> > > Mutt and Neomutt are MUAs, which stands for mail user agent.  That is,
> > > they're mail clients that people use to read, compose, and send email.
> > 
> > People can use MUA to send email, the only problem is `-i`. I consider the following method
> 
> Sure, I agree that we can do so.  In fact, as soon as I'm done composing
> this email, I'll be using mutt to send that.
> 
> > ```
> > [sendemail]
> > 	suppresscc = author
> > 	sendmailCmd = git-neomutt
> > ```
> > 
> > `~/.local/bin/neomutt`
> > 
> > ```
> > #!/usr/bin/env bash
> > neomutt "${@//-i/}"
> > ```
> > 
> > And it can work:
> > 
> > ```
> > ❯ git send-email -1
> > /tmp/5441yKUviQ/0001-TEST.patch
> > The following files are 8bit, but do not declare a Content-Transfer-Encoding.
> >     /tmp/5441yKUviQ/0001-TEST.patch
> > Which 8bit encoding should I declare [UTF-8]?
> > To whom should the emails be sent (if anyone)? my-another@email
> > Message-ID to be used as In-Reply-To for the first email (if any)?
> > Logging in...
> > Warning: Fcc to an IMAP mailbox is not supported in batch mode
> > Skipping Fcc to imaps://imaphz.qiye.163.com/Sent
> > OK. Log says:
> > Sendmail: git-neomutt -i my-another@email
> > From: Wu Zhenyu <wuzhenyu@ustc.edu>
> > To: my-another@email
> > Subject: [PATCH] TEST
> > Date: Sun,  6 Nov 2022 16:39:49 +0800
> > Message-Id: <20221106083949.210946-1-wuzhenyu@ustc.edu>
> > X-Mailer: git-send-email 2.38.1
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=UTF-8
> > Content-Transfer-Encoding: 8bit
> > 
> > Result: OK
> > ```
> 
> There's nothing here preventing you from invoking an arbitrary program.
> That program just has to implement a sendmail-compatible interface,
> which neomutt doesn't.  If you want to wrap neomutt in a
> sendmail-compatible interface like you've done, then this can work just
> fine.
> 
> > I want to know can we remove `-i` to allow more MUA/MTA? If user want to add something, why not let them
> > 
> > ```
> > [sendemail]
> > 	sendmailCmd = msmtp -i
> > ```
> 
> This breaks a lot of the existing tooling which expects that this is a
> sendmail-compatible interface.  In addition, we might add an additional
> value in the future, like -B8BITMIME (which we really should be adding
> if we're sending 8bit data).  The documentation specifically says it
> should be sendmail-like.
> 
> > I think it should be easy to realize.
> 
> I think this is going to cause a bunch of compatibility problems.  git
> send-email is specifically designed to cause email to be sent (i.e., via
> SMTP).  If you want to use another tool to do the sending, that's fine,
> but then you typically want to use git format-patch to provide those to
> the other program.
> 
> > And I'll consider share this tip to neomutt.
> > 
> > Thanks!
> 
> -- 
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA



-- 
Best Regards
Wu Zhenyu
