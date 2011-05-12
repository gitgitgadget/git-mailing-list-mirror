From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Exit code of git-ls-remote
Date: Thu, 12 May 2011 09:21:30 -0700
Message-ID: <7voc37dh4l.fsf@alter.siamese.dyndns.org>
References: <20110512120536.GA22033@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Thu May 12 18:21:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKYdz-0005IQ-9s
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 18:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757971Ab1ELQVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 12:21:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757939Ab1ELQVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 12:21:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 27CEB4A9F;
	Thu, 12 May 2011 12:23:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wwGe82lWNUOVbdCy4n2td7OAfDQ=; b=CZs9XY
	aEWlR9OdHIZePU80UuzjOU3k9/qD241PKCqDsHkKEzEwGxdGwDT7R5GjTmohJh+k
	gfymtI0R77RgEjq6Kl0x3X+Gbk3FPt6nMIfwakSjuOqrTQKwl+gfyVLdspAYwhtB
	oc5Ab2j92Dvy/ptbrKUhCeoTAMor7LZev6PWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WTGVUaVhcvst6uQu4pQIcOJ8/2cuj5mm
	gzOnmtYpShFlk5p2wnV+MnENpjiN9WBcmjUf8CeCXIad+n2vZ6hm3omMzROlR2Lg
	2ChJlXJJO1W5nKSAQWWplNQm+4N4IdaZnFXXkmcf77UWaYRT69JuK+Q+EKWEshsN
	C6pprlmTtFA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 051AE4A9D;
	Thu, 12 May 2011 12:23:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ECF244A9C; Thu, 12 May 2011
 12:23:36 -0400 (EDT)
In-Reply-To: <20110512120536.GA22033@camk.edu.pl> (Kacper Kornet's message of
 "Thu, 12 May 2011 14:05:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 322CE90E-7CB4-11E0-9436-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173480>

Kacper Kornet <draenog@pld-linux.org> writes:

> git-ls-remote behaves differently then git-show-ref when it cannot find
> any matching refs. While the latter returns non zero exit code in this
> case, the former always returns 0. Is there any specific reason for this
> behaviour?

There is no specific reason other than "they happened to be implemented
like so".  These commands have always behaved that way and people are
relying on their exit status, so unless there is a compelling reason, they
will not change.

It is just a matter of opinion to consider that it is an error condition
or just a normal case to see an empty set for a "List 'em and filter with
these criteria" request. Outside git, "find /there -name no-such-file"
exits with zero status, while "grep no-such-pattern file" exits with
non-zero status.

You can rely on your knowledge of the commands and write your tests like
this:

	test $(git ls-remote $there $pattern | wc -l) != 0 || die "none"
	git show-ref -q $pattern || die "none"

Alternatively, you can defend yourself against the next person who asks
the same question by writing the last one as:

	test $(git show-ref $pattern | wc -l) != 0 || die "none"

Either would work.
