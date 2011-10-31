From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reference has invalid format: check maybe a bit to harsh?
Date: Mon, 31 Oct 2011 13:19:21 -0700
Message-ID: <7vpqhcq5h2.fsf@alter.siamese.dyndns.org>
References: <60007404.ge1WXNp2Qn@soybean>
 <7vty6pos20.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Oberndorfer <kumbayo84@arcor.de>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 31 21:19:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKyKO-0005AS-Vj
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 21:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374Ab1JaUTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 16:19:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59047 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304Ab1JaUTY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 16:19:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C190B6D4A;
	Mon, 31 Oct 2011 16:19:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DcwYQfaLC+X7fzNq4Mfss1SxPl0=; b=EK2EDg
	/nTK1hdf2NYy1JdfqawRn/ssZazyJLp0iRGS1qVj323QHZCI1ldg24EFJxGUwB5i
	eD8EcQNBjN5mnI8KPYczJepF37R/MHGqaDrsTRKr9vXou197IxhA7lkUosyRKa8W
	Fbmo+KMyeBhEzFt3q8qScTVZCyYZl7UPTwalc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kfk3y8IvBaJs/YYKZZjd7EjXD/0fQlEz
	NRA/uqKa6llTdl+1psr8+j52Sqod8STEmxW4DGdxoXq0YPD8iyrpHPLwOEpzriE5
	jKnyEldKrw9D6C7HwF3tvVwxGBsZdjut+cRCCCpxVT88CRjErNd5TKzbHdBPPvL3
	MR7JEVNSdko=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7CB76D49;
	Mon, 31 Oct 2011 16:19:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CE056D48; Mon, 31 Oct 2011
 16:19:23 -0400 (EDT)
In-Reply-To: <7vty6pos20.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 31 Oct 2011 12:54:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F4C6390-03FD-11E1-B368-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184519>

Junio C Hamano <gitster@pobox.com> writes:

> I agree that we would want to give users an escape hatch.  That is, if we
> can make something like this to work:
>
>     c=$(git rev-parse --force refs/patches/obd_development/blah:_vari...)
>     git update-ref refs/patches/obd_development/blah--various-improvements $c

Also we would need to be able to say

    git update-ref -d refs/patches/obd_development/blah:_vari...

to get rid of the offending one.

> I think we would be in a good shape.

Having said all that, I think we should in general loosen the checks done
on the reading side a lot more. The "checks" themselves should stay, can
give loud warnings, and even can error out when appropriate, but in an
operation that is necessary to recover from _existing_ breakage (like the
one in this thread, a file with a colon in its name in .git/refs/), the
ability to read and to remove is essential for recovery.

I vaguely recall we had to apply a fix in the same spirit to loosen
reading side after the offending topic was merged to 'master' during this
cycle about $GIT_DIR/config not possibly being a ref getting warned, or
something.

Michael, what do you think?
