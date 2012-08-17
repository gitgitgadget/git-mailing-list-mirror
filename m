From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] test: git-stash conflict sets up rerere
Date: Fri, 17 Aug 2012 11:01:17 -0700
Message-ID: <7v393lv1n6.fsf@alter.siamese.dyndns.org>
References: <1341960748-26949-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, phil.hord@gmail.com
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 20:01:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Qrm-0001ZS-Fz
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 20:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758665Ab2HQSBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 14:01:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39793 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758639Ab2HQSBU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 14:01:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7398C7EAC;
	Fri, 17 Aug 2012 14:01:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=6m5tQd7C3F2p7lIGYdE3D/UHoWA=; b=UlcG7MZCB+03obVIzwLt
	XroSqLNYamvmULYtygO+fah0J3ehAfhkxLpphfmhN3JrkIlRRVC0pzGYt/TDfqiE
	6oocLAV16zw5YyaFK1Mer2tw07Uk1Fd+W7CTxwQq0STbie1tQD1KiGt0yewWSNve
	NhgTB7wSXEf+Ie91UEWpbvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=iVmi9BtDKaFn4iWtsxlXNZj4FFc+PjklxqZZ6OUzk5uydd
	/Dzej0y9G2pMIUpYoGG3NinjqZUE3T3/yvqDKC1+zKuKR+Clsfv0ce+Vvj81QN4J
	AvyDj3MZOXQ7fopz8ptriU4wDS05EXhnbw+2df3kmdFHoSn2Nha/Zp0FdQIqA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60F997EAB;
	Fri, 17 Aug 2012 14:01:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCDDA7EA8; Fri, 17 Aug 2012
 14:01:18 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BA55F68-E895-11E1-A901-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203635>

Phil Hord <hordp@cisco.com> writes:

> Add a failing test to confirm a conflicted stash apply
> invokes rerere to record the conflicts and resolve the
> the files it can.
>
> mergetool may be confused by a left-over
> state from previous rerere activity causing it to
> think no files have conflicts even though they do.
> This condition is not verified by this test since a
> subsequent commit will change the behavior to enable
> rerere for stash conflicts.
>
> Also, the next test expected us to finish up with a reset,
> which is impossible to do if we fail (as we must) and it's
> an unreasonable expectation anyway.  Begin the next test
> with a reset of his own instead.
>
> Signed-off-by: Phil Hord <hordp@cisco.com>
> ---
>  t/t7610-mergetool.sh | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index f5e16fc..725f316 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> ...
>  test_expect_success 'mergetool takes partial path' '
> +    git reset --hard

I'll add " &&" at the end and queue.  Thanks.

>      git config rerere.enabled false &&
>      git checkout -b test12 branch1 &&
>      git submodule update -N &&
