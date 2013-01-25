From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] mergetool--lib: Improve show_tool_help() output
Date: Fri, 25 Jan 2013 13:47:59 -0800
Message-ID: <7vbocd2auo.fsf@alter.siamese.dyndns.org>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
 <1359107034-14606-8-git-send-email-davvid@gmail.com>
 <20130125195446.GA7498@serenity.lan> <20130125200807.GB7498@serenity.lan>
 <7vpq0t2f2t.fsf@alter.siamese.dyndns.org>
 <20130125204619.GC7498@serenity.lan>
 <7vlibh2d8a.fsf@alter.siamese.dyndns.org>
 <20130125211601.GD7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 25 22:48:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyr8O-0007X4-7h
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 22:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab3AYVsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 16:48:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab3AYVsF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 16:48:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6015B6B3;
	Fri, 25 Jan 2013 16:48:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3ioHnvCnSgrblZdN7gx5iv9Ic8U=; b=XHMf9u
	ztnGUOsAO1nqhrgdcNdx3FA/3t55/43nXciUtezgvA2s7wYGxXw0pX2vj9gXjazr
	Ov5/7+9LkHD9OFlYnpYv6t88WPnBZzEJa6mDVWLzTUrMKMOVqbO9q0hBEfmb1YUd
	QHd6w9Z/VCKj9gckb1S4j5x1aKrhEso66X03U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xT7OvTboawB/J30evyUgyIblgDVh4nBQ
	u4e6UKF7DhfTeb+4l1fO330uwF9fGi0FULKeI82xWb38GAzw7igiS4eKej6UuzpT
	BjfJbD/ykuCdqS5XC/2Xg+5uj1zLo7/ZsO4iXSaj8HsTmmoVJqXnCzJF3LNby/GG
	+vQLURPSjgg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E7F0B6B1;
	Fri, 25 Jan 2013 16:48:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50368B6AE; Fri, 25 Jan 2013
 16:48:01 -0500 (EST)
In-Reply-To: <20130125211601.GD7498@serenity.lan> (John Keeping's message of
 "Fri, 25 Jan 2013 21:16:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3DE7508-6738-11E2-AAC0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214585>

John Keeping <john@keeping.me.uk> writes:

>> > It doesn't - the "|| continue" is to catch errors from setup_tool.
>> 
>> Ugh.
>
> Is that targeted at my suggestion at the top of this email or calling
> exit in setup_tool?

At the fact that you had to go a convoluted route because you cannot
just run setup_tool in subshell and do translate_merge_tool_path
after that, because the latter needs to look at the shell variable
the former sets.

> With the patch above, the block of code at the top becomes:
>
>  	test "$tool" = defaults && continue
>
>  	setup_tool "$tool" 2>/dev/null || continue
>  	merge_tool_path=$(translate_merge_tool_path "$tool")
>
> which IMHO is pretty readable.

Of course it is.  The current callers of setup_tool may need some
adjustments, but that should be fairly trivial, I hope.
