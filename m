From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Wed, 03 Dec 2014 12:02:30 -0800
Message-ID: <xmqqr3wgh57t.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com> <20141203051344.GM6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 21:02:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwG8D-0001xR-BU
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 21:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbaLCUCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 15:02:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750862AbaLCUCc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 15:02:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CDD502469E;
	Wed,  3 Dec 2014 15:02:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=axu3zUzVyAKyu4iY2JO4/Cjxt7g=; b=Nln/SZ
	Yzs8G/Kv2twcz0pEquYPnPS9FG23stEL34ehlEDjSpMfwSPHTUPPypTx1MaiMHWI
	D9q63BQUq6FPYmJhhThzdHXUJySktByW8ePl6SQVUZuEIsajWtPvgZxljHyxVBIW
	T6kAyFriBaYzbOurloBOmCqzEs18MMkq7BCew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fGUYvT56AyrHdyvsNpNBcFJijbZNg0l0
	BGlD6lxg9TCJ6CfBhDhLss8f0UCltxn1nTKjNsmbppka/0R08YR9dpAVgIryaIGg
	J1ZuKT5+TmJZR25jeDtrH9UjlONjZLRlybJyw7bBHcqJj6tV8jj//MidnHKK8Yqu
	ynUl2OyqgBU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C50B92469D;
	Wed,  3 Dec 2014 15:02:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B9102469C;
	Wed,  3 Dec 2014 15:02:31 -0500 (EST)
In-Reply-To: <20141203051344.GM6527@google.com> (Jonathan Nieder's message of
	"Tue, 2 Dec 2014 21:13:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 508CEB4A-7B27-11E4-BEB9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260683>

Jonathan Nieder <jrnieder@gmail.com> writes:

> This way, callers can put the message in context or even avoid
> printing the message altogether.
>
> Currently hold_lock_file_for_append tries to save errno in order to
> produce a meaningful message about the failure and tries to print a
> second message using errno.  Unfortunately the errno it uses is not
> meaningful because copy_fd makes no effort to set a meaningful errno
> value.  This change is preparation for simplifying the
> hold_lock_file_for_append behavior.
>
> No user-visible change intended yet.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> The title feature.

By the way, this seems to address the same thing as sb/copy-fd-errno
topic that has been cooking in 'pu'?  Should we drop that other
topic and use this one instead?
