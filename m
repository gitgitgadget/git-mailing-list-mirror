Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC21C35250
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 13:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC9D206D6
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 13:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgBINOq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 9 Feb 2020 08:14:46 -0500
Received: from claranet-outbound-smtp07.uk.clara.net ([195.8.89.40]:57228 "EHLO
        claranet-outbound-smtp07.uk.clara.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727340AbgBINOq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Feb 2020 08:14:46 -0500
Received: from 79-76-59-82.dynamic.dsl.as9105.com ([79.76.59.82]:8008 helo=PDSDELL)
        by relay07.mail.eu.clara.net (relay.clara.net [81.171.239.37]:10465)
        with esmtpa (authdaemon_login:gershenson-smith) id 1j0mQ6-0001y1-Oy 
        (return-path <paul@pauldsmith.org.uk>); Sun, 09 Feb 2020 13:14:43 +0000
From:   <paul@pauldsmith.org.uk>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <paul@pauldsmith.org.uk>
Cc:     <git@vger.kernel.org>
References: <VI1P192MB025548BB0508125DF9B5852DC81C0@VI1P192MB0255.EURP192.PROD.OUTLOOK.COM> <005001d5dda3$5bc12510$13436f30$@pauldsmith.org.uk> <20200207234618.GH6573@camp.crustytoothpaste.net>
In-Reply-To: <20200207234618.GH6573@camp.crustytoothpaste.net>
Subject: RE: Support 'help' for custom/alias commands
Date:   Sun, 9 Feb 2020 13:14:42 -0000
Message-ID: <00df01d5df4a$e422af70$ac680e50$@pauldsmith.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJYcFYYt0Fq+QhLlA5BsdLSkzFOOgHxLHG/AjQdIHmm7Im7cA==
Content-Language: en-gb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian,

Thanks for considering this.  I've not tried MANPATH but will take a look - my employers use both Linux and Windows so this would only address half the issue but I also understand your comments on "one config to rule them all" and the HTML/MAN issue.

I've used ASCIIDOCTOR already to create config but I feel it would be nice if that could be rolled up into some sort of bundle but it users don't want Ruby then yes, it's not going to work for them.  My personal take is that anyone wanting docs for their custom applications should create them like core Git does - and with Docker and similar it's easy to isolate an environment so perhaps a Docker image might be the way to go.

Clearly room for a little more thought on my part.

Regards,
Paul DS

-----Original Message-----
From: brian m. carlson <sandals@crustytoothpaste.net> 
Sent: 07 February 2020 23:46
To: paul@pauldsmith.org.uk
Cc: git@vger.kernel.org
Subject: Re: Support 'help' for custom/alias commands

On 2020-02-07 at 10:42:56, paul@pauldsmith.org.uk wrote:
> Adding a custom comment (let’s call is ‘foolish’) is easy but then you 
> someone types ‘git help foolish’, they get some strange message about 
> help not being found.
> 
> There are two problems with this:
> 
> 1. It’s hard for users to create good documentation in the same format 
> as the core git product 2. The git ‘help’ processing currently looks 
> in one, and one place only and that location is often ‘locked down’ 
> meaning that mere users cannot add their custom help to this directory.

It is possible to extend the set of locations that one can use for man by setting MANPATH.  If you do so, something like "git foolish --help"
does indeed work.

> I propose that #1 be solved by creating a command/tool and 
> documentation that explains how to mimic the input to the standard Git 
> help files and have them processed to create the HTML/HTML5/MAN help 
> normally produced.  Ideally it would do exactly the same processing as 
> the core tools (perhaps even having their docs built using this tool 
> now) and use exactly the same template files that core git uses.

There is such a tool, and it's called Asciidoctor.  However, it's written in Ruby, and not all users will want to install Ruby as part of their Git installation.  It does work nicely, though, and I use it for my own custom Git subcommands.

Also, if a user prefers to use a different tool for creating manual pages or HTML documentation, they can certainly do so.

> I propose that #2 be solved by allowing a new set of ‘git config’ fields.
> The layout should be sensible and should users to be able to set a git 
> variable which then means that the core git help finds their help text.
> Possible we want to force
> 
> <where I installed my tool>/docs/man, or html, or html5
> 
> And the git config variable be something like 
> “help.custom.foolish=<where-foolish-is-installed>/docs”

I think specifying a single location may be a problem because different types of documentation live in different locations.  On Debian, man pages live in /usr/share/man, but HTML documentation lives in /usr/share/doc.

We could theoretically add support for this if we did help.foolish.man and help.foolish.html, though.

I don't feel strongly enough about this to implement it, but if you're interested, I could review a patch.
--
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

