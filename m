From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/config.txt: change "pull.rebase" description in favor of safer 'preserve' option.
Date: Tue, 05 Aug 2014 15:32:08 -0700
Message-ID: <xmqqa97io9ef.fsf@gitster.dls.corp.google.com>
References: <87bnrzxhrm.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 00:32:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEnHa-0000G7-BJ
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 00:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbaHEWcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 18:32:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57062 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753987AbaHEWcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 18:32:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 76D9E2F499;
	Tue,  5 Aug 2014 18:32:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fyd1fKXRQ1raF9grYAlG6ECLDfo=; b=CAEK1E
	Dg3kr6ST9YKpMWCvBPdIAMbGxEwmFvDJX8MRI1L7VF3+IuQnRE7JiBtTsKpxT4sz
	kVLY0D5wGYgVJemCEIV2M9mCrR03/uaEkVCYQpHPefBhtPsQ2LjUvYpHAt2RI0zR
	cgCZESB81QVHUMWoTlmw9SIh91AcWrm7Wj1JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ng2nghiu4eZa+6xFPn5wCJFER/JKs87n
	wSg3GF/bcb3FpzS0T+df7cP633ytvRezvrFaw3Zi4jjJQFWRI58wXGiAN1Ro8L36
	7beUsJs+ydddVMkCSrB2Zr29fn8rE9Xjwxc7ryeMUPvp4siPP9OLCWplUNRmFKTz
	q+uZmPmWO2Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C7C92F497;
	Tue,  5 Aug 2014 18:32:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D5DC2F48C;
	Tue,  5 Aug 2014 18:32:09 -0400 (EDT)
In-Reply-To: <87bnrzxhrm.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue, 5
	Aug 2014 14:58:29 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 567A4DEE-1CF0-11E4-B25A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254838>

Sergey Organov <sorganov@gmail.com> writes:

> Previous description implicitly favored 'true' value for "pull.rebase"
> and "pull.<branch>.rebase" options,

I do not share that impression.  It is true that 'true' is described
first before 'preserve', which can be argued that it is being
implicitly favoured, but we have to pick one over the other when
describing two things, so I do not see it as a strong preference.

> when for some workflows 'preserve'
> is the right choice, and for others it hardly makes any difference.
> Therefore, 'preserve' should be preferred in general, unless the user
> knows exactly what she is doing.

I doubt we saw any such conclusion in the recent thread that
discussed this, other than your repeating that statement---and I've
learned to tell repeated voices and chorus apart over time ;-).

One approach is more suitable for some workflows while being
inappropriate for others and that goes for both variants.  A
downside of flattening is that it gives a wrong result when the user
wants to keep merges.  Two downsides of preserving are that it gives
a wrong result when the user wants to flatten, and it tends to be
slower.

During that discussion, you seemed to assume that those who want a
flattened end result would never merge locally; I do not think that
is true.  Having your own merges on a branch that you would want to
rebase to flatten is not unusual.

You may employ a workflow to build on separate topic branches while
developing, merge the topics among them that are ready into your
local 'master' to be used personally, and after using it from your
local 'master' for a while to make sure it is solid, you may decide
to make it final by publishing it to the outside world, and at that
point you would want to flatten the history on top of the latest
upstream before pushing.  That's not anything advanced that takes "
the user knows exactly what she is doing."
