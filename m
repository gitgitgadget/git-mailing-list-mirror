From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-sh-setup: make require_clean_work_tree part of
 the interface
Date: Tue, 20 Dec 2011 12:52:46 -0800
Message-ID: <7vd3bjj78h.fsf@alter.siamese.dyndns.org>
References: <7vwr9rjbaq.fsf@alter.siamese.dyndns.org>
 <23d761193dcf25f36206adc3d392e8578c566cd7.1324412815.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 20 21:53:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd6gS-00022I-KH
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 21:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990Ab1LTUw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 15:52:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64493 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918Ab1LTUwt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 15:52:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F4CC6375;
	Tue, 20 Dec 2011 15:52:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vzuivbj3CtPwxoLFnx+UnEvnDvs=; b=eJPWPU
	yz/QMvhQtnvcqCudEhf6n0XXv23yecDXaLx2WUGMGZYpXq41T9gkhRQMamVHNzcG
	8YcIVHwY3Z8loyCWKIGNXeq/03nblvyZFgFe/uNTquL3uEXzhSjcyatBCuceaFoF
	LtAcIFz9xAv0gT4XiYGBmwhh48o5RBI66Efbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s3zIFrq5cC50VJddElKiBY4+MKANvzNS
	RBmOPjJ0BUfHXd0d+MpDETJQUtBitfsVZOBl6BbDxBRsetBgxHa+6nLwJTalIioP
	RLuV1ZELJpXDOpAEninL5zsosupQjzZ81YbLGSKMPbNMZPuocQ+9zN+9fSmz4xJ5
	SF8/EHS43zw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 972076374;
	Tue, 20 Dec 2011 15:52:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2260C6373; Tue, 20 Dec 2011
 15:52:48 -0500 (EST)
In-Reply-To: <23d761193dcf25f36206adc3d392e8578c566cd7.1324412815.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 20 Dec 2011 21:29:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92FEF406-2B4C-11E1-BBA0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187527>

Thomas Rast <trast@student.ethz.ch> writes:

> 92c62a3 (Porcelain scripts: Rewrite cryptic "needs update" error
> message, 2010-10-19) refactored git's own checking to a function in
> git-sh-setup.  This is a very useful thing for script writers, so
> document it.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  Documentation/git-sh-setup.txt |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
> index a2f346c..9a0e574 100644
> --- a/Documentation/git-sh-setup.txt
> +++ b/Documentation/git-sh-setup.txt
> @@ -68,6 +68,16 @@ require_work_tree_exists::
>  	cd_to_toplevel, which is impossible to do if there is no
>  	working tree.
>  
> +require_clean_work_tree <action> [<hint>]::
> +	checks that the working tree associated with the repository
> +	has no uncommitted changes to tracked files.  Otherwise it
> +	emits an error message of the form `Cannot <action>:
> +	<reason>. <hint>`, and dies.  Example:

Doesn't it also enforce cleanliness on the index, not just the working tree?

> ++
> +----------------
> +require_clean_work_tree rebase "Please commit or stash them."
> +----------------
> +
>  get_author_ident_from_commit::
>  	outputs code for use with eval to set the GIT_AUTHOR_NAME,
>  	GIT_AUTHOR_EMAIL and GIT_AUTHOR_DATE variables for a given commit.
