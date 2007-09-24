From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-checkout hook, and related docs and tests
Date: Mon, 24 Sep 2007 16:54:58 -0700
Message-ID: <7vfy138vql.fsf@gitster.siamese.dyndns.org>
References: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>
	<7vzlzfh7xd.fsf@gitster.siamese.dyndns.org>
	<1190654052.6078.14.camel@beauty>
	<7vsl53ap5x.fsf@gitster.siamese.dyndns.org>
	<1190662396.6078.63.camel@beauty>
	<7vejgnai1z.fsf@gitster.siamese.dyndns.org>
	<1190671558.6078.87.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Josh England" <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Tue Sep 25 01:55:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZxli-00024C-5j
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 01:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756700AbXIXXzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 19:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757708AbXIXXzH
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 19:55:07 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:33663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948AbXIXXzG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 19:55:06 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 05FD713B3E7;
	Mon, 24 Sep 2007 19:55:23 -0400 (EDT)
In-Reply-To: <1190671558.6078.87.camel@beauty> (Josh England's message of
	"Mon, 24 Sep 2007 16:05:58 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59080>

"Josh England" <jjengla@sandia.gov> writes:

> On Mon, 2007-09-24 at 14:07 -0700, Junio C Hamano wrote:
> ...
>> If you want to spacial case 
>> 
>>         $ git checkout otherbranch path.c
>> 
>> it raises another issue.  Which commit should supply the
>> "extended attribute description" for path.c?  Should it be taken
>> from the current commit (aka HEAD), otherbranch, or the index?
>
> This already is a special case and your question is valid but not one
> that git should necessary care about.  Since extended attributes are not
> built into git the only way to handle them is through hooks.  A such, it
> is up to the hook to worry about these kinds of issues.

The fear I have is that that kind of thinking would necessitate
your hook to be called after the user edits paths.c in any other
way not to confuse users.

What I am questioning is where we should stop, in order to keep
things simpler to explain, and I happen to think that it is far
easier if we can teach that "git checkout other path.c" is
equivalent to "git cat-file blob other:path.c >path.c" followed
by "git add path.c", than saying "checkout is magical and if you
have external hook it can do far more than editing the file
yourself to arrive at the same contents".

But I am obviously not the one who is interested in tracking
extended attributes attached to git contents, and I do not feel
too strongly about one way or the other.  I am Ok with it if you
think "checkout is magical" is easier to teach [*1*].

I just wanted to make sure we know what semantics this is
bringing in, and get it clearly documented.  That's all.


[Footnote]

*1* I actually suspect this might be the case. I consider that
per-path checkout from a commit is just a fancy and handy way to
edit individual files but that probably comes from knowing how
git works too much and I lost my git virginity too long ago.  A
pure "user" who types "git checkout commit path" may actively
expect "checkout" command to do something more magical than
simply updating the index and the work tree files to a random
state that happens to match the state recorded in one commit.
