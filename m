From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/5] t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
Date: Thu, 20 Jun 2013 13:38:14 -0700
Message-ID: <7vtxksr009.fsf@alter.siamese.dyndns.org>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com>
	<8ca30465721ee9f98613397c1778640e3fcc0f83.1371720245.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 22:38:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uplcb-0007XY-RC
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 22:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161208Ab3FTUiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 16:38:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965712Ab3FTUiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 16:38:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71DB52AD6D;
	Thu, 20 Jun 2013 20:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=GGbBuxAjDHSLCZJeLZRtVLOClp8=; b=RzD+EJ9MYC0j2cDTPfUT
	OG/9EMHi3ZWhwdyQxXsB6qs86gtpV3/GppWtZSkWfm3aoBxJoFRZLHqnJD8/wDbf
	MdybSUhS0zgH2irg3JFj8Bw23B7z+YIow/r4a6M4DFkIwO2EWOnnQgAZjQk21TP4
	veFhbta4De5cWf/GsmScjKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Y227d4Z+tdNE7m1IMuhdLM0FG3PDpu056kZUob+sbHvK9L
	7ZmrRQu4A1dAXwDi/FVTfBHYsYVsfs1KMuLIF1VJx0Ll2TWqVDuhm5uMwd0arU7P
	YCKLAQiYY8/PacdIaEYB+SXrahz12qtnq4bH1uwHfuy2zxjXfWqVTrMjR5fq0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6640A2AD6C;
	Thu, 20 Jun 2013 20:38:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF74B2AD68;
	Thu, 20 Jun 2013 20:38:15 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 557A7E50-D9E9-11E2-B497-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228535>

Alexey Shumkin <Alex.Crezoff@gmail.com> writes:

> The expected SHA-1 digests are always available in variables. Use
> them instead of hardcoding.
>
> Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> ---
>  t/t4205-log-pretty-formats.sh | 48 +++++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
>
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 26fbfde..6d8d457 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -101,7 +101,11 @@ test_expect_failure 'NUL termination with --stat' '
>  
>  test_expect_success 'setup more commits' '
>  	test_commit "message one" one one message-one &&
> -	test_commit "message two" two two message-two
> +	test_commit "message two" two two message-two &&
> +	head1=$(git rev-list --max-count=1 --abbrev-commit HEAD~0) &&
> +	head2=$(git rev-list --max-count=1 --abbrev-commit HEAD~1) &&
> +	head3=$(git rev-list --max-count=1 --abbrev-commit HEAD~2) &&
> +	head4=$(git rev-list --max-count=1 --abbrev-commit HEAD~3)

Hmmph.  Why not rev-parse --short like in your 1/5?
