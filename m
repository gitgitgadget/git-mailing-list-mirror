From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream
 local branches
Date: Tue, 19 Feb 2008 16:55:31 -0800
Message-ID: <7vzltwe9a4.fsf@gitster.siamese.dyndns.org>
References: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com>
 <20080219074423.GA3982@steel.home>
 <76718490802190549p549a34afo913efefebaf5fa97@mail.gmail.com>
 <20080220001339.GA16574@steel.home>
 <7v4pc4fo6y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 01:56:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRdGI-0005XJ-82
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 01:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbYBTA4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 19:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753214AbYBTA4C
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 19:56:02 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbYBTA4A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 19:56:00 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 12BD77D5B;
	Tue, 19 Feb 2008 19:55:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 6347E7D56; Tue, 19 Feb 2008 19:55:50 -0500 (EST)
In-Reply-To: <7v4pc4fo6y.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 19 Feb 2008 16:48:05 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74488>

Junio C Hamano <gitster@pobox.com> writes:

> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> Well, it could also mean that there is no rules yet, and you can
>> do the next sane thing of your choice.
>>
>>> enum color_branch {
>>> 	COLOR_BRANCH_RESET = 0,
>>> 	COLOR_BRANCH_PLAIN = 1,
>>> 	COLOR_BRANCH_REMOTE = 2,
>>> 	COLOR_BRANCH_LOCAL = 3,
>>> 	COLOR_BRANCH_CURRENT = 4,
>>> };
>
> This enum is used as an index into branch_colors[] array.  ...
> ...  But we would want to leave a clue for people who would
> want to touch this later that individual values have some
> meaning, more than just that they have to be distinct.
> ...
>>> enum CAPABILITY {
>>> 	NOLOGIN = 0,
>>> 	UIDPLUS,
>>> 	LITERALPLUS,
>>> 	NAMESPACE,
>>> };
>
> This seems to be meant to match the order in the corresponding
> cap_list[] array, so this cannot be reshuffled (iow, it is
> similar to color_branch).

Side note.  My preference for enum that indexes an array is to
use the latter, not spelling everything out like "color_branch"
does.  The first one being 0 and everybody else increments by 1
is a good enough clue that you cannot arbitrarily reshuffle them
(as opposed to everbody left to the default).  After being
warned with the clue, somebody who is adding new elements to the
array and defining a symbolic index to the element will know to
append to the list, not just insert into an arbitrary place.
Spelling out all the rest explicitly like "color_branch" one
does is wasteful (new entries would need to carry "= (n+1)"),
pointless (you cannot write anything but "= (n+1)" because it is
an array index), and misleading (it makes you wonder if the
specific values have meaning other than being used for an array
index).
