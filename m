From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply that handles rejects like merge conflicts
Date: Mon, 07 Nov 2011 15:45:48 -0800
Message-ID: <7v4nyf1opf.fsf@alter.siamese.dyndns.org>
References: <4EB85768.1060508@avtalion.name>
 <20111107225508.GB28188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ori Avtalion <ori@avtalion.name>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 08 00:45:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNYt3-0000im-1o
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 00:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212Ab1KGXpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 18:45:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38533 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755067Ab1KGXpv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 18:45:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 886976C12;
	Mon,  7 Nov 2011 18:45:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yjgdx3azoaeZLe/NjkqiUl6F230=; b=hpa3Xk
	E3kUKWfWCaouTcRfOQjp8l55hMnhYvDnXPl9BRcKulPwOAbJnIhXpx1G/q8kLMZT
	cunz94qcnZ7egvyW9TRphnSzvXmuJApCSByCLXHnhut4cGkgY2DsSu69Q+jk2WOn
	LgUWT+XU+chwiQcc0iuqNHOdioAteuaLypvi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k2RWNynpJDUG7Rl62BX3pkTQ7/a0ZOS3
	2Z2K6SOfAASroQ/prFQmjTotxOKYSBzaFUgVsujfWrPRI+P4hzPStkqYwZVVe2Xe
	4bN2DbhFiiozsXMk735+ZWOpNsE6T8z/5MceuvnTXqzvrvnf3Jmeu84ywCGNyo/K
	R9cfnsNYtgc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F8A66C11;
	Mon,  7 Nov 2011 18:45:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14A366C0F; Mon,  7 Nov 2011
 18:45:49 -0500 (EST)
In-Reply-To: <20111107225508.GB28188@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 7 Nov 2011 17:55:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F5A95B2-099A-11E1-BA5A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185048>

Jeff King <peff@peff.net> writes:

> In the general case, you can't represent all failed hunks with conflict
> markers, can you?

Conflict markers come from the use of a 3-way merge, and if you were to do
a 3-way merge, by definition, you would need some way to tell where the
preimage of the patch and the target tree you are attempting to apply the
patch forked from. That's done by fall-back-3way in "am -3".

You _could_ lift that logic out of "am -3", but I do not think it is worth
the effort to do so (IOW, I do not see a reason to avoid "am -3").

If you do not want to create a commit for whatever reason, then you can
"reset --soft" back.
