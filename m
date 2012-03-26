From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] grep: add more information to hunk separators
Date: Sun, 25 Mar 2012 22:14:05 -0700
Message-ID: <7vr4wgq6zm.fsf@alter.siamese.dyndns.org>
References: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 07:14:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SC2Fz-0001mG-3e
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 07:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab2CZFOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 01:14:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64724 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874Ab2CZFOI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 01:14:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C6B774D0;
	Mon, 26 Mar 2012 01:14:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jz4a61UsG73EXrTO5ZXA2fQEBUI=; b=A7oTqJ
	cRSKJQkHeOisztYLq+qMzrr3LQIyTG0CVXTssSVDoy4DI94FfIu3oOpcCIE5hlb5
	WyjQC+926jc30/IS5XsI4g9YtVHTYrI5hQSh6UmU5akrzLvIZYIE0pjEtv6KxR9F
	wJaBNTevF7MbSShI1Tj3sikfQNj8KOEEOiot8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uk8k/jG0VbThKqdPLzTNH3Du2F+IaOEC
	4sECm62Zsdim/lTcUWfshWiZLUmpmbwoXUGm8sd1s8i5ewfhnSQ7T6eHHYCi3dz5
	7YFSOhtz20XdudnDxjhVchLkhfteWMi6O5wS48LRYzjVaepDl0bAzX04ZXHA241N
	y4z8jQdyW4Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AFCB74CF;
	Mon, 26 Mar 2012 01:14:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99B9374CE; Mon, 26 Mar 2012
 01:14:06 -0400 (EDT)
In-Reply-To: <1332729705-9283-1-git-send-email-lodatom@gmail.com> (Mark
 Lodato's message of "Sun, 25 Mar 2012 22:41:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82D41320-7702-11E1-AEDE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193898>

Mark Lodato <lodatom@gmail.com> writes:

> Originally, I had envisioned also moving the function name (`-p') to the hunk
> header, similar to the diff context line.  For example:
>
>     -- git.c:570 -- int main(int argc, char argv)
>                     printf("usage: %s\n\n", git_usage_string);
>                     list_common_cmds_help();
>                     printf("\n%s\n", git_more_info_string);
>
> After implementing this feature, I was not happy with the result and
> subsequently removed it.  To me, the output was too cluttered and the line
> number was ambigous.  For example, in the above, it is not obvious to me that
> line 570 is the "printf" line and not the "int main" line.  Still, if you
> would like to see the patch to implement this feature, please let me know.

The worst part of all of the above is that the output becomes utterly
ambiguous and the reader cannot tell if "-- git.c..." came because the
file had such a line that begin with two dashes in it and grep found it,
or it is your output format embellishment. It is obvious that these are
not meant to be machine parseable, but if the goal is to make the output
more useful to the humans, then it may be a better approach to come up
with a front end that reads our machine readable output and shows output
with its own embellishments. You could even make it an interactive front
end.

In other words, I am not yet convinced this belongs to "git grep" proper.
