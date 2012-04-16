From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/7] t4052: Adjust --graph --stat output for prefixes
Date: Mon, 16 Apr 2012 11:48:22 -0700
Message-ID: <7vzkabtsw9.fsf@alter.siamese.dyndns.org>
References: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
 <1334573095-32286-5-git-send-email-lucian.poston@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Junio C Hamano" <gitster@pobox.com>
To: Lucian Poston <lucian.poston@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 20:48:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJqyU-0001TG-Tw
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 20:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822Ab2DPSsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 14:48:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675Ab2DPSsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 14:48:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A376962A5;
	Mon, 16 Apr 2012 14:48:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=atKFfEMxtggk2rkRtBmtDjHeqm8=; b=UaoP++bxPL9uQ1FoqudI
	6OFP3dXafPOiKqDWOa1tvM4J89m92l+Owhl2FnliR5sPYUZK6yl8XiSKqMExL2Gv
	pYSUgmhBVbJtpweMdX5blZjuyh9N8M24ViV13S2Vyzae7MpyoaaE6+xoI3hEEonY
	b9Vl4rUIhsrjxHJgFdMMHKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=kYoxIVw2eYlozaP2bHOnS+cFqTHi44LGyDjXej9ZxxL60n
	HKisIQPiCOhxQu01dF5FkaVGMEellULhvecMHhxa0MhwK+PFw5ae9LWFk/wXInnG
	YLzbVKoS7q8RAJc1+4X/I4DYgtCypBWPrmEmRMMt2yO1+gGteCkg3XeugLzE0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B25E62A4;
	Mon, 16 Apr 2012 14:48:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2AF5B62A3; Mon, 16 Apr 2012
 14:48:24 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BEDEB28C-87F4-11E1-A43A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195678>

Lucian Poston <lucian.poston@gmail.com> writes:

> Adjust tests to verify that the commit history graph tree is taken into
> consideration when the diff stat output width is calculated.
>
> Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
> ---
>  t/t4052-stat-output.sh |   34 +++++++++++++++++++++++++---------
>  1 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
> index da14984..d748e5e 100755
> --- a/t/t4052-stat-output.sh
> +++ b/t/t4052-stat-output.sh
> @@ -89,7 +89,7 @@ cat >expect200 <<'EOF'
>   abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  EOF
>  cat >expect200-graph <<'EOF'
> -|  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> +|  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  EOF

This change is easily explainable.  Earlier, the code did not take the "|
" part at the very left end (i.e. ancestry graph) and drew the --stat
output too wide by two columns, but now the code is updated to compensate
for that, because "200" is coming from COLUMNS to clip the whole width,
not just the stat-width part.

>  while read verb expect cmd args
>  do
> @@ -117,7 +117,7 @@ cat >expect40 <<'EOF'
>   abcd | 1000 ++++++++++++++++++++++++++
>  EOF
>  cat >expect40-graph <<'EOF'
> -|  abcd | 1000 ++++++++++++++++++++++++++
> +|  abcd | 1000 ++++++++++++++++++++++++
>  EOF

Likewise.

>  while read verb expect cmd args
>  do
> @@ -127,12 +127,6 @@ do
>  		test_cmp "$expect" actual
>  	'
>  
> -	test_expect_success "$cmd $verb statGraphWidth config" '
> -		git -c diff.statGraphWidth=26 $cmd $args >output
> -		grep " | " output >actual &&
> -		test_cmp "$expect" actual
> -	'
> -

This is unclear.  Why does this need to be removed?
