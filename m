From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Supporting .git/hooks/$NAME.d/* && /etc/git/hooks/$NAME.d/*
Date: Tue, 26 Apr 2016 14:52:02 -0700
Message-ID: <xmqq60v4don1.fsf@gitster.mtv.corp.google.com>
References: <CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBrL_PiEQyLmCzLUVxg@mail.gmail.com>
	<xmqq4mapmvjq.fsf@gitster.mtv.corp.google.com>
	<CACBZZX6AYBYeb5S4nEBhYbx1r=icJ81JGYBx5=H4wacPhHjFbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 23:52:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avAtx-0005LN-PK
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 23:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbcDZVwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 17:52:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752344AbcDZVwH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 17:52:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 05903161E0;
	Tue, 26 Apr 2016 17:52:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=09ODDdnf4l1O
	0/7pppWCboQyCj0=; b=pMwSw3QFiVOlzPWam/wxptXRul1K47N7KL7BpYhjp9aO
	Nmfwle8qeUjYiOUGXSrpGL4kJKROCJV83ok6ZBwtWx+HsC7dqFqtxNUSTsRTPWoh
	P9HO9aioL/ceAuRFP27oh1/SG273ASWpvmmZ4bkRFjC+9ix8dqkskYk7pULtNFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hadYUU
	vYUvkcGCd1Phte3sKoUAsYd08Gi/CG5G297qhT7locL5njVaNJyGq8kI8chv0aIn
	EIhz88oDP+HGfEEJcHiqdXBBv8ZwYNSyH5Rf/QjiMBQ6ZDusYjNYhT/nEJPKK46T
	Z4Onef+7nFBMBNFYKC0Dl93qSwnMiYo7B39Ig=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F1627161DF;
	Tue, 26 Apr 2016 17:52:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 319DE161DE;
	Tue, 26 Apr 2016 17:52:04 -0400 (EDT)
In-Reply-To: <CACBZZX6AYBYeb5S4nEBhYbx1r=icJ81JGYBx5=H4wacPhHjFbQ@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 26 Apr
 2016 12:58:04
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1CF8518E-0BF9-11E6-B02D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292685>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think it's fair enough to say that if we had this facility this
> would be good enough:
>
>  * Your hooks are executed in glob() order, local .git first, then /e=
tc/git/...
>
>  * If it's a hook like pre-commit that can reject something the first
> hook to fail short-circuits. I.e. none of the rest get executed.
>
>  * If it's not a hook like that e.g. post-commit all of the hooks wil=
l
> get executed.
>
>  * If you need anything more complex you can just wrap your hooks in
> your own shellscript.
>
> I.e. it takes care of the common case where:
>
>  * You just want to execute N hooks and don't want to write a wrapper=
=2E
>
>  * For pre-* hooks the common case is it doesn't matter /what/
> rejected things, just that it gets rejected, e.g. for pre-receive.
> Also if you care about performance you can order them in
> cheapest-first order.

Stop using the word "common" to describe what is not demonstratably
"common".

The above only covers a very limited subset of the use cases, which
is the two bullet points above (one of them i.e. "I do not bother to
write a wrapper" is not even a valid use case).  That may be a good
starting point, but it is so simple that can be done with a wrapper
with several lines at most.  So I am not sympathetic to that line of
reasoning at all.

I can buy "It is too cumbersome to require everybody to reinvent and
script the cascading logic, and the core side should help by giving
a standard interface that is flexible enough to suit people's need",
though.

And I have to say that a sequential execution that always
short-circuits at the first failure is below that threshold.

One reason I care about allowing the users to specify "do not
shortcut" is that I anticipate that people would want to have a
logging of the result at the end of the chain.
