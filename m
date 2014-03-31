From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 16/27] t1400: Test one mistake at a time
Date: Mon, 31 Mar 2014 14:50:36 -0700
Message-ID: <xmqq38hy3umr.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-17-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:50:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUk6V-0002yF-Bu
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbaCaVum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:50:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40226 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbaCaVuj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 17:50:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2D2B79F18;
	Mon, 31 Mar 2014 17:50:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AwXY6WIOx8Qb26inG70Y/eoUVPk=; b=wCCfKH
	VVLuVr69LUn6zBLJXJIKkNGiWhSRS2ptpoR2/XCVMwiTYstvzW75Ny4H49h25BGo
	4I3GjhW+hWR5Ai/ofmjiRSGPkXOvFSj1vTI8k1ClCwPz3Nyo07qK+0hJUJ0EmOvq
	qbVhPk4XtRTyh08h+kms5MazrNyUQvTbObUlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w831OLY2gh6kexa4k6Qs2p9klE/11z16
	dqLWQd/o1/0KthVmoLydsRFN66yJh/fogusSg7A4BdLCqfcfgf35dgd9QAVAF2rG
	EUXym3ncwthKhzGjRrgjmjtPHW5PDfYDKBdzA7LCynomvKu4W5MNS9JnAdEIsrz8
	Kryn8i/6EFI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0C2579F15;
	Mon, 31 Mar 2014 17:50:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E9B579F14;
	Mon, 31 Mar 2014 17:50:38 -0400 (EDT)
In-Reply-To: <1395683820-17304-17-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 24 Mar 2014 18:56:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7F128C48-B91E-11E3-9AF0-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245544>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This case wants to test passing a bad refname to the "update" command.
> But it also passes too few arguments to "update", which muddles the
> situation: which error should be diagnosed?  So split this test into
> two:
>
> * One that passes too few arguments to update
>
> * One that passes all three arguments to "update", but with a bad
>   refname.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>
> t1400: Add a test of "update" with too few arguments
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

What's happening here?

> ---
>  t/t1400-update-ref.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 2d61cce..6b21e45 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -724,8 +724,14 @@ test_expect_success 'stdin -z fails update with no ref' '
>  	grep "fatal: update line missing <ref>" err
>  '
>  
> +test_expect_success 'stdin -z fails update with too few args' '
> +	printf $F "update $a" "$m" >stdin &&
> +	test_must_fail git update-ref -z --stdin <stdin 2>err &&
> +	grep "fatal: update $a missing <oldvalue>" err
> +'
> +
>  test_expect_success 'stdin -z fails update with bad ref name' '
> -	printf $F "update ~a" "$m" >stdin &&
> +	printf $F "update ~a" "$m" "" >stdin &&
>  	test_must_fail git update-ref -z --stdin <stdin 2>err &&
>  	grep "fatal: invalid ref format: ~a" err
>  '
