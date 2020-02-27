Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9EFC3F2C2
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 21:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503422469F
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 21:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgB0V5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:57:20 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:51081 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbgB0V5U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 16:57:20 -0500
X-Originating-IP: 73.42.98.145
Received: from Kepler (c-73-42-98-145.hsd1.nm.comcast.net [73.42.98.145])
        (Authenticated sender: greg@gpanders.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 83E2640002;
        Thu, 27 Feb 2020 21:57:17 +0000 (UTC)
Date:   Thu, 27 Feb 2020 14:57:15 -0700
From:   Greg Anders <greg@gpanders.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Subject: Re: git-shell default working directory
Message-ID: <20200227215715.qzxtbzvirxg3mnqv@Kepler>
References: <20200226004830.oxd5562v7qqspnkk@Kepler>
 <241ea912-44b2-96fa-6f9a-3f04d5386b05@gmail.com>
 <20200226201121.GA287048@coredump.intra.peff.net>
 <xmqqeeuhhz3a.fsf@gitster-ct.c.googlers.com>
 <20200226203931.GA288832@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200226203931.GA288832@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the replies everyone!

>Disclaimer: I'm not at all familiar with git server setup. Would it 
>make sense to change git user home directory to be the required 
>dedicated directory?      

I did think about this but that doesn't really solve the problem. The 
reason I'd like to use a dedicated directory for the repositories is so 
that I can separate the repos from the git user's home files (e.g.  
.profile, .ssh, etc.) I am also hosting an HTTP front end that reads the 
repos and I don't want to introduce a security risk by giving the web 
server access to the git user's home directory.

>Yeah, that's what I would suggest. git-shell does explicitly cd to
>$HOME, so any chdir you do before then will be lost (though you could
>perhaps just set $HOME in ~/.ssh/rc).

I did try ~/.ssh/rc, but when using git-shell it says `/bin/sh .ssh/rc: 
Unknown command` or something to that effect. I'm assuming this has to 
do with the fact that git-shell can only run a certain subset of 
commands (although according to the SSH docs, the rc file _should_ be 
executed _before_ switching to the user's $SHELL, so I'm not actually 
quite sure why this doesn't work).

>And I second the notion of gitolite for a dedicated setup like this (I
>haven't really used it much myself, but the design always seemed quite
>sane to me).

I'd actually never heard of gitolite before. It does look like a great 
piece of software, but I'm worried it might be overkill for me since I'm 
running just a single-user setup (i.e. me).

For now, I've just created symlinks from /srv/git into /home/git which 
allows cloning over SSH to work how I'd expect. I also created a 
interactive command under git-shell-commands/ that will create a new 
repository in /srv/git and also automatically generate the symlinks into 
/home/git. It feels a bit hacky, but it works!

