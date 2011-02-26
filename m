From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4 submit: prevent 'Jobs' section from being removed
 from p4 change log
Date: Fri, 25 Feb 2011 23:37:13 -0800
Message-ID: <7vk4gn8cwm.fsf@alter.siamese.dyndns.org>
References: <AANLkTimdd_AdVyDGKyLUoOABuRjJ5QmpC3DnMQYRRcNm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Michael Horowitz <michael.horowitz@ieee.org>
X-From: git-owner@vger.kernel.org Sat Feb 26 08:37:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtEiW-00028g-8e
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 08:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503Ab1BZHhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 02:37:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab1BZHhX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 02:37:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6F72D23DB;
	Sat, 26 Feb 2011 02:38:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=THdEiVjjeFG8iB1+YytYxuuPrYo=; b=eC2DkK
	QrqDU3VKFiSXZgqRWSyICG3yL8rpL+DanIj6LvuafTaUIfW8ea4MbZ6t/naP9d+n
	UNmRD1X6/Fiw/1hZi7PHaD2Z5pwopS+XSwqPw30Q4sSEVefABc40hV4eL6RU4JBl
	fQgZwCDBGpvlnjDdOsFr/UiZEkwFQf3yz3yjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=syjdFT2bsI2wtzLmYfZXenMll+lWZyPk
	Q5uR/aehIbOukMsDy6Rw5j5hd0crJey1r6Lj/mTe9KkRUD4eo6W9j4qkrp8hd76r
	HXBsUa3VT9M3UVmlCK8V9AW3p6gM29D1AuDZ/MNeytJHmIL5pQwntRGpd6TSt7G/
	ZnZmUi8yAHE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4C18023DA;
	Sat, 26 Feb 2011 02:38:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 63B8E23D9; Sat, 26 Feb 2011
 02:38:30 -0500 (EST)
In-Reply-To: <AANLkTimdd_AdVyDGKyLUoOABuRjJ5QmpC3DnMQYRRcNm@mail.gmail.com>
 (Michael Horowitz's message of "Fri\, 25 Feb 2011 21\:31\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 69C9949E-417B-11E0-B53E-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167962>

Michael Horowitz <michael.horowitz@ieee.org> writes:

> In an attempt to overwrite the 'Description:' section of the p4 change
> log to include the git commit messages, it also overwrote the 'Jobs:'
> section.  This fix restores the 'Job:' section.
>
> Signed-off-by: Michael Horowitz <michael.horowitz@ieee.org>
> ---
>  contrib/fast-import/git-p4 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index a92beb6..8b00fd8 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -570,7 +570,7 @@ class P4Submit(Command):
>                 continue
>
>             if inDescriptionSection:
> -                if line.startswith("Files:"):
> +                if line.startswith("Files:") or line.startswith("Jobs:"):
>                     inDescriptionSection = False
>                 else:
>                     continue

This is not a new issue with the code, but it makes me wonder if the
output you are reading from guaranteed to have these lines in the same
order.  Otherwise the next bug report and/or patch would add another
similar looking line.startswith("SomethingElse:") to this statement, and
we wouldn't know when to stop, would we?

Will queue anyway, though.  Thanks.
