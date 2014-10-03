From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/24] refs.c: pass a list of names to skip to is_refname_available
Date: Fri, 03 Oct 2014 12:05:28 -0700
Message-ID: <xmqqoattkm87.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140911030318.GD18279@google.com> <20141002014817.GS1175@google.com>
	<20141002020332.GB1175@google.com>
	<xmqq61g2nuud.fsf@gitster.dls.corp.google.com>
	<20141003185128.GS1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 21:05:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa8Ag-0000xb-Hg
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 21:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbaJCTFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 15:05:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53570 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbaJCTFe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 15:05:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA4163F09A;
	Fri,  3 Oct 2014 15:05:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pOpCAE4eABD793ytR8rUUgFF8mw=; b=VthWop
	6nLAPDx74DzBYrqZTIj9xaqnmeRT+Q9ekLHTrn4TN2fjJ46c8nXwRgUPD9qU/o7p
	ZQQrRQPZMMVIkHqKzSPhHImK4d3x2lxQFk2wnBGn/dPUBOgc8lBiF+J8iaoUuqOE
	ahg2He5U8IDzNXr4dMxZtQnIO032aBIRIu4A0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BNITkOUe1sR3RJbcw0HP+TTFFvT13u6S
	6x873VdeHbMOoB04EBJZwNsFMZbdsh7qXM63+EnE3bWdbeC89G1tF9oOipwjyYbd
	yOslH4DcMvB4QlEWcOf8rYsxzB+tD7+HWETeeUhqqRPiW24Q21tK9IZPBeJwHdsI
	CqvwU1saR5g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDC363F099;
	Fri,  3 Oct 2014 15:05:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 29D703F08F;
	Fri,  3 Oct 2014 15:05:30 -0400 (EDT)
In-Reply-To: <20141003185128.GS1175@google.com> (Jonathan Nieder's message of
	"Fri, 3 Oct 2014 11:51:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3EC9259E-4B30-11E4-9611-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257846>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
> ...
>> As cbe73331 (refs: speed up is_refname_available, 2014-09-10)
>> touches the same area and is now in 'master', the logic around here
>> in this series needs to be reworked.
>
> Thanks for the heads up.  (I hadn't realized the ref-transaction-1 was
> part of 'master' --- yay!)  Rebased and reworked:
> https://code-review.googlesource.com/1027

Heh, I was sort of expecting that heavy-weight contributors that
throw many and/or large patch series would at least be paying
attention to "What's cooking" reports.

Will take a look over there (I really hate having to context switch
only to review this series, though).

> I'll give a week or so for review comments on this version of the
> series and then post a hopefully final version.

Thanks.
