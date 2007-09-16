From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-apply: use strbuf's instead of buffer_desc's.
Date: Sat, 15 Sep 2007 17:56:49 -0700
Message-ID: <7v4phv8m26.fsf@gitster.siamese.dyndns.org>
References: <20070915141210.GA27494@artemis.corp>
	<20070915141340.334CA4C152@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 02:57:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWiRY-00056v-Mx
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 02:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbXIPA45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 20:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753425AbXIPA45
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 20:56:57 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:36358 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393AbXIPA44 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 20:56:56 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A1A8135C1A;
	Sat, 15 Sep 2007 20:57:15 -0400 (EDT)
In-Reply-To: <20070915141340.334CA4C152@madism.org> (Pierre Habouzit's message
	of "Sat, 15 Sep 2007 16:04:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58285>

Pierre Habouzit <madcoder@debian.org> writes:

>  1 files changed, 73 insertions(+), 130 deletions(-)

Nice reduction.

> -		}
> -		return got != size;
> +
> +		nsize = buf->len;
> +		nbuf = convert_to_git(path, buf->buf, &nsize);
> +		if (nbuf)
> +			strbuf_embed(buf, nbuf, nsize, nsize);
> +		return 0;


I suspect that changing the convert_to_git() interface to work
on strbuf instead of (char*, size_t *) pair might make things
simpler and easier.
