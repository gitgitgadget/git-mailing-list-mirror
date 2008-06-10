From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Date parsing
Date: Tue, 10 Jun 2008 09:55:30 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806100942500.3101@woody.linux-foundation.org>
References: <bd6139dc0806100758xb41d08dh18e3051088b707e5@mail.gmail.com>  <Zx2uvEYSssjj9E0HrmUL8wYASyWX9L9w8LkR-gGRAmnD9isjoEeyKg@cipher.nrlssc.navy.mil> <bd6139dc0806100831y7a00a0f4sbc8dee9df7a8c16a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jun 10 18:56:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K679E-0000kp-Lg
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 18:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbYFJQzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 12:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbYFJQzr
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 12:55:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51285 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751365AbYFJQzq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 12:55:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5AGtVwu027585
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jun 2008 09:55:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5AGtU2k019633;
	Tue, 10 Jun 2008 09:55:30 -0700
In-Reply-To: <bd6139dc0806100831y7a00a0f4sbc8dee9df7a8c16a@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.384 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84523>



On Tue, 10 Jun 2008, Sverre Rabbelier wrote:
> On Tue, Jun 10, 2008 at 5:10 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> > Take a look at match_multi_number in date.c
> > European ordering is preferred when the separator is '.'
> 
> Ok, then I'll use . in the future, that's nice :).

Well, there are safer ways to give the date.

If you do it in strict rfc822 format, you'll never have any confusion 
what-so-ever. The "approxidate()" thing tries to parse any random input, 
but it *is* meant to be excessively liberal.

IOW, you can literally say "at tea-time two weeks ago" and get a date, and 
it will even work. But you can also say "my 3rd child was born in 
December", and it will also give you a date. The date will not make 
_sense_, but it will give you one (it will decide that what you meant 
is "Dec 3rd").

So if you want to be precise and safe, you should be precise. I'd 
personally suggest using yyyy-mm-dd, which is the ISO date format, 
although if that fails approxidate will still try the admittedly 
crazy yyyy-dd-mm.

And always set the timezone explicitly if you really care. Again, we try 
out best if you don't explicitly say which timezone to use, but if you 
don't want any guessing - even _informed_ guessing - you really should 
state things explicitly.

> I think that it should bail out when it encounters "20-01-2008"
> instead of automagically going for european notation. Even more
> helpfull would be to inform the user that "20.01.2008" is the proper
> notation.

See above. git approxidate() tries the exact reverse: it's extremely 
willing to turn absolutely any line noise into a date.

Which is really nice when you do

	git log @{last.week}..

but if you actually want to state an exact date it really means that the 
onus is on _you_ to be exact, and use a well-defined standard format.

			Linus
