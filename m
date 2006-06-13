From: David Kowis <dkowis@shlrm.org>
Subject: Re: Thoughts on adding another hook to git
Date: Tue, 13 Jun 2006 08:03:50 -0500
Message-ID: <448EB7B6.4020708@shlrm.org>
References: <448DB201.5090208@shlrm.org>	 <f36b08ee0606121206k62242354k13671f95da6b1418@mail.gmail.com>	 <448DBC2B.1070807@shlrm.org>	 <f36b08ee0606121218s6cdcfec2i42482ed5284a45e3@mail.gmail.com>	 <448DBEEB.3000308@shlrm.org> <dbfc82860606122329w77c566evb94ca79081a0a057@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Yakov Lerner <iler.ml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 13 15:04:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fq8Yv-0007Ke-Fb
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 15:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWFMND7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 09:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWFMND7
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 09:03:59 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:49559 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP
	id S1750728AbWFMND6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 09:03:58 -0400
Received: from pimout5-ext.prodigy.net (pimout5-int.prodigy.net [207.115.4.21])
	by ylpvm29.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id k5DD2sW0003567
	for <git@vger.kernel.org>; Tue, 13 Jun 2006 09:02:55 -0400
X-ORBL: [66.143.247.87]
Received: from mail.shlrm.org (adsl-66-143-247-87.dsl.snantx.swbell.net [66.143.247.87])
	by pimout5-ext.prodigy.net (8.13.6 out.dk/8.13.6) with ESMTP id k5DD3poq225918;
	Tue, 13 Jun 2006 09:03:52 -0400
Received: from [192.168.2.111] (rrcs-24-173-63-133.sw.biz.rr.com [24.173.63.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.shlrm.org (Postfix) with ESMTP id 61878280342D;
	Tue, 13 Jun 2006 08:03:51 -0500 (CDT)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Nikolai Weibull <now@bitwi.se>
In-Reply-To: <dbfc82860606122329w77c566evb94ca79081a0a057@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21777>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Nikolai Weibull wrote:
> On 6/12/06, David Kowis <dkowis@shlrm.org> wrote:
>> Yakov Lerner wrote:
> 
>> > git-commit sure creates those temp files with
>> > specific naming in specific dir. You could check for
>> > that in EDITOR script. In the script, you could even check
>> > the name of the parent process.
> 
>> This is true. However, I'd be running that script every time something
>> invoked $EDITOR. And some people may not like that solution. I'm
>> thinking that more than just I will like to use this pre-edit hook.
>> Especially in the distro I'm helping develop.
> 
> Perhaps you could tell us what editor you are using.  That way we may
> provide additional solutions.
> 

I'm using vim. But that's irrelevant with what I'm trying to do.

Perhaps I need to explain more:

In SourceMage, we have a collection of scripts, the grimoire, that
contain the little bits of instructions on how to build and install all
the software. 99% of the time most commits are based in one directory.
For example:
I just updated the abook spell (A spell is that collection of
instructions I mentioned earlier.)

I modified two files. DETAILS and HISTORY.
DETAILS contains the version information, and a source hash to verify
downloads (and a bit of other stuff, but it's not important). HISTORY is
just a changelog. Now I do `git commit .`
I get:

  1 # Explicit paths specified without -i nor -o; assuming --only paths...
  2 #
  3 # Updated but not checked in:
  4 #   (will commit)
  5 #
  6 #   modified: mail/abook/DETAILS
  7 #   modified: mail/abook/HISTORY

What I'd like to be able to do is have that "abook" directory name
automatically added to the top of my commit message before it gets into
the editor. I can do this with a script (echo ${PWD##*/}) but it'd need
to be a hook before the editor shows up.

  1 abook:
  2 # Explicit paths specified without -i nor -o; assuming --only paths...
  3 #
  4 # Updated but not checked in:
  5 #   (will commit)
  6 #
  7 #   modified: mail/abook/DETAILS
  8 #   modified: mail/abook/HISTORY

It helps in the short log (git log) for describing for which spell the
log refers. Although it could be done with an EDITOR script I don't
think that's the best solution. It's certainly not a good solution to
give out to a lot of people. Most of the changes to our grimoire are
like this one, so this would be extremely useful to us.

Hope that clears things up a bit,
- --
David Kowis

ISO Team Lead - www.sourcemage.org
Source Mage GNU/Linux

Progress isn't made by early risers. It's made by lazy men trying to
find easier ways to do something.
  - Robert Heinlein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)

iQGVAwUBRI63tsnf+vRw63ObAQqvqAv/QkyEi4/wIDo+sQGMPkXhj/e7yMDXbVLm
XYaVhlxOG3rXfaEu6ecdjm8b6h4UYCMFnhYKUiDqD42LlEdofCIOecGULyP5Nx9q
JAL8BaZpq4MwRQt4HiX9oLQBTIW2ZcD9Fg5ZqFUL3QWFbjednbEl+M8/41JGFL4s
XpvIcKHfAy90qdG5QrgsHdQTAS6JG+9mFmyi4d0wlDWBh4WoutfEfL/nwbH79d2B
Udq6j/SIy0dmsbjNmzJnPYn5IVrFYGez4y5bW7LDpO5ddf4027iz9mNb8hd0wCzL
akh1f4xQQ178iaFz4y60TTmNavxswRmdoKTghRKet0MXTtBTUXe0TUJ5vNOtKODz
5MWu9M5/olCcLqlb7L6wnvqJ9HnJTvAEAUQpvKztQcC2Uy2XkpznW3XmeEK50CLU
VQjxSzubUfXDxkf/hS1nY3WKL3UuQoGWVDmL2Maxno+Kwb3YoyW5+etvYvfoqNT7
Vi7bpiX6fPVF/r6ogATzqla2EFLsta1f
=m3vG
-----END PGP SIGNATURE-----
