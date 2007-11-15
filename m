From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: refining .gitignores
Date: Thu, 15 Nov 2007 11:39:45 +0000
Message-ID: <807ikj3fge.fsf@tiny.isode.net>
References: <804pfobgkp.fsf@tiny.isode.net>
            <20071114230258.GG3973@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 12:41:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isd5p-0003gU-1S
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 12:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759384AbXKOLju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 06:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757645AbXKOLju
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 06:39:50 -0500
Received: from rufus.isode.com ([62.3.217.251]:51115 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757514AbXKOLjt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 06:39:49 -0500
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <RzwwAQBBVKjC@rufus.isode.com>; Thu, 15 Nov 2007 11:39:46 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Thu, 15 Nov 2007 11:39:45 +0000
X-Hashcash: 1:20:071115:raa.lkml@gmail.com::dtNemgfHYTDDjcCP:00000000000000000000000000000000000000000002Cu5
X-Hashcash: 1:20:071115:git@vger.kernel.org::vo+CijWJb+8Yq6Of:0000000000000000000000000000000000000000005XTQ
In-Reply-To: <20071114230258.GG3973@steel.home> (Alex Riesen's message of "Thu\, 15 Nov 2007 00\:02\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65109>

Alex Riesen <raa.lkml@gmail.com> writes:

> Bruce Stephens, Wed, Nov 14, 2007 23:36:06 +0100:
>> How do I get a list of files (in HEAD, say) that would be ignored by
>> the .gitignore files (and the other usual settings)?
>> 
>> It feels like something like this ought to work:
>> 
>>      git ls-files -z | xargs -0 git ls-files --ignored
>> 
>> But listing its arguments that are ignored by .gitignore (etc.)
>> doesn't seem to be what "git ls-files --ignored" does.  Or at least,
>> not quite as straightforwardly as that.
>
> git ls-files --exclude-per-directory=.gitignore -X .git/info/exclude -i -o

That doesn't seem to work.

For example, if I add '*.c' to .gitignores in git.git, I can't seem to
get that command to display any .c files.

Run on its own, it displays lots of files, but no .c files.  Run with
an argument (such as builtin-add.c), it displays nothing.

>> The motivation is (obviously) that I fear some of the .gitignore
>> patterns are too broad, and a reasonable check is that none of the
>> files that are already committed would be caught by the patterns.
>
> git ls-files --exclude-per-directory=.gitignore -X .git/info/exclude -i

That also doesn't seem to do quite what I want, and probably in the
same way.  I see git add returns non-zero error status if a file is
ignored, so I can do it with

excluded=()
for f in $(git ls-files)
do
    git add $f || excluded=($excluded $f)
done

But that feels kind of clunky.  I feel I'm missing something basic
about how git ls-files is intended to work, or something.
