From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 01/10] Teach rebase interactive the mark command
Date: Mon, 14 Apr 2008 17:11:15 -0700
Message-ID: <7vve2k6kpo.fsf@gitster.siamese.dyndns.org>
References: <69a88a530804131351n7d9f8188vf2bbb0174ade3ca0@mail.gmail.com>
 <alpine.DEB.1.00.0804141506270.28504@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Fredrickson <paul.fredrickson@gmail.com>, git@vger.kernel.org,
	joerg@alea.gnuu.de
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 15 02:12:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlYmU-0004Yl-B0
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 02:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347AbYDOAL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 20:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757212AbYDOAL3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 20:11:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbYDOAL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 20:11:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0EC573FCF;
	Mon, 14 Apr 2008 20:11:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 252FB3FC2; Mon, 14 Apr 2008 20:11:19 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79545>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I would like it much better, if there was something like
>
> pick 5cc8f37 (init: show "Reinit" message even in ...)
> pick 18d077c (quiltimport: fix misquoting of parse...)
> merge 9876543:5cc8f37,18d077c (Merge blub)
> reset 5cc8f37
> ...
>
> I.e. like with filter-branch, and like with rebase -i -p in its current 
> form, we take the _original_ names as keys as to which commits to merge, 
> or where to reset to.

While the need probably would not be felt strongly if we design this only
for rebase -i, I suspect that you would want to have two kinds of reset if
you go that route.  There might be some other insn that may have similar
issues.

For example, imagine a case where you want to create a merge with a
recontructed side branch.  First you grow the branch you would merge into,
with a sequence:

	pick A
        pick B
        pick C

Then in order to reconstruct a side branch that begins from a known point,
say the tip of "master", you would want to reset to a commit that is
outside of the scope of this rewriting.  And then you rebuild that side
branch:

	reset master
        pick D
        pick E

And finally (and this step shows the beauty of your approach), come back
to the other tip and make the merge:

	reset C
        merge E

Two resets above would have different semantics.  The former resets to
unwritten, and the latter rewritten.
