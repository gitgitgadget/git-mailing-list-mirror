From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-blame.el: does not show one-line summary in echo area
Date: Fri, 04 Feb 2011 10:53:24 +0100
Message-ID: <87tygkm8h7.fsf@krank.kagedal.org>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <m2fx7qae49.fsf@igel.home>
	<87ljhi3cao.fsf@osv.gnss.ru> <87fx7q4p6h.fsf@lysator.liu.se>
	<87einafojx.fsf@osv.gnss.ru> <87d42s3pv2.fsf@lysator.liu.se>
	<20110204014315.GB28525@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Xavier Maillard <zedek@gnu.org>,
	Alexandre Julliard <julliard@winehq.org>,
	Martin Nordholts <enselic@gmail.com>,
	Kevin Ryde <user42@zip.com.au>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	Sergei Organov <osv@javad.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 11:13:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlIf7-0005l4-5B
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 11:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065Ab1BDKNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Feb 2011 05:13:01 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:41410 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772Ab1BDKNA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 05:13:00 -0500
X-Greylist: delayed 1170 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Feb 2011 05:13:00 EST
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 86CF340004;
	Fri,  4 Feb 2011 10:53:29 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 77C0740009; Fri,  4 Feb 2011 10:53:28 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [62.20.90.206])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 9D79740004;
	Fri,  4 Feb 2011 10:53:26 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 5428F61403; Fri,  4 Feb 2011 10:53:24 +0100 (CET)
In-Reply-To: <20110204014315.GB28525@elie> (Jonathan Nieder's message of "Thu,
	3 Feb 2011 19:43:26 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166031>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi David et al,
>
> David K=C3=A5gedal wrote:
>> Sergei Organov <osv@javad.com> writes:
>
>>> Now, I've evaluated (require 'format-spec) in my Emacs 22 (yes, 22,=
 not
>>> 23), and now git-blame almost works there. The problem I see is tha=
t it
>>> doesn't output anything in the echo area. It color-codes the buffer=
, it
>>> does show correct pop-up when mouse is over a region, but it doesn'=
t
>>> print anything in the echo area when I move cursor through the regi=
ons.
>>> Any idea how to debug/fix this?
>>
>> Well, it appears I removed the output to the echo area. I didn't thi=
nk
>> it worked very well, and the new output format mostly replaces it by
>> showing the hash.
>>
>> There are also technical reasons for removing it (it couldn't be
>> implemented very cleanly).
>
> I don't use git-blame.el ("git blame", "git gui blame", and "git log
> -S/-G" take care of my needs already) but it seems to me that this
> change was a regression.  The emacs support before v1.6.6-rc0~120^2
> had a simple way to find out the purpose of each line of code, while
> after that there is no simple way.  And it is what the README
> promises:
>
>  * git-blame.el:
>
>    Emacs implementation of incremental git-blame.  When you turn it o=
n
>    while viewing a file, the editor buffer will be updated by setting
>    the background of individual lines to a color that reflects which
>    commit it comes from.  And when you move around the buffer, a
>    one-line summary will be shown in the echo area.
>
> Any advice for people who want to fix that?  Is anyone interested in
> doing so?  (It is quite likely I am guessing incorrectly about what i=
s
> useful, but I would imagine that at least the documentation could use
> updating.)

Let's try to figure out how we would like it to work. I agree that the
mouseover information is not good enough. There are several things we
can do:

1) Use some command to request information about the current line.
   When the command is invoked (bound to some convenient key?), it pops
   up a buffer with the result of "git show <commit>" or similar.

2) Have a separate buffer always showing information about the line
   under the cursor. This should at least be the info in the commit
   object, but going to the diff should be accessible.

3) Showing when you move to a different blame chunk, by showing a
   one-line summary in the echo area.

There are variations and combinations. I think that 1+3 or 2 are the
best options.

--=20
David K=C3=A5gedal
