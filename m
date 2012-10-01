From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Mon, 01 Oct 2012 14:09:31 -0700
Message-ID: <7va9w5c31w.fsf@alter.siamese.dyndns.org>
References: <5064140E.50007@drmicha.warpmail.net>
 <50658C9B.6030809@nieuwland.nl> <7vipaym3ks.fsf@alter.siamese.dyndns.org>
 <50695ECE.5010101@nieuwland.nl> <7v626udse6.fsf@alter.siamese.dyndns.org>
 <7v4nmec8fi.fsf@alter.siamese.dyndns.org> <5069EE8D.6050200@nieuwland.nl>
 <7vr4piaryi.fsf@alter.siamese.dyndns.org> <506A0366.6030009@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Oosthoek <soosthoek@nieuwland.nl>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Oct 01 23:10:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TInG8-0003Jz-8D
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 23:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225Ab2JAVJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 17:09:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37168 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932136Ab2JAVJe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 17:09:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 559DD86BC;
	Mon,  1 Oct 2012 17:09:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pJ7oTwwAAy+042E1Lg1uUoLO6EE=; b=b77Jl+
	b59s9OdEZne0a+m/sX9AeQZqjzIzkxeES/clEBkDH9UJ/n0NYTMq8V3DRew4kdpp
	t3UdujVc3bWBnIPaThIg6TbQ4qkF3NMBcMgMzbZG5T0n34r0Ap6dc1Oy7uvdJSqS
	bG41WAg2xUUpuHEt7bw2CqzmTchiOxkrkZEyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jK63PgCCekWKmUqMVQGVI+9BETAzTVm1
	lFrshImoWgo046/peUOARV++ougqsXNpLVDD8d5mo645WxXks8QsrloCEFsbIM0R
	vnqkCumWf1KA/YDpVoEVf10WZiwhitw5+tBUalIei9oydUIW8muHjGueOM1sDnqd
	Jg9nfR8orgs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4340986BB;
	Mon,  1 Oct 2012 17:09:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A03E686BA; Mon,  1 Oct 2012
 17:09:32 -0400 (EDT)
In-Reply-To: <506A0366.6030009@xs4all.nl> (Simon Oosthoek's message of "Mon,
 01 Oct 2012 22:56:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BE03156-0C0C-11E2-AFA6-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206768>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

> It's possible to set PS1 to nothing and print a string from
> PROMPT_COMMAND, but then you miss out on all the features of the PS1
> interpretation by bash and compared to the use of __git_ps1 at the
> moment, it has to put out quite a different string. Because if you like
> to see user@host+workdir (git-status)[$#]
> the current users of __git_ps1 say PS1="\u@host+\w $(__git_ps1 "%s")\$
> ", but all __git+ps1 has to put out is "(branch)" or "(branch *)", etc.
>
> If it has to print the same prompt in PC mode, it has to add all the
> user/host/workdir/[$#] data as well, withouth being able to use the bash
> internal interpretation (because that is only working when PS1 is set).

The longer I read your explanation, the less useful the "PC mode"
sounds like, at least to me.  So why does an user even want to use
such a mechanism, instead of PS1?  And even if the user wants to use
it by doing \w, \u etc. himself, she can do that with

	PROMPT_COMMAND='
		PS1=$(printf "\u \h \w %s$ " $(__git_ps1 "%s"))
        '

just fine, no?

So I still do not see the problem, even taking your "Set PS1 in the
command, without spitting anything out of the command" use case into
account.

Confused....
