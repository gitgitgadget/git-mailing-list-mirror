From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git fetch one tag only
Date: Wed, 06 Jun 2012 22:33:30 -0700
Message-ID: <7vpq9bk7o5.fsf@alter.siamese.dyndns.org>
References: <CAH5vBdK_M+7Hjk=juVeP7Phqvs2+npknFD-=45OVR032k5S-0A@mail.gmail.com>
 <CAPc5daVwOuP_dPiHh5zcjV6kTvdb2FNhzXz_capEDhHgE5ZUKw@mail.gmail.com>
 <CAH5vBdKPH_-cn=r-zxQKCOi5PB5D6vuSXrZxPeZJ+HYg-K9Yqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: cheng renquan <crquan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 07:33:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScVLm-0008AX-Mz
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 07:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402Ab2FGFdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 01:33:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47369 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753661Ab2FGFdc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 01:33:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DF5A9C93;
	Thu,  7 Jun 2012 01:33:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tI8AOaBgUybv4KZpZES7l3gqun8=; b=T2QVm6
	f7x79/KduTacXI6ar6ek2mRxLxdmoPvgJL//q/fX/nk8074tafxTvfogqkHxbzJZ
	yaJwlOF7IC2sJQmQXMKxSeE+Lu+1a9c2L6qM/3OQW2p9kb5mDMpsqIApEBanmf7M
	3n+cuD6TtCOpEnNFhe6fhPxTE38UUEGUbEuSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h0iiJgSF3fHSBu469vtUWxpCndbo6kXY
	+r/YHOZbse8HxUJulcGKV3gJgJMKxPF1XgVhFcE3LIC3u6HRnNC8NX5DAPgapkH8
	Fo8zLubV7n4EZfFwuRZefuInsge6fLb9RRFqdkICedtzaCGf9ZJSxgk8ClCB5V5m
	v8FZB+Q0z5E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 443169C92;
	Thu,  7 Jun 2012 01:33:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A50169C91; Thu,  7 Jun 2012
 01:33:31 -0400 (EDT)
In-Reply-To: <CAH5vBdKPH_-cn=r-zxQKCOi5PB5D6vuSXrZxPeZJ+HYg-K9Yqw@mail.gmail.com> (cheng
 renquan's message of "Wed, 6 Jun 2012 22:17:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5167BB18-B062-11E1-85D4-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199371>

cheng renquan <crquan@gmail.com> writes:

>> There is a convenience short-hand "tag <tagname>", i.e.
>>
>>  git fetch 3rd-repo tag the-tag-name
>>
>> that is equivalent to
>>
>>  git fetch 3rd-repo refs/tags/the-tag-name:refs/tags/the-tag-name
>>
>> So I do not think your patch is necessary for your use case, and
>> obviously it will break other people's use case where they just
>> want to fetch (and inspect what is left in FETCH_HEAD) but do not
>> want to store.
>
> No, I tried what you said but it doesn't work as expected:
> ...
> [linus-git] $ git fetch -v --dry-run linux-stable tag v3.4.1 |& head
> From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable
>  = [up to date]      v3.4.1     -> v3.4.1
>  * [new tag]         latest     -> latest
>  * [new tag]         v2.6.12.1  -> v2.6.12.1
>  * [new tag]         v2.6.12.2  -> v2.6.12.2
> [...]
> maybe I'd better to fix that?

Ahh, that is auto-following of tags.  Read up on that in "git fetch"
manual page, and there is an option to decline auto-following also
described.

The (current) rule is to grab all tags that reference commits you
are fetching *IF* you are storing any refs resulting from the fetch
in your refs/ namespace, and "tag v3.4.1" obviously asks for storing
that tag at refs/tags/v3.4.1 in your repository, so it is expected
that the auto-following kicks in.

It is a separate matter if we should add some special case to further
reduce the cases where auto-following happens. I personally do not
think any change is needed.
