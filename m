From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Let git-help prefer man-pages installed with this version of git
Date: Fri, 07 Dec 2007 02:39:24 -0800
Message-ID: <7vodd23i1v.fsf@gitster.siamese.dyndns.org>
References: <87hciv7jkt.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0712062107520.21625@wbgn129.biozentrum.uni-wuerzburg.de>
	<87d4ti7qu1.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 11:40:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0acj-0004V8-My
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 11:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbXLGKjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 05:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbXLGKjk
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 05:39:40 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:43542 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbXLGKjj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 05:39:39 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CB0673B0B;
	Fri,  7 Dec 2007 05:39:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E36A23B0A;
	Fri,  7 Dec 2007 05:39:29 -0500 (EST)
In-Reply-To: <87d4ti7qu1.fsf@osv.gnss.ru> (Sergei Organov's message of "Fri,
	07 Dec 2007 13:16:06 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67409>

Sergei Organov <osv@javad.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Thu, 6 Dec 2007, Sergei Organov wrote:
>>
>>> Prepend $(prefix)/share/man to the MANPATH environment variable before 
>>> invoking 'man' from help.c:show_man_page().
>>
>> This commit message is severely lacking.  Why would you _ever_ prefer the 
>> installed man pages before invoking "man", which should find them
>> anyway?
>
> Obviously because you want manual pages corresponding to the version of
> git you are invoking, not any random version of man-pages man may find
> by default.

While I almost agree with the rest of your sentence, you have to realize
that it is obviously not obvious if somebody asked you to clarify.

How about this:

    Prepend $(prefix)/share/man to the MANPATH environment variable
    before invoking 'man' from help.c:show_man_page().  There may be
    other git documentation in the user's MANPATH but the user is asking
    a specific instance of git about its own documentation, so we'd
    better show the documentation for _that_ instance of git.

Having written that, it is very tempting to further clarify the above:

    Usually, if a user has his own version of git and regularly uses it
    by having the non-system executable directory (e.g. $HOME/bin/git)
    early in his $PATH, its corresponding documentation would also be in
    a non-system documentation directory (e.g. $HOME/man) early in his
    $MANPATH, and this change is a no-op.  The only case this change
    matters is where the user installs his own git outside of his $PATH
    and $MANPATH, and explicitly runs his git executable
    (e.g. "$HOME/junk/git-1.5.4/bin/git diff").

When you clarify it this way, the change does not look as useful
anymore, does it?  How typical would that use be, to run your git
executable by always naming it by path without relying on $PATH
environment variable?
