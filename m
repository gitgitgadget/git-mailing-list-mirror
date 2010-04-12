From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is it possible to have a file shared between branches?
Date: Mon, 12 Apr 2010 09:10:11 -0700
Message-ID: <7vd3y4lkik.fsf@alter.siamese.dyndns.org>
References: <alpine.OSX.2.01.1004121058390.52293@kroll.spectro.jussieu.fr>
 <m3ljctf0hs.fsf@localhost.localdomain>
 <alpine.OSX.2.01.1004121639230.60420@kroll.spectro.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Eric LEBIGOT <Eric.Lebigot@normalesup.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 18:11:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1MDt-00084n-QV
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 18:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714Ab0DLQKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 12:10:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47081 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab0DLQKW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 12:10:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F9F6AAE95;
	Mon, 12 Apr 2010 12:10:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lvBGdr1o3XNp+CzGu7y1u5YEJ7A=; b=woQ/os
	T2xT3XaNqpiUGQkbGWi8cyP0hnPAKwuZvx4DJYpUZlwXj3fiF7hRVftRfdHaSl++
	gwsuCsaIO9yw+3mZyDeSXETh62ziG/vyak7boo5lk87Tv7dNq4jYj2jHdO6uulb7
	Z4jsmbcCHcUJhy3/n9uPMxjJd3dvOrQ16edcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hdm+T3ffBFBUa2CWbAmpf2W2rBztHp9K
	+We6RFTLc9TGOH5fjZ2Pleg3H1VUjvixVtwOAzYnkUQIil+7dm2kGyO6DdI6ibjZ
	9HNEgH4ki56zZjfaUN0Zla98Jj7aCy5r85DEd/ThH7mszzT52GOWD1MHNrfeqigC
	L1fzuJDUvEg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39DDEAAE94;
	Mon, 12 Apr 2010 12:10:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50398AAE91; Mon, 12 Apr
 2010 12:10:13 -0400 (EDT)
In-Reply-To: <alpine.OSX.2.01.1004121639230.60420@kroll.spectro.jussieu.fr>
 (Eric LEBIGOT's message of "Mon\, 12 Apr 2010 16\:46\:11 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E31A0FBA-464D-11DF-BA23-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144748>

Eric LEBIGOT <Eric.Lebigot@normalesup.org> writes:

> Thank you!  I can see what is done in the git.git repository, thanks
> to your pointer, and it looks like I'm trying to get from git.  But
> how do you create and manage such an independent 'todo' branch?  This
> branch appears on the same level as master, in the pages you gave, but
> you also mention a "non versioned Meta/ directory".  Does this mean
> that the file structure is like the following?
>
>  ./.git
>  Meta/.git
>  Meta/<todo files>
>
> If yes, how do all branches appear at the same level in
> http://git.kernel.org/?p=git/git.git;a=summary ?  If no, how was the
> todo' branch created?  (I would love to have the todo file in the same
> directory as the rest.)

The way this was arranged was simply:

	$ mkdir Meta
        $ cd Meta && git init
        $ do a lot of work that creates files you see on 'todo'
        $ git commit
        $ git push k.org:/pub/scm/git/git.git master:todo
	$ cd .. ;# back to the primary working tree.

And the last step could have been to push into /pub/scm/git/git-todo.git/
iow a separate repository.

The _only_ reason 'todo' and 'master' live in the same repository is
because I only have write privilege to /pub/scm/git/git.git/ and not at
the /pub/scm/git/ level.  Having these unrelated branches in the same
repository is nothing to find cool and imitate; I'd recommend not to do it
if you don't have to.

Having these unrelated branches published in the same repository helps
distribution a bit, but it never helps the use of the contents in these
branches.
