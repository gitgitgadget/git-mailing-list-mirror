From: Thell <tbfowler4@gmail.com>
Subject: Re: [PATCH] New whitespace checking category 'trailing-blank-line'
Date: Thu, 30 Jul 2009 23:47:23 +0000 (UTC)
Message-ID: <loom.20090730T230729-582@post.gmane.org>
References: <200907261145.38449.bruno@clisp.org> <7vbpn7p1mw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 01:50:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWfO5-0002XP-CV
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 01:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbZG3XuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 19:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbZG3XuG
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 19:50:06 -0400
Received: from main.gmane.org ([80.91.229.2]:38770 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbZG3XuE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 19:50:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MWfNq-0003IP-Vl
	for git@vger.kernel.org; Thu, 30 Jul 2009 23:50:02 +0000
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 23:50:02 +0000
Received: from tbfowler4 by ip70-178-75-143.ks.ks.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 23:50:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 70.178.75.143 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1) Gecko/20090624 Firefox/3.5 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124489>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Bruno Haible <bruno <at> clisp.org> writes:
> 
...
> > Here is a proposed patch, to allow people to turn the check against trailing
> > blank lines independently from the whitespace-in-a-line checking. The default
> > behavior is not changed.
> 
> The "default" for people who do not have configuration may not change, but
> people who explicitly asked git to check the trailing blank lines by
> specifying "whitespace=trail" attribute, and have been relying on it, will
> now be unprotected. Such a regression/incompatibility should be noted here.
> 
> Better yet would be not to introduce such a regression, of course.
> 
> 
> 
... 
> Another idea would be to:
> 
>     - introduce two new settings:
> 
>         blank-at-eol		: SP/HT at EOL is an error
>         empty-lines-at-eof	: empty lines at the end of file is an error
> 
>     - make existing "trailing-space" a mere short-hand for "blank-at-eol"
>       and "empty-lines-at-eof".
> 
> 
> The "git diff" part looked reasonable from a quick glance, but I do not
> think I saw anything that affects "git apply --whitespace=fix" in the
> patch.
> 

Hi all!  How appropriate that this was posted so recently.  Seems to be a fairly
popular issue lately with the recent commits 735c674 and the correction 422a82f.

I was thinking of a fix for the disappearing EOL @ EOF and was hoping for some
input and direction, yet wasn't really sure if a new RFH thread would be better
than here or not.  Until otherwise noted how about just diving in...


My initial posting was to get input on which approach would be best received to
give a capability similar to what Junio's idea above states.  The problem is
which way to best go about it.  Obviously if someone is doing whitespace=fix
with trailing-space set then they indeed want it fixed, but having the blank
lines removed... ?

Currently the section in builtin-apply.c (v1.6.4) that is the culprit for
removing these lines is:

1999                 if (added_blank_line)
2000                         new_blank_lines_at_end++;
2001                 else
2002                         new_blank_lines_at_end = 0;

Having a --keep-new-blank-lines argument for apply, and am seems like a winner
that then doesn't effect regular operations.

1999                 if (added_blank_line && !keep_new_blank_lines_at_end)

I've tested having the added_blank_line reset to 0 during testing of whitespace
fixing from crlf to lf and it seems good to go for that purpose.

Is that something that I should try for?  Ie: having a new arg for am and apply,
or is a new core whitespace option the better route?

Sincerely,
Thell (almostautomated on freenode)
