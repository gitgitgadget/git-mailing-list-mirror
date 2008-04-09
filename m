From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --only-merges flag to display only merge commits.
Date: Wed, 09 Apr 2008 13:06:19 -0700
Message-ID: <7v3apu6bes.fsf@gitster.siamese.dyndns.org>
References: <20080408203648.GS11574@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Apr 09 22:08:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjgb8-0007d9-Gg
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 22:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096AbYDIUH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 16:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756818AbYDIUH6
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 16:07:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756633AbYDIUH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 16:07:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D8A21BF2C;
	Wed,  9 Apr 2008 16:06:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 53A761BEA9; Wed,  9 Apr 2008 16:06:27 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79128>

Miklos Vajna <vmiklos@frugalware.org> writes:

> This is the opposite of git-rev-list --no-merges: It will hide commits
> with single or no parent.
>
> It is useful if a maintainer has a lot of commits between tags and
> usually each feature is developed in its own topic branch.

For that particular use case, I'd suggest --first-parent.  It is not just
about filtering the output but more importantly also affects the way the
traversal is done (it does not descend into side branches).  It simply is
more suited for the job you described.

At this point, I have a mild aversion to a random addition to rev-list
that does not have to affect how the traversal works but only filters the
output, and more importantly does only a single purpose filtering.

It is very much unclear if the --only-merges is a very common thing for
people to want to do, and it is very clear what --only-merges does is a
very narrow single purpose filtering.

Contrast that to existing --no-merges or --grep.  The former is a very
narrow single purpose filtering but it is clearly something everybody
would want to have.  The latter also satisfies a common desire, and it is
an easy way to query with a customized filtering, e.g. you can use it like
so: 'log --grep="Merge " v1.5.4..v1.5.5'.
