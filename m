From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7006: guard cleanup with test_expect_success
Date: Wed, 14 Apr 2010 17:56:25 -0700
Message-ID: <7v7ho9mt3a.fsf@alter.siamese.dyndns.org>
References: <20100413021153.GA3978@progeny.tock>
 <20100413021355.GA4118@progeny.tock>
 <7v4ojdpxls.fsf@alter.siamese.dyndns.org>
 <20100415003803.GB14151@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 02:56:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2DNq-0007g4-4F
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 02:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543Ab0DOA4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 20:56:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab0DOA4f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 20:56:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5708FAB3BD;
	Wed, 14 Apr 2010 20:56:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VN973iXdl3S6KShdCkgyS/5OWaU=; b=ygdiVY
	lco93AyxKPbkTwTSFGEyfYRXz0U+oK7WrCaT0NlxK9wFq+dn7+rf9rcdh4qaBKhy
	H4pAGZT3gkYMd78bO22PNaJ8FVcZ8NWULDyXT6uxRyGxqvrmyuWYdyLT1xL4gu8j
	xxruQs5Sul20p9wQIAFjW85rdVjn8Q9cJkLog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LjEAo+bPHbEdNQOt2QYwGghvBM6Umwgr
	7ori4xDKPp39bldAvAqcLXkK+Ppqok0xtJnu6FZrNokhkn0PnFuTO+Mv0OAV6Qy+
	Q/vcoaE8Wx/gaHYX/HwuCUbtwnF/ymgaZhhtPFIwyylBB+evg/k6rAE1DGfZbHm2
	MK0dknn5cGA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12120AB3BC;
	Wed, 14 Apr 2010 20:56:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4029AAB3B9; Wed, 14 Apr
 2010 20:56:26 -0400 (EDT)
In-Reply-To: <20100415003803.GB14151@progeny.tock> (Jonathan Nieder's message
 of "Wed\, 14 Apr 2010 19\:38\:07 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BADEEB1E-4829-11DF-B0AB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144936>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index d9202d5..62595ab 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -4,17 +4,24 @@ test_description='Test automatic use of a pager.'
>  
>  . ./test-lib.sh
>  
> -rm -f stdout_is_tty
> +cleanup_fail() {
> +	echo >&2 cleanup failed
> +	exit 1
> +}

I think you meant to say "false" or "(exit 1)" here.  To see why...

>  test_expect_success 'set up terminal for tests' '
> +	rm -f stdout_is_tty ||
> +	cleanup_fail &&
> +

... try your patch with "rm -f stdout_is_tty" replaced with "(exit 1)" to
see how your cleanup_fail behaves.

Other than that I like the general idea, especially "might-fail" is cute.
