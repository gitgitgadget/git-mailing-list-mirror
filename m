X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] [checkout-index] Give names to stages
Date: Sun, 3 Dec 2006 21:18:32 -0800 (PST)
Message-ID: <505428.75434.qm@web31808.mail.mud.yahoo.com>
References: <7v1wngv2rc.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 4 Dec 2006 05:18:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=4E943ylQ2Zne7Gg2qroJPSyBvA7bv5AaD6Sw5lTNvbVJcOkDfbLZeW5k5ybk93qh6cxWHQmJbUrcz7Xb/H0lM7LCqQ4McTUTHqYOmieLWDlrcLeqWzutS4+a0KHmMdkoR58kgYksI8BCb/QHxEZdX9r0jbE3cHYMwNbNI3wXI0c=;
X-YMail-OSG: htl_y9sVM1lzM_srj1KgWwX_glvloGPJZiqH3yjNjnGkuWTfHvqH6zcOPnb_agDCWqLemw4gcqQdtS.9WTCkkFYFDnIeumUpfjQ9Jlhum_GbhtvPmBV087bvv8GCDKi24Pr93bmrWcY-
In-Reply-To: <7v1wngv2rc.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33164>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr6Dw-0007uY-Df for gcvg-git@gmane.org; Mon, 04 Dec
 2006 06:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932068AbWLDFSh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 00:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759862AbWLDFSh
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 00:18:37 -0500
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:62880 "HELO
 web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1759861AbWLDFSg (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 00:18:36 -0500
Received: (qmail 76007 invoked by uid 60001); 4 Dec 2006 05:18:32 -0000
Received: from [68.186.59.199] by web31808.mail.mud.yahoo.com via HTTP; Sun,
 03 Dec 2006 21:18:32 PST
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > One can now say "git-checkout-index --stage=ours ..."  or
> > "git-checkout-index --stage=theirs ...", instead of having
> > to remember the corresponding number assigned to each stage.
> 
> I really do not like to have this in checkout-index; I would
> rather keep checkout-index a purely plumbing thing.  If there
> are valid and frequently appearing use cases that currently
> requires "checkout-index --stage=$n", I think that need should
> be addressed as a missing feature in the UI layer.

Sometimes when I pull things from a bunch of places and do
a resolve, I'm presented with the standard resolve format of
a source file, "<<<< ==== >>>>" thingie, and all I'd really
like to do is "accept ours".  I.e. something similar to what I've
seen in other (commercial) SCMs, a la "scm resolve accept ours".

This patch merely allows the user to say
   git-checkout-index --stage=ours their_broken_file.c
instead of
   git-checkout-index --stage=2 their_broken_file.c
and similarly for "theirs", etc.

If you think this breaks the ideology, ok.

    Luben

> During a conflicted merge, you may run "diff --cc" in order to
> decide that you would want to take yours (or theirs), and that
> would be a good reason to wanting to checkout "your" version (or
> "their" version; but I do not think of a valid reason to want to
> say "checkout-index --stage=1").  From the UI point of view, it
> would make more sense to be able to say:
> 
> 	$ git checkout --ours hello.c
> 	$ git checkout --theirs Makefile
> 
> If the user is interested in looking at raw copies of our and
> their version for comparison (not just "diff --theirs" kind of
> usage), it _might_ even make sense to be able to do:
> 
> 	$ git checkout --stdout --ours hello.c >hello.c-ours
> 	$ git checkout --stdout --theirs hello.c >hello.c-theirs
>         $ diff -u hello.c-ours hello.c-theirs
> 
> I do not particularly like the above overloaded meaning of
> "checkout" myself, but that would be something people who are
> used to "cvs up -p" might expect to be able to do.
> 
> If we were to do both of the above, then it might even make
> sense to make the first form (sans --stdout) to also mark the
> index entry after checking out the specified higher stage.
> 
> And the UI layer (Porcelain-ish) should be where we should add
> the "usability" and "human readability" bits.

