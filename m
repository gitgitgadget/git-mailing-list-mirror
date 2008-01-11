From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] additional help when editing during interactive rebase
Date: Fri, 11 Jan 2008 00:42:36 -0800
Message-ID: <7vprw83g8z.fsf@gitster.siamese.dyndns.org>
References: <1199845915-sup-797@south>
	<7vsl17pv1c.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801091120150.31053@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, William Morgan <wmorgan-git@masanjin.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 11 09:43:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDFTr-0007qA-BC
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 09:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756682AbYAKImq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 03:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756588AbYAKImq
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 03:42:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756682AbYAKImp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 03:42:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F817595D;
	Fri, 11 Jan 2008 03:42:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 97043595C;
	Fri, 11 Jan 2008 03:42:40 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801091120150.31053@racer.site> (Johannes
	Schindelin's message of "Wed, 9 Jan 2008 11:23:32 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70137>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 8 Jan 2008, Junio C Hamano wrote:
>
>> I would have removed those empty lines around the instruction if I were 
>> patching this, though.  Losing 5 lines out of 25-line terminal was 
>> marginally Ok.  Losing 9 lines 4 lines too many and is unacceptable.
>> 
>> Thoughts?
>
> I wonder if it would not make even more sense to record the current HEAD 
> name, and call "commit --amend" if it is the same upon "--continue".

My understanding of the original issue is that "git-rebase -i"
stops at 'edit' and gives the user a chance to muck with the
commit, saying "do whatever you want now and then record the
result with git commit --amend".  The user can follow that but
then needs to say "git rebase --continue" after that.  The insn
does not talk about it, so after running "git commit --amend" as
told, a clueless user is left wondering "huh, and then now
what?".

Do you mean you would instead suggest "git rebase --continue" in
the insn, and make the workflow like this:

	$ git rebase -i ...
        Now do whatever you want and say "rebase --continue"
	$ edit foo.c
        $ git add foo.c
        $ git rebase --continue

and have "rebase --continue" to continue with the modified
contents recorded in the index, invoking "git commit --amend",
but doing so only if the user hasn't run "git commit" with or
without --amend yet?

It feels like a better automation than what we currently have,
but I somewhat worry how that would change the user experience
for using 'edit' to split a commit into two or more.
