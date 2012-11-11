From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Sun, 11 Nov 2012 18:45:32 +0100
Message-ID: <CAMP44s1mny-fBCxywM0V=AgEoxV5EZdDWc_0NK3gepcKf32nww@mail.gmail.com>
References: <5093DC0C.5000603@drmicha.warpmail.net>
	<20121108200919.GP15560@sigill.intra.peff.net>
	<509CCCBC.8010102@drmicha.warpmail.net>
	<CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
	<509E8EB2.7040509@drmicha.warpmail.net>
	<CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>
	<509EAA45.8020005@gmail.com>
	<CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com>
	<509FD9BC.7050204@gmail.com>
	<20121111171518.GA20115@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 18:45:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXbbP-0007ad-7u
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116Ab2KKRpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 12:45:34 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:56163 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab2KKRpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 12:45:33 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5568987oag.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 09:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=k8Bcw42gtzIjtv3nxCTgqjNmifInzlAxsitkJaVQrDg=;
        b=ek3mVtOUzLeDeOKRZapspFf7lRq2UUM/J4xTRV6wWype2+9awq07jzBVjl4cR4dT2b
         yvn4m2gDjgdt9ilE4SMA/cDIW7r8Xc9bjHYLPECQ5o8Mwb0xF60on8D8UNbchfCr9Mnl
         BnS+B0ffg+3c2bat7i+5sTrTfynM6myYQkMIg5JYn4qldF9LoumdQBbNlUS/89A6LM3q
         f8idV1Kqzjng7GmO9j1LMCnGTfnMBYIhfeoBZ4sJt9uzVtor0aq6DStxK+ZhwLC2rNwj
         +PL8L5O416ag8LQOxHzwmQWUK8My6IVD+kKMYEGpSv6Cz5JITXxKOnEnCoT1NOsU501+
         49hA==
Received: by 10.182.245.20 with SMTP id xk20mr13421124obc.89.1352655932714;
 Sun, 11 Nov 2012 09:45:32 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 09:45:32 -0800 (PST)
In-Reply-To: <20121111171518.GA20115@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209427>

On Sun, Nov 11, 2012 at 6:15 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 11, 2012 at 12:00:44PM -0500, A Large Angry SCM wrote:

> If there is a standard filter, then what is the advantage in doing it as
> a pipe? Why not just teach fast-import the same trick (and possibly make
> it optional)? That would be simpler, more efficient, and it would make
> it easier for remote helpers to turn it on (they use a command-line
> switch rather than setting up an extra process).

Right, but instead of a command-line switch it probably should be
enabled on the stream:

  feature clean-authors

Or something.

> But what I don't understand is: what would such a standard filter look
> like? Fast-import (or a filter) would already receive the exporter's
> best attempt at a git-like ident string.

Currently, yeah, because there's no other option. It's either try to
clean it up, or fail.

But if 'git fast-import' as a superior alternative, I certainly would
remove my custom code and enable that feature.

> We can clean up and normalize
> things like whitespace (and we probably should if we do not do so
> already). But beyond that, we have no context about the name; only the
> exporter has that.

There is no context.

> So if we receive:
>
>   Foo Bar<foo.bar@example.com> <none@none>
>
> or:
>
>   Foo Bar<foo.bar@example.com <none@none>
>
> or:
>
>   Foo Bar<foo.bar@example.com
>
> what do we do with it? Is the first part a malformed name/email pair,
> and the second part is crap added by a lazy exporter? Or does the
> exporter want to keep the angle brackets as part of the name field? Is
> there a malformed email in the last one, or no email at all?

These are exactly the same questions every exporter must answer. And
there's no answer, because the field is not a git author, it's a
mercurial user, or a bazaar committer, or who knows what.

>From whatever source, these all might be valid authors:
john
john <john@travolta.com> (grease)
<test@test.com>
test@test.com
test<test@test.com>
test <test@test.com
test # a space
test < test@test.com >
test >test@est.com>
test <test <at> test <dot> com>
<>
>
<
The first chapter of the LOTR

There is no context.

> The exporter is the only program that actually knows where the data came
> from,

It doesn't matter where it came from, it's not a name/email pair.

> how it should be broken down,

It cannot be broken down, it's free-form text. Any text.

> and what is appropriate for pulling
> data out of its particular source system.

This free-form text is the lowest granularity. There is nothing else.

> For that reason, the exporter
> has to be the place where we come up with a syntactically correct and
> unambiguous ident.

*If* the exporter is able to do this, sure, but many don't have any
more information.

See:

% hg commit -u 'Foo Bar<foo.bar@example.com> <none@none>' -m one
% hg --debug log
changeset:   0:5ef37a2c773f02d0e01f1ecdcc59149832d294e8
tag:         tip
phase:       draft
parent:      -1:0000000000000000000000000000000000000000
parent:      -1:0000000000000000000000000000000000000000
manifest:    0:c6d4cd25b9fc2f83b0dd51f4acbea9486fce54d7
user:        Foo Bar<foo.bar@example.com> <none@none>
date:        Sun Nov 11 18:33:00 2012 +0100
files+:      file
extra:       branch=default
description:
one

What is a hg exporter tool supposed to do with that?

What such a tool can do, 'git fast-import' can do.

> I am not opposed to adding a mailmap-like feature to fast-import to map
> identities, but it has to start with sane, unambiguous output from the
> exporter.

And if that's not possible?

-- 
Felipe Contreras
