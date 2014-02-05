From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/13] Makefile: introduce sq function for shell-quoting
Date: Wed, 05 Feb 2014 11:12:17 -0800
Message-ID: <xmqqr47h4bn2.fsf@gitster.dls.corp.google.com>
References: <20140205174823.GA15070@sigill.intra.peff.net>
	<20140205175741.GH15218@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 05 20:12:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB7to-0004xb-20
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 20:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbaBETMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 14:12:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47312 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbaBETMf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 14:12:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18BA269DD8;
	Wed,  5 Feb 2014 14:12:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mBHglErJ1UKh/sUNiob8ln8aPkg=; b=UmnNJK
	tSMRoK6Z3QIvSF84VEfC5V4y/9Rq7cT3S+0CgNmd2ggS7bNatpp+r8vztKng1b41
	43pGiPY/N9FC7YOp0qb+Nh7n6vT0ZXsMm68lS2jRjBhs7RYfE8QfGuY+BZA+G3bt
	fYQwAxSYj+qWen32yFS++CKDvmsSUgX98vG8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PvXKEY6EvIrIiILDo4zNPyyO6Tipq5qd
	hkvdy1O/c6XQtqSt0QdTsCLnbhzZJbWFz4h+5zq47jPPClY8ZD4xIJ4miezVpij4
	k0+SXouR53u+roLA/kuLbS5sHEjbbtDbba/R1IGgaW+6Dczq2F/yXnTf+x55bs2J
	ULXMMUkyaSI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05A5669DD7;
	Wed,  5 Feb 2014 14:12:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6004369DAA;
	Wed,  5 Feb 2014 14:12:21 -0500 (EST)
In-Reply-To: <20140205175741.GH15218@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Feb 2014 12:57:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 70274368-8E99-11E3-804B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241638>

Jeff King <peff@peff.net> writes:

> Since we have recently abolished the prohibition on $(call)
> in our Makefile, we can use it to factor out the repeated
> shell-quoting we do. There are two upsides:
>
>   1. It is much more readable than inline calls to
>      $(subst ','\'').
>
>   2. It is short enough that we can do away with the _SQ
>      variants of many variables (note that we do not do this
>      just yet, as there is a little more cleanup needed
>      first).

Yay.

> .... But
> many instances are not really any more readable (e.g., see the first
> hunk below).
> ...
>  .PHONY: install-perl-script install-sh-script install-python-script
>  install-sh-script: $(SCRIPT_SH_INS)
> -	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> +	$(INSTALL) $^ $(call sq,$(DESTDIR)$(gitexec_instdir))

Hmph, I do not see it as bad as the "make-var", which forces you to
say $(eval $(call ...)); this $(call sq, ...) is fairly readable.
