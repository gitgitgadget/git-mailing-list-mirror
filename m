From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/2] show-ref.c: Add missing call to git_config()
Date: Tue, 18 Jun 2013 19:38:49 +0100
Message-ID: <51C0A939.8030200@ramsay1.demon.co.uk>
References: <51BCCE98.3070201@ramsay1.demon.co.uk> <7vppvlighf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 20:40:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up0pH-0000CE-0v
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 20:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933660Ab3FRSkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 14:40:09 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:35299 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932419Ab3FRSkI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 14:40:08 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 3804F6F867A;
	Tue, 18 Jun 2013 19:40:07 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 7D6E26F82CD;
	Tue, 18 Jun 2013 19:40:06 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Tue, 18 Jun 2013 19:40:05 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7vppvlighf.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228294>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> At present, 'git show-ref' ignores any attempt to set config
>> variables (e.g. core.checkstat) from the command line using
>> the -c option to git.
> 
> I think what you really want to see is not giving "-c" and have it
> honored.
> 
> 	"git show-ref" does not honor configuration variables at
> 	all, but at least core configuration variables read by
> 	git_default_config (most importantly core.checkstat) should
> 	be read and honored, because ...
> 
> would be more appropriate.  What are the variables that matter to
> show-ref, and what are the reasons why they should be honored?  I
> thought show-ref was just a way to enumerate refs, and does not read
> the index nor checks if there are modifications in the working tree,
> so I do not see any reason offhand for it to honor core.checkstat
> (and I think that is the reason why we don't have the call there in
> the current code).

:-D Yes, you caught me!

These patches *may* not be necessary, prior to Michael's
"reference related races" series. Specifically, the introduction
of the stat_validity_check() function to the reference handling API.

This means that the behaviour 'git show-ref' is now affected by
several config variables, including core.checkstat. I haven't
spent any time auditing the code, but the list would include
(at least) core.trustctime, core.filemode, core.checkstat,
core.ignorecygwinfstricks, ...

> 
> Exactly the same comment applies to 2/2.

ditto

> Note that I am _not_ opposing these changes.  You brought them up
> because you saw some reason why these should honor some core
> variables.  I just want that reason to be explained in the log for
> the future developers.

Yes, I will send a v2 (soon-ish, I hope).

ATB,
Ramsay Jones
