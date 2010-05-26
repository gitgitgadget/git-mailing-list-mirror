From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t7502-commit: add summary output tests for empty and
 merge commits
Date: Tue, 25 May 2010 22:07:45 -0700
Message-ID: <7vvdabp7xa.fsf@alter.siamese.dyndns.org>
References: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
 <1274694452-4200-2-git-send-email-rctay89@gmail.com>
 <1274694452-4200-3-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 07:08:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH8qY-0005ZO-Dv
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 07:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933430Ab0EZFHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 01:07:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab0EZFHy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 01:07:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E79C6B67CD;
	Wed, 26 May 2010 01:07:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=yLyzveDjbyecAZtROiITtHax1Rc=; b=YRs/YNV3jy/ifrmxequ90Fs
	D98J4glEuiMZCqzQMjoDRJRs4JsniO3SZhQrlhukAMGKS0wrZOxuioV85lV5bkaM
	qrcrAdBbB74XWPq5IbKVVWZjpNHUnziC0/4/lELSYghLASQT2lvWZnTnt4e5sjsu
	FN1KqBBnjU8BmYu2iy/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=bhvoF+Cg89d2uiB8rm7evsVKyMhMH0MHpCSh48rlL6seQBSp6
	+OTnQCEAjII1ObtN3k7KSeAkqXKuO1Yb2PDu0Prr1eNSmetPWn7atF3oyjJT2X9D
	Fpc7fHEHpMlIv7B+J9jbl7FQPgzXipJa4ZukY7movZHxfiasVpmjyH0gSs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AFB4BB67CC;
	Wed, 26 May 2010 01:07:50 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80190B67CA; Wed, 26 May
 2010 01:07:46 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A1F9C2BA-6884-11DF-8DA3-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147742>

Tay Ray Chuan <rctay89@gmail.com> writes:

> After c197702 (pretty: Respect --abbrev option), non-abbreviated hashes
> began to appear, leading to failures for these tests.
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  t/t7502-commit.sh |   29 +++++++++++++++++++++++++++--
>  1 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
> index 589e8e6..8a4a277 100755
> --- a/t/t7502-commit.sh
> +++ b/t/t7502-commit.sh
> @@ -4,10 +4,10 @@ test_description='git commit porcelain-ish'
>  
>  . ./test-lib.sh
>  
> -# Arguments: [<prefix] [<commit message>]
> +# Arguments: [<prefix] [<commit message>] [<commit options>]
>  check_summary_oneline() {
>  	test_tick &&
> -	git commit -m "$2" | head -1 > act &&
> +	echo "$3" | xargs git commit -m "$2" | head -1 > act &&

Why do you have to fork xargs?  Wouldn't/shouldn't

    git commit ${3+"$3"} -m "$2"

work?
