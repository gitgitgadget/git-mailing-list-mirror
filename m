From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/13] ident: don't write fallback username into
 git_default_name
Date: Mon, 21 May 2012 02:11:58 -0700
Message-ID: <7v396t99up.fsf@alter.siamese.dyndns.org>
References: <20120518230528.GA30510@sigill.intra.peff.net>
 <20120518231933.GH30031@sigill.intra.peff.net>
 <7v7gw69rbz.fsf@alter.siamese.dyndns.org>
 <20120521063145.GB2077@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 21 11:12:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWOew-0003PX-JV
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 11:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757337Ab2EUJMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 05:12:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757259Ab2EUJMC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 05:12:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62DCD4827;
	Mon, 21 May 2012 05:12:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=pTFZojwn1Rj9h6DhkMgGuWL62OQ=; b=J+zLU5kmEy39SfgBxWhT
	TxIBA8mi9vX3k2qd/3QQrwIuOn7HJRAdHt3sfCpaS0V2DdD+lbQpyj0banQY70o8
	YKrroNYzMSphgf/gMg4d6RTnsKTosY17QPwj11XuecGyv+wPpQbD7wDHBdR4qG5v
	mg6yZtBBL55TKTy4+/gBWCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=VOG4wWxHim1pD4gRavz5HySfWUZWtI9cM/6nlGTJwPIYKz
	IzXozbDW7hzQZxYlz5ajwXLdI5IGn6V5E2nQcv3HOcig95Hmqf8vP6ZQ117GQmvA
	AXTBL74omhZdlT72jbOfVZP8FEUoPMOSRO+cIjVC6sCtM4AnrkKiDhJ8poEcE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46FAD4826;
	Mon, 21 May 2012 05:12:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B7574823; Mon, 21 May 2012
 05:12:00 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 059EABC8-A325-11E1-9C3A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198097>

Jeff King <peff@peff.net> writes:

> It does raise a subtle issue, though: should we be trimming whitespace
> and other undesirable characters from git_default_email (or
> git_default_name)? We don't currently, and it ends up OK because the
> result typically is fed through fmt_ident, which cleans it up. But:
>
>   1. We do look at the git_default_* variables for things like deciding
>      whether the name is blank. So if your gecos field was " ", I think
>      that would fool git into thinking it had something useful, and skip
>      the IDENT_ERROR_ON_NO_NAME check, even though fmt_ident would
>      produce an empty name.
>
>   2. We don't always feed it through fmt_ident (the http-push.c callsite
>      I mentioned above, and now patch 6 adds another one).
>
> So I think my preference would be:
>
>   - apply the patch below as 5.5/13
>
>   - tweak patch 9 to remove the extra trimming
>
>   - add a patch 14 to call strbuf_trim on the name and email buffers
>     after reading them from system files.

Sounds sensible; thanks.
