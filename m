From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] git-commit: add a prepare-commit-msg hook
Date: Mon, 04 Feb 2008 19:08:45 -0800
Message-ID: <7vk5lkgkw2.fsf@gitster.siamese.dyndns.org>
References: <2885c7896ba72adee6bc5c9e2210a8881904f601.head.git.bonzini@gnu.org>
	<5840dd34338023e3af8446241a63927d18772f62.1200933409.git.bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 04:09:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMEBp-0000Yl-Hd
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 04:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbYBEDI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 22:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbYBEDI6
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 22:08:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbYBEDI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 22:08:57 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CE04240A2;
	Mon,  4 Feb 2008 22:08:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4974240A0;
	Mon,  4 Feb 2008 22:08:53 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72615>

Paolo Bonzini <bonzini@gnu.org> writes:

> It takes two parameters.  The first is the source of the commit
> message, and can be: `message` (if a `\-m` or `\-F` option was
> given); `template` (if a `\-t` option was given or the
> configuration option `commit.template` is set); `merge` (if the
> commit is a merge or a `.git/MERGE_MSG file exists); `squash`
> (if a `.git/SQUASH_MSG file exists); or a commit id (if a
> `\-c`, `\-C` or `\--amend` option was given).  The second
> parameter if the name of the file that the commit log message.

Please do without funny mark-ups.  The commit log is not
AsciiDoc.

> The hook is not suppressed by the `\--no-verify` option.  However,
> exiting with non-zero status only aborts the commit if said option
> is not given to `git-commit`.

I do not understand why.  I do understand that you do not want
to bypass prepare-commit-msg with or without --no-verify,
because this hook is not about input validation but about input
preparation.  But I do not understand why a failure exit from it
should be treated any differently with or without --no-verify?

If you want to be strict and be safe catching a breakage in the
prepare-commit-msg hook, you should always abort.  You could
also choose to ignore.  In either case, shouldn't the validation
be left to pre-commit hook (for the tree) and commit-msg hook
(for the message, that is left after this hook)?

> While the default hook just adds a Signed-Off-By line at the bottom

It's "s/[OB]/ob/;", and ...

> of the commit messsage, the hook is more intended to build a template
> for the commit message following project standards, that the user
> can then edit or discard altogether.
>
> Signed-off-by: Paolo Bonzini <bonzini@gnu.org>

... you know it ;-)
