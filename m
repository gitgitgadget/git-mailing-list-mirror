From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] pre-merge-hook
Date: Wed, 05 Sep 2012 22:07:34 -0700
Message-ID: <7v8vcn68o9.fsf@alter.siamese.dyndns.org>
References: <cover.1346851863.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 06 07:07:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9UJp-0007rB-6g
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 07:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950Ab2IFFHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 01:07:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44403 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab2IFFHh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 01:07:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADDD440E2;
	Thu,  6 Sep 2012 01:07:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9W26utjB03W8VUGR5GoEJG2W6dw=; b=P8BKVg
	U1iXE79l7JiDPRpkbH4oBQDGDIDeCzERhUBAO6wSYiu5VdtF3BPcUG65Jt26Ho9K
	nkBWHaufdfLjDnj9TRQNO10UM5lx/ZcPY24AvKe9mCacZj6IZN+j2Sc1f4DDh3O2
	T9pI73lgPhfY/p1ZykVHxLqk+x0PP2lMuiDCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=daDJ/fIZbUT3vab4ho2A2vnQkPQeMp9p
	2EBMimLwWlkv4DO743iEnlyqYDRJXMbykz0Y+yPUUhGUTiq6eBg5qf3MjKL0CjZ9
	MU8xDBPOj8fSutHjNeczr8jN70l6jv8CN1cfR1tgWk+UMYFI0wCdoNGAVYHi4g5n
	FVZb4H8c/5M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A2FB40E1;
	Thu,  6 Sep 2012 01:07:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1000A40E0; Thu,  6 Sep 2012
 01:07:35 -0400 (EDT)
In-Reply-To: <cover.1346851863.git.git@drmicha.warpmail.net> (Michael J.
 Gruber's message of "Wed, 5 Sep 2012 15:39:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5C73784-F7E0-11E1-8BF4-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204861>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The pre-commit hook is often used to ensure certain properties of each
> comitted tree like formatting or coding standards, validity (lint/make)
> or code quality (make test). But merges introduce new commits unless
> they are fast forwards, and therefore they can break these properties
> because the pre-commit hook is not run by "git merge".
>
> Introduce a pre-merge hook which works for (non ff, automatic) merges
> like pre-commit does for commits. Typically this will just call the
> pre-commit hook (like in the sample hook), but it does not need to.

When your merge asks for a help from you to resolve conflict, you
conclude with "git commit", and at that point, pre-commit hook will
have a chance to reject it, presumably.  That means for any project
that wants to audit a merge via hook, their pre-commit hook MUST be
prepared to look at and judge a merge.  Given that, is a separate
hook that "can just call the pre-commit but does not need to" really
needed and useful?

I admit that I haven't thought things through, but adding a boolean
"merge.usePreCommitHook" smells like a more appropriate approach to
me.

I dunno.
