Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 616681F4F8
	for <e@80x24.org>; Thu, 29 Sep 2016 02:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbcI2CrM (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 22:47:12 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:43046 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750719AbcI2CrL (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Sep 2016 22:47:11 -0400
Received: from x590e2b22.dyn.telefonica.de ([89.14.43.34] helo=localhost.localdomain)
        by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
        iface 141.3.10.81 id 1bpRNE-0001l5-Cs; Thu, 29 Sep 2016 04:47:01 +0200
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>, peff@peff.net,
        torvalds@linux-foundation.org, git@vger.kernel.org
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
Date:   Thu, 29 Sep 2016 04:44:00 +0200
Message-Id: <20160929024400.22605-1-szeder@ira.uka.de>
X-Mailer: git-send-email 2.10.0.516.gccda3a9
In-Reply-To: <20160928233047.14313-5-gitster@pobox.com>
References: <20160928233047.14313-5-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1475117222.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> As Peff said, responding in a thread started by Linus's suggestion
> to raise the default abbreviation to 12 hexdigits:
> 
>     I actually think "12" might be sane for a long time. That's 48 bits of
>     sha1, so we'd expect a 50% change of a _single_ collision at 2^24, or 16

s/change/chance/

I know it's quoted, but still.

>     million.  The biggest repository I know about (in number of objects) is
>     the one holding all of the objects for all of the forks of
>     torvalds/linux on GitHub. It's at about 15 million objects.
> 
>     Which _seems_ close, but remember that's the size where we expect to see
>     a single collision. They don't become common until much later (I didn't
>     compute an exact number, but Linus's 16x sounds about right). I know
>     that the growth of the kernel isn't really linear, but I think the need
>     to bump to "13" might not just be decades, but possibly a century or
>     more.
> 
>     So 12 seems reasonable, and the only downside for it (or for "13", for
>     that matter) is a few extra bytes. I dunno, maybe people will really
>     hate that, but I have a feeling these are mostly cut-and-pasted anyway.

I for one raise my hand in protest...

"few extra bytes" is not the only downside, and it's not at all about
how many characters are copy-and-pasted.  In my opinion it's much more
important that this change wastes 5 columns worth of valuable screen
real estate e.g. for 'git blame' or 'git log --oneline' in projects
that don't need it and certainly won't ever need it.

Sure, users working on smaller repos are free to reset core.abbrev to
its original value.  I don't have any numbers, of course, but I
suspect that there are many more smaller repos out there that this
change will affect disadvantageously, than there are large repos for
which it's beneficial.


> And this does exactly that.
> 
> Keep the tests working by explicitly asking for the old 7 hexdigits
> setting in the fake system-wide configuration file used for tests.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
