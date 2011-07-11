From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/17] revert: Save data for continuing after conflict
 resolution
Date: Mon, 11 Jul 2011 14:01:12 -0700
Message-ID: <7vbox0cz1j.fsf@alter.siamese.dyndns.org>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-12-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 23:01:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgNbX-0003Iq-Th
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 23:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757873Ab1GKVBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 17:01:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49734 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757791Ab1GKVBP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 17:01:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E00576820;
	Mon, 11 Jul 2011 17:01:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+KsSlYq1okV52lD+4bcXemvefRU=; b=wTkWGt
	R/mKnOxr6c6wp1ugmnf1gPs2x2ffjP10kP9mAPdbVkY3hAT3XJHe7N5bM46ffO17
	Ul0T1du3HuaB5lQxLSe7H7Bih8SFVNl0AhMXIAuyp9djF9cYCBEPXK8xXxErc7zS
	qPalInLP9N+AwauZnoxWENv7UK3SYcIvsO2C4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YwGRLvK1AYe/KikWEwpU0O9eUVRsloTo
	XpP3R24wHUjdI7jOBhSUqYn/UwZZJcNgft6RXyCa/4VySTuoS7F/L/zsfvknsReC
	Lx4XKdrvfAsVHPj137pGXETWJj/Ck+NztqvNOjb2ZV5rG3Ycaxn5mGzfUdPXt4Wy
	vzQ/nObs9b0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D92F0681F;
	Mon, 11 Jul 2011 17:01:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 303D6681E; Mon, 11 Jul 2011
 17:01:14 -0400 (EDT)
In-Reply-To: <1310396048-24925-12-git-send-email-artagnon@gmail.com>
 (Ramkumar Ramachandra's message of "Mon, 11 Jul 2011 14:54:02 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9B53C4A-AC00-11E0-BA97-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176892>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +/* Insert into todo_list in same order; commit_list_insert reverses
> + * the order

Style: end the first line of multi-line comment at "/*".

As you say "in same order", you solicit a question "The same as what?".
As you say "insert reverses the order", you sound as if you are
complaining you do not want insert to do so.

And you do not need either of them. The function is "append", and if you
explain it as "append", you do not have to contrast it with "insert".
In other words, starting this comment with

        /*
         * Append a commit at the end of the commit_list.

is perfectly adequate, I think. More useful would be (although it could be
read from the usage example) to help callers what "next" means, perhaps
like:

         * next starts by pointing at the variable that holds the head of
         * the list when the for an empty commit_list, and is updated to
         * point at the "next" field of the last item on the list, as new
         * commits are appended to the list.

> + *
> + * Usage example:
> + *
> + *     struct commit_list *list;
> + *     struct commit_list **next = &list;
> + *
> + *     next = commit_list_append(c1, next);
> + *     next = commit_list_append(c2, next);
> + *     *next = NULL;
> + *     assert(commit_list_count(list) == 2);
> + *     return list;
> + *
> + * Don't forget to NULL-terminate!

I am still not convinced that making it the caller's responsibility to
NULL-terminate the list after it finishes to append is a good trade-off
between run-time performance and ease of API use.  If you are appending
thousands of commits to a commit list in a tight loop, surely you would
save the same thousands of assignment of NULL to the next field of the
element at the tail of the list, which may reduce the instruction count a
tiny bit, but that field was assigned in the last round in that tight loop
and the cacheline would likely to be owned by the CPU already, so it might
not make much practical difference.
