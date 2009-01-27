From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-am annoyance
Date: Tue, 27 Jan 2009 14:30:23 -0800
Message-ID: <7vr62o1iww.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0901271407i4406d5e6u6db1df9e5a7bdc4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jan 27 23:32:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwTN-0001Op-Aj
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbZA0Wab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbZA0Wab
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:30:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbZA0Wab (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:30:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 58DBF94836;
	Tue, 27 Jan 2009 17:30:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4FD1494835; Tue,
 27 Jan 2009 17:30:24 -0500 (EST)
In-Reply-To: <bd6139dc0901271407i4406d5e6u6db1df9e5a7bdc4f@mail.gmail.com>
 (Sverre Rabbelier's message of "Tue, 27 Jan 2009 23:07:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 195095CC-ECC2-11DD-809A-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107398>

Sverre Rabbelier <alturin@gmail.com> writes:

> Observe what happens if, on accident, rather than running a alias
> (amendall), the 'tab' didn't catch on:
> $ git am
> ^C

It wants to read from the stdin as "git am < mbox" is a valid usage.

A patch to detect that the input was killed with ^C and clean things up
would be welcome.  Also we may be able to detect "-t 0", too.

> $ # ok, now what do I do?

Here is one thing you could do.

    $ PS1=': $(__git_ps1 "%s"); '
    : master|AM/REBASE; 
    : master|AM/REBASE; git am --abort

But you are right.  We should be able to detect this.

I think it was just people who often use "am" are so used to correctly the
command that the state where no state files are created didn't happen
often and never reported the breakage.
