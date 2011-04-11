From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] gitk: show modified files with separate work tree
Date: Mon, 11 Apr 2011 12:15:13 -0700
Message-ID: <7vipukwqf2.fsf@alter.siamese.dyndns.org>
References: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1301969659-19703-9-git-send-email-martin.von.zweigbergk@gmail.com>
 <20110410020318.GB25368@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 21:15:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9MaV-0007JQ-HE
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 21:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764Ab1DKTP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 15:15:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab1DKTP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 15:15:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1210958E9;
	Mon, 11 Apr 2011 15:17:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t4woCRXknqTDfuBu5bxFkVe19+s=; b=v/msGr
	LcDcqoDs/uEMba+ElAmld/ARnhcBod6YplwByXcPiZthh9nG82hBY+aGrSwLRATh
	74HtpTL5wi+ar9ICH+TND/ooQ850MKxbp27UhmJ41FRbCA0mLV2zGg+0RVAKdcAN
	9GhgmvUQOMnsfzQiSDc5IwGbCGoFeg6AiL8DU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H1kLVnravv6z/6nzHbJudDKfh2BV8uy0
	S5wdjziVkCAFdlKdezswa1qSYTYxSrgbCr5pl6DyKaPeBPalxteFNxE6MOP8eCDP
	thHv8aasETtKdS0BmwfYTn3kf/1+kogSP7fp7BmIxExs+QW+CJQbFJHm5q9ULYMe
	1W64ch+IlCE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D403758DF;
	Mon, 11 Apr 2011 15:17:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B479458DE; Mon, 11 Apr 2011
 15:17:13 -0400 (EDT)
In-Reply-To: <20110410020318.GB25368@brick.ozlabs.ibm.com> (Paul Mackerras's
 message of "Sun, 10 Apr 2011 12:03:18 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50EBD9C4-6470-11E0-A011-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171349>

Paul Mackerras <paulus@samba.org> writes:

>> Why do git commands that need a work tree not work under .git?
> ...
> Don't know, ask Junio. :)

Whatever the current behaviour is, I am reasonably sure that it is coming
more from "meh -- who cares such a case?" than "it should work like this
when you are in .git because of such and such reasons".

For example, what does it mean to be able to do this?

	$ edit Makefile
        $ git add Makefile
        $ edit Makefile
	$ cd .git
        $ git grep frotz Makefile

Perhaps the last step needs to be

	$ git grep frotz ../Makefile

instead, but a more important point is, how would that be useful?

If you have both GIT_DIR and GIT_WORK_TREE set up to point at the correct
places, I think it is sensible to make the above (the "../Makefile"
version, not the one without dot-dot) work as expected.

I suspect (but would not bother to dig the history myself to find out)
that "we require a working tree" semantics that in fact often means "we
require you to be in the working tree" was a misdesign that did not matter
that came from the days back when GIT_WORK_TREE was not either present or
not widely used.  Now more people seem to be using GIT_WORK_TREE for some
reason, I don't have anything against a patch series that defines and
implements a more desirable behaviour clearly.

Thanks.
