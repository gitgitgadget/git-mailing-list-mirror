From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] transport-helper: check if remote helper is alive
Date: Tue, 02 Apr 2013 17:35:51 -0700
Message-ID: <7v1uas8n88.fsf@alter.siamese.dyndns.org>
References: <1364898709-21583-1-git-send-email-felipe.contreras@gmail.com>
 <1364898709-21583-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 02:36:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNBgk-0004CM-Jt
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 02:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758254Ab3DCAf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 20:35:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52158 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757573Ab3DCAfz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 20:35:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 274F810514;
	Wed,  3 Apr 2013 00:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uAbCR/hytp4YO5d/ex4JjE1aUII=; b=a/TMKR
	S3DrYb/JH9EK+nRC2D5zkJ/d55bS2wckHrwFAnxWK3nhAU6h32afTiQ1Vab/C4i4
	k+lxYn3jYHxSozxakTMFZLaZuGv1dmJrRR2/hbVlU98t/D45d8N6TmKd31jwGHIR
	Ix7/E32jyrdoIH/wzqJ44c0Age1EMXHf1ww+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P1EOxtVB1+8ToEq7oH67cEjMslTJx25K
	1xKq9jq7e3k8NYOGvN3ScMGG/ki60jiVCUzRXoHazgdEXL4XJmMlU5P1TZRa28SN
	jpxZMHCmL83nhx4RXAnSDNOi5v+KAdzQOLZ7q+tkzrDEHmZoHe5mBQUYWQMru1Hm
	HWdGqdMdlUY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D22F10513;
	Wed,  3 Apr 2013 00:35:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D19B810512; Wed,  3 Apr
 2013 00:35:52 +0000 (UTC)
In-Reply-To: <1364898709-21583-3-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Tue, 2 Apr 2013 04:31:47 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70B1509E-9BF6-11E2-829E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219905>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Otherwise transport-helper will continue checking for refs and other
> things what will confuse the user more.
> ---

Sign-off?

>  git-remote-testgit        | 11 +++++++++++
>  t/t5801-remote-helpers.sh | 19 +++++++++++++++++++
>  transport-helper.c        |  8 ++++++++
>  3 files changed, 38 insertions(+)
>
> diff --git a/git-remote-testgit b/git-remote-testgit
> index b395c8d..ca0cf09 100755
> --- a/git-remote-testgit
> +++ b/git-remote-testgit
> @@ -61,12 +61,23 @@ do
>  			echo "feature import-marks=$gitmarks"
>  			echo "feature export-marks=$gitmarks"
>  		fi
> +
> +		if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
> +		then
> +			exit -1

That looks somewhat funny.  Why not exit 1 or exit 127?

> +		fi
> +


>  		echo "feature done"
>  		git fast-export "${testgitmarks_args[@]}" $refs |
>  		sed -e "s#refs/heads/#${prefix}/heads/#g"
>  		echo "done"
>  		;;
>  	export)
> +		if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
> +		then
> +			exit -1

Ditto.

> +		fi
> +
>  		before=$(git for-each-ref --format='%(refname) %(objectname)')
>  
>  		git fast-import "${testgitmarks_args[@]}" --quiet
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index f387027..efe67e2 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -166,4 +166,23 @@ test_expect_success 'push ref with existing object' '
>  	compare_refs local dup server dup
>  '
>  
> +test_expect_success 'proper failure checks for fetching' '
> +	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
> +	export GIT_REMOTE_TESTGIT_FAILURE &&
> +	cd local &&
> +	test_must_fail git fetch 2> error &&
> +	grep "Error while running helper" error
> +	)
> +'
> +
> +# We sleep to give fast-export a chance to catch the SIGPIPE
> +test_expect_failure 'proper failure checks for pushing' '
> +	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
> +	export GIT_REMOTE_TESTGIT_FAILURE &&
> +	cd local &&
> +	test_must_fail git push --all 2> error &&
> +	grep "Error while running helper" error
> +	)
> +'
> +
>  test_done
> diff --git a/transport-helper.c b/transport-helper.c
> index cb3ef7d..dfdfa7a 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -460,6 +460,10 @@ static int fetch_with_import(struct transport *transport,
>  
>  	if (finish_command(&fastimport))
>  		die("Error while running fast-import");
> +
> +	if (!check_command(data->helper))
> +		die("Error while running helper");
> +
>  	argv_array_free_detached(fastimport.argv);
>  
>  	/*
> @@ -818,6 +822,10 @@ static int push_refs_with_export(struct transport *transport,
>  
>  	if (finish_command(&exporter))
>  		die("Error while running fast-export");
> +
> +	if (!check_command(data->helper))
> +		die("Error while running helper");
> +
>  	push_update_refs_status(data, remote_refs);
>  	return 0;
>  }
