From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] git log --pretty=lua
Date: Tue, 25 Sep 2012 18:22:49 +0700
Message-ID: <CACsJy8Bs4P7R7m7uAqHYdmrXJA1RQmuoC7ybJFHWhW=efffQyw@mail.gmail.com>
References: <20120925002325.GA19560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 25 13:23:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGTEi-0001PJ-8u
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 13:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024Ab2IYLXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 07:23:21 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37256 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843Ab2IYLXU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 07:23:20 -0400
Received: by ieak13 with SMTP id k13so13516209iea.19
        for <git@vger.kernel.org>; Tue, 25 Sep 2012 04:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=h2mbdeLwVk12X/kVoukP0PefWurNtTNBNQ48i7g0jR4=;
        b=lnPUPMl60DYe79njpTsN4glF8+BYnHEoDGUC4A05ukc7D4gAOIUuSCrr13YSlqTEGX
         Na4L/r6i3g+tb7df8v8fa02GctCvwmzbOXDhAiRBgjR3IlhCqr6bukjUb8utGYO2eKFB
         pNYNSxloxOennNKVGw5EfcDePstlocYIZU9Fl6Y6Sed/fMH2rcDXaWfl2uamFnwFScbg
         XNdjLf46Zjykb4Alf2b6WVkslUHR8lDSyUFTVgzSJzjynxgsBJYQkW4RAtS2OouWvn8K
         TS/U37CW9Gy0LsCF8DR1yOrZbPC23yeKrfDs/mfaBH3l7ww3/w9gnBkDyvuCtwAm/UHO
         bJjQ==
Received: by 10.50.87.167 with SMTP id az7mr7974113igb.40.1348572199514; Tue,
 25 Sep 2012 04:23:19 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Tue, 25 Sep 2012 04:22:49 -0700 (PDT)
In-Reply-To: <20120925002325.GA19560@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206356>

On Tue, Sep 25, 2012 at 7:23 AM, Jeff King <peff@peff.net> wrote:
> We've talked off and on about extending the --pretty=format specifiers
> to something more flexible. There's also been talk recently of more
> flexible commit-filtering (e.g., grepping individual notes).  Rather
> than invent a new Turing-complete language, I thought I'd try building
> on somebody else's work by embedding an existing language.
>
> Why Lua? I don't especially like it as a language. But it's designed for
> this purpose, which makes it very lightweight and relatively simple to
> embed.

Personally I'd prefer a Scheme variant.

> The syntax, on the other hand...yuck.

Oops. Scheme is out then.

> One thing that makes Lua
> horrible for this use is that it does not have interpolated strings.
> However, there are template libraries for Lua, so maybe there's
> something there.

For --pretty, the first thing I looked up was utf-8 support and Lua
does not seem to have that built in. Libraries can help but it'll be
more verbose than native language support.

> And a "4/3" patch would probably add "--lua-filter" as a revision option
> for limiting commits.

I was thinking of nearly the same thing, except that I hide the
filters behind sha-1 extended syntax. Users can link <sha-1>@{foo} to
a lua function, for example.

I wonder what areas in git might benefit from such a scripting
language, and whether someday we would convert some of git builtin
commands to $NEWLANG, if $NEWLANG proves easier to maintain for
complex logic commands. grep and rev-list (searching in general) are
probably where $NEWLANG shines. But for really complex searches, one
may want to go with libgit2 or other bindings to their favourite
language than one git may provide. gitignore and gitattributes can
make use of $NEWLANG but it has to be really fast. There was talk
about conditionals in config file, which $NEWLANG might also help.

In general I'm quite happy with what git provides. There are many
advanced features that I have never used/or even aware of.
-- 
Duy
