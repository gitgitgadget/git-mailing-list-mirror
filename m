From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add tests for 'git rebase --keep-empty'
Date: Thu, 09 Aug 2012 10:22:40 -0700
Message-ID: <7v628sou8v.fsf@alter.siamese.dyndns.org>
References: <1344444498-29328-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1344526791-13539-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 19:22:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzWRe-00080u-1E
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 19:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab2HIRWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 13:22:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49173 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753580Ab2HIRWn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 13:22:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFAC87815;
	Thu,  9 Aug 2012 13:22:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DkqhC0tkOX68J3czbaDsqbJD1UE=; b=QoHI7l
	vO2gsp+7/Jot2taxT32Gvx76mvPc3CYvzOIC8ScXFQe4MlYrdjx//O9vgZhiSJcZ
	CfREkYvv3ZDWB6OV2lpjau/GD3Z3E9rNvkwAMxTcvCTs8FnScGnJpDECaZ2BtGAE
	NTH9MCpR0dZSH/gc8ibyLYDrCFwOcbJXpMay0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D5jEeArv08qbrEpzqz+0SggiPjuHRcZT
	PqtpWl1kkbAht2gni95B+dMw3PLUqUowvaZJ2MB26GNhYDI78iw0Y7tJ9eo7HZLB
	UMTCsg//LB/uLGcqyrNiTUJ6iO+Jf31HHvoWC+W3CTP/p7tugktjsW+LsIUEyZsa
	X1ZZjd5UW9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B71197814;
	Thu,  9 Aug 2012 13:22:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2245D780F; Thu,  9 Aug 2012
 13:22:42 -0400 (EDT)
In-Reply-To: <1344526791-13539-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Thu, 9 Aug 2012 08:39:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D37B519E-E246-11E1-A9BB-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203169>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Add test cases for 'git rebase --keep-empty' with and without an
> "empty" commit already in upstream. The empty commit that is about to
> be rebased should be kept in both cases.
>
> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
> ---
>
> Added another test for when the upstream already has an empty
> commit. The test case protects the current behavior; I just assume the
> current behavior is what we want.

Thanks.  I think it makes sense, as "upstream already has an empty
commit" together with "want to keep empty while rebasing" is a
strong sign that the user wants to have a history littered with many
empty commits.  Unlike a normal commit whose "patch-id" identity may
have meaningful significance (i.e. "the change to do X is already
in, or not yet in, this branch"), all the empty commits share the
same emptiness, so having one empty somewhere long time ago in the
history of where we are transplanting the commits shouldn't be a
reason to countermand the "want to keep empty" wish by the user.

And I do not think the conclusion would change even if we changed
the definition of "identity" for empty commits so that two empty
commits with the same message are detected as equal.  The only semi
sensible justification I heard from people who want to have empty
commits in their history is to keep in-history "notes" (e.g. "at
this point in the series, the code stops to compile, but the next
one fixes it", "it is possible that we may want to redo the previous
patch but I dunno"), and it may not make sense to drop such an empty
commit under "--keep-empty" mode if there are similar or identical
looking "notes" in the "upstream" part of the history.
