From: Junio C Hamano <junkio@cox.net>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Wed, 31 Jan 2007 12:01:15 -0800
Message-ID: <7vabzzvud0.fsf@assigned-by-dhcp.cox.net>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
	<20070130165548.GF25950@spearce.org> <20070131015555.GA1944@thunk.org>
	<eppshi$1l4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mercurial@selenic.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 21:03:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCLeQ-0008Qs-LH
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 21:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933091AbXAaUBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 15:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933125AbXAaUBS
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 15:01:18 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:49015 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933091AbXAaUBR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 15:01:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070131200116.BBTE9717.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Wed, 31 Jan 2007 15:01:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Hw1F1W01e1kojtg0000000; Wed, 31 Jan 2007 15:01:16 -0500
In-Reply-To: <eppshi$1l4$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	31 Jan 2007 11:56:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38289>

Jakub Narebski <jnareb@gmail.com> writes:

> Theodore Tso wrote:
>> 
>> To be fair hg modifies files using O_APPEND only.  That isn't quite as
>> safe as "only creating new files", but it is relatively safe.
>
> From (libc.info):
>  -- Macro: int O_APPEND
>  ...
> I don't quote understand how that would help hg (Mercurial) to have
> operations like commit, pull/fetch or push atomic, i.e. all or nothing.

If I remember correctly, thanks to their log-like file format,
they can rely on O_APPEND to do the right thing when growing,
and aborting the current transaction is just a truncate away (or
a set of truncates on the files appended in the transaction, if
hg touches more than one log-like file but I do not know if hg
uses only one file or more than one).  That's one of the things
I found clean and beautiful (from theoretical point of view, at
least) in their design.  I do not think O_APPEND is not used to
control concurrent operations.
