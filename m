From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] object name: introduce '^{/!-<negativepattern>}' notation
Date: Mon, 11 Jan 2016 09:13:33 -0800
Message-ID: <xmqqpox8xcn6.fsf@gitster.mtv.corp.google.com>
References: <1433550295-15098-1-git-send-email-wmpalmer@gmail.com>
	<1433550295-15098-3-git-send-email-wmpalmer@gmail.com>
	<xmqqbngqcfxd.fsf@gitster.dls.corp.google.com>
	<loom.20160108T065547-969@post.gmane.org>
	<CACsJy8Dar9sCkTg_SQsDUOWYNQ1PHjmA0KcgrvpvmeY=yVXPMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephen Smith <ischis2@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 18:13:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIg2G-0000zn-2C
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934294AbcAKRNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 12:13:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934254AbcAKRNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:13:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB84B38A64;
	Mon, 11 Jan 2016 12:13:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jcH4YiyYbDLpXcFVscKMi6w2Ptg=; b=Q2hept
	qpucIPTGoHVOygnKdIjgxaqEwCh/UQII2vdjHaTuhrjHKyn5kTnBZCyaPbMtpOxa
	mlC5HyKnB+i2T1DSbkHWso94tt5cIx0CwOi9V6e5BAcjf1PkQmpsGsUml7Omq/0n
	pGMMBIAxkYIOWgSlPRtcg7bz1CwF6WJdeDtHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SQB8BcIYvSNxpu2IAHvfU1bL1xhLVWWI
	M1HKyphpYDF2Bho0/trPlrD2pFtJDEbSm0N7EcPFdrxle9m7dzKAsxKIwoKtvfTs
	zyj7ll/giV2ZYhopiXqvFKGYSldtW0EWwZL9rJ2ZT8AA8wz0hnIOK1Dq3BekjaAF
	mpH9lT1o5XQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E310038A63;
	Mon, 11 Jan 2016 12:13:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 598DC38A62;
	Mon, 11 Jan 2016 12:13:34 -0500 (EST)
In-Reply-To: <CACsJy8Dar9sCkTg_SQsDUOWYNQ1PHjmA0KcgrvpvmeY=yVXPMg@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 9 Jan 2016 09:18:11 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A557CD64-B886-11E5-BF0E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283675>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Jan 8, 2016 at 1:04 PM, Stephen Smith <ischis2@cox.net> wrote:
>>> > +test_expect_success 'ref^{/!-}' '
>>> > +   test_must_fail git rev-parse master^{/!-}
>>> > +'
>
> Shouldn't it be ^{!/... instead of ^{/!... ? People could have a
> pattern starting with "!" and /! will change its meaning. On the other
> hand, anything else after { is still reserved and can safely be used.

http://thread.gmane.org/gmane.comp.version-control.git/40460/focus=40477
clarifies the above, I think.


Back then we seem to have been thinking only about ":" as the
overall "search the history to name an object traversing from all
tips" prefix, but the current one is described in terms of the more
generally useful "<committish>^{/<pattern>}" syntax and the escape
hatch applies--they are both handled by get_sha1_oneline() the same
way.
