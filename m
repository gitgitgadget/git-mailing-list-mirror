From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-checkout hook, and related docs and tests
Date: Mon, 24 Sep 2007 14:07:36 -0700
Message-ID: <7vejgnai1z.fsf@gitster.siamese.dyndns.org>
References: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>
	<7vzlzfh7xd.fsf@gitster.siamese.dyndns.org>
	<1190654052.6078.14.camel@beauty>
	<7vsl53ap5x.fsf@gitster.siamese.dyndns.org>
	<1190662396.6078.63.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Josh England" <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Mon Sep 24 23:07:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZv9h-0005ec-P9
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 23:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbXIXVHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 17:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753101AbXIXVHo
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 17:07:44 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:57926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbXIXVHn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 17:07:43 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7592213B522;
	Mon, 24 Sep 2007 17:08:00 -0400 (EDT)
In-Reply-To: <1190662396.6078.63.camel@beauty> (Josh England's message of
	"Mon, 24 Sep 2007 13:33:16 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59076>

"Josh England" <jjengla@sandia.gov> writes:

> ...  Granted, the
> branch (and HEAD) does not change for this operation, but that shouldn't
> matter.  It is somewhat in line with the principle of 'least-surprise':
> if the hook runs for 'git checkout otherbranch', but not 'git checkout
> otherbranch path.c', this could cause confusion and distress to the
> user.  IMO, it is a 'checkout' so the post-checkout hook should run.
> Why is that so insane?  

Because I find it would be surprising if the following commands
behave differently:

	$ git cat-file blob otherbranch:path.c >path.c
        $ git show otherbranch:path.c >path.c
        $ git diff -R otherbranch path.c | git apply
        $ git checkout otherbranch path.c

These are all talking about various ways to _edit_ working tree
files, and not about switching between revisions.

That's why I said I found that what the second sentence from
your original description implied ("the hook gets old and new
commit object name" which means we are talking about switching
between revisions) was sensible, but it needs to be stressed a
bit.

If you want to spacial case 

        $ git checkout otherbranch path.c

it raises another issue.  Which commit should supply the
"extended attribute description" for path.c?  Should it be taken
from the current commit (aka HEAD), otherbranch, or the index?
