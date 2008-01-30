From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why does git track directory listed in .gitignore/".git/info/exclude"?
Date: Wed, 30 Jan 2008 13:06:31 -0800
Message-ID: <7vfxwfgh0o.fsf@gitster.siamese.dyndns.org>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com>
	<6bc632150801230604p2589c893pa05bb6f27e482de8@mail.gmail.com>
	<alpine.LFD.1.00.0801231313590.2803@woody.linux-foundation.org>
	<47A06EF9.60704@users.sourceforge.net>
	<7vprvjgi9v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	pradeep singh rautela <rautelap@gmail.com>,
	git@vger.kernel.org
To: Adam Piatyszek <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Jan 30 22:08:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKKAV-0005Hf-Uq
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 22:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760028AbYA3VGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 16:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757103AbYA3VGy
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 16:06:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759960AbYA3VGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 16:06:52 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 869D0214A;
	Wed, 30 Jan 2008 16:06:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A34802148;
	Wed, 30 Jan 2008 16:06:43 -0500 (EST)
In-Reply-To: <7vprvjgi9v.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 30 Jan 2008 12:39:24 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72070>

Junio C Hamano <gitster@pobox.com> writes:

> Adam Piatyszek <ediap@users.sourceforge.net> writes:
>...
>> Can you seen any drawbacks of such modification?
>
> I do not see a problem if you are saying:
>
> 	when the user has an entry 'dir/' in .gitignore, it
> 	should match directory 'dir'.
>
> However, there is a subtle problem in a naive implementation of
> that.  IOW,
>
> 	when the user has an entry 'dir/' in .gitignore, behave
> 	as if the entry were 'dir' instead.
>
> is wrong.
>
> When you say "foo", you mean "I want either 'foo' that is a
> non-directory, or everything under 'foo' if that is a
> directory".  When you say "foo/", you are saying "I do not want
> 'foo' if it is a non-directory.  I want everything under 'foo'
> if and only if that is a directory".  Compare:
>
> 	git ls-files -s Makefile/
>       git ls-files -s Makefile
>
> The first one is silent, and the latter answers.  On the other
> hand, for a directory, both of these give you the same:
>
> 	git ls-files Documentation/
>       git ls-files Documentation

Perhaps "wrong" might have been too strong a word, and I should
have said "inconsistent with other parts of the system."

It could be that people may find pathspec "Makefile/" meant
exactly the same thing as "Makefile" in ls-files and other
commands.  If that is the case, then we could uniformly strip
the trailing slash, both in all of these commands _and_ .gitignore
entries.

In any case, their behaviour should be consistent.
