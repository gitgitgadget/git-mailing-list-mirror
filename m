From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: define options in OPTIONS_SPEC
Date: Sun, 27 Feb 2011 02:59:44 -0800
Message-ID: <7v7hcl4uan.fsf@alter.siamese.dyndns.org>
References: <4D5BE49D.1040402@viscovery.net>
 <1298516875-10765-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 12:00:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PteMC-0001SB-2m
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 12:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab1B0LAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 06:00:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab1B0LAB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 06:00:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29C2E2BF7;
	Sun, 27 Feb 2011 06:01:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tfq+0yXO2r79S6KwQfxvEvMkB9I=; b=pm342n
	XfYLWhmpmGSaVtNnQJDRpq3qC7kAtUlLHrfDNfmSM7lTuKm+T7nSofxTWRM9ho/b
	d3BAnK5DCN/d2tpk+Cy0UBV1WfXB4XG0QMDl48alm8Rks0YqMJrKR//9Knz8nAT6
	TD5QAPYlDCOekKI9Ktec5DE45XNKFKX16+f4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hBOy0Ta9tiHTLLGNF6vCY4qjAjRFOpIA
	LzNu1q6UgIz6nCKI7dXapg24UsUvIYlqOhAKSiAqdX6cse5B0ZxvR8wdrjh8Fp1p
	HlZwIshSg37bp9rh/3EOuEM0lZ/sqvuZNfk+GN05Pz9j2EybGd2pt44RLMMq3Fux
	GUurKrP8GEM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B8D022BF6;
	Sun, 27 Feb 2011 06:01:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 18D482BF5; Sun, 27 Feb 2011
 06:01:03 -0500 (EST)
In-Reply-To: <1298516875-10765-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Wed\, 23 Feb 2011 22\:07\:55 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E3301C1E-4260-11E0-85DD-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168024>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> What is the difference between the "options" and "actions" sections?

For historical reasons, "git rebase" does not take subcommands in the way
many other commands do (e.g. "git bisect start", "git rerere remaining",
"git stash save").  Some --option to the command are used for specifying
the subcommand.  "git rebase --continue", if it were designed to be
consistent with the other commands, would have been "git rebase continue"
instead.  "Actions" part lists them.

This is somewhat unfortunate, but is understandable given that "rebase"
didn't have its own options at all, and there was only one mode of
operation, namely, to start the rebase process.  It allowed the user to be
terse, i.e. instead off having to say "git rebase onto master", it was
sufficient to say "git rebase master".

When "git rebase --continue" was introduced (before, you were supposed to
say "git am --resolved", which was nonsense from the UI point of view),
somebody should have noticed this as a problem and started a process to
deprecate the "git rebase <branchname>" and to require explicit subcommand
names, just like we did to "git stash [save]", but that didn't happen.

Perhaps this is something to consider at 2.0 boundary.
