From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5540-http-test: shorten grep pattern
Date: Sun, 28 Aug 2011 22:17:25 -0700
Message-ID: <7vhb5094pm.fsf@alter.siamese.dyndns.org>
References: <1314506520-17430-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 07:18:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxuEs-0003Nc-AQ
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 07:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab1H2FRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 01:17:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873Ab1H2FR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 01:17:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD15E5C7E;
	Mon, 29 Aug 2011 01:17:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eAyfvNoqdww9oQnK7BVmdwPWRtA=; b=iCX83y
	R8OBTR8kor44Am3bRkcrIVCTL98hVG8WV16Gik2QzNtvPb/nj7agro/Ft1W2fBLY
	yvN+TkdL62qa59UFoGIJlhXfSkccGk0M/JndmNubdIuRGTn9drFhl5TC0GuAHR+M
	npUSyTysA/A4qNnLQpx9WUc5R6D7K/hsjwmDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hiwb4bqoJyzrzlgIcLkatRFroimMejtt
	cigqk/TFwUnRU4DN7P526fjYdbUGHnXUDkB2TJ16q1ICf8+f3tcmrzo1wQhcXnYQ
	yPnoIW9xAnO/M5cIK39I8dY/NiN4YqOqvlf3cUgHXkU1yq46uFxo0By4ODyj9T02
	me3ZlAoBr9U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4E935C7D;
	Mon, 29 Aug 2011 01:17:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19E705C7C; Mon, 29 Aug 2011
 01:17:26 -0400 (EDT)
In-Reply-To: <1314506520-17430-1-git-send-email-brian@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Sun, 28 Aug 2011 00:42:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F92D024-D1FE-11E0-A320-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180294>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> On OS X, the grep pattern
>
>     "\"OP .*/objects/$x2/X38_X40 HTTP/[.0-9]*\" 20[0-9] "
>
> is far too long ($x38 and $x40 represent 38 and 40 copies of
> [0-9a-f]).  In order to still be able to match this, use the sed
> invocation to replace what we're looking for a token.
>
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
>  t/t5540-http-push.sh |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
> index a266ca5..5bf287d 100755
> --- a/t/t5540-http-push.sh
> +++ b/t/t5540-http-push.sh
> @@ -132,8 +132,9 @@ x38="$x5$x5$x5$x5$x5$x5$x5$x1$x1$x1"
>  x40="$x38$x2"
>  
>  test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
> -	sed -e "s/PUT /OP /" -e "s/MOVE /OP /" "$HTTPD_ROOT_PATH"/access.log |
> -	grep -e "\"OP .*/objects/$x2/${x38}_$x40 HTTP/[.0-9]*\" 20[0-9] "
> +	sed -e "s/PUT /OP /" -e "s/MOVE /OP /" -e "s/$x40/X40/" -e "s/$x38/X38/"\
> +		"$HTTPD_ROOT_PATH"/access.log |
> +	grep -e "\"OP .*/objects/$x2/X38_X40 HTTP/[.0-9]*\" 20[0-9] "
>  
>  '

Hmm...

Is it sensible to replace $x40 with X40 and $x38 with X38 on any line
anywhere for the purpose of this test? As the downstream test is only
interested in a line with HTTP request line that asks for a specific path
under objects/??/?{38}_?{40}, wouldn't it make more sense to replace
occurrences of only such line?

	sed -n \
            -e "s/PUT /OP " \
	    -e "s/MOVE /OP /" \
	    -e "s|/objects/$x2/$x38_$x40|WANTED_PATH_REQUEST|p" \
	    "$HTTPD_ROOT_PATH/access.log" |
	grep -e "\"OP .*WANTED_PATH_REQUEST HTTP/[.0-9]*\" 20[0-9] "
