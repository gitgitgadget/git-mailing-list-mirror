From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to fork a file (git cp ?)
Date: Wed, 04 May 2011 14:02:44 -0700
Message-ID: <7viptqdvrf.fsf@alter.siamese.dyndns.org>
References: <4DC1934D.6070608@aldan.algebra.com> <4DC19955.7040503@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Mikhail T." <mi+thun@aldan.algebra.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed May 04 23:03:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHjDs-0006Y7-6a
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 23:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab1EDVC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 17:02:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab1EDVC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 17:02:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5579643F0;
	Wed,  4 May 2011 17:04:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bjkwCqHYIhH0GP0F/FasY7qL9ME=; b=bxBmud
	SOQTVbURXg/EQwikTED0dGb7bjC15Qkhj+fJrvg56umzD2iJ8wmKrkRyu/wgjdTq
	K+cK5Y4KqadfQhftk1qsoYpNsNp7VVFnmUdy18xYcHI1e/FJtlnbSPOpyAaIJO6i
	HXDgV8+zscEt8OOEPLLNlZeic5ln9ebgJHnz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=imsv8PSwOSTeU5y1qER/MzomDB37Nr0h
	7FGBzyxl1nCMIeazq6EbU96KVBqWB2+cZu7uQlYv6Rx8Or+t/Q2xXtAf/FP9WCym
	ANN7tgnLA8Pe635el7btB1/J+/cFY8cjiKVvEIRLgZCKBLYruOaVHABc9u92QtOZ
	bJ5bXglLmVE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 236D043EF;
	Wed,  4 May 2011 17:04:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EF93343EE; Wed,  4 May 2011
 17:04:50 -0400 (EDT)
In-Reply-To: <4DC19955.7040503@kdbg.org> (Johannes Sixt's message of "Wed, 04
 May 2011 20:22:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2942B45E-7692-11E0-95B1-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172768>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 04.05.2011 19:56, schrieb Mikhail T.:
>> I need to add a new thing to our project. The thing will be similar to
>> what already exists. I'd like to "derive" the new files from the
>> existing ones -- without altering them and by preserving the
>> change-history.
>
> You cannot. Git does not have such a thing as "copy-with-preserved-history".

Well, if you come from the mindset that a "file" has an identity (hence
there is a distinction between "This file used to be called A and at one
point was renamed to B which is the name we see today" and "Some time ago
somebody created a file B with the same contents as A and then removed A
at the same time"), "copy" would not make much sense.  What identity does
a new file B gets when you create it by copying from A?

The same identity, or a different one?  What happens when you later
refactor the redundant part from these two files to create a common third
file C?  What identity does C have?

> You just cp the file and git add it. But you will not be able to follow
> a history of the file.

Correct.  You cannot follow a history of _the file_, as there is no such
thing.

You can still follow the history of contents, though.  If you did a
refactor like the one in the above example, "blame -L <range>" would
follow the contents just fine.  The command is a 80% satisfactory
implementation of Linus's grand vision expressed in one of the most
important message in the git mailing list archive:

    http://thread.gmane.org/gmane.comp.version-control.git/27/focus=217
