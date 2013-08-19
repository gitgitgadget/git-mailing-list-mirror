From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v4] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 18:37:56 +0200
Message-ID: <61B1EB04-497F-4398-8C52-CCE3A1A81B10@zib.de>
References: <1376900499-662-1-git-send-email-prohaska@zib.de> <1376926879-30846-1-git-send-email-prohaska@zib.de> <CA+55aFzQhJqE4QDwJDKtkTtJpMNbz3_Aw5_Q3yTk5DnhLJyjCQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 19 18:38:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBSTL-0006B9-Jc
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 18:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123Ab3HSQiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 12:38:23 -0400
Received: from mailer.zib.de ([130.73.108.11]:53659 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012Ab3HSQiX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Aug 2013 12:38:23 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id r7JGc2UD018628;
	Mon, 19 Aug 2013 18:38:07 +0200 (CEST)
Received: from kodkod.zib.de (kodkod.zib.de [130.73.68.88])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id r7JGc1vk016171
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 19 Aug 2013 18:38:01 +0200 (MEST)
In-Reply-To: <CA+55aFzQhJqE4QDwJDKtkTtJpMNbz3_Aw5_Q3yTk5DnhLJyjCQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232551>


On Aug 19, 2013, at 6:04 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I hate your patch for other reasons, though:
> 
>> The problem for read() is addressed in a similar way by introducing
>> a wrapper function in compat that always reads less than 2GB.
> 
> Why do you do that? We already _have_ wrapper functions for read(),
> namely xread().  Exactly because you basically have to, in order to
> handle signals on interruptible filesystems (which aren't POSIX
> either, but at least sanely so) or from other random sources. And to
> handle the "you can't do reads that big" issue.
> 
> So why isn't the patch much more straightforward? 

The first version was more straightforward [1].  But reviewers suggested
that the compat wrappers would be the right way to do it and showed me
that it has been done like this before [2].

I haven't submitted anything in a while, so I tried to be a kind person
and followed the suggestions.  I started to hate the patch a bit (maybe less
than you), but I wasn't brave enough to reject the suggestions.  This is
why the patch became what it is.

I'm happy to rework it again towards your suggestion.  I would also remove
the compat wrapper for write().  But I got a bit tired.  I'd appreciate if
I received more indication whether a version without compat wrappers would
be accepted.

	Steffen

[1] http://article.gmane.org/gmane.comp.version-control.git/232455
[2] 6c642a8 compate/clipped-write.c: large write(2) fails on Mac OS X/XNU