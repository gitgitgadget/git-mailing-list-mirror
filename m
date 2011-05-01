From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diff: introduce --stat-lines to limit the stat lines
Date: Sun, 01 May 2011 11:33:32 -0700
Message-ID: <7vmxj6s22r.fsf@alter.siamese.dyndns.org>
References: <5f16db0f3730be70ff522e63fbd491dc910c34d0.1304089050.git.git@drmicha.warpmail.net> <7voc3pyqy4.fsf@alter.siamese.dyndns.org> <1304238428.8704.1446945897@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun May 01 20:33:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGbSn-0006le-E6
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 20:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761301Ab1EASdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 14:33:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761286Ab1EASdn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 14:33:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6BB9A4E64;
	Sun,  1 May 2011 14:35:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=dV1ckhN2iby1WEEbJlvbmGNziTw=; b=jGkVstSo2diwSjlHOCoN
	UXjw3f6LqXj0XCONjGBNXi1XLDgYw+m7W8JcVXkbEelFdUzGJ9UXTnTvvz5WNjOn
	/RUeluByEwIrFLzEYEykIn0fG9YWOt+QW4Fb46DEAr1/qNGXmz5EkDIoKcoj9ktf
	VbREQ7BOUJzPhf38Jy5doHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mBweVBxoUF63oEKKfYK/YmiD8gRuJ9yloMbHWCFVctHcBc
	G05F95pFBvLx51vYXFGPySkiEz1wqtiDRYr6t9z87wr6e/VwrMj+1uUcNT3LTZqB
	xF8QOcc3N2nrMLsE6hv9hWNbY7W7eSKvFis2/1SXy0IB8r+75l+cFCZWosSSQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B1B04E63;
	Sun,  1 May 2011 14:35:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3C4864E62; Sun,  1 May 2011
 14:35:37 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D11DF224-7421-11E0-8FE6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172541>

"Michael J Gruber" <git@drmicha.warpmail.net> writes:

> On Fri, 29 Apr 2011 09:15 -0700, "Junio C Hamano" <gitster@pobox.com>
> wrote:
>> Also getting (N+1) "lines" output for specifying N feels very unnatural.
>> 
> It's actually 2*(N+1): The first and last N, plus the "..." line.

Yeah, that was what I meant, but I think my mistake itself demonstrates
how unintuitive "N lines each from the top and the bottom end" is.

It shouldn't be too difficult to divide the number given by the user by 2
and adjust only one end when the given number is even, but I am not sure
if that is worth doing, or if it is even a good idea to have "..." in the
middle to begin with; it would make it harder to notice that the list is
elided than having the marker at the end.

But what problem are you trying to solve?

If it is just you do not want to see a huge list, shouldn't that option
also be controlling how --summary is produced?

> With "count" I would expect to see the first N lines/items. That's even
> simpler to do. Do you think that makes more sense then head+tail?

"Hide noise and show only a few from the top and from the bottom" makes
sense when the items near the top and near the bottom are somehow more
important than the others.  Otherwise, "keep only a few from the top"
should work just as well.

Usually, no single path is more important than the others, and even if
there were a path that is more important than the others, people tend to
arrange so that these more important paths come very early in the natural
sort order (think "00_README"), so in that sense, items near the top could
be more important than items elsewhere, while items near the bottom are
unlikely to have higher nor lower importance than the remainder.

The bottom of a sorted list could become a bit more important than others
in a narrow corner case that we would likely not care: when your change is
only for paths whose names begin with 'a' through 'm', "show only a few
from the top and from the bottom" would let you see that nothing between
'n' and 'z' was touched.  I do not think it is an important piece of
information to convey, though.

I designed merge.log (back then it was merge.summary) to show commits near
the top because the person reading the log would be better served by
seeing up to what change the merge integrated the topic branch.

A typical clean history of a topic branch tends to have necessary but
uninteresting clean-up commits earier and the commits to complete the
feature near the top.  In the context of reading the merge itself, you
care much more about why the merge was done (what the integration tree
wanted out of the topic) than about how the topic progressed.  Seeing the
bottom (i.e. one commit above the fork point) may only be interesting for
the person who is making a merge of his own topic branch, but it is not
very useful for the integrator (the fork point itself may be a useful
thing to know, though) nor for the reader of the history.

But the same "bottom could be a bit more important than others" argument
can apply here, and I wouldn't oppose to a patch to change "merge.log" to
show N-2 top entries, "...", and then a single bottom entry, when merging
more than N+1 commits to your branch.

That approach would probably apply equally well to your --stat-count and
covers the "the bottom is slightly more important than others" issue.  It
would go like this:

 - Show the first N-2 items unconditionally;

 - If you have shown N-2 items already, keep counting without
   showing, and remember the last two items you saw;

 - At the end of the loop,

   - if you didn't discard any and the last ones you remember comes
     immediately after the first N-2 items, just show them;

   - if you skipped any, show "... (%d items omitted)" and then
     show the last item.
