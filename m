From: Junio C Hamano <gitster@pobox.com>
Subject: Re: calling git rebase with invalid onto-ref exits with wrong error
 message
Date: Wed, 30 May 2012 08:37:33 -0700
Message-ID: <7v7gvt1xz6.fsf@alter.siamese.dyndns.org>
References: <op.we351rjtt21y7h@id-c1003.oslo.osa>
 <CABPQNSZntbPQ7taPhr_QUNnwzOcexjteUsnpmrkCiRUYRA3nvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: manuelah@opera.com, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed May 30 17:37:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZky3-0005L7-4E
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 17:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863Ab2E3Phi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 11:37:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52815 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754633Ab2E3Phg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 11:37:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34E7D755B;
	Wed, 30 May 2012 11:37:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TtGHsnea1JkeqxdotD/ll52Q6IY=; b=qHmCNj
	Y/RshFkwpBhaqKrNEsTAQqFkEj82ZBaGVMCiPPWCZmdCFRGjtpyQs8aMvYBJ2Dz0
	B/ho7DT1Wm+ySeCSP5ieJNuS2KPtYBsKJkcnj+c8hTtARtWtUTfvNW4Wp6utQan+
	4itzMITKO4jG/528zHRqXFnT5ji/mk1xUJPLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lA35QcupKuWamKKHKcGQ/FsDm81CiOQb
	hYdMqzZxUuuW9X/9GA+XHKtCMLXzB/QzuNM38YpcCePfdEdjRhBYzQoql3lzPpoq
	O8J4FATTOWYs59jT4CAB/5Ih2K8rcNpWcGiDRXo47KYv9y0viKKTEMMHTBCS1uZP
	q702ibSddo0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29BF7755A;
	Wed, 30 May 2012 11:37:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B103C7559; Wed, 30 May 2012
 11:37:34 -0400 (EDT)
In-Reply-To: <CABPQNSZntbPQ7taPhr_QUNnwzOcexjteUsnpmrkCiRUYRA3nvA@mail.gmail.com> (Erik
 Faye-Lund's message of "Wed, 30 May 2012 11:27:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60A4483A-AA6D-11E1-883D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198814>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Indeed. This looks like the result of a bad merge-resolution, but I
> could be mistaken.

It looks like 9765b6a (rebase: align variable content, 2011-02-06)
originally botched it, which propagated to 71786f5 (rebase: factor
out reference parsing, 2011-02-06) in the series, and finally merged
at 78c6e0f (Merge branch 'mz/rebase', 2011-04-28).

> This looks like the correct solution to me:
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 24a2840..3267c92 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -423,7 +423,7 @@ case "$onto_name" in
>  	;;
>  *)
>  	onto=$(git rev-parse --verify "${onto_name}^0") ||
> -	die "Does not point to a valid commit: $1"
> +	die "Does not point to a valid commit: $onto_name"
>  	;;
>  esac

Yes, it does.
