From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Message from git reset: confusing?
Date: Wed, 05 Aug 2009 10:21:51 -0700
Message-ID: <7v1vnqb2hc.fsf@alter.siamese.dyndns.org>
References: <vpqab2e7064.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:22:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYkBk-0001oY-D0
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 19:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbZHERV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 13:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934727AbZHERV4
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 13:21:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934516AbZHERVz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 13:21:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F6FE215E9;
	Wed,  5 Aug 2009 13:21:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A4ADB215E8; Wed, 
 5 Aug 2009 13:21:52 -0400 (EDT)
In-Reply-To: <vpqab2e7064.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed\, 05 Aug 2009 17\:25\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7921DEF4-81E4-11DE-9365-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124926>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I was wondering what was the motivation for the output of "git merge":

You meant "git reset".

> $ git reset file
> file: locally modified
> $ 

First a tangent.

Removing this output _when no <path> is given_ would greatly reduce the
usability of the command.

I often find myself working on something that consists of more than one
steps, and initially I decide that these would form, say, two commits A,
and B.  I first start adding the changes that are relevant to A, and my
index gradually gets closer to what A should finally look like.

But then I realize that logically commit B should come before commit A,
and it is time to "git reset" without any <path>s.  The output would let
me review the changes (this includes changes pertaining to both A and B)
to help me recall which files would contain changes that are relevant to
B.

I agree that "git reset a-single-exact-filename" could be much more
silent.  I would even say we do not even need -v in such a case.

But the thing is, that is a very narrow special case.  The parameter the
command takes is not _a file_, but is a set of pathspecs, and I would
imagine that when you are in a situation similar to what I just described
in a larger project, you would appreciate the same reminder of modified
paths when you run the command like this:

    $ git reset include/ arch/x86/

I wouldn't oppose to a patch that squelches the output when all pathspecs
given from the command line _exactly_ name existing paths, but I tend to
think that it would be usability regression if you do not show any output
in a case like the last example.
