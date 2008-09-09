From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git apply vs. renamed files index mismatch
Date: Tue, 09 Sep 2008 07:45:19 -0700
Message-ID: <7vtzcp8jk0.fsf@gitster.siamese.dyndns.org>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
 <1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
 <48C57A92.6060608@freescale.com>
 <20080908212717.GA21338@oksana.dev.rtsoft.ru>
 <7vej3ucf6y.fsf@gitster.siamese.dyndns.org>
 <20080909100628.GA15298@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Wood <scottwood@freescale.com>,
	Becky Bruce <becky.bruce@freescale.com>,
	linuxppc-dev@ozlabs.org, git@vger.kernel.org
To: avorontsov@ru.mvista.com
X-From: git-owner@vger.kernel.org Tue Sep 09 16:49:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd4UG-0007nr-Ks
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 16:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbYIIOp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 10:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754012AbYIIOp3
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 10:45:29 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbYIIOp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 10:45:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B6EA274503;
	Tue,  9 Sep 2008 10:45:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8187074501; Tue,  9 Sep 2008 10:45:21 -0400 (EDT)
In-Reply-To: <20080909100628.GA15298@oksana.dev.rtsoft.ru> (Anton Vorontsov's
 message of "Tue, 9 Sep 2008 14:06:28 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F16C1ACA-7E7D-11DD-8F6B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95390>

Anton Vorontsov <avorontsov@ru.mvista.com> writes:

> Now consider the following patch (modified by hand: it should say
> +foo, but I changed it to +bar).
> ...
> The "index ..." stuff says that there are no changes and it is
> pure rename, but obviously there is a change.

Ah, I see what you mean.  But in general, it is not obvious at all.

If you have the identical preimage (recorded on the LHS of the index line)
or the patch reproduces the postimage in full (i.e. "create a new file"),
you *could* notice.  It's an interesting idea from git person's point of
view (i.e. "would be fun to implement"), but I doubt it would be useful in
practice, because:

 (1) You often do not have the identically matching preimage;

 (2) More importantly, it is not unusual for people to *edit* the patch in
     their MUA (think of typofixes), after getting it out of git.

 (3) Even more importantly, even if you notice there is some difference,
     you cannot produce the postimage by only looking at the hash (this is
     obvious -- otherwise by definition you broke SHA-1), so you cannot
     tell *how* the patch was modified.

What is of much more practical value to learn here in the context of this
topic would be that after accepting such a patch that does not use -M (so
that non-git people can use patch(1) to apply), a git person can still
verify the result with "git show -M" to see what changes other than a pure
rename was made by the patch.
