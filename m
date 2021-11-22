Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187F8C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 16:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbhKVQtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:49:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46426 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbhKVQtq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 11:49:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BDCB91FD49;
        Mon, 22 Nov 2021 16:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637599598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MwY9CItopwYCDWBhG7Ab99sZyNE4d5JyP/KYmEZ4qLs=;
        b=BIklKBVghw/POD3LQLqxvrJ+wFApRscu+FvwLXwUxXn3W7whMXruQqa+MUVbJPmXaS2KOI
        Xt/4s7DwS9Qyw/2HJeHCFIt0srluCpVN5RiwiiCQqfdVcvmwQLWMDK7aKtjqkXHdhQWGqf
        9+v1E2LBGkyIplOhW2bPLpGvAZMOnr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637599598;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MwY9CItopwYCDWBhG7Ab99sZyNE4d5JyP/KYmEZ4qLs=;
        b=BZEk3PNng1yt3t+g9N3bpvsq7eJ+8ZMeKl7csOINiL5sPMqrHGgwwXYrpQLus+Eczl+idb
        pfw3SF5BMDDG8fAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 399DE13B44;
        Mon, 22 Nov 2021 16:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mnluAG7Jm2ETOgAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Mon, 22 Nov 2021 16:46:38 +0000
Date:   Mon, 22 Nov 2021 13:46:35 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
Message-ID: <20211122164635.6zrqjqow4xa7idnn@cyberdelia>
References: <20211120194048.12125-1-ematsumiya@suse.de>
 <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
 <xmqqfsrplz3z.fsf@gitster.g>
 <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
 <211122.86a6hwyx1b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <211122.86a6hwyx1b.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/22, =C6var Arnfj=F6r=F0 Bjarmason wrote:
>I think an alternate direction of simply getting rid of "argv" is better
>in this case, and I've just submitted a topic to do that:
>https://lore.kernel.org/git/cover-0.5-00000000000-20211122T153605Z-avarab@=
gmail.com/

Well, this is my first interaction with git's source, so I can't say for
sure, but that solution seems more complete indeed.

>It still leave us with this oddity:
>
>    $ ~/g/git/git -c pager.show=3DINVALID_PAGER show  HEAD
>    error: cannot run INVALID_PAGER: No such file or directory
>    error: cannot run INVALID_PAGER: No such file or directory
>
>But that was the case before that topic (if we hadn't
>crashed/segfaulted), and with your proposed change here.

Yes, I did find it weird on my initial debugging, but didn't care at
first.

Now, looking again, it's because git (main command) have a higher
precedence on pager preference, so it tries to setup/run the pager
before running subcommands.

An issue I've hit now is, if we don't want to fallback to any other
setting, this works:

diff --git a/pager.c b/pager.c
index d93304527d62..b528bbd644b5 100644
--- a/pager.c
+++ b/pager.c
@@ -110,6 +110,14 @@ void setup_pager(void)
         if (!pager)
                 return;

+       /*
+        * There's already a pager set up and running.
+        * Regardless if it was successful or not, we shouldn't try running
+        * it again.
+        */
+       if (pager_in_use())
+               return;
+
         /*
          * After we redirect standard output, we won't be able to use an i=
octl
          * to get the terminal size. Let's grab it now, and then set $COLU=
MNS

However, IMHO it would make sense to try pager.<subcommand> if a
previous attempt failed, e.g.:

$ git config pager.show my-valid-pager
$ GIT_PAGER=3Dinvalid-pager git -p show

So this will first try invalid-pager, fail, and not try again, with the
above patch. As a user, I would expect that my-valid-pager to be run in
case invalid-pager failed.

What do you think?


Cheers,

Enzo
