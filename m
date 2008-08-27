From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Support "core.excludesfile = ~/.gitignore"
Date: Tue, 26 Aug 2008 22:01:03 -0700
Message-ID: <7vy72jrr00.fsf@gitster.siamese.dyndns.org>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>
 <7vsksw92nh.fsf@gitster.siamese.dyndns.org>
 <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu>
 <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
 <20080824220854.GA27299@coredump.intra.peff.net>
 <7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
 <20080824231343.GC27619@coredump.intra.peff.net>
 <7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
 <quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>
 <20080827002506.GB7347@coredump.intra.peff.net>
 <quack.20080826T2012.lthvdxn2ls4@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Wed Aug 27 07:02:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYDAi-0007hj-C0
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 07:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbYH0FBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 01:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbYH0FBM
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 01:01:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58587 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbYH0FBL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 01:01:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CABBB699A3;
	Wed, 27 Aug 2008 01:01:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5CD806999D; Wed, 27 Aug 2008 01:01:05 -0400 (EDT)
In-Reply-To: <quack.20080826T2012.lthvdxn2ls4@roar.cs.berkeley.edu> (Karl
 Chen's message of "Tue, 26 Aug 2008 20:12:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2A7FC124-73F5-11DD-940F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93856>

Karl Chen <quarl@cs.berkeley.edu> writes:

>>>>>> On 2008-08-26 17:25 PDT, Jeff King writes:
>
>     Jeff>   1. It should probably re-use path.c:user_path, as
>     Jeff>      Johannes mentioned.
>
> That function has the wrong interface for this task (requires
> extra strdup, imposes PATH_MAX, conflates all error conditions
> into returning NULL, also returns NULL if input doesn't have "~").
> Do you still think it should re-use that function?

On the other hand you have a pair of ugly "casting a const pointer down,
temporarily modifying what is const" in your version.

In any case, I think their point is that these two functions are meant to
do the same thing, and a unified interface would be desirable.

You do not necessarily have to use user_path() from path.c, but
user_path(), if its interface is coarser, could become a thin wrapper
around yours, don't you think?  Even better, perhaps the current callers
of user_path() may benefit from finer distinction among error conditions
(I didn't look, though).
