From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] Teach git-pull to pass -X<option> to git-merge
Date: Wed, 25 Nov 2009 22:16:31 -0800
Message-ID: <7vd435erpc.fsf@alter.siamese.dyndns.org>
References: <cover.1259201377.git.apenwarr@gmail.com>
 <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com>
 <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com>
 <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com>
 <73a42e99b4a083c74b017caf2970d1bbf5886b96.1259201377.git.apenwarr@gmail.com>
 <cover.1259201377.git.apenwarr@gmail.com>
 <1ff0b2f7e3fae4cc6c7610c92711f33df9a3d07c.1259201377.git.apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 07:17:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDXf9-00089K-M2
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 07:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbZKZGQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 01:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754114AbZKZGQb
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 01:16:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40056 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbZKZGQb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 01:16:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 439B682F47;
	Thu, 26 Nov 2009 01:16:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=s5psbzwFI1ehhAsjbKKQQg+ZzTc=; b=jsVnn54hnVNRTW/wX0fE/jp
	KYHMqEq6B/KQga5TdeWu2eh+tFUN/A6AVpBka70GCw8V81O4gX64zXZUJyhDC8su
	HLya2TEGXZ8Jf0r4lgXeNK2k2EdZlhkPUhNTuY/j7rVTuv2qnfHIaLe6Q7wberYF
	84cIzngMT6e+t63m3Of4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=qCJmo+FRDfCihSYPi+ILdQ+ufbFnwSpSzC2fVbV/AWNWn5NFo
	blRM35+TWBu+TtT/i5T1xcKldURFAqFbJFiPr7JBP2bfaFMlmvbPO3eg5yq9pQds
	ZKgJz3ihMC91wDCw7U1bGuLjvfPmBlaLmBZLHYnX18sRvNhLFroGxYhFZc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 202D382F46;
	Thu, 26 Nov 2009 01:16:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F71282F45; Thu, 26 Nov
 2009 01:16:32 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F8CB818-DA53-11DE-A946-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133767>

Avery Pennarun <apenwarr@gmail.com> writes:

> (Patch originally by Junio Hamano <gitster@pobox.com>.)
>
> Signed-off-by: Avery Pennarun <apenwarr@gmail.com>

You should take the full authorship of this patch without even mentioning
"originally by".  It has no code from me.

> @@ -216,7 +229,7 @@ fi
>  
>  merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
>  test true = "$rebase" &&
> -	exec git-rebase $diffstat $strategy_args --onto $merge_head \
> +	exec git-rebase $diffstat $strategy_args $merge_args --onto $merge_head \
>  	${oldremoteref:-$merge_head}
> -exec git-merge $diffstat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args \
> +exec git-merge $diffstat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args $merge_args \
>  	"$merge_name" HEAD $merge_head $verbosity

This part needs the usual "sq-then-eval" trick; -X subtree="My Programs"
on the command line will be split by the shell if you didn't do so.
