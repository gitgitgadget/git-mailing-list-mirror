From: Colin Watson <cjwatson@debian.org>
Subject: Re: Suggestion: "man git clone"
Date: Sun, 28 Jun 2009 03:34:57 +0100 (BST)
Organization: riva.ucam.org
Message-ID: <20090628023458.297703BC143@sarantium.pelham.vpn.ucam.org>
References: <48AE143C.8030704@acm.org>
Cc: Jeff King <peff@peff.net>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Federico Lucifredi <flucifredi@acm.org>
X-From: git-owner@vger.kernel.org Sun Jun 28 05:00:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKkcr-0002Qf-CG
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 05:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbZF1C5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 22:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbZF1C5X
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 22:57:23 -0400
Received: from queue01.mail.zen.net.uk ([212.23.3.234]:45581 "EHLO
	fizeau.zen.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbZF1C5W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 22:57:22 -0400
X-Greylist: delayed 1331 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Jun 2009 22:57:22 EDT
Received: from [212.23.3.140] (helo=smarthost01.mail.zen.net.uk)
	by fizeau.zen.co.uk with esmtp (Exim 4.63)
	(envelope-from <cjwatson@riva.dynamic.greenend.org.uk>)
	id 1MKkHZ-0000Z0-Gz; Sun, 28 Jun 2009 02:38:17 +0000
Received: from [82.69.40.219] (helo=riva.pelham.vpn.ucam.org)
	by smarthost01.mail.zen.net.uk with esmtp (Exim 4.63)
	(envelope-from <cjwatson@riva.dynamic.greenend.org.uk>)
	id 1MKkEV-0005bW-NP; Sun, 28 Jun 2009 02:35:07 +0000
Received: from sarantium.pelham.vpn.ucam.org ([172.20.153.24])
	by riva.pelham.vpn.ucam.org with esmtp (Exim 3.36 #1 (Debian))
	id 1MKkEV-0002ZH-00; Sun, 28 Jun 2009 03:35:07 +0100
Received: by sarantium.pelham.vpn.ucam.org (Postfix, from userid 1000)
	id 297703BC143; Sun, 28 Jun 2009 03:34:57 +0100 (BST)
In-Reply-To: <48AE143C.8030704@acm.org>
X-Originating-Smarthost01-IP: [82.69.40.219]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122392>

(Sorry I didn't see this until now. HPA only CCed the maintainer of one
of the two man packages popular on Linux-based systems; I'm the other
one. I happened to find this thread while searching for something else.)

In article <48AE143C.8030704@acm.org>, Federico Lucifredi wrote:
>Jeff King wrote:
>> On Thu, Aug 21, 2008 at 08:07:56PM -0400, Federico Lucifredi wrote:
>>> I am all for bass-ackwards compatibility, and I think the suggestion of  
>>> going on "man foo bar" :
>>>
>>>  1) look for foo-bar; if success, terminate search
>>>  2) look for foo
>>>  3) look for bar
>>>  ....
>>>
>>> may be acceptable - I don't see drawbacks at a first glance, and it would 
>>> allow for groups of pages to be meaningful.

I think this is a sensible enough compromise, especially given an option
to disable it. The code would be a little ugly, but *shrug* not that
bad. The extra stat is cheap enough.

Using a plain 'git' section for this in order to provoke the
happenstance of 'man git clone' working is definitely wrong as far as
the manual page hierarchy goes; it means that things like searching for
just user commands (section 1) that contain some term will fail. Putting
them in section '1git' (i.e. section 1 with a git "extension") would be
more in line with how manual pages are typically laid out, and at least
with man-db would not require any configuration file changes. However, I
think both of these are suboptimal. Section extensions are typically
used for things like functions or modules in other programming
languages, or sometimes for cases where file names would otherwise
clash. I'm not much of a git user myself, but I don't get the impression
that most git users think of 'git clone' as analogous to a 'clone'
command in a hypothetical 'git' programming language; it's closer to an
ordinary user command.

The only case where I've seen subcommands given their own unprefixed
manual pages with only the section extension to tell them apart is
OpenSSL, with pages like x509(1ssl). IME, this is very confusing and not
a good example to follow: firstly, you can't trivially find a list of
all the subcommands with something like 'apropos openssl-'; secondly,
it's easy to miss that you're dealing with an openssl subcommand unless
you keep your eyes peeled.

Short of some mechanism for git to provide a plug-in to man to tell it
where to find subpages (eek! potential overengineering alert!), a
foo-bar lookup seems tolerable enough.

>> Personally I have never ever wanted to see two manpages from one man
>> invocation, so I have no real problem with that assumption.
>
>I expected as much, and we should have an option to disable the "new" 
>behavior as a safety anyway.

Would you like to suggest an option name for this, so that we can avoid
unnecessary divergence? Perhaps something like --separate?

>>> Are you willing to put your patch where your mouth is? :-)
>> 
>> I've never looked at man code before, but there seem to be at least two
>> man packages for Linux. My boxes have man-db 2.5.2.
>
>There are two man packages for linux, man and man-db, the latter being a 
>90's fork that uses Berkeley DB as a backend to speedup man -k searches 
>(it helped back then).

(I hope git@ will excuse the digression.)

Don't be confused by the name. Once upon a time the main feature of
man-db was indeed its database; these days that's almost one of the
least interesting features as far as I'm concerned (and I recommend GDBM
for the database layer nowadays anyway, since Berkeley DB is overkill
and has gone through an annoying number of disk format changes).

These days, much more relevant are things like the fact that man-db can
handle encodings properly (both in manual pages and its own translated
messages; *why* does man still use catgets?), and the effort put into
process glue libraries so that it doesn't have to be audited carefully
for unsafe shell code and so that it can be a lot more efficient when
processing large numbers of manual pages (e.g. man -K).

Anyway, if you look at the history, what happened is that John W. Eaton
wrote the original man way back in 1990/1 or so, then two different sets
of people developed it in different directions into man and man-db. That
was in the early 1990s when free software developers weren't
communicating as often as they do now. Then, by the time it became
obvious around 1995 that there'd been a fork, the two were already
separate packages with different aims and it was now too hard for anyone
to merge them. You could still see the common ancestry if you looked
closely (indeed, you still can in places), but they're really much more
like two completely separate implementations than a fork. It's a bit of
a shame in some ways, but harmless enough.

Cheers,

-- 
Colin Watson                                       [cjwatson@debian.org]
