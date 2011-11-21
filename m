From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t5501-*.sh: Fix url passed to clone in setup test
Date: Sun, 20 Nov 2011 19:24:49 -0800
Message-ID: <7vaa7qi2da.fsf@alter.siamese.dyndns.org>
References: <4EC805CE.10203@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Nov 21 04:25:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSKVJ-0006OG-1V
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 04:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063Ab1KUDYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Nov 2011 22:24:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39938 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759Ab1KUDYy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2011 22:24:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E5A25F03;
	Sun, 20 Nov 2011 22:24:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QDOb+9sYAb39r/pjAPEKy28RIsI=; b=aFI2nV
	XHujDn+t2XMo1hjc5BRIsDmi/goxp54MbxeRKIqOMA7MLKqne74t672CuHUARkEb
	lMU2/dPBdUPVzgwpV0Gu48UhgWBqG9+s8EBQJ3h7qfUNjMu7wx5jJuMNXQfy7TO2
	bg6HZUsUItRnQI4+4P0vrNxXeuDGRC2QdviP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aoAMe0pb10p5xw9L8Lll7aYg1AblH2Gp
	wNj/tVA6Cf04ZevPwUDgQ17cII6YRpDiUsF0h1ITliJOfOCVtwl/iROSTUIfdu59
	u6gG5se+j3AagdCJekkuD4UlFteA28OgzqM9XXMxF12k6anz+Kxt+vqcUBC9kEZe
	5aVqHzQPh5o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3487E5F02;
	Sun, 20 Nov 2011 22:24:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A75C5F00; Sun, 20 Nov 2011
 22:24:50 -0500 (EST)
In-Reply-To: <4EC805CE.10203@ramsay1.demon.co.uk> (Ramsay Jones's message of
 "Sat, 19 Nov 2011 19:38:54 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F19E57E-13F0-11E1-B240-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185729>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> In particular, the url passed to git-clone has an extra '/' given
> after the 'file://' schema prefix, thus:
>
>     git clone --reference=original "file:///$(pwd)/original one
>
> Once the prefix is removed, the remainder of the url looks something
> like "//home/ramsay/git/t/...", which is then interpreted as an
> network path. This then results in a "Permission denied" error, like
> so:
>
>     ramsay $ ls //home
>     ls: cannot access //home: No such host or network path
>     ramsay $ ls //home/ramsay
>     ls: cannot access //home/ramsay: Permission denied
>     ramsay $
>
> In order to fix the problem, we simply remove the extraneous '/'
> character from the url.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---

Thanks; obviously correct.


>  t/t5501-fetch-push-alternates.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t5501-fetch-push-alternates.sh b/t/t5501-fetch-push-alternates.sh
> index b5ced84..1bc57ac 100755
> --- a/t/t5501-fetch-push-alternates.sh
> +++ b/t/t5501-fetch-push-alternates.sh
> @@ -28,7 +28,7 @@ test_expect_success setup '
>  		done
>  	) &&
>  	(
> -		git clone --reference=original "file:///$(pwd)/original" one &&
> +		git clone --reference=original "file://$(pwd)/original" one &&
>  		cd one &&
>  		echo Z >count &&
>  		git add count &&
