From: John Keeping <john@keeping.me.uk>
Subject: Re: [FEATURE-REQUEST] difftool --dir-diff: use the commit names as
 directory names instead of left/right
Date: Sat, 23 Mar 2013 12:36:03 +0000
Message-ID: <20130323123603.GL2283@serenity.lan>
References: <1363971156.20287.5.camel@heisenberg.scientia.net>
 <CAJDDKr6fmvb8AN8AcyO+t=7wqte+6ryhtt_o0CN92Vm-xSdn+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Anton Mitterer <calestyo@scientia.net>,
	git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 13:36:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJNgg-0004Tz-Hf
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 13:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115Ab3CWMgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 08:36:15 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:58770 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3CWMgO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 08:36:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 5493B161E2EF;
	Sat, 23 Mar 2013 12:36:13 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YKv14VgEDiUQ; Sat, 23 Mar 2013 12:36:10 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 6AB0E161E036;
	Sat, 23 Mar 2013 12:36:05 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr6fmvb8AN8AcyO+t=7wqte+6ryhtt_o0CN92Vm-xSdn+A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218908>

On Fri, Mar 22, 2013 at 09:56:17PM -0700, David Aguilar wrote:
> On Fri, Mar 22, 2013 at 9:52 AM, Christoph Anton Mitterer
> <calestyo@scientia.net> wrote:
> > Hi.
> >
> > Right now, when I use difftool --dir-diff, the temp dirs are creates as
> > e.g.:
> > /tmp/git-difftool.QqP8x/left
> > /tmp/git-difftool.QqP8x/right
> >
> > Wouldn't it be nice, if instead of left/right... the specified commit
> > name would be used?
> >
> > e.g.
> > /tmp/git-difftool.QqP8x/r1.1.1
> > /tmp/git-difftool.QqP8x/HEAD
> > or
> > /tmp/git-difftool.QqP8x/fd4e4005a4b7b3e638bc405be020b867f8881e72
> > /tmp/git-difftool.QqP8x/ce0747b74fccd20707b6f495068503e69e5473df
> >
> > Cause then, one would see in the difftool which side is what, without
> > the need to remember how git difftool was invoked.
> >
> >
> > Of course one might probably need to escape the commit names if they
> > contain stuff like "/" or "..", etc.
> 
> I can see that being pretty helpful.
> If we do it we should go all the way.
> 
> What do you all think about something like the output of
> "git describe --always" instead of the SHA-1?

I think Christoph was suggesting that it should use the revision as
specified by the user, presumably falling back to HEAD when only one
revision has been specified.

That's likely to be the easiest to understand since git-describe could
show "v1.8.2-134-g328455f" (or "remotes/origin/maint-121-g328455f" with
--all) where the user specified HEAD^.  I suspect in that case we have
to be careful about special characters, perhaps it's best to just fall
back to the SHA1 if we encounter something like
"origin/master^{/^diff.c}" which is likely to cause issues with shell
quoting.

The interesting question around this is precisely how commit specifiers
map to directory names and at what point (if ever) we give up and use
the SHA1.  At the very least we need to translate '/' to something else
('~' maybe?).

> BTW there are some patches in-flight around difftool so
> you'll probably want to apply them first if you're going to
> give it a try.  patches very much appreciated! ;-)
> If no one beats me to it, I can give it a try after the weekend.
> -- 
> David
