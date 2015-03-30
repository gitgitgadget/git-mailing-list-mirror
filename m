From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/4] Add "-" as @{-1} support for the rev-parse command
Date: Mon, 30 Mar 2015 12:46:56 -0700
Message-ID: <xmqqy4mew9n3.fsf@gitster.dls.corp.google.com>
References: <1427737315-7229-1-git-send-email-kenny.lee28@gmail.com>
	<1427737315-7229-2-git-send-email-kenny.lee28@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 21:47:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcfeJ-0006du-Sb
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 21:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbbC3Tq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 15:46:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752679AbbC3Tq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 15:46:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7565344F56;
	Mon, 30 Mar 2015 15:46:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BhvjEa1Hh2xfkNhC4rDhimLm7ig=; b=fMKdsc
	rnIB1UJJ4vzNj5WHbyR6z2c61b484+BrH1DXW/hbja7sLc3ZQvJFQg77+AamY5ow
	ai/KLQc/H+pQ1G29U6wBXB7AZvX9atmUPp6Yo9ICc+YcfLUlIpMBqVhkqjOYasdq
	leqOpVfRDAw+fBv2suHm/ftqc2VeMlbIC8ELo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IWlrp8NdcLoXPDDjyT2OMXxMZ/898rB3
	xjv+25G6ayZ3wUSwl9L9qoDzQhDA7YtKkNhN45FWroG0DC/hOio9gyp5lvmoK6+i
	X3U6lj6Umrpp73kg9DhzaRFI1NTQjOX5HiUWbPVrc4zZXHZBAFO4oW1EhEG8Cxd7
	VUehAoWDeic=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EA6E44F55;
	Mon, 30 Mar 2015 15:46:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7F3C44F53;
	Mon, 30 Mar 2015 15:46:57 -0400 (EDT)
In-Reply-To: <1427737315-7229-2-git-send-email-kenny.lee28@gmail.com> (Kenny
	Lee Sin Cheong's message of "Mon, 30 Mar 2015 13:41:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 868CE44E-D715-11E4-8C61-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266470>

Kenny Lee Sin Cheong <kenny.lee28@gmail.com> writes:

> Allows the use of the "-" shorthand notation, including
> use with revision ranges. If we plan to allow "-" as a stand in every
> where a revision is allowed, then "-" would also need to be usable in
> plumbing commands, for writing tests, for example.
>
> Checks if the argument can be interpreted as a revision range first
> before checking for flags. This saves us from having to check that
> something that begins with "-" does not get checked as a possible flag.

Doesn't that mean -<something> that is a valid flag can no longer be
recognised as a flag if the same string can be an extended SHA-1
whose formulation starts from "the previous branch"?  It sounds like
a regression to me.

Hmmm.

After all, "we often call for the previous branch, so let's give a
short-and-sweet '-' as an even shorter short-hand than '@{-1}'" and
"allow '-' anywhere" are two quite different things.  We may do "git
checkout -" very often to go back to what we were working on, but I
do not think "git log -.." or "git log ..-" are something we want to
do very often.

I think what I am saying is that it may be perfectly fine if we said
"'-' can be used for '@{-1}' only by itself; no ranges, no
parent-traversals, no other uses", if it makes it less likely for
mistakes and confusions to happen.
