From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Sun, 7 Sep 2008 22:10:38 +0200
Message-ID: <20080907201038.GB8765@cuci.nl>
References: <20080907103415.GA3139@cuci.nl> <7vtzcrn9uv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 22:11:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcQbs-0000hJ-UP
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 22:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbYIGUKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 16:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755581AbYIGUKk
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 16:10:40 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:58860 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322AbYIGUKk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 16:10:40 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id CC4F55465; Sun,  7 Sep 2008 22:10:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtzcrn9uv.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95170>

Junio C Hamano wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> writes:
>> The questions now are:
>> - Would there be good reason not to record the backport/forwardport
>>   relationship in the additional parents of a commit?

>In general, I do not think what you did is a good idea.  The _only_ case
>you can do what you did and keep your sanity is if you cherry-picked every
>single commit that matters from one branch to the other.

Wouldn't that be the normal use case for these kind of side-port
references?

>If something is not "parent", you shouldn't be recording it as such.

It depends on what you define to be a parent.  The git repository
doesn't care either way (that's the beauty of the format definition of
the git repository, just as the tree snapshots allow for later more
complicated diff/blame processing history, so do the parent
relationships allow for more complicated parent references which were
not imagined as the repository format was defined).

>Remember, when you are making a commit on top of one or more parents, you
>are making this statement:

> * I have considered all histories leading to these parent commits, and
>   based on that I decided that the tree I am recording as a child of
>   these parents suits the purpose of my branch better than any of them.

That is a statement which depends on the view of the user.  I concur
that up till now, that is what a user says.  But maybe it is possible to
accomodate both the traditional statement and the sideport-statement
without confusing the two.

>This applies to one-parent case as well.

>Imagine you have two histories, forked long time ago, and have side-port
>of one commit:

>If you recorded A' with parents A and X.  Here is what you would get:

>             o---...o---B---A
>            /                \ (wrong)
>        ---o---o---...o---X---A'

>But that is not what you did.  The tree state A' lacks what B did, which
>could be a critical security fix, and you didn't consider all history that
>leads to A when you cherry-picked it to create A'.

>To put it another way, having the parent link from A' to A is a statement
>that A' is a superset of A.  Because A contains B, you are claiming A'
>also contains B, which is not the case in your cherry-picked history.

Which existing git command actually misbehaves because it makes the
above assumption?
-- 
Sincerely,
           Stephen R. van den Berg.

"The future is here, it's just not widely distributed yet." -- William Gibson
