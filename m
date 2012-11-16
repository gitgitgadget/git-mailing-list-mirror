From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] completion: consolidate test_completion*() tests
Date: Fri, 16 Nov 2012 15:41:50 -0800
Message-ID: <7v7gplktdt.fsf@alter.siamese.dyndns.org>
References: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
 <1352644558-9410-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 00:42:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZVXz-0005jG-Fc
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 00:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab2KPXly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 18:41:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56257 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753173Ab2KPXlx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 18:41:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCEE2AA01;
	Fri, 16 Nov 2012 18:41:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ZsLC66gy8MzwhLItwFFQcJQrcwY=; b=cavPzI9Wf9M7By2SRwb4
	jtU1bTcauP5emupladP/9btdZAtF5H3pWyYlCDyQd+9DI4Rr9lLUramA5WznwxUg
	EgIbsU+vAkokILn1nk1pQja+kakdsuiGp0Qkkep9Wl6VOnDVD4ozxtreAd5NmFUv
	roiQuG2JPwYIskAJjb2kbR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=jpAAHcPgtX+ldFUJgK3NluH9O06toJVT0qlDrcKSUHH+qg
	M3saMlBCJXu9x2sxpQeNESBQUeM4Wntd+onVCJN+f7+pQGslqS1gra7e/qx9i1sQ
	iUHMv/LGoJlwQbcTeEmlU4XByXL2bzSBS5ozJ/0iQw7gdfSvza9XUKJoVJZJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB720AA00;
	Fri, 16 Nov 2012 18:41:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BF40A9FF; Fri, 16 Nov 2012
 18:41:52 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32890160-3047-11E2-84AB-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209920>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> No need to have two versions; if a second argument is specified, use
> that, otherwise use stdin.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t9902-completion.sh | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 204c92a..59cdbfd 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -60,19 +60,15 @@ run_completion ()
>  # 2: expected completion
>  test_completion ()
>  {
> -	test $# -gt 1 && echo "$2" > expected
> +	if [ $# -gt 1 ]; then
> +		echo "$2" > expected
> +	else
> +		sed -e 's/Z$//' > expected
> +	fi &&

As "$2" could begin with dash, end with \c, etc. that possibly can
be misinterpred by echo, I'd rewrite this as

		printf '%s\n' "$2" >expected

Otherwise looked fine; thanks.
