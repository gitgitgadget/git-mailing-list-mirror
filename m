From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9300: use cmp instead of test_cmp to compare binary files
Date: Fri, 12 Sep 2014 10:58:30 -0700
Message-ID: <xmqq1trgbu0p.fsf@gitster.dls.corp.google.com>
References: <54132E88.8050803@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 19:58:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSV7G-0000hU-CE
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 19:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbaILR6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 13:58:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61331 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbaILR6d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 13:58:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C4DAA37EB5;
	Fri, 12 Sep 2014 13:58:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CWKPRuHCmGRec6e7Y/6TI+L7BXM=; b=d6tMBw
	tiNSYqxb1PFZ05FsU3B5XLTkDIuWnXlOX9Xs81ckOCe7lRokgZhNhx4tdUYgjN2d
	j7zRhfI5LU0lFk1bwut1yllOcbIClXHW7C8/btKyHt6GMVncbmAGWlLzE7uNEO+U
	JpfUePEBjQ2Jbs3Pc2gTtYydqVt2TlxReNN3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LgOWe9CkLHafzIeUrEcMyIu75fVRmboh
	dQPqzZuobC1ftgHa2Gw1/H2Ygff2kHzw70o9MB4nfYGqYuUiK2rb5kNs9/Y7mcwQ
	cA1ly3/abrEu46UJzMkuqQ9QU1Q3LX2fHnSj5gnDPQCnfEuGYKRKcrG1bC2sa4Hm
	mbA/QydGrYI=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BB98737EB3;
	Fri, 12 Sep 2014 13:58:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 404D337EB2;
	Fri, 12 Sep 2014 13:58:32 -0400 (EDT)
In-Reply-To: <54132E88.8050803@kdbg.org> (Johannes Sixt's message of "Fri, 12
	Sep 2014 19:34:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 68A7638E-3AA6-11E4-96D9-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256933>

Johannes Sixt <j6t@kdbg.org> writes:

> test_cmp is intended to produce diff output for human consumption. The
> input in one instance in t9300-fast-import.sh are binary files, however.
> Use cmp to compare the files.

Thanks.

>
> This was noticed because on Windows we have a special implementation of
> test_cmp in pure bash code (to ignore differences due to intermittent CR
> in actual output), and bash runs into an infinite loop due to the binary
> nature of the input.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t9300-fast-import.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 99f5161..4b13170 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -2687,7 +2687,7 @@ test_expect_success 'R: verify created pack' '
>  test_expect_success \
>  	'R: verify written objects' \
>  	'git --git-dir=R/.git cat-file blob big-file:big1 >actual &&
> -	 test_cmp expect actual &&
> +	 cmp expect actual &&
>  	 a=$(git --git-dir=R/.git rev-parse big-file:big1) &&
>  	 b=$(git --git-dir=R/.git rev-parse big-file:big2) &&
>  	 test $a = $b'
