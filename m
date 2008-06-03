From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Maintaining two branches.
Date: Tue, 03 Jun 2008 12:09:32 -0700
Message-ID: <7vod6i2v4j.fsf@gitster.siamese.dyndns.org>
References: <20080603163431.GA1244@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Tue Jun 03 21:10:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3bu6-0005Qy-Ia
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 21:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbYFCTJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 15:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753645AbYFCTJs
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 15:09:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbYFCTJr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 15:09:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 91650407B;
	Tue,  3 Jun 2008 15:09:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2614B4071; Tue,  3 Jun 2008 15:09:37 -0400 (EDT)
In-Reply-To: <20080603163431.GA1244@old.davidb.org> (David Brown's message of
 "Tue, 3 Jun 2008 09:34:31 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A05B0652-31A0-11DD-9F2F-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83690>

David Brown <git@davidb.org> writes:

> Looking for some advice/ideas on a git workflow:
>
> We have three branches of the code:
>
>   - upstream - The upstream release versions, tracks outside git repo.
>   - external - Other external patches not included in the main git repo.
>   - local - Our local development.
>
> For release reasons, we need to keep our local branch separate, but normal
> development needs to be done on a merge of 'external' and 'local' (the tree
> needs the merge of both just to build).  Developers will generate patches,
> and maintainers will apply these patches to 'local'.
>
> I've tried creating a 'next' branch where I merge each change from local
> and/or external, and this seems to work, but the history gets very
> cluttered with merge commits.  For some reason, history simplification
> doesn't seem to eliminate any of these merges.
>
> We also have an automated build/test system that checks out versions of
> 'next', and when the build and test moves 'master' forward to that version.
> Because of this, it would be nice to keep 'next' fairly up-to-date, which
> implies having a lot of merges.

You do not have to, and very likely do not want to, merge 'next' directly
into 'master'.

Instead of having a single local integration branch 'local', it is wiser
to keep separate topic branches to house your local development.  Each of
them will start its life in an imperfect shape, and will need multiple
rounds of fixups, which is normal, and you will merge them regularly into
'next' to make sure everything will work together, and 'next' will have
tons of merges for this exact reason.

However, what you will merge to 'master' is not 'next' as a whole.
Instead, you will merge each individual topic, only it is fully cooked and
proved to be Ok while it has been in 'next', to 'master'.  That way, if a
work to enhance an appliation area took four attempts to get it right over
four 'next' cycles, 'next' branch may have four merges from that topic
branch, you will see only one merge from that topic to 'master', that
merges the enhancement in completed state.  At that point, 'next' will
have other topics in an earlier stage of polishing, and these imperfect
ones will not in 'master' yet.

IOW, just like you keep separate things separate by having distinction
between 'external' and 'local', by keeping separate development tracks
among what you currently use single basket 'local' to hold, your history
will become much more meaningful and understandable.
