From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Fri, 31 May 2013 20:40:51 +0100
Message-ID: <20130531194051.GC1072@serenity.lan>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org>
 <51A7A73C.6070103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri May 31 21:41:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiVCD-0000sI-CN
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 21:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab3EaTlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 15:41:01 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:47764 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab3EaTk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 15:40:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 2928B60650D;
	Fri, 31 May 2013 20:40:59 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Knvis7roPnpX; Fri, 31 May 2013 20:40:58 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 449FE606507;
	Fri, 31 May 2013 20:40:53 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <51A7A73C.6070103@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226096>

On Thu, May 30, 2013 at 09:23:40PM +0200, Jens Lehmann wrote:
> Am 30.05.2013 01:58, schrieb Junio C Hamano:
> > * jk/submodule-subdirectory-ok (2013-04-24) 3 commits
> >   (merged to 'next' on 2013-04-24 at 6306b29)
> >  + submodule: fix quoting in relative_path()
> >   (merged to 'next' on 2013-04-22 at f211e25)
> >  + submodule: drop the top-level requirement
> >  + rev-parse: add --prefix option
> > 
> >  Allow various subcommands of "git submodule" to be run not from the
> >  top of the working tree of the superproject.
> 
> The summary and status commands are looking good in this version
> (they are now showing the submodule directory paths relative to
> the current directory). Apart from that my other remarks from
> gmane $221575 still seem to apply. And this series has only tests
> for status, summary and add (and that just with an absolute URL),
> I'd rather like to see a test for each submodule command (and a
> relative add to) to document the desired behavior.

To summarize what I think are the outstanding issues from your email:

* Should '$sm_path' be relative in "submodule foreach"?
* "submodule add" with a relative path
* "submodule init" initializes all submodules
* Tests

The current version does make '$sm_path' relative in "submodule
foreach", although it's hard to spot because we have to leave doing so
until right before the "eval".

I'm not sure what you mean about "submodule add" - the new version
treats the "path" argument as relative (providing it is not an absolute
path).  The "repository" argument is not changed by running from a
subdirectory but I think that's correct since it is documented as being
relative to the superproject's origin repository.

"submodule init" is behaving in the same way as "deinit" - if you say
"submodule init ." then it will only initialize submodules below the
current directory.  The difference is that "deinit" dies if it is not
given any arguments whereas "init" will initialize everything from the
top level down.  I'm not sure whether to change this; given the
direction "git add -u" is heading in for 2.0 I think the current
behaviour is the most consistent with the rest of Git.

> But I'm not sure if it's better to have another iteration of this
> series or to address the open issues a follow-up series. Having
> status, summary and add - at least with absolute URLs - lose the
> toplevel requirement is already a huge improvement IMO. Opinions?

I think the only thing outstanding is tests.  I'm happy to add those as
a follow-up or in a re-roll.
