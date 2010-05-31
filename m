From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: suggest what to do with superfluous patches
Date: Mon, 31 May 2010 12:31:50 -0700
Message-ID: <7vwrujzx3t.fsf@alter.siamese.dyndns.org>
References: <4C01B855.7080409@gmail.com>
 <20100530101926.3bac34c8jk@jk.gs@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dale Rowley <ddrowley@gmail.com>, git@vger.kernel.org
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon May 31 21:32:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJAiY-0000dt-0V
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 21:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757075Ab0EaTcE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 May 2010 15:32:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab0EaTcD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 May 2010 15:32:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70B7FB85F6;
	Mon, 31 May 2010 15:31:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rOzdSkfOERnE
	gZrsGVIRb4vgi9g=; b=eryAP5iiLf+tiODISKi6HAqXjP5nJJj2uyXaYkMuj28G
	EqpObFLeLSHree0dfJ7yb0a/+VC1gRg29BqqMKlTLXP5TmZAGycfdJVUes2Xpc1M
	+CQeA33pN2d5G+fsZ7ZqTt9U5Sj1pmeAGjNAcGqIDXXcVWbGhBFA0M8M4rcOizA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=waDfeV
	FuY+oKSYsR+N/oOtRFh/tOoZ2zLwYvWn9aj+j6aPbQl6vC7LxCUBjIN/Hp6+nF1T
	o/XpWHIqbv9nlTZhPRM1vDvslE23RdstKu8y7crKsw9iOHUnIudEOoPjF3gLhiDs
	D1Lj9GvnLOVMbsmudPfIy2gCErQj0bawhhuEU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FAD7B85F4;
	Mon, 31 May 2010 15:31:56 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AF13B85ED; Mon, 31 May
 2010 15:31:52 -0400 (EDT)
In-Reply-To: <20100530101926.3bac34c8jk@jk.gs@perceptron> ("Jan
 =?utf-8?Q?Kr=C3=BCger=22's?= message of "Sun\, 30 May 2010 10\:19\:26 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2C45E344-6CEB-11DF-B78B-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148051>

Jan Kr=C3=BCger <jk@jk.gs> writes:

> Particularly in the context of rebase, conflicts frequently occur
> because the change in the patch to be applied was made obsolete by ne=
w
> upstream commits. In this case, solving the conflict effectively mean=
s
> skipping the patch. However, it's not always readily apparent that th=
e
> patch needs to be skipped, and when people solve the conflict and try
> git rebase --continue, they get confronted with a message of
>
>   No changes - did you forget to use 'git add'?
>
> That's not very helpful if you did actually stage your changes and th=
ey
> happen to turn the patch into a no-op. This extends the message to po=
int
> out what's going on.
>
> Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
> ---

I think this is a change in a good direction; we _might_ want to allow
this squelched with "advice.*" configuration, but my gut feeling is tha=
t
it wouldn't probably matter much, as it is rather rare to trigger this.

> diff --git a/git-am.sh b/git-am.sh
> index 87ffae2..43ea52c 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -726,6 +726,8 @@ do
>  		resolved=3D
>  		git diff-index --quiet --cached HEAD -- && {
>  			echo "No changes - did you forget to use 'git add'?"
> +			echo "If there is nothing left to stage, chances are that somethi=
ng else"
> +			echo "already introduced the same changes; you might want to skip=
 this patch."

The exact wording I'd let people to fight out, but I think this is
probably better than Ramkumar's one that says "if you dropped".  The us=
er
may not know that he is doing an equivalent of dropping as a side effec=
t
of the new base that had accepted the same change, and your message nud=
ges
the reader to realize that.
