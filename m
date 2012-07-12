From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: git-am: indicate where a failed patch is to be
 found.
Date: Thu, 12 Jul 2012 14:55:17 -0700
Message-ID: <7vfw8wablm.fsf@alter.siamese.dyndns.org>
References: <1342108243-8599-1-git-send-email-paul.gortmaker@windriver.com>
 <7vhatcc1ql.fsf@alter.siamese.dyndns.org> <4FFF1821.7030705@windriver.com>
 <7va9z4byl3.fsf@alter.siamese.dyndns.org> <20120712211835.GA858@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jul 12 23:55:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpRML-0008T3-E9
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 23:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815Ab2GLVzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 17:55:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37370 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932998Ab2GLVzW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 17:55:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCCDC8EC3;
	Thu, 12 Jul 2012 17:55:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uQFn3dFGe8IU6agtvgxGOB6di+A=; b=giJdVo
	KRUMm6NHFjiOPFWRUO4efs226kiRpe46qycHO3yBPNo7eLvkqP9zddYZnkvi/V9p
	B1yXxAJo+rZQx8Iq7VAQVHC8dRiiGdMDGgVojdvSVubw7OS9TtIfsI4sN8H8wqWh
	LF01dftKoFh2kTuHPkAXYFmxEe+Dz60TX8OSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wdjfp2YszuYzJYlbna0quTpCDWCRrMeb
	aMeOoUoNtatQjU8GpwCLM49Xmjisq+5HvNGfjy6aK9RPs0kU72gIFDlnYEZR+p2L
	/9NNN3zK+uMUnBO/b516uJ6YFeqCMYkesgypoiqUAZUiRJ/M5FJaBU1nxdtlv1Qb
	FOraTuhfWyM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC0768EC2;
	Thu, 12 Jul 2012 17:55:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D1198EBF; Thu, 12 Jul 2012
 17:55:19 -0400 (EDT)
In-Reply-To: <20120712211835.GA858@vidovic> (Nicolas Sebrecht's message of
 "Thu, 12 Jul 2012 23:18:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 456F16F0-CC6C-11E1-93F1-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201384>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> The 12/07/12, Junio C Hamano wrote:
>
>> It does not matter at all that 0001-foo.patch only has a single
>> patch.  If you are going to fix up the patch after you saw "git am"
>> failed, you will be fixing .git/rebase-apply/patch with your editor
>> and re-run "git am" without arguments, at which point "git am" will
>> not look at your 0001-foo.patch file at all.
>
> Hugh! Didn't know that.
>
> Is it actually expected from users to manually edit
> .git/rebase-apply/patch path? I can't find any reference about that in
> the documentation and it really sounds like interfering with the git
> internals.
>
> Shouldn't git-am/git-rebase expose this to the user (I'm thinking about
> something like
>
>   git am --edit-offending-patch
>   git am --fix-patch

I doubt it would be very useful.  As Paul says, it is a powerful way
to work, but it is not for everybody, and more importantly, it is
not the only way to work with the patch, once the user knows where
it is.

The first problem before any of that is that we didn't tell the user
where the patch is.  You can re-run "git am" with different options
like reject, "-3", and/or with a reduced context and many cases are
handled without having to know where the patch is at all, but if the
user starts wanting to know where the patch is because she wants to
do things beyond that, we should just tell her where it is, instead
of adding a yet another option to run an editor on it, still without
telling her where it is.
