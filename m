From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a way to exclude user-specified files or directories 
 from participating in merges?
Date: Tue, 17 Feb 2009 17:58:25 -0800
Message-ID: <7vfxic1p6m.fsf@gitster.siamese.dyndns.org>
References: <e38bce640902171649g765275a4n4e86d1d4f4aaf394@mail.gmail.com>
 <7v1vtw367w.fsf@gitster.siamese.dyndns.org>
 <e38bce640902171732j9b8801gca4223cdb96d2d34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 03:00:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZbjK-0000B4-QR
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 03:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbZBRB6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 20:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbZBRB6b
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 20:58:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbZBRB6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 20:58:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A2E29AEB1;
	Tue, 17 Feb 2009 20:58:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2D1669AEB0; Tue,
 17 Feb 2009 20:58:26 -0500 (EST)
In-Reply-To: <e38bce640902171732j9b8801gca4223cdb96d2d34@mail.gmail.com>
 (Brent Goodrick's message of "Tue, 17 Feb 2009 17:32:03 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A3CCA968-FD5F-11DD-B367-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110494>

Brent Goodrick <bgoodr@gmail.com> writes:

> Thanks. Well, I should have said in my initial request: "Without
> manually forwarding changes from branch to branch and without having
> to remember special rules about what I can and cannot merge into which
> branch", since that is likely to get forgotten. :)
>
> The answer I am hearing you say is that git doesn't have a way to
> automatically exclude files akin to how rsync handles include/exclude.
>  Is that what you are saying? Or, could the hook mechanism be
> exploited to get this behavior?

A merge is defined as a whole tree operation simply because there is no
sane way to support repeated merges (even a single direction merges)
otherwise.  What I explained was one (note that I am not saying "one true"
here) workflow that naturally supports "common version and multiple
variants" pattern that logically follows the definition of what a merge
is.

I would imagine you could define a custom merge strategy that knows to
ignore changes you made to work.sh file when you merge from work to common
(and home.sh file when you merge from home to common) to implement what
you would want, but for one thing the resulting history would not make
sense (e.g. a merge from work to central would appear as if it reverts all
the changes work made to certain files).  It would be Ok if you were using
git as a mere backup+sneakernet medium (in such a case you would not care
what the history would show you), but that is not the intended target of
git, so there is no such built-in support.

Also such a custom merge strategy would be very project specific and as
your project grows and/or as you add more deployments, I suspect its rules
will have to become a lot more complicated.  I haven't even thought about
what should happen in such a merge strategy when you try to merge work to
home.

Compared to that, the two simple rules "commit chagnes to generic things
only to the generic branch" and "merge only from generic to specific" will
not grow as your project grows complexity.
