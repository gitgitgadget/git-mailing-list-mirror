From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5537: re-drop http tests
Date: Fri, 30 May 2014 09:45:42 -0700
Message-ID: <xmqq38frb4g9.fsf@gitster.dls.corp.google.com>
References: <87y4xk8asq.fsf@spindle.srvr.nix>
	<20140530010649.GD28683@sigill.intra.peff.net>
	<20140530013419.GE28683@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nix <nix@esperi.org.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 18:45:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqPwH-0001Dq-M5
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 18:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933620AbaE3Qpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 12:45:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54756 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932148AbaE3Qpt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 12:45:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 673FA1B9EF;
	Fri, 30 May 2014 12:45:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kL2LzdhH0C+woRCFq4LHgCOGNbQ=; b=HmtzN6
	KBVhRpPE3q7kG98A4SiYBc2sHig8AHZxibua5UENyYygccY0G/YGgYOXa43J0B42
	Scw5hFtHcPJM4T7R7bO+O5WYK7KcH6W1YPACtbya1pL1GEAe7j1tVkx26q0Agqp1
	E9NzytgMdbCRJu3/4Dm8pHZFSMmceB2D+mt0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jNcxydpiD6TDZFZer29ug+e9iNe1wAE4
	FkrxboEgFgy3ob/Yg5ioMoPRbMgpE5Ysr6K+QEeahVO96ep6iYZeB5/Tua+PWxVq
	1AgGSvh/IitW2xMmx3k/9M1vFe2Io/1Fn9avg/4tE1kmDXARB+XiY78a0HBNArBf
	1JYXWvk5qJ0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5BDD41B9EE;
	Fri, 30 May 2014 12:45:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6EC5A1B9E8;
	Fri, 30 May 2014 12:45:44 -0400 (EDT)
In-Reply-To: <20140530013419.GE28683@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 29 May 2014 21:34:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D7DCD80E-E819-11E3-95A6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250443>

Jeff King <peff@peff.net> writes:

> And a final side note. If you retry the merge by:
>
>   m=1ddb4d7
>   git checkout $m^1
>   git merge $m^2
>
> you can see the resulting conflict is quite tricky to understand....
> Viewing it with diff3 conflict-style makes it much more obvious.

Yes, that was a clear mismerge on my side; thanks for catching it.

>
>  t/t5537-fetch-shallow.sh | 28 ----------------------------
>  1 file changed, 28 deletions(-)
>
> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index be951a4..a980574 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -173,33 +173,6 @@ EOF
>  	)
>  '
>  
> -if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
> -	say 'skipping remaining tests, git built without http support'
> -	test_done
> -fi
> -
> -LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5537'}
> -. "$TEST_DIRECTORY"/lib-httpd.sh
> -start_httpd
> -
> -test_expect_success 'clone http repository' '
> -	git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> -	git clone $HTTPD_URL/smart/repo.git clone &&
> -	(
> -	cd clone &&
> -	git fsck &&
> -	git log --format=%s origin/master >actual &&
> -	cat <<EOF >expect &&
> -7
> -6
> -5
> -4
> -3
> -EOF
> -	test_cmp expect actual
> -	)
> -'
> -
>  test_expect_success POSIXPERM,SANITY 'shallow fetch from a read-only repo' '
>  	cp -R .git read-only.git &&
>  	find read-only.git -print | xargs chmod -w &&
> @@ -213,5 +186,4 @@ EOF
>  	test_cmp expect actual
>  '
>  
> -stop_httpd
>  test_done
