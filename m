From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is misleading
Date: Thu, 08 May 2014 15:31:15 -0700
Message-ID: <xmqqlhub298s.fsf@gitster.dls.corp.google.com>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
	<20140508213806.GA19464@serenity.lan>
	<xmqqvbtg0w65.fsf@gitster.dls.corp.google.com>
	<20140508221024.GB19464@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri May 09 00:31:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiWqb-0002fQ-AU
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 00:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbaEHWbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 18:31:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50088 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753994AbaEHWbU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 18:31:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B2E2F1592A;
	Thu,  8 May 2014 18:31:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ljhn/DWk0mk63E6vDcIlpwBzkQM=; b=vNkyhQ
	U3R0AsECP8AYC9ShjizePNQjcU3XA2GrptDQ35wGfiC8PuyjIV/yh+gI6Zi/fztj
	JOWTaHBH1EGTcpbzw3m8xYKGXuVTzg5NLr95bXgCertqzXG6Iya0VPX+BT0bIv0R
	CSszKteDQgn6AFlfJ4NYjtEiA9zkWKkcoNkO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QqbPkKIxz9rw60ZQA6NvjWzkbigdwzeg
	FEjLfYQW+QmAXMqyoLTFokDnfnJTp1nHwm2PGirZGzAhJa/epiRTHAdcOjcyY4kU
	SKTuKmBwZEwwMDYYDOyJtWqzRZVkc0GDoAU8Pk4/F9sauM9VCPB1OeyUVssbMvYH
	7ZSPAxWzDgk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A885E15928;
	Thu,  8 May 2014 18:31:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F356615926;
	Thu,  8 May 2014 18:31:16 -0400 (EDT)
In-Reply-To: <20140508221024.GB19464@serenity.lan> (John Keeping's message of
	"Thu, 8 May 2014 23:10:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7855480A-D700-11E3-8887-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248458>

John Keeping <john@keeping.me.uk> writes:

> Yes, it's marking it as a boundary but I'm not convinced that's correct.
> Compare these two cases:
>
> $ git blame Makefile | head -5
> 7a3fc144 (John Keeping      2013-12-26 17:37:53 +0000   1) REL_VERSION = v0.2
> 5c9829f9 (John Keeping      2013-07-29 17:03:26 +0100   2) 
> 5c9829f9 (John Keeping      2013-07-29 17:03:26 +0100   3) # The default target is...
> ^f7fae99 (John Keeping      2013-03-24 17:14:40 +0000   4) all::
> ^f7fae99 (John Keeping      2013-03-24 17:14:40 +0000   5) 
>
> $ git blame ^5c9829f9 Makefile | head -5
> 7a3fc144 (John Keeping      2013-12-26 17:37:53 +0000   1) REL_VERSION = v0.2
> ^5c9829f (John Keeping      2013-07-29 17:03:26 +0100   2) 
> ^5c9829f (John Keeping      2013-07-29 17:03:26 +0100   3) # The default target is...
> ^5c9829f (John Keeping      2013-07-29 17:03:26 +0100   4) all::
> ^5c9829f (John Keeping      2013-07-29 17:03:26 +0100   5) 
>
>
> While it might be useful to mark the initial commit, the current output
> seems to mean that lines 4 and 5 existed before the repository was
> created.  If you consider blame's output to mean "introduced by commit"
> then those lines should simply blame to the initial commit.

You may be onto something, but I am not sure.  Let me, as you told
me to, compare these two outputs.

The first says "At f7fae99, these lines were already there, and we
are not showing anything before that state."  The second says
exactly the same thing but with f7fae99 replaced with 5c9829f.

It is debatable if a root commit is *that* special to be shown
differently from an in-between commit that introduced a change, and
for consistency, I tend to agree with you that it may be better if
roots weren't marked with the "^" prefix.
