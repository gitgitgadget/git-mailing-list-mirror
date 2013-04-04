From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Thu, 04 Apr 2013 12:17:38 -0700
Message-ID: <7va9pehzql.fsf@alter.siamese.dyndns.org>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
 <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>, Git List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:18:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpfp-0007sd-Pu
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764546Ab3DDTRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:17:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59652 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764538Ab3DDTRo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:17:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0840134EA;
	Thu,  4 Apr 2013 19:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H+6wVe6nU3oDOLH36/pjPMYJiws=; b=fc0jTF
	8dfJ9P6rUdBioaOacAb/nt57esoqmeRuIQSLqRdzImhi4a2F1uaIdtavO9FRCZqE
	hQ4UqcST83S/1a7x9hMPpywMMTffR+nS4Q38CVXhaojr8QoZVsM8d5oUu5/jtnWT
	zigQPkSE6epS3p3+GQlnAT1BdwmtItZJJrDnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cJ2pRcC5Ex2nCH/XA+oEQjk09bK6wKUD
	9noFKfwNzaHnh/qUxCwJqAYxvPcw0ULWACUuWQ25FU/wcGCnW13/MNy2EKfmO7x+
	q4VgQvPXDHUWfc8rRVN3qZ9tMHK2xPcJHNSc9vnxVjvW/TSsI1uhHI+/7u5PS98v
	TQWrJ/3HX/A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3D34134E9;
	Thu,  4 Apr 2013 19:17:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05B74134DC; Thu,  4 Apr
 2013 19:17:43 +0000 (UTC)
In-Reply-To: <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com> (Linus
 Torvalds's message of "Thu, 4 Apr 2013 12:04:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5318D306-9D5C-11E2-9E98-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220074>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> ... The features you seem to be after (ie that whole
> floating/refname thing) don't seem fundamentally antithetical to the
> current model (a "commit" SHA1 of all zeroes for floating, with a new
> refname field in .submodules? I dunno)..

Just on this part.

I think Heiko and Jens's (by the way, why aren't they on the Cc:
list when this topic is clearly discussing submodules?  Don't we
want to learn how the current submodule subsystem is used to solve
what real-world problems?) .gitmodules updates is exactly going in
that direction.

 - A submodule can be marked as floating in .gitmodules and be
   specified how (typially, "use the tip of this branch in the
   submodule");

 - Running "submodule update" a floating submodule does not detach
   the submodule working tree to commit in the index of the
   superproject; instead it will use the specified branch tip;

 - A floating submodule records a concrete commit object name in the
   index of the superproject (no need to stuff an unusual SHA-1
   there to signal that the submodule is floating---it is recorded
   in the .gitmodules).  Thanks to this, a release out of the
   top-level can still describe the state of the entire tree;

 - It would be normal for the commit recorded in the index of the
   superproject not to match what is checked out in the submodule
   working tree (i.e. the tip of the branch in the submodule may
   have advanced).  A traditional non-floating submodule has many
   mechanisms to be noisy about this situation to prevent users from
   making an incomplete commits, but they may have to be toned down
   or squelched for floating submodules.

Anything I missed, Jens, Heiko?
