From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] .clang-format: introduce the use of clang-format
Date: Wed, 21 Jan 2015 16:28:00 -0500
Message-ID: <CALkWK0knxJ5VTJoKhR_t4GS7pfg6PPYox9Srf3bvaX=m+sjqVw@mail.gmail.com>
References: <1421530221-39306-1-git-send-email-artagnon@gmail.com>
 <1421859687-27216-1-git-send-email-artagnon@gmail.com> <20150121204502.GA3287@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:28:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE2pU-0005iD-7k
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 22:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbbAUV2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 16:28:43 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:61877 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbbAUV2l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 16:28:41 -0500
Received: by mail-ie0-f179.google.com with SMTP id x19so10448534ier.10
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 13:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Y+ifvXTDdZe4ZDQT8iZMILCS49soynYniEKpwWbtyo8=;
        b=RigaeIz88BPKccVPInYJec7/H/7zeSOsVoZPfY1Uj67K8C/gEmmVszSTmZ9JF2nOPj
         HNrZMa8wgm6+zqZzi/QH03KXyM737s9Z0Zz2VBKVMfwLEVR/T+m2tMstqTeRI96iKnMU
         neuaYSb/hl03r0d4ek8gr83pJIG68kv6Zf1mPUt6gr9KmMkjPHygxbo3My58Z/RZDomz
         EDy3zOaXTtP9hnPOb3mXYqOrOh6xqY3UNqWdRikk17Afh1Yl5ttZYZt8dyvn1fWN+sDp
         v1Nmd6sosFup/ciXKxHJ14GhBhDBI/Jdc71jyXPi+exTBN78ufsztFhxnubmRNej9Fiv
         zBEQ==
X-Received: by 10.50.114.33 with SMTP id jd1mr38383770igb.31.1421875720880;
 Wed, 21 Jan 2015 13:28:40 -0800 (PST)
Received: by 10.64.102.163 with HTTP; Wed, 21 Jan 2015 13:28:00 -0800 (PST)
In-Reply-To: <20150121204502.GA3287@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262771>

Jeff King wrote:
> On Wed, Jan 21, 2015 at 12:01:27PM -0500, Ramkumar Ramachandra wrote:
>> +BreakBeforeBraces: Linux
>> [...]
>> +BreakBeforeBraces: Stroustrup

Oh, oops.

>  - It really wants to break function declarations that go over the
>    column limit, even though we often do not do so. I think we're pretty
>    inconsistent here, and I'd be fine going either way with it.
>
>  - It really wanted to left-align some of my asterisks, like:
>
>      struct foo_list {
>        ...
>      } * foo, **foo_tail;
>
>    The odd thing is that it gets the second one right, but not the first
>    one (which should be "*foo" with no space). Setting:
>
>      DerivePointerAlignment: false
>      PointerAlignment: Right
>
>    cleared it up, but I'm curious why the auto-deriver didn't work.

Sounds like a bug.

>  - It really doesn't like list-alignment, like:
>
>       #define FOO    1
>       #define LONGER 2
>
>    and would prefer only a single space between "FOO" and "1". I think
>    I'm OK with that, but we have a lot of aligned bits in the existing
>    code.
>
>  - It really wants to put function __attribute__ macros on the same line
>    as the function. We often have it on a line above (especially it can
>    be so long). I couldn't find a way to specify this.

You have to compromise a bit if you want to use an auto-formatting
tool, without losing your head patching every little detail :)

>  - I had a long ternary operator broken across three lines, like:
>
>      foo = bar ?
>            some_long_thing(...) :
>            some_other_long_thing(...);
>
>    It put it all on one long line, which was much less readable. I set
>    BreakBeforeTernaryOperators to "true", but it did nothing. I set it
>    to "false", and then it broke. Which seems like a bug. It also
>    insisted on indenting it like:
>
>      foo = bar ?
>                    some_long_thing(...) :
>                    some_other_long_thing(...);
>
>     which I found less readable.

To be honest, the LLVM community doesn't fix bugs just because they
can be fixed: it's quite heavily driven by commercial interest. And I
really don't find long ternary operators in a modern C++ codebase.

> I'm slightly dubious that
> any automated formatter can ever be _perfect_ (sometimes
> human-subjective readability trumps a hard-and-fast rule), but this
> seems like it might have some promise.

It works almost perfectly for the LLVM umbrella of projects. When they
want to change a coding convention (like leading Uppercase for
variable names), they write a clang-tidy thing to do it automatically.

> So overall I think it has some promise, but I do not think it is quite
> flexible enough yet for us to use day-to-day.

The big negative is that it will probably never be. I'll try to look
at the larger issues later this week, if you can compromise on the
fine details that are probably too hard to fix.

>   2. It can operate on patches (and generates patches for you to apply!
>      You could add a git-add--interactive mode to selectively take its
>      suggestions).

There's a git-clang-format in the $CLANG_ROOT/tools/clang-format/. I do:

   $ g cf @~

... with the appropriate aliases.
