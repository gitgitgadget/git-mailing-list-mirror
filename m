From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-branch --print-current
Date: Sat, 03 Jan 2009 21:17:15 -0800
Message-ID: <7vzli73b1g.fsf@gitster.siamese.dyndns.org>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
 <402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com>
 <quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu>
 <20090104033839.GD21154@genesis.frugalware.org>
 <quack.20090103T2026.lth3afzg0hx@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	David Aguilar <davvid@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Sun Jan 04 06:18:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJLNu-0000bV-5g
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 06:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbZADFR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 00:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbZADFR0
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 00:17:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbZADFRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 00:17:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E5EA98DDEF;
	Sun,  4 Jan 2009 00:17:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 26A4D8DDEE; Sun,
  4 Jan 2009 00:17:16 -0500 (EST)
In-Reply-To: <quack.20090103T2026.lth3afzg0hx@roar.cs.berkeley.edu> (Karl
 Chen's message of "Sat, 03 Jan 2009 20:26:34 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F79FB1CA-DA1E-11DD-AAA7-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104494>

Karl Chen <quarl@cs.berkeley.edu> writes:

> For example: Google for how to add the name of the git branch to
> the bash prompt and you'll find countless examples of people using
> git-branch.  And they're all different, so people aren't just
> blindly copying one guy; here is a small sample:
> ...
> There were a few using git-symbolic-ref but most used git-branch.

That is a good point about user education, and is a demonstration why a
new option to cover a very narrow-special case to symbolic-ref will not
help the situation.  People will add their own embellishments around the
name of the branch anyway, and the most generic symbolic-ref output is
just as useful as a special case option to show without refs/heads/.

What you quoted are all inferior implementations of showing the name of
the current branch in the bash prompt.  The most correct way (in the sense
that it won't be broken in future git) is always found in the bash
completion script in contrib/completion/git-completion.bash and it reads:

    PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

You can of course change this to suit your taste.  For example, here is a
variant I personally use:

    PS1=': \h \W$(__git_ps1 "/%s"); '

The point is that __git_ps1 shell function is defined to be used for this
exact purpose and is documented in the completion script.

Besides showing the current branch, it knows how to interpret the various
state clues git operations leave in the repository and the work tree, and
reminds them what you are in the middle of (e.g. applying patch series
using "git am", rebasing interactively, resolving conflicts after a merge
did not autoresolve, etc.), and also knows how to show the detached HEAD.
