From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] attr.c: respect core.ignorecase when matching
 attribute patterns
Date: Wed, 14 Sep 2011 21:01:16 -0700
Message-ID: <7vsjnyqws3.fsf@alter.siamese.dyndns.org>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil> <1316051979-19671-1-git-send-email-drafnel@gmail.com> <1316051979-19671-5-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, git@vger.kernel.org, sunshine@sunshineco.com,
	bharrosh@panasas.com, trast@student.ethz.ch, zapped@mail.ru
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 06:01:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R438u-0001tQ-Nb
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 06:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766Ab1IOEBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 00:01:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730Ab1IOEBT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 00:01:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D68C58D4;
	Thu, 15 Sep 2011 00:01:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kLB+uvbvTy2lO6hwq9JqsiDlHMU=; b=TYUtHp
	IzSfMOPJBgVI2TybeDlS4xLeKhC1ETeWfmxtmPd5wmq08kd6ur/K4Ys517WWH374
	eVwVUxFtlzi8SCFYren3/9rUHLRHZWlBgm879JcuOx6PVRZq3lQdFQxsSHXXqbsp
	mXYDL+kjiAiHOoIxhheqABs3bZ56Fy8Z76j2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dr0OTi9bSO7dTr0dt4LKLrWW/KQ4bbGH
	1qTINhBNZiw9H5tkCm584Wda5S3MOQfZCw9s5qGLR2azr/tt7keYPXOHrlxtOGvD
	8jXDrB5GspLiqEtAHVM7yPAEd5HLeDqK9PhcZXcD6cmB2DU3jhhLVXPCz6PviEgi
	Vh7CbhNXaVc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 227B558D3;
	Thu, 15 Sep 2011 00:01:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9217558D2; Thu, 15 Sep 2011
 00:01:17 -0400 (EDT)
In-Reply-To: <1316051979-19671-5-git-send-email-drafnel@gmail.com> (Brandon
 Casey's message of "Wed, 14 Sep 2011 20:59:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CF564E2-DF4F-11E0-AAE4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181432>

Brandon Casey <drafnel@gmail.com> writes:

> It's easy to work around this issue.  I could just parse core.ignorecase
> in git_attr_config() and set ignore_case myself like:
>
>    if (!strcmp(var, "core.ignorecase")) {
>            ignore_case = git_config_bool(var, value);
>            return 0;
>    }

I think it is immensely preferrable to do this than cascading to
default_config like this patch does and then piling band-aid on top to fix
the breakage caused by calling default_config.

An alternative approach may be to move reading of core.attributesfile to
default_config, and drop git_config() call from bootstrap_attr_stack(),
getting rid of git_attr_config callback altogether.
