From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bring description of git diff --cc up to date
Date: Tue, 22 Jul 2008 14:21:02 -0700
Message-ID: <7vd4l5lio1.fsf@gitster.siamese.dyndns.org>
References: <20080722111947.BIW29914@m4500-01.uchicago.edu>
 <7v63qxn8w2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Greaves <david@dgreaves.com>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:23:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPJJ-0001Ce-QE
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbYGVVVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbYGVVVP
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:21:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbYGVVVP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:21:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 64F0D364F4;
	Tue, 22 Jul 2008 17:21:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8A521364F2; Tue, 22 Jul 2008 17:21:09 -0400 (EDT)
In-Reply-To: <7v63qxn8w2.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 22 Jul 2008 10:09:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1CB2DBE4-5834-11DD-99A4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89538>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@uchicago.edu> writes:
>
>> Just to make sure I understand, here is what I think --cc does:
>>
>>   - In a two-parent merge, it is exactly as Linus has been
>>     ...
>>   - In a many-parent merge, the criterion is more stringent.
>>     ...
>>
>> Is that correct?
>
> The logic in the code does not have separate criteria for two-parent and
> Octopus cases.  Actually Linus talks about "when you have two versions to
> choose from, and if the result matches one of them, then it is not
> interesting".  In a two-parent merge, you cannot have three or more
> possible versions to choose from by definition, can you?

To put it another way, I think what you wrote is correct, but two-parent
case is just a degenerated case of a more general rule, that is:

    A hunk is not interesting if the person who merged had only two
    choices offered by the parents to pick from, and the merge result
    exactly matched one of the choices.

You can come up with examples that do not match the above criteria; they
are all interesting.

For example, if all the parent of a tripus disagreed, the person had more
than two choices to pick from, so no matter what the resolution is, the
hunk is interesting.

On the other hand, if 4 parents in a dodecapus lack a line that all other
8 parents have (see the first example in [*1*]), then the choice for the
person who merges these 12 parents is either to include or not include
that line.  If the line was included, it is not interesting.  If the line
was deleted (which is different from what happened in *1*), it is not
interesting, either.

One thing to note is "have only two choices to pick from" does not have a
direct connection to two-parent-ness.  In a two-parent merge (di-pus?), by
definition you cannot have more than two choices, but that is not any
different from a Dodecapus that has only two groups of parents.  Most
octopus merges have only two groups of parents like the "merge from hell"
does when we talk about individual paths (otherwise it would be very
painful to resolve so it is not done in practice).

[Reference]

*1* http://article.gmane.org/gmane.comp.version-control.git/15487
