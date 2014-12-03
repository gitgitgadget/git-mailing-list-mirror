From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Wed, 03 Dec 2014 11:01:08 -0800
Message-ID: <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
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
X-From: git-owner@vger.kernel.org Wed Dec 03 20:01:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwFAq-00023B-9Y
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 20:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbaLCTBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 14:01:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750798AbaLCTBL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 14:01:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5906C23831;
	Wed,  3 Dec 2014 14:01:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S5EK80bFwVM5jIbXsMfqEKoPT4s=; b=X1VQdy
	GCyeWeePnnH7zyu2Z4TqrbdYhpBF74MTmglDwrnpvC987+kHhU6u2sUDwa8yQt9n
	HC/FeKthacWByvT39iQM+RLVjbi/M8mz16Bn/GN/GFYZeOVFYUBJQUuanLGKjMXr
	pA3LYBVMwcrV1Ju1V1uzN/PY3aMI9CR0CkEvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E70OdqQkyg7ykNip9fMPlJjK5zZ5sh/t
	hNPSJeAPOJ5VpCGE1d46sn0h9xW6/zIaOh7rPu4hWoE4JdTlQ+vYYPSWwL7Hs+59
	xDgiUnlV17NsEPuM7C4b8IN0qJuoSx2gtN1aHvJapBGRZkm7fX1rirkqF95f2uaG
	ePlapMKM39M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 458B023830;
	Wed,  3 Dec 2014 14:01:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAB632382E;
	Wed,  3 Dec 2014 14:01:09 -0500 (EST)
In-Reply-To: <20141203051344.GM6527@google.com> (Jonathan Nieder's message of
	"Tue, 2 Dec 2014 21:13:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BE220E1E-7B1E-11E4-9DF5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260680>

Jonathan Nieder <jrnieder@gmail.com> writes:

> -extern int copy_fd(int ifd, int ofd);
> +extern int copy_fd(int ifd, int ofd, struct strbuf *err);

It is not limited to this single function, but what contract do we
envision this "error messages are given back to the caller via
strbuf" convention should give between the callers and the callee?

For example, is it a bug in the callee to touch "err" when there is
no error to report?  Another example is if we should allow the
callers to pass NULL there when they do not care about the nature of
the error (e.g. "git cmd -q").

There may be other rules we want to enforce consistently across
functions that adopt this convention.

The change in this patch looks sensible.

Thanks.
