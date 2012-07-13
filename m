From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: indicate where a failed patch is to be found.
Date: Fri, 13 Jul 2012 11:06:03 -0700
Message-ID: <7vtxxb8rjo.fsf@alter.siamese.dyndns.org>
References: <1342108243-8599-1-git-send-email-paul.gortmaker@windriver.com>
 <7vhatcc1ql.fsf@alter.siamese.dyndns.org> <4FFF1821.7030705@windriver.com>
 <7va9z4byl3.fsf@alter.siamese.dyndns.org> <4FFF2720.6090705@windriver.com>
 <7v629sbvh8.fsf@alter.siamese.dyndns.org> <50005D8E.1020407@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 20:06:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpkFu-0002pu-Ak
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 20:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030867Ab2GMSGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 14:06:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932757Ab2GMSGK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 14:06:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DAD681A9;
	Fri, 13 Jul 2012 14:06:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t/1+qXriyMfuzFGrFJ5YpTM46VQ=; b=tdQCpA
	UavfDyPqojPRKq9PLvkJGpwWLCwNKw6m2uRKdmu3WRDhKqryXSRY5qP7ES3jNum1
	nJAA2VkCAXfHtgK6txNUf7E48Xk29AxL84Nzht8UQU44nsQkc+ar1Kb/Yeu+NpUx
	9FokTeqnij8DR9fRgBRp2J7xR6uRPkjGK4OuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MHAgLp0y5R+x5BmAKrn/pqGZN+JStJxj
	mHuPbrqPkCDBGHHy+QJkxzcItoIYkvQhD6TX4dSBxoXLfvJRvo7kyrqC4c6VM0aN
	sYQNtLHGwF2jG+cBPBTKvPlz1IQnqTkra8K960fUrliIUUwhkqI4wGtKFwU3oA/b
	lYPxMBHnoTc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AB7981A7;
	Fri, 13 Jul 2012 14:06:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6816881A4; Fri, 13 Jul 2012
 14:06:05 -0400 (EDT)
In-Reply-To: <50005D8E.1020407@windriver.com> (Paul Gortmaker's message of
 "Fri, 13 Jul 2012 13:40:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A03BD5A-CD15-11E1-A423-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201414>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> Sorry, that description was a bit context free.  Two typical cases:
>
> 1) applying a series of commits (e.g. preempt RT feature) to a newer
> baseline. Some of those commits may have been upstreamed and now
> present in mainline.  The "git am" failure doesn't really hint that
> "already applied" may be the case -- e.g. consider and compare the
> output when we extract and then intentionally try to re-apply something
> already in tree, created with:
>
> -------------
> $git format-patch 50fb31cf~..50fb31cf
> 0001-tty-hvc_opal-Fix-debug-function-name.patch
> -------------
>
> With "git am":
> --------------------------
> $git am 0001-tty-hvc_opal-Fix-debug-function-name.patch
> Applying: tty/hvc_opal: Fix debug function name
> error: patch failed: drivers/tty/hvc/hvc_opal.c:401
> error: drivers/tty/hvc/hvc_opal.c: patch does not apply
> Patch failed at 0001 tty/hvc_opal: Fix debug function name
> When you have resolved this problem run "git am --resolved".
> If you would prefer to skip this patch, instead run "git am --skip".
> To restore the original branch and stop patching run "git am --abort".
> ---------------------------
>
> ...versus 
>
> ---------------------------
> $patch -p1 --dry-run < 0001-tty-hvc_opal-Fix-debug-function-name.patch 
> patching file drivers/tty/hvc/hvc_opal.c
> Reversed (or previously applied) patch detected!  Assume -R? [n] 
> Apply anyway? [n] 
> Skipping patch.
> 1 out of 1 hunk ignored -- saving rejects to file drivers/tty/hvc/hvc_opal.c.rej
> ---------------------------

"git am -3" will give you a message "already applied" and moves on,
or if an already applied stuff is similar but not different would
stop with conflict, or fail butd the latter two cases GNU patch
would not say "reversed", so "am -3" would be a win 2 out of 3 cases
and the remaining 1 out of 3 case would be a tie.

> 2) In maintaining linux stable releases (esp older ones), the dry-run
> output, if say it says something like 23/30 chunks failed, it tells me
> that the underlying baseline has probably changed too much for a simple
> backport.  But if only 1/30 chunks fail or similar, I'll simply proceed
> since the backport is viable and likely trivial.

Perhaps "git apply" when stops upon unapplicable patch may want to
be improved to give more detailed diagnostics (I think it stops upon
first hunk per each file that is touched---it may be able to keep
going and see if other hunks might apply).  This is in "patches
welcome" category ;-).
