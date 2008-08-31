From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 - RFH/WIP] xdiff-merge: optionally show conflicts in
 "diff3 -m" style
Date: Sun, 31 Aug 2008 11:42:10 -0700
Message-ID: <7vd4jp2fi5.fsf@gitster.siamese.dyndns.org>
References: <7vzlmwbs1u.fsf@gitster.siamese.dyndns.org>
 <7vsksobrn9.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808281727490.3300@nehalem.linux-foundation.org>
 <7vmyiwbpe2.fsf@gitster.siamese.dyndns.org>
 <7v1w05d5hm.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808311021120.12958@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 31 20:43:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZrtW-0003Hn-Hy
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 20:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbYHaSmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 14:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754808AbYHaSmV
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 14:42:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405AbYHaSmU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 14:42:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2F72B6F720;
	Sun, 31 Aug 2008 14:42:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 92C646F71E; Sun, 31 Aug 2008 14:42:13 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808311021120.12958@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Sun, 31 Aug 2008 10:38:18 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 89C40402-778C-11DD-B775-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94501>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 31 Aug 2008, Junio C Hamano wrote:
>> ...
>> My observation so far suggests that it would be best for me to leave the
>> configuration "merge.conflictstyle" to the default "merge", and instead
>> give an option to allow me to tell "git checkout -m -- $path" (which is
>> also a new feature; it overwrites the $path by the result of a fresh merge
>> to reproduce the conflicted state in the working tree, using the three
>> stages recorded in the index) to use "diff3 -m" style, when I want to.
>
> Now *this* I think is a great idea! 
>
> The reason I think it's a great idea is that it solves so many _different_ 
> issues (which is the mark of a really good solution):
> ...
>  - it fixes another totally unrelated problem: incorrect merge 
>    resolutions.

I do not know if rerere often kicks in in your workflow, but occasionally
I notice that I have a faulty merge recorded by it, which automatically is
applied again when reproducing a merge.  And it makes me deeply regret
that I invented the rerere mechanism.

The best solution for this issue I found so far is embarrasingly clumsy.
Run "ls -tl .git/rr-cache" to find the newest one with "thisimage", make
sure it is the right one, remove the directory and redo the merge.

Actually, the feature of "git checkout -m -- $path" to reproduce the merge
for the named path was conceived to address this "I cannot easily correct
the faulty resolution that was re-applied" issue.
