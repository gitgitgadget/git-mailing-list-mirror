From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] git reintegrate v0.3; manager of integration branches
Date: Tue, 20 May 2014 14:29:37 -0700
Message-ID: <xmqqtx8krvem.fsf@gitster.dls.corp.google.com>
References: <53795175664d5_10da88d308ce@nysa.notmuch>
	<xmqqha4lxyqt.fsf@gitster.dls.corp.google.com>
	<537bc3e1c605c_a6f166b3088f@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 23:29:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmrbX-0001xk-P2
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 23:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbaETV3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 17:29:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55834 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbaETV3n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 17:29:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7EB0619DFA;
	Tue, 20 May 2014 17:29:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mZ6buTAGl0fZcTGRulsu8MKWPQ8=; b=OiH8Ui
	SLPjqTnNiYaQkNLGGUIIWL1GrKEZP+QoBmro2zQisaJMRHym+NsQWwd1rmhYzhf3
	PKpnDEb6W/fK1WaKIes1kvELXRpJOelLzFdJe8r3iqYBAkBkUMSa69eTHNnRrPN+
	Sf1VK2LmLSE9fqcCuMsgJ+TROqT1vjY/iU+hY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uus6+Nh1LbPm4pvTFEgJAOT0m9ZSyF+f
	BzvN765EpCnoNr6dlSg/l3MAaAuDKJPjnCGcAdjMZ+t3359fBjK34hUZH8UfM7jd
	GnOwGU/UN453yvsouU+5UktWXdFTQs00yNEWDP4vntAtlgpA9tQcdyIgQsBnhM+I
	X+e7/VJeWFw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 755FF19DF9;
	Tue, 20 May 2014 17:29:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2A93519DF0;
	Tue, 20 May 2014 17:29:39 -0400 (EDT)
In-Reply-To: <537bc3e1c605c_a6f166b3088f@nysa.notmuch> (Felipe Contreras's
	message of "Tue, 20 May 2014 16:06:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D9379272-E065-11E3-8B2B-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249747>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Or have an option to specify a dynamic instruction sheet, so you can cat
> the instructions of 'match-next' and replace the base. However, I don't
> see the point of re-applying the branches for 'next' if you already know
> that 'next' and 'match-next' are the same.

The output from Reintegrate script (in 'todo') only lists the names
of topic branches (or something like "xx/topic~4" when the topic is
not fully merged yet), and a topic branch may acquire a follow-up
change (or two) on top (there is a machinery to see if xx/topic~4
is still valid in such a case and update the offset as needed).

Rebuilding 'jch' on top of 'master' with the same insn sheet will
then merge the updated topic branch in its entirety, and the new
commits on the topic branch somehow needs to go to 'next' for the
"match next" on 'jch' and 'next' to be in sync (in addition, updated
'master' must be merged to 'next', but that goes without saying).

In other words, I already know that 'next' and "match next" are not
the same, that they must become the same, and there needs a way to
make them so.

And that is done by re-running the insn sheet for 'jch' up to the
"match next" mark, merging the topic that are not fully merged to
'next' while ignoring the ones that already are fully in 'next'.
