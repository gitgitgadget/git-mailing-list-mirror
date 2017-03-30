Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9BA20958
	for <e@80x24.org>; Thu, 30 Mar 2017 02:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbdC3C2h (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 22:28:37 -0400
Received: from mx1.riseup.net ([198.252.153.129]:42127 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752493AbdC3C2h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 22:28:37 -0400
Received: from piha.riseup.net (unknown [10.0.1.163])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 740021A22D1;
        Thu, 30 Mar 2017 02:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1490840915; bh=F1Y5D17+/k23gLnSYQRD9HtunBt+9l0HLxtPKcUyYzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NBO+jEyYoObnwak+2cHvbOa8wuBVzxpHAPe8oSbhmRP51Dx+/NIz9LYXYNRmSUMQv
         NA27iu0kaDkbenGn32+oRTpa2BirYNMSPxtGAF6y8AIh9+M2N7cJtqrS3FizZHuack
         2AOhRFSif+1XwmtVQ6Paae/O7FxP4iA9iZv/zXE8=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: pickfire)
        with ESMTPSA id 0554D1C0370
Date:   Thu, 30 Mar 2017 10:28:22 +0800
From:   Pickfire <pickfire@riseup.net>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: Re: [PATCH] userdiff: add build-in pattern for shell
Message-ID: <20170330022822.YGyP5YgSE%pickfire@riseup.net>
References: <20170329165331.17742-1-pickfire@riseup.net>
 <xmqqzig49e4j.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqzig49e4j.fsf@gitster.mtv.corp.google.com>
Mail-Followup-To: gitster@pobox.com, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> Ivan Tham <pickfire@riseup.net> writes:
> 
> > Shell are widely used but comes with lots of different patterns. The
> > build-in pattern aim for POSIX-compatible shells with some additions:
> >
> > - Notably ${g//re/s} and ${g#cut}
> > - "function" from bash
> >
> > Signed-off-by: Ivan Tham <pickfire@riseup.net>
> > ---
> >  Documentation/gitattributes.txt |  2 ++
> >  t/t4034-diff-words.sh           |  1 +
> >  t/t4034/sh/expect               | 14 ++++++++++++++
> >  t/t4034/sh/post                 |  7 +++++++
> >  t/t4034/sh/pre                  |  7 +++++++
> >  userdiff.c                      |  5 +++++
> >  6 files changed, 36 insertions(+)
> >  create mode 100644 t/t4034/sh/expect
> >  create mode 100644 t/t4034/sh/post
> >  create mode 100644 t/t4034/sh/pre
> >
> > diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> > index a53d093ca..1bad72df2 100644
> > --- a/Documentation/gitattributes.txt
> > +++ b/Documentation/gitattributes.txt
> > @@ -706,6 +706,8 @@ patterns are available:
> >  
> >  - `ruby` suitable for source code in the Ruby language.
> >  
> > +- `sh` suitable for source code in POSIX-compatible shells.
> 
> The new test you added seems to show that this is not limited to
> POSIX shells but also understands bashisms like ${x//x/x}.  Perhaps
> drop "POSIX-compatible" from here

Those shells are still POSIX-compatible so I think it is true to put
that or otherwise, something like fish shell will break since it is
as well a shell but the syntax is totally different.

> > diff --git a/userdiff.c b/userdiff.c
> > index 8b732e40b..8d5127fb6 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -148,6 +148,11 @@ PATTERNS("csharp",
> >  	 "[a-zA-Z_][a-zA-Z0-9_]*"
> >  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
> >  	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
> > +PATTERNS("sh",
> > +	 "^[ \t]*(function )?[A-Za-z_][A-Za-z_0-9]*[ \t]*()[\t]*\\{?$",
> 
> There is something funky going on around parentheses on this line.
> The ones around "function " is meant to be syntactic metacharacters
> to produce a group in the regexp so that you can apply '?'
> (i.e. zero or one occurrence) to it.  But I think the second pair of
> parentheses that appears later on the line, which enclose nothing,
> are meant to be literal?  E.g. "hello (){\n\techo world;\n}\n"  They
> would need some quoting, perhaps like
> 
> 	...[ \t]*\\(\\)[\t]*....

Ah, I think I forgot to escape the quoting of ( and ). I will send in another
patch for that.

> > +	 /* -- */
> > +	 "(\\$|--?)?([a-zA-Z_][a-zA-Z0-9._]*|[0-9]+|#)|--" /* command/param */
> 
> TBH, I have no idea what this line-noise is doing.

That breaks word into "a", "$a" and "-a" as well as "$1" and "$#". I tried
supporting $? by adding +|#|\\?)--" but it doesn't seemed like it is working.

> $foobar, $4, --foobar, foobar, 123 and -- can be seen easily out of
> these patterns.  I am not sure what --# would be (perhaps you meant
> to only catch $# and --# is included by accident, in which case it
> is understandable).  It feels a bit strange to see that $# is
> supported but not $?; --foo but not --foo=bar; foobar but not "foo
> bar" inside a dq-pair.

Yes, getting --# will be very rare in shell. I think it is better to seperate
the --foo=bar into --foo and bar. I don't get what you man by the dq-pair.

> > +	 "|\\$[({]|[)}]|[-+*/=!]=?|[\\]&%#/|]{1,2}|[<>]{1,3}|[ \t]#.*"),
> 
> And this one is even more dense.

Yes, that takes care of the operators, special symbols and stuff.
