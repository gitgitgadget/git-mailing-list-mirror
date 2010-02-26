From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] git-core: Support retrieving passwords with
 GIT_ASKPASS
Date: Fri, 26 Feb 2010 09:50:22 -0800
Message-ID: <7vmxyvx4wx.fsf@alter.siamese.dyndns.org>
References: <1267143154-5020-1-git-send-email-lznuaa@gmail.com>
 <4B87797D.7030905@viscovery.net> <7vr5o84erv.fsf@alter.siamese.dyndns.org>
 <4B87952F.1000902@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 18:50:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl4Kl-0002LE-5P
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 18:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965542Ab0BZRud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 12:50:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965483Ab0BZRud (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 12:50:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EA6A59D751;
	Fri, 26 Feb 2010 12:50:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/m08k90VypwYBdq1Daf2si0MmYo=; b=yM2rkN
	+Zh1uX7xYvD7VBGYzxnU+mcNWnFamuYgkSDJVsBoR7jg4KrNRVS8nR+DGSQhYSO/
	RTuL0c7IN3wio3pWaHYMyWpBksWNjbka7carxYPYQs83IZmi7WG8yA2xf4GNn/Ar
	K5hszr9VPd7dvWLJ7NjQYPXl3/CNbxnj7r6nQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XVb4X46QxIdta5oXTy9VA+2Jnt083E+n
	BWnU6nYwG5lIxOzwsEhleSHSJp+Yl1U9inkUhGsYXm7bopNFp/cLmwoLMqZ/DnlB
	JY561yyp7FddOtoJb7xVl6YvYAW8IZbmPJ3zscMb5Z+15X/N6HGP1n3YsOn6zzj8
	I1uw0iT5ycA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B63539D74D;
	Fri, 26 Feb 2010 12:50:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3CB69D74C; Fri, 26 Feb
 2010 12:50:23 -0500 (EST)
In-Reply-To: <4B87952F.1000902@viscovery.net> (Johannes Sixt's message of
 "Fri\, 26 Feb 2010 10\:32\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6C7F118C-22FF-11DF-8F67-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141138>

Johannes Sixt <j.sixt@viscovery.net> writes:

> openssh treats SSH_ASKPASS as a command name and uses execlp, i.e., does a
> PATH search; no shell tricks are possible. Hence, we should *not* set
> use_shell.
>
> http://www.openbsd.org/cgi-bin/cvsweb/src/usr.bin/ssh/readpass.c?rev=1.47
>
> Of course, we could define that GIT_ASKPASS is different from SSH_ASKPASS
> in this regard, but I haven't followed the discussion to know whether this
> is necessary.

It is sad that they do exec*p() on that one; it means that the users
cannot supply leading set of options with CMD="cmd --initial-option".

But we should do the same as others do.

It is doubly sad that I earlier was hoping that we can run external
programs specified via GIT_* uniformly via shell.
