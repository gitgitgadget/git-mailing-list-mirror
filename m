From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] push: return reject reasons via a mask
Date: Mon, 26 Nov 2012 10:43:19 -0800
Message-ID: <7vobikryrc.fsf@alter.siamese.dyndns.org>
References: <1353644515-17349-1-git-send-email-chris@rorvick.com>
 <1353644515-17349-2-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 19:43:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td3ed-00054h-Lx
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 19:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975Ab2KZSnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 13:43:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526Ab2KZSnW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 13:43:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F6259CD2;
	Mon, 26 Nov 2012 13:43:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OVLAN4tM+CWULwdm2d1fmSydVtw=; b=OmYkwu
	y1cmg0eqCIsa7nFKA+CEpPKYer2M5EIeiogpdxvYcs22tqPKBfjQkKpRFk9isK7r
	WZP87QP2Qv9h9tSeroLmmOSJID75GZL6t/oWw06398YutTxQ2O1MRB3G0GNJj6EA
	kd85c3NlOPpxkc3MJvDSQohankjHIhQmLxSVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=laRYSS86qS25X1iZjChwJs4qfHR5o6Ht
	6GAje5V5U6lACUkhxq2aj6RL4CcZpa7sYrwfE1yWPYZO+lvKBLXaQYoW/Hq3gCZh
	n5DjFnArM7G5sowhhroThjZg2V60Z5OCkgzWckW2MCxdhm38WWKWfyLGaIU/bcaC
	gVROQiABJIk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CD5A9CC9;
	Mon, 26 Nov 2012 13:43:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BE049CC8; Mon, 26 Nov 2012
 13:43:21 -0500 (EST)
In-Reply-To: <1353644515-17349-2-git-send-email-chris@rorvick.com> (Chris
 Rorvick's message of "Thu, 22 Nov 2012 22:21:49 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 270E5470-37F9-11E2-88F6-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210467>

Chris Rorvick <chris@rorvick.com> writes:

> Pass all rejection reasons back from transport_push().  The logic is
> simpler and more flexible with regard to providing useful feedback.
>
> Signed-off-by: Chris Rorvick <chris@rorvick.com>
> ---

Thanks for a reroll.

I do not think they are "masks", by the way.  They are set of flags
(i.e. a bitset).

A bitset is often called "a mask" when it is used to "mask" a subset
of bits in another bitset that has the real information, either to
ignore irrelevant bits or to pick only the relevant bits from the
latter.  And your "reject_mask" is never used as a mask in this
patch---it is the bitset that has the real information and it gets
masked by constant masks like REJECT_NON_FF_HEAD.

In any case, naming it as "reject_mask" is like calling a counter as
"counter_int".  It is more important to name it after its purpose
than after its type, and because this is to record the reasons why
the push was rejected, "rejection_reason" might be a better name for
it.
