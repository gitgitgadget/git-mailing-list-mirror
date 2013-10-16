From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Wed, 16 Oct 2013 14:42:27 -0700
Message-ID: <xmqqeh7k51vg.fsf@gitster.dls.corp.google.com>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Wed Oct 16 23:42:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWYrS-0001Q4-A5
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 23:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760342Ab3JPVma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 17:42:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab3JPVma (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 17:42:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B74A4B391;
	Wed, 16 Oct 2013 21:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ZBgFisrwyzPRbe1PO13Xz2L4NGA=; b=SKAD2mVQZ2rh+govbWvm
	QCJjlaotebo84uczlPFaQCn6EosBZ0K4Uea2dNjagkQ4ej9HpU+rYhfFH72vhYvc
	sPIqQK5KknyTMebtgwJwnDbbPKiU5+XpAG8pHToKMpL+LYK3pNSaFW1u+xim+9IG
	8UIxFNiq5PNO1EDmbZ1/2fU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=bTfcAB0Msxn9cuJ7WUmXoLTNWlQvL2Dg+0+1fqq9cTnmX7
	lml3WzzkQLeRq0NR8vowmpBISfOPHJYDaR+x8jfbiIuotmMJh1KT2npUdPvLGorH
	MX32KsbJ0ODcTNBnD+FGY1yW9iTsyBkxsYapvJC+axc6EZg7vppyQOPQSooh4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 869984B390;
	Wed, 16 Oct 2013 21:42:29 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2AA64B389;
	Wed, 16 Oct 2013 21:42:28 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DAC2519A-36AB-11E3-89F4-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236272>

worley@alum.mit.edu (Dale R. Worley) writes:

> In general, Git commands on a repository with a detached worktree can
> be executed by cd'ing into the directory containing the .git
> directory, ...

Eh?  News to me; it might happened to have appeared to work by
accident, but that is not by design.

IIRC, the intended use pattern (i.e. the change that introduced
GIT_DIR and GIT_WORK_TREE environment variables was designed to
support) for such a working tree is to:

 - export GIT_DIR that points at the correct .git directory;

 - export GIT_WORK_TREE that points at the correct top-level of such
   a working tree; and then

 - run the commands anywhere in the working tree, as if you did not
   export these two environment variables and instead had the .git
   directory at the usual place in the working tree.

It _is_ possible that we may have broken this canonical use pattern
over time with more recent updates; I do not think we have extensive
test coverage for "detached worktree" use case in the first place.

> Does anyone have any feedback on this?

Not exporting GIT_DIR variable in sh-setup was done not by accident
but as a very deliberate design choice, IIRC.
