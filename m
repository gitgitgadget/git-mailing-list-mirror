From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add option hooks.emaildiff to include full diff in
 post-receive-email
Date: Wed, 03 Aug 2011 11:52:49 -0700
Message-ID: <7vr552ba4e.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1108022132230.3386@ybpnyubfg6.ybpnyqbznva6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Jensen <jon@endpoint.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 20:53:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QogYs-0000VG-S1
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 20:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827Ab1HCSwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 14:52:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44568 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872Ab1HCSwx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 14:52:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B66243A7;
	Wed,  3 Aug 2011 14:52:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PJe+PfuOuV25VhxznGvRLLtfHNc=; b=E+Zh9R
	ibyBrFTSVN7FKpu3Vg31B20MsZGzBmeoWaarvtj7JlLdNlEGXfXPSAEyjYXVlsRb
	o+JDMoANwRKDYFxbETp0DqcJDNb/Rv9jBjamZ6rw7wT2voNF5h+j5jzZyUqjOJsq
	J4d/IfcPrNCPOgLCQlX3KzY9TnmUg3E/3g320=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MUZTiXsgltvBZaspHtf2Q5ELSxxnT9jj
	XJCuPHcvo5pIcS4mLjObBv+aDljImW2O917HVw2Mfg5BtQiXQKG/0YsooFRcgdMf
	DTCK977FHINurN+gu0uhSnH8VjMFuRSGZSS9M26izDUY5K18wN6fhuyx0Qjo/fpb
	49Amdi0d2IM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BEAE43A6;
	Wed,  3 Aug 2011 14:52:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4A4F43A4; Wed,  3 Aug 2011
 14:52:50 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.02.1108022132230.3386@ybpnyubfg6.ybpnyqbznva6>
 (Jon Jensen's message of "Tue, 2 Aug 2011 21:34:48 -0600 (MDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9976614-BE01-11E0-97FB-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178605>

Jon Jensen <jon@endpoint.com> writes:

> -	echo "Summary of changes:"
> -	git diff-tree --stat --summary --find-copies-harder $oldrev..$newrev
> +	if [ -n "$emaildiff" ]; then
> +		echo "Summary of changes and diff:"
> +		git diff-tree --stat --summary --find-copies-harder -p $oldrev..$newrev
> +	else
> +		echo "Summary of changes:"
> +		git diff-tree --stat --summary --find-copies-harder $oldrev..$newrev
> +	fi

Depending on the project, people may want to customize other aspects of
the summary generation, e.g. rejecting the overhead of -f-c-h.

Why not do it like this intead?

	diffopts=$(git config hooks.diffopts)
	: ${diffopts:="--stat --summary --find-copies-harder"}
        
	echo "Summary of changes:"
        git diff-tree $diffopts $oldrev..$newrev
