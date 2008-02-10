From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternative approach to the git config NULL value checking patches..
Date: Sun, 10 Feb 2008 14:47:02 -0800
Message-ID: <7v7ihce8ex.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0802101225110.2896@woody.linux-foundation.org>
	<7vir0wfqrz.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802101406560.2896@woody.linux-foundation.org>
	<7vbq6oe98y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:47:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOKxm-0007Ju-BL
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 23:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbYBJWrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 17:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbYBJWrU
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 17:47:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbYBJWrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 17:47:19 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EA922C97;
	Sun, 10 Feb 2008 17:47:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D9EE2C96;
	Sun, 10 Feb 2008 17:47:09 -0500 (EST)
In-Reply-To: <7vbq6oe98y.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 10 Feb 2008 14:29:01 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73430>

Junio C Hamano <gitster@pobox.com> writes:

> But as you seem to imply, it might make sense to equate
>
> 	[some-random-section]
>         	some-random-variable
>
> to
>
> 	[some-random-section]
>         	some-random-variable = ""
>
> for variables that cannot possibly have any meaningful "bool"
> semantics.  This third class of variables is a possible benefit
> your patch brings in.  The code can be lax for these variables.
>
> However, it would make things inconsistent ("this variable is
> bool and the above two forms mean completely opposite things,
> while that variable is not bool and they mean the same thing").
> I am just having a hard time convincing myself that this little
> detail does not matter.

Having said all that, it might be an option to change your patch
slightly to say:

	const char config_true[] = "true";

IOW, make

	[section]
        	var

equivalent to

	[section]
		var = "true"

Existing codepaths that deal with variables that were originally
bool but now bool + more might get upset if we did so, though.
An example I could think of offhand was "d7f4633 (Make AutoCRLF
ternary variable" but that one is safe.
