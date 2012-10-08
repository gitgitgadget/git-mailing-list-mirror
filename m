From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Allow __git_ps1 to be used in PROMPT_COMMAND
Date: Mon, 08 Oct 2012 14:17:08 -0700
Message-ID: <7v7gr0k6jv.fsf@alter.siamese.dyndns.org>
References: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org>
 <20121005210945.GA4961@simaj.xs4all.nl>
 <7vr4p8lto5.fsf@alter.siamese.dyndns.org> <50732EA1.7040608@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git@drmicha.warpmail.net, spearce@spearce.org,
	artagnon@gmail.com, schwab@linux-m68k.org, soosthoek@nieuwland.nl
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Oct 08 23:17:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLKhX-0002G8-Ft
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 23:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab2JHVRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 17:17:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53439 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab2JHVRL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 17:17:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B508B8666;
	Mon,  8 Oct 2012 17:17:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gf4IngNHa+slSt/uqhOZBeXfJOI=; b=LNUnja
	Htoq5j3EsU8kBB9dA1nR3QGWoEWK3ZioslTIVJynvb/9NnxZFBNpl0t09W3EHPWR
	JGIcGcJaovoTqnyvGPnHnqqciI0jiA9tygv8jj0WSuDIzj2kRPICeA0XyZkPICgN
	rney8NaYtuM54ZtgjHW6uF5uAwURP/VCzbfcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vYLnk4zhxpKSYn9eN6+kGbvC49KAtwvD
	yb7oLGpoJpvSTw6Nog7o6addr+xfTj4VyYzG1a4Xx4/zYMnLeov2aVrWogpnKVul
	+CggLYHa8OiDe/9eOPT9sYUFyCWikIJeyNXdrlYpIs/8hDtPQ2UfymSZDsD3vV8u
	3MZnUPkf0VU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A19998664;
	Mon,  8 Oct 2012 17:17:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 197BF8662; Mon,  8 Oct 2012
 17:17:10 -0400 (EDT)
In-Reply-To: <50732EA1.7040608@xs4all.nl> (Simon Oosthoek's message of "Mon,
 08 Oct 2012 21:50:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85719172-118D-11E2-8ED9-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207271>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

> How about "This has advantages for using color without running
> into prompt-wrapping issues. Only by assigning \[ and \] to PS1
> directly can bash know these and the color codes in between don't
> count in the length of the prompt."?
>
> I'll rewrite the patch later on...
>
> Isn't it confusing that the color codes don't figure in this patch at all?

Since the "Subject:" is "allow ... to be used in PROMPT_COMMAND", it
very much is relevant to mention that we need to use PROMPT_COMMAND
in order to correctly use \[ and \] to generated zero-width escape
sequences, which cannot be done by simply setting PS1 to command
substitution.

"color" is just an example; if it makes you uneasy to say "color",
you can say zero-width escape sequences.  It could be \007 (BEL) ;-)

> I don't think it would be possible to detect any other kind of
> customization without including specific code for it. Do you think it's
> unnecessary to include a warning? (I think it would take people a long
> time to figure out why their prompt goes whoopsy without getting a hint
> that PROMPT_COMMAND messes up the PS1)

I think you need your warning _only_ because you attempt to
auto-detect it, when you do not have to.

> (OTOH, if you configure PROMPT_COMMAND, you're bound to know a little
> bit about what you're doing...)

Yup.
