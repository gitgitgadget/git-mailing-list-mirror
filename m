From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A couple branch questions
Date: Wed, 13 Feb 2008 19:43:21 -0800
Message-ID: <7vr6fgkxt2.fsf@gitster.siamese.dyndns.org>
References: <76718490802131739n22c56cadn39c1871ea1762dc3@mail.gmail.com>
 <ee77f5c20802131745p23aa1db3j47207f1e6538b0e@mail.gmail.com>
 <18355.42595.377377.433309@lisa.zopyra.com>
 <ee77f5c20802131903i45b1629fpcb4a5c6e4f483052@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Bill Lear" <rael@zopyra.com>,
	"Jay Soffian" <jaysoffian@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 04:44:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPV1i-0002AE-Kk
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 04:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756669AbYBNDoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 22:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756026AbYBNDoL
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 22:44:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509AbYBNDoK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 22:44:10 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D28302DFE;
	Wed, 13 Feb 2008 22:44:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 8D40B2DFB; Wed, 13 Feb 2008 22:43:54 -0500 (EST)
In-Reply-To: <ee77f5c20802131903i45b1629fpcb4a5c6e4f483052@mail.gmail.com>
 (David Symonds's message of "Wed, 13 Feb 2008 19:03:12 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73845>

"David Symonds" <dsymonds@gmail.com> writes:

> If I have four branches, a, b1, b2 and c, and I've merged b2 into c
> (but planning to keep developing on b2), and just merged b1 into a
> (which I have checked out), then I probably only want to delete b1,
> not b2. The "current" branch is a useful notion because it
> significantly simplifies merging/rebasing operations.

Not just "simplifies", but it tends to make it much safer.

People often mistake that the safety of "branch -d" is to not
lose the commit (i.e. not making it unreachable), but that is
not the case.  That safety already exists in HEAD reflogs.

The "branch -d" safety is about not losing the particular point.
The information we really are trying to protect is "this branch
points at _that commit_", which is just as important if not
more.

And immediately after merging that branch into your current
branch is where we can be fairly certain that you are truly done
with the branch and that did not make a typo, if we hear you say
"I do not need that branch anymore, delete it".  "If it is
merged in _some random branch_" does not give such an assurance
and an inappropriate test for this purpose.

I should point out that the current protection based on HEAD
predates the invention of the "branch --track".  If we were
designing the safety today, it would have taken the form of "if
the branch to be removed is fully merged in the branch that it
used to be tracking, or the current branch, then it is safe to
remove it.".
