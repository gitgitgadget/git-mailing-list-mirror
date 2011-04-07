From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: replace each tab with 8 spaces for consistency
Date: Thu, 07 Apr 2011 11:45:24 -0700
Message-ID: <7v1v1dgat7.fsf@alter.siamese.dyndns.org>
References: <1302156081-3286-1-git-send-email-andrew@andrewgarber.com>
 <7vhbaafr7r.fsf@alter.siamese.dyndns.org> <4D9DE7E4.1030808@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 20:45:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7uD5-00085Q-KH
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 20:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543Ab1DGSpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 14:45:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756297Ab1DGSpd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 14:45:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F116B5ADF;
	Thu,  7 Apr 2011 14:47:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b5COEjltxNqYqRqVIyRufNcyg0E=; b=SDsVK/
	pu7pBUTR1K+FfzDnJRDeuBAAF4hxrYlJS0jg9LhrKHOq5x6AwZiztueesrao2Dch
	OkT4nDPIJxjFnFdeKCAjfFU4uiWAgIDMbG4JapguPXnYBcmAY06tinqjZlsymKZ/
	lg/az3A8IW/n/wWU3F4csyKqQ4bkdQfEKcKKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kAh+McB/yvy25kLNAWJ1RFmYjzJnBcXP
	Ys6iAQMalbTdVIvkgcSrSkEANzoD0qn84yhgW6D72JfkSSFURBtOIz06IgGWRyZ4
	uNqha8+FGTs2X4/1veI1A50eORbULMthIjB0R2hnaUDIqZIEqrVxDelrXKypjOEc
	F8Mj1ZZn3Cg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CCB5B5ADE;
	Thu,  7 Apr 2011 14:47:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F1AFF5ADD; Thu,  7 Apr 2011
 14:47:19 -0400 (EDT)
In-Reply-To: <4D9DE7E4.1030808@cisco.com> (Phil Hord's message of "Thu, 07
 Apr 2011 12:35:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79583D20-6147-11E0-8B11-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171070>

Phil Hord <hordp@cisco.com> writes:

> This is what I want:
>
>    git fix-whitespace             # fix new ws errors in workdir
>    git fix-whitespace --all       # fix all ws errors in workdir
>    git fix-whitespace foo         # fix new ws errors since foo
>    git fix-whitespace --cached    # fix new ws errors in the index
>    etc.

If you understood the example I gave, you should be able to figure all of
these out.  In the most general case, you would come up with a way to
generate a diff that represents the change you want to fix (e.g. "new
errors" would be comparing the HEAD and the working tree), reverse apply
the diff and then forward apply the same diff with --whitespace=fix, but
often you can omit "reverse apply the diff" step by finding an appropriate
combination between HEAD/index/working tree.

I long time wrote this alias

[alias]
        wsadd = "!sh -c 'git diff -- \"$@\" | git apply --cached --whitespace=fix;\
                git co -- ${1-.} \"$@\"' -"

that acts as if you are saying "git add $path" while fixing the whitespace
errors I introduced in the working tree version.
