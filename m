From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/7] rebase -i: write better reflog messages
Date: Tue, 18 Jun 2013 13:36:21 -0700
Message-ID: <7v38sf40my.fsf@alter.siamese.dyndns.org>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
	<1371581737-10013-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 22:36:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up2dg-0001qZ-P2
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 22:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933533Ab3FRUgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 16:36:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60279 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933076Ab3FRUgX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 16:36:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C8FD29EFB;
	Tue, 18 Jun 2013 20:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=e7Igb1QEQ4v7YPQkoPyriWUz7VY=; b=qUNE/O/nFibu8c3G8gSP
	V2isOHfeAWpXm1ynjWzQIZQRVhxRZhz8Pbq0sJuEAdqW0rvWebCi7yu1TdZzsN3u
	YTOfIu/8Ngrx8+615Pu0txyaAODJgoYogyOvdvvfPL5Qorp/n6nYxiJ5kj6gwlBJ
	F9KGcBUS+lXB3Bljs+Ewg3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=aLrgY4AsMlQEfQs1wObQ4w/oT37TLa7r4Hpk5zQXxUuGWL
	VnPrhloD0kHSqTsOoMKWt5nVfUvzr4sLW22qYlxUhdvxaNsx32jU3/l6DzoWOURC
	B7m/7EQu2II9Z6WcVK0pfwqfOjx8Cjp0o/R+bE7ioREd/gX4lWPGCa3JCwOBw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30E7E29EFA;
	Tue, 18 Jun 2013 20:36:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1D9229EF6;
	Tue, 18 Jun 2013 20:36:22 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD261E9A-D856-11E2-997B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228313>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 79e8d3c..f7d0147 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -934,6 +934,21 @@ test_expect_success 'rebase --edit-todo can be used to modify todo' '
>  	test L = $(git cat-file commit HEAD | sed -ne \$p)
>  '
>  
> +test_expect_success 'rebase -i produces readable reflog' '
> +	git reset --hard &&
> +	git branch -f branch1 H &&

Why did this have to change back from branch-reflog-test to branch1
(which I used by mistake in "how about this" patch, but fixed in the
version queued on 'pu')?

The reason I did not use 'branch1' in the version I queued on 'pu'
is because rr/rebase-sha1-by-string-query, when merged on top of
this, makes an assumption on where branch1 is in the test and
fliping its tip here will break it.

Have you tested this with combination of that topic before sending
it out?
