From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document git rev-list --first-parent
Date: Tue, 25 Dec 2007 01:35:05 -0800
Message-ID: <7vwsr3nmly.fsf@gitster.siamese.dyndns.org>
References: <1198484450-16454-1-git-send-email-avi@qumranet.com>
	<7v3atstry4.fsf@gitster.siamese.dyndns.org>
	<476F6F95.1030506@qumranet.com>
	<7vprwwsbey.fsf@gitster.siamese.dyndns.org>
	<476F7EA4.1030001@qumranet.com>
	<7vejdcs9cb.fsf@gitster.siamese.dyndns.org>
	<476F8679.8010706@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
X-From: git-owner@vger.kernel.org Tue Dec 25 10:35:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J76CO-0005rE-Ln
	for gcvg-git-2@gmane.org; Tue, 25 Dec 2007 10:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbXLYJfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Dec 2007 04:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbXLYJfQ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Dec 2007 04:35:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbXLYJfO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Dec 2007 04:35:14 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AA0D6A62F;
	Tue, 25 Dec 2007 04:35:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CB30A62E;
	Tue, 25 Dec 2007 04:35:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69231>

Avi Kivity <avi@qumranet.com> writes:

> I'm a mid-level maintainer for a particular subsystem (kvm).  I merge
> patchsets from others and do my own work, but I am careful to keep
> everything linear (no real merges in the git sense).  Every once in a
> while I merge from upstream or some other tree, but these are never
> kvm developments.  Every merge window I rebase the development branch
> to upstream, removing commits that were later reverted, and merging
> fixes into the patches that introduce them and push the result to
> Linus.  Hopefully that's clear as I'm not much of an ascii artist.
> So, for me --first-parent means "commits to the development branch of
> kvm", whether by myself or someone else.

Sure.  That's a perfect use case for --first-parent, as you can
afford to rebase.

I wanted to point out that the description needs to be clear
enough that people know the option is applicable only to some
workflow, but not necessarily to their own.  Saying "this option
gives a better overview" as if it always would felt wrong.  For
example for Linus, the option will not give a better overview.

Even in your case, if you merged from others' kvm tree, the
option becomes useless, as you mentioned ("I am careful to keep
everything linear").

If somebody cannot rebase (Linus certainly doesn't, and as a
general rule the top-level integration branch would never be
rebased) but pulls from people, some merges end up as real
merges while some others fast-forward and do not create merge
commits.  In such a history, --first-parent is not very useful.
Some parts of development will see individual commits (i.e. ones
applied by the top-level integrator himself, and the ones built
and committed by a subsystem person whose merge happened to have
fast-forwarded), while other parts will just show merge commits
(i.e. all other merges from subsystem people).

I however think the wording "... the evolution of a particular
branch" lessens my worries a bit, because it hints that the
option is about viewing the history of a topic branch, not the
integration mainline.  Maybe the wording can be made even more
explicit and say something like:

    This option can give a better overview when viewing the
    evolution of a particular topic branch, because merges into
    a topic branch tend to be only about adjusting to updated
    upstream from time to time, and this option allows you to
    ignore the individual commits brought in to your history by
    such a merge.

By the way, the wording "if a branch implements a consistent
fast-forward policy" suggests that forcing a real merge when the
merged branch is a fast-forward of your history is somehow a
good thing, but I think it is backwards to make such an
artificial real merge just to keep --first-parent happy.
