From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/2] custom format for interactive rebase todo
Date: Tue, 09 Sep 2014 09:58:13 -0700
Message-ID: <xmqqtx4gloii.fsf@gitster.dls.corp.google.com>
References: <864mwhi9qu.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Clifford <mr.william.clifford@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 18:58:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XROkK-0001Wq-Bq
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 18:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757417AbaIIQ6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 12:58:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54669 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757401AbaIIQ6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 12:58:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B186537597;
	Tue,  9 Sep 2014 12:58:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sOBS4N6GuSpab408FsgxxqRl6Oc=; b=GgUG4A
	kXkcm7GWZptA2ZdhWGZu/Uirde6dxoMOg40nhvU3Bey8in4qxKarycCr1dhVqvjV
	jrjNTC6YT4TzlH46KdtiTN8jnklQBMJ/CX9KV0zAvPlG+dMBV7Hinv3RQ8RUjqk/
	W0Ss3wtwRz1z8YT0TBKypbwFqEc4eQ8FI5O4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LTSe0p7ulR6eHbDvZDRCSjR+1Bop8eiq
	8IvRhKo28wiI+yy2mVC1fjb2scdes/uc9zqtacq19TdBMaUk/NgWp8/jzOGdrC1k
	Ji0/lvnhKjbxS6RxETiPh312ok9P77ahLfFFczctTnqfWCg5RL231pqfwv09MqkF
	jrVzqy3Q2XY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A58BC37596;
	Tue,  9 Sep 2014 12:58:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0D37637595;
	Tue,  9 Sep 2014 12:58:14 -0400 (EDT)
In-Reply-To: <864mwhi9qu.fsf@gmail.com> (William Clifford's message of "Mon, 8
	Sep 2014 21:47:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7D63B18A-3842-11E4-A6E0-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256693>

William Clifford <mr.william.clifford@gmail.com> writes:

> A couple of examples:
>
> - `git config sequence.format "%<(12,trunc)%ae %s"`
> - `git config sequence.format "%s <%aN %aE>"`
> - `git config sequence.format "%s%n%%n%b"`
> ... I'm unsure what would happen if I tried to rebase with the
> third style unedited or uncommented.

It should be simply forbidden.  The body part may have a line that
is similar enough (i.e. starting with one of the command words and
then a hexadecimal string) to confuse the sequencing machinery.

Other than that safety issue, I am not fundamentally opposed to the
idea.

As to the implementation in 1/2, your unconditional use of ">%h" is
wrong (you would end up including the commits from the left side).

Use '%m' instead of a hardcoded '>', perhaps?
