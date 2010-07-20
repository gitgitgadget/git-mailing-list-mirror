From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add test for git clean -e.
Date: Tue, 20 Jul 2010 13:34:21 -0700
Message-ID: <7vmxtllwoi.fsf@alter.siamese.dyndns.org>
References: <cover.1279654370.git.jaredhance@gmail.com>
 <b8f95cd841124e24b9774c301ac63e803da325de.1279654370.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 22:34:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObJWP-0004WU-3R
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 22:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab0GTUeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 16:34:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab0GTUeb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 16:34:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A9E0C63F2;
	Tue, 20 Jul 2010 16:34:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I2PHx3HlzYO8/KeqPCWAtZvi4UQ=; b=r/FK00
	1f35s9k3F/j3Ih9JiUSLd5nhSfynalQx6MlESWsYPHiu3f1h0dLWvcMh4+E221kA
	Ov6dIT2oYTwqgtTexpMM8a+z0kRP137PbGnEkkL7RVBJTkuFxikCDGdRndxvVfU6
	vgigXsOIyf3vKDFZk5wPwGrd6J50xcxXHo6JI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hRZhzE1ad9ZpoeHo2bt0150jirEbufqu
	bmnDdh+TeR280HS2p+ndRIa97T+YzSkR2Td7haitvBRvi2g98L6FNgkEzwApgbbs
	KaEcVyad8EdNNDh2+HFi5HCm3gLzFJQEzHQQBxtbiwi/1b76n9oavorjqHR4PL3u
	Zzy84QIg2f8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D713C63F1;
	Tue, 20 Jul 2010 16:34:26 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52283C63F0; Tue, 20 Jul
 2010 16:34:23 -0400 (EDT)
In-Reply-To: <b8f95cd841124e24b9774c301ac63e803da325de.1279654370.git.jaredhance@gmail.com> (Jared Hance's message of "Tue\, 20 Jul 2010 15\:36\:21 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 302C7732-943E-11DF-9765-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151363>

Jared Hance <jaredhance@gmail.com> writes:

> Signed-off-by: Jared Hance <jaredhance@gmail.com>
> ---
>  t/t7300-clean.sh |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 7d8ed68..3a43571 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -438,4 +438,20 @@ test_expect_success 'force removal of nested git work tree' '
>  	! test -d bar
>  '
>  
> +test_expect_success 'git clean -e' '
> +	rm -fr repo &&
> +	mkdir repo &&
> +	(
> +		cd repo &&
> +		git init &&
> +		touch 1 2 3 known &&
> +		git add known &&
> +		git clean -f -e 1 -e 2 &&
> +		test -e 1 &&
> +		test -e 2 &&
> +		! (test -e 3) &&
> +		test -e known
> +	)
> +'

This is a good start but it doesn't seem to test possible interactions
with entries in .gitignore file(s) in the working tree.  Do we care?

What should happen when a path "path":

 (1) is marked to be ignored in .gitignore and -e "path" is also given;

 (2) is marked not to be ignored (i.e. "!path") in .gitignore but -e
    "path" is given;

 (3) is marked to be ignored in .gitignore but -e "!path" is given;

 (4) is marked not to be ignored in .gitignore and -e "!path" is also
     given;

 (5) perhaps other combinations like "!path" in a/.gitignore, and -e "a/path"
     from the command line.

What does the code actually do?
