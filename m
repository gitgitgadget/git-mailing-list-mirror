From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to merge from newer branch to older branches?
Date: Tue, 21 Apr 2009 22:13:23 -0700
Message-ID: <7vmya946fg.fsf@gitster.siamese.dyndns.org>
References: <2729632a0904211224x6e2621caxf6c169d90b760530@mail.gmail.com>
 <20090421193615.GB7832@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skillzero@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 07:15:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwUnb-0008B6-Kh
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 07:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbZDVFNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 01:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbZDVFNb
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 01:13:31 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbZDVFNa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 01:13:30 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B05EC664;
	Wed, 22 Apr 2009 01:13:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C392BC662; Wed,
 22 Apr 2009 01:13:24 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 508AB06E-2EFC-11DE-BFFD-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117174>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 21, 2009 at 12:24:26PM -0700, skillzero@gmail.com wrote:
>
>> We have a "future" branch for new development. I wanted to add a new
>> feature so I branched from "future" to create a branch named
>> "feature". I completed the work, but now they've decided they need
>> that on two older branches. It looks like this:
>> [...]
>> I've read I should have started from the oldest common denominator
>> branch that I might ever want, but at the time I created the branch,
>
> Right. Junio branches all topics in git from "master", but then merges
> promising ones into "next". When the topic is ready for master, he can
> then just merge the topic branch, pulling in that topic but not the rest
> of next.

No, I don't.

I often branch from somewhere older than 'master', often tip from 'maint'
sometimes even older.  And that is not necessarily because I am better
than other people in planning ahead.  There are branches that forked from
older series (like 1.6.0.X) that are merged to next and then master,
without ever getting merged to produce 1.6.0.(X+1).

> Yep. Advanced planning is not always possible. :)
>
>> What's the best way to merge changes on the "feature" branch into the
>> 1.1 and 1.2 branches? If I try to checkout 1.1 then 'git merge
>
> If it is just one or two commits, you probably just want to "git
> cherry-pick" them onto your older branches.

I would suggest against it.  Just like you did not manage to plan in
advance for these two patches to fork from older branches, you will regret
later that these two were still full of bugs and need to be fixed up with
more patches on top.  Even if they are only a few right now, keeping a
cleaned up series that applies to the oldest would be easier to manage in
the long run.

I.e., rebase feature onto somewhere older (like 1.1):

	git rebase --onto v1.1 feature~2 feature

then let q&a people merge that to v1.1 and v1.2, while keeping the tip of
the feature still open.  You will queue further fix-ups on that branch and
tell q&a people to merge again to get the fixed to the feature.
