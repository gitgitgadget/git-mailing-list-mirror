From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: handle lines containing only whitespace better
Date: Wed, 20 Oct 2010 09:08:49 -0700
Message-ID: <7v4ocgx2we.fsf@alter.siamese.dyndns.org>
References: <1287549978-54280-1-git-send-email-kevin@sb.org>
 <7vzku9wfrp.fsf@alter.siamese.dyndns.org>
 <780B144B-03E0-4ED5-8E92-D4EB3CBBBF71@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Oct 20 18:09:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8bDt-0007SP-Re
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 18:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943Ab0JTQI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 12:08:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab0JTQI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 12:08:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E2DAE05A0;
	Wed, 20 Oct 2010 12:08:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7byQm8L5lt41VLbBxhv8NJbmzW0=; b=wCwQFH
	uE3vBY1xTdoatazrrgem5eVzTewPwoZesjhSV9OhUr+VH9L77cf34D47IXSvkQRb
	pu+J0FnJDV3LL9bbxkNGWRiCH7vEuKFjr63o6Nrifg1svmXzGaS9N/Lqnhrw9B4M
	PAiLBEr8U11zRrXqToznM/fCvT7f+6jzyTFj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mou+M2yn5jx0hclQeNHF/Jjo4OzGbgrs
	YaTcHGv5w2CH933eNPuBntzmQY8UO5bV0AKwt/nRJ7D9Rqc01M46RU4fdpzSbnpf
	iAVDE9SZEdYbyuUTGRb8hK99WJrD7rkW78M3yVVdJ8zws0iCrwAPdhwuoYfgBz0p
	XVWMhCD5JOQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE97AE059F;
	Wed, 20 Oct 2010 12:08:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CCB5E059E; Wed, 20 Oct
 2010 12:08:51 -0400 (EDT)
In-Reply-To: <780B144B-03E0-4ED5-8E92-D4EB3CBBBF71@sb.org> (Kevin Ballard's
 message of "Tue\, 19 Oct 2010 23\:38\:41 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 55CE9466-DC64-11DF-914D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159414>

Kevin Ballard <kevin@sb.org> writes:

> Incidentally, I just realized the description of the patch is slightly
> wrong. The problem only occurs when the line contains at least one
> tab...

That exactly is why I asked for tests, as I couldn't reproduce it from the
description at all.

But I see it now.

	$ HT='   '
	$ mv Makefile Makefile+
        $ sed -e "3s/^.*/$HT/" Makefile+ >Makefile
        $ git diff --color

> ...Should I resend the patch with an updated description? I can also
> attempt to write tests if you can give me some guidance on how to deal
> with the need for ansi color codes.

This may show us a good starting point.

    $ git grep RED t/
