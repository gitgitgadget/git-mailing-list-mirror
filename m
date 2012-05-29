From: "Steven E. Harris" <seh@panix.com>
Subject: Re: How does Git's maintenance policy handle topics that don't start from "master?"
Date: Tue, 29 May 2012 17:51:53 -0400
Organization: SEH Labs
Message-ID: <m2sjei4pvq.fsf@Spindle.sehlabs.com>
References: <m21um2682e.fsf@Spindle.sehlabs.com>
	<7vbol63ccs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 23:53:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZULd-0004T9-0f
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 23:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab2E2Vwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 17:52:47 -0400
Received: from plane.gmane.org ([80.91.229.3]:48527 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728Ab2E2VwN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 17:52:13 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SZUKn-00042A-3r
	for git@vger.kernel.org; Tue, 29 May 2012 23:52:09 +0200
Received: from c-24-23-122-157.hsd1.pa.comcast.net ([24.23.122.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 May 2012 23:52:09 +0200
Received: from seh by c-24-23-122-157.hsd1.pa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 May 2012 23:52:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-23-122-157.hsd1.pa.comcast.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3.50 (darwin)
Cancel-Lock: sha1:aIBT+EN17up6JveLsOJ0Tn3GIK4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198766>

Junio C Hamano <gitster@pobox.com> writes:

> It often is clear that the follow-on topic depends on an earlier topic
> branch (mostly because the contributor is aware of it and state it in
> the message).  An obvious thing to do in such a case is to create a
> new branch to queue that topic starting at the tip of the earlier
> topic.  Note that this is never from the tip of "next", as it is very
> unlikely that such a follow-on topic depends on everything that is not
> in "master" yet.

Thank you for the thorough reply.

I want to make sure that I understand the main hazard that the policy
aims to avoid. If an author bases a topic branch on the tip of "next,"
then, later, it will not be possible to merge his work to "master"
without implicitly accepting all of "next" (or, at least the part of
"next" the precedes this topic branch) into "master." We are trying to
avoid merging "upward" from "next" to "master" like that, and prefer to
take the topics to "master" directly rather than implicitly by way of
their inclusion in "next."

What isn't so clear to me, though, is /why/ this don't-merge-from-"next"
rule is so important. Say that we had one topic "t1" depart from "next,"
and then another topic "t2" depart from "t1," and both have been cooking
in "next," with good results.

  ---o---o---o---o  master
                  \
                   o---o---o---o---o---M---o---o next
                        \     /       /
                         o---o t1    /
                              \     /
                               o---o t2

If we wanted to graduate these two topics to "master," we /could/ merge
from commit M back to "master," though here I deliberately included the
nefarious commit X, which shows other interleaved contributions along
"next" that are also part of the M commit.

What about this case, where topics "t1" and "t2" did depart from
"master," and are doing well along "next" together as of commit M.

  ---o---o---o---o  master
      \   \       \
       \   o---o---o---M---o---o next
        \     /       /
         o---o t1    /
          \         /
           o---o---o t2

The Git policy as I understand it prescribes that we merge from the tips
of "t1" and "t2" back to master, not from a commit like M. What harm
would come from merging from M in this case? Future archaeology of topic
provenance?

-- 
Steven E. Harris
