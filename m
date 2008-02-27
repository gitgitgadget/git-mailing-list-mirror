From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Add '--fixed-strings' option to "git log --grep" and
 friends
Date: Tue, 26 Feb 2008 17:03:55 -0800
Message-ID: <7vfxvf2osk.fsf@gitster.siamese.dyndns.org>
References: <1204028528-18941-1-git-send-email-jnareb@gmail.com>
 <1204028528-18941-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 02:06:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUAjM-00017g-BS
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 02:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757078AbYB0BEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 20:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756027AbYB0BEN
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 20:04:13 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755255AbYB0BEM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 20:04:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9825821A2;
	Tue, 26 Feb 2008 20:04:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 776672151; Tue, 26 Feb 2008 20:04:03 -0500 (EST)
In-Reply-To: <1204028528-18941-2-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Tue, 26 Feb 2008 13:22:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75197>

Jakub Narebski <jnareb@gmail.com> writes:

> Add support for -F | --fixed-strings option to "git log --grep"
> and friends: "git log --author", "git log --committer=<pattern>".
> Code is based on implementation of this option in "git grep".
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This would simplify ignore-case searching for a fixed string from
> within gitweb, as gitweb wouldn't then have to deal with differences
> in quoting and unquoting (if you quote character which doesn't need
> quoting, would git (grep) unquote it?) between searched phrase,
> basic/extended regular expression as understood by git/by grep,
> and regular expressions in Perl (when showing matched info).
>
> [I am not sure if the above paragraph should be added to commit
> message, so it is in patch comments. Feel free to add it.] 

I do not understand the issue from reading that paragraph, so it
probably means that (1) it does not help even if it is in the
commit log message, and/or (2) more readable explanation may
help in the commit log message ;-).

The rule for grep input should be known by anybody who writes
scripts around grep, so I do not think this patch is absolutely
necessary if this is only for gitweb.  But for command line
end-user usage, fixed string search _might be_ useful, although
I've personally never felt need for that.  So I am reluctant to
see it grab a short-and-sweet -F option letter that might have
better uses, but I do not have major objection against a more
explicit --fixed-strings.

By the way, do you allow the default regexp search in gitweb?
If so, how do you handle a malformed regexp that a user gives
you?  For example,

	$ git log --grep="don\('t" -1

barfs, and I suspect that you can catch the exit status 128 from
die() and say something other than "nothing found" if you really
wanted to.
