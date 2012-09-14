From: Jens Bauer <jens-lists@gpio.dk>
Subject: Re: CRLF, LF ... CR ?
Date: Fri, 14 Sep 2012 06:36:11 +0200
Message-ID: <20120914063611904486.56216c42@gpio.dk>
References: <20120913170943725232.01d717ef@gpio.dk>
 <CAJDDKr5-ze2bhTkT+jzcS1iZipJO6kEr2qAf73GRn4QQ-rS1dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 06:36:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCNdf-0001nm-QL
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 06:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896Ab2INEgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 00:36:15 -0400
Received: from [92.246.25.51] ([92.246.25.51]:62530 "EHLO mail.multitrading.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750825Ab2INEgO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 00:36:14 -0400
Received: (qmail 7714 invoked from network); 14 Sep 2012 04:36:12 -0000
Received: from unknown (HELO ?10.0.2.26?) (jb@multitrading.dk@92.246.25.51)
  by audiovideo.dk with ESMTPA; 14 Sep 2012 04:36:12 -0000
In-Reply-To: <CAJDDKr5-ze2bhTkT+jzcS1iZipJO6kEr2qAf73GRn4QQ-rS1dQ@mail.gmail.com>
X-Mailer: GyazMail version 1.5.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205450>

Hi David.

Thank you for the information.
I am not the one to decide whether or not this should be a built-in feature; I'm only a plain user. :)
My personal opinion: If it was a built-in feature, people all over the World would not be getting into trouble with it.
I've seen on the net, that even on PC (I don't know if it's DOS or Windows), a user wrote a program, that did not output CRLF, nor LF, but only CR.

Perhaps git does not treat LF or CRLF in any special way, if that's the case, git's very beautifully programmed.
-But gitweb does not seem to make correct output unless I add a clean/smudge filter.
In addition to that, there is also the detail, that the terminal treats CR and LF differently...
echo -e "this\ris\ra\rtest"
will in bash only output...
test
...while
echo -e "this\nis\na\ntest"
in bash outputs...
this
is
a
test
...This means that 'git diff' will (to the user) only output a single line of "junk", when line-endings are CR and not LF or CRLF.

Also... git diff says that a file containing CR line endings have no end-of-line, which to me appears as that git diff thinks there is only one line.

Finally, when I want to display the file using head, cat or tail, I still see only one line of text. [That's correct behaviour!]

As you mentioned, there are good possibilites for fixing these things using clean/smudge filters.
The clean/smudge filter I ended up using is quite simple (much simpler than I first thought it would be).
I ended up with...
[filter "cr"]
	clean = tr '\\15' '\\12'
...and no smudge, because the application supports reading lines ending in LF, so I wanted the files to stay readable.
-But normally, there should ofcourse be a smudge filter, that reverses \15 and \12.

In my opinion, the benefit from having git diff support CR, would be that the user does not lose the history if he/she wants to 'clean' the projects.
Existing projects would be shown correctly. Of course, gitweb would need to support CR, so it generates correct line endings, instead of showing one long line with a lot of "\r" in them.

[When thinking about all these CR/LF problems, I am grateful that Sinclair Research did not continue to use the ZX81 characterset in the ZX Spectrum. Imagine a mess we could have had!]


Love
Jens


On Thu, 13 Sep 2012 21:06:32 -0700, David Aguilar wrote:
> On Thu, Sep 13, 2012 at 8:09 AM, Jens Bauer <jens-lists@gpio.dk> wrote:
>> Hi everyone.
>> 
>> I'm quite fond of git, and have used it for a while.
>> Recently, I've started making printed circuit boards (PCBs) using an 
>> application called OsmondPCB (for Mac), and I'd like to use git to 
>> track changes on these.
>> This application was originally written for the old Mac OS (Mac OS 6 
>> to Mac OS 9.2).
>> The old Mac OS does not use LF, nor CRLF for line endings, but only CR.
>> 
>> I've read that git supports two different line endings; either CRLF 
>> or LF, but it does not support CR.
>> Would it make sense to add support for CR (if so, I hereby request 
>> it as a new feature) ?
>> The alternative is to ask the developer if he would change the file 
>> format, so that new versions of his software would change the files 
>> to end in LF, but he'd have to be careful not to break compatibility.
>> If the software is to be changed, this would not fix similar issues 
>> that other people might have.
> 
> Do you mean that you want automatic conversion from CR to LF?
> 
> What's about just storing the files as-is,
> with no conversion at all? (this is the default git behavior)
> 
> git doesn't really even support LF.  It stores content as-is which
> means LF works just fine.  git prefers to not mess around with the content,
> but we do have autocrlf to help folks stuck on windows.
> 
> If you need to, you can use .gitattributes to add a clean/smudge filter
> that does this conversion for you.
> 
> See the "filter" section for an example:
> 
> http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
> 
> If you're serious about wanting that feature then we'll
> happily review any patches you might have.  That said, I don't really
> think it's a common enough case for git to natively support, so
> I'd recommend going with the .gitattributes filter.
> 
> good luck,
> -- 
> David
