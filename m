Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68399C433FE
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 09:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiKFJD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 04:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiKFJD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 04:03:26 -0500
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5D4BA8
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 01:03:23 -0800 (PST)
Received: from desktop (unknown [211.86.152.151])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id DF8BF8000E6;
        Sun,  6 Nov 2022 17:03:21 +0800 (CST)
Date:   Sun, 6 Nov 2022 17:02:33 +0800
From:   Wu Zhenyu <wuzhenyu@ustc.edu>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: Can git send-email support neomutt?
Message-ID: <20221106090233.ukf6rjzrygpnavzh@desktop>
References: <20221105154600.hbrqs74inmvpebie@desktop>
 <Y2anAijZxu9QEX4M@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2anAijZxu9QEX4M@tapette.crustytoothpaste.net>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSxodVh1NSkkfSB9DSElJT1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUlKSlVDTVVKTklVSk5KWVdZFhoPEhUdFFlBWU9LSFVKSkpDSE1VSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRg6PAw*KD0uD1EJQygSFjEy
        PiwwCThVSlVKTU1MTElOT0tJSElPVTMWGhIXVQwOARMeFQIOOw4IDxhVHh8ORVlXWRILWUFZSUpK
        VUNNVUpOSVVKTkpZV1kIAVlBT0pOSDcG
X-HM-Tid: 0a844c2e1f5eb03akuuudf8bf8000e6
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your quick reply.

> You can also use `git format-patch --stdout | neomutt -f -` and that may
> provide you the same functionality you were hoping for with
> `sendemail.sendmailCmd`.

It cannot use `git send-email -1` I like.

> Mutt and Neomutt are MUAs, which stands for mail user agent.  That is,
> they're mail clients that people use to read, compose, and send email.

People can use MUA to send email, the only problem is `-i`. I consider the following method

```
[sendemail]
	suppresscc = author
	sendmailCmd = git-neomutt
```

`~/.local/bin/neomutt`

```
#!/usr/bin/env bash
neomutt "${@//-i/}"
```

And it can work:

```
❯ git send-email -1
/tmp/5441yKUviQ/0001-TEST.patch
The following files are 8bit, but do not declare a Content-Transfer-Encoding.
    /tmp/5441yKUviQ/0001-TEST.patch
Which 8bit encoding should I declare [UTF-8]?
To whom should the emails be sent (if anyone)? my-another@email
Message-ID to be used as In-Reply-To for the first email (if any)?
Logging in...
Warning: Fcc to an IMAP mailbox is not supported in batch mode
Skipping Fcc to imaps://imaphz.qiye.163.com/Sent
OK. Log says:
Sendmail: git-neomutt -i my-another@email
From: Wu Zhenyu <wuzhenyu@ustc.edu>
To: my-another@email
Subject: [PATCH] TEST
Date: Sun,  6 Nov 2022 16:39:49 +0800
Message-Id: <20221106083949.210946-1-wuzhenyu@ustc.edu>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Result: OK
```

I want to know can we remove `-i` to allow more MUA/MTA? If user want to add something, why not let them

```
[sendemail]
	sendmailCmd = msmtp -i
```

I think it should be easy to realize.

And I'll consider share this tip to neomutt.

Thanks!

On Sat, Nov 05, 2022 at 06:10:10PM +0000, brian m. carlson wrote:
> On 2022-11-05 at 15:46:00, Wu Zhenyu wrote:
> > Excuse me.
> > 
> > I want to use neomutt as git send-email's cmd:
> > 
> > ```
> > [sendemail]
> > 	sendmailCmd = neomutt
> > ```
> 
> Mutt and Neomutt are MUAs, which stands for mail user agent.  That is,
> they're mail clients that people use to read, compose, and send email.
> The sendmailCmd wants an MTA, or mail transfer agent, which is
> essentially a mail server.  It's customary for most Unix systems to have
> such a piece of software which emulates the original Sendmail in its
> command-line interface, even if that's to send data off the system.
> 
> That's why you see a fixed interface here, because whether someone is
> using Sendmail, Exim, Postfix, or a smarthost-only tool like esmtp-run,
> whatever software is being used presents the same interface.
> 
> It's not likely that we'd add a lot of customizability to this option.
> However, you can use the same SMTP server that you use with Neomutt by
> setting the smtpuser, smtpencryption, smtpserver, and smtpserverport
> options.
> 
> You can also use `git format-patch --stdout | neomutt -f -` and that may
> provide you the same functionality you were hoping for with
> `sendemail.sendmailCmd`.
> -- 
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA



-- 
Best Regards
Wu Zhenyu

