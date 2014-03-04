From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] t3200-branch: test setting branch as own upstream
Date: Tue, 04 Mar 2014 15:56:59 -0800
Message-ID: <xmqqmwh5ikl0.fsf@gitster.dls.corp.google.com>
References: <1393569662-68351-1-git-send-email-modocache@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 00:57:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKzCv-0000Pi-GW
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 00:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757AbaCDX5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 18:57:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755400AbaCDX5C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 18:57:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 189067153C;
	Tue,  4 Mar 2014 18:57:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OobUEdanc7/99OXwQXBfK2zzUaY=; b=QDopmP
	Ji8p5jVFw7DU3uKu5LJvHrYymPaPlpTc/2C3h7CJa/ooHeaiSkMIP5jqk5OpioZH
	G++L7FMbFKNwJ2syjQKN4k6rC9GZDBH78cKXVSvX1yvq+lHKYGbFAHYLHiLHVAvV
	0/s9TgHtxAObO3HIP9pb/RInlcPTibyI6N998=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TcMR9pj3+I/oeSheSIzau1rOrib7WTuQ
	Q31YvYDiG5+7T4LCK9dkI8/PgNyCw0aGvFvmfx8WGEe9FAJ5WJy9ECdO7jwmxbik
	GVUBirg1h/DageTbmNwjfZIa1MEsBmvCBV3XCXCX5LVy602q1AJ/+KW6zUSXH6H/
	zxRSM0jkPFA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0670F7153B;
	Tue,  4 Mar 2014 18:57:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4701871539;
	Tue,  4 Mar 2014 18:57:01 -0500 (EST)
In-Reply-To: <1393569662-68351-1-git-send-email-modocache@gmail.com> (Brian
	Gesiak's message of "Fri, 28 Feb 2014 15:41:02 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ADB832EA-A3F8-11E3-B1AA-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243406>

Brian Gesiak <modocache@gmail.com> writes:

> No test asserts that "git branch -u refs/heads/my-branch my-branch"
> emits a warning. Add a test that does so.
>
> Signed-off-by: Brian Gesiak <modocache@gmail.com>
> ---
>  t/t3200-branch.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index fcdb867..6164126 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -507,6 +507,14 @@ EOF
>  	test_cmp expected actual
>  '
>  
> +test_expect_success '--set-upstream-to shows warning if used to set branch as own upstream' '
> +	git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
> +	cat >expected <<EOF &&
> +warning: Not setting branch my13 as its own upstream.
> +EOF
> +	test_i18ncmp expected actual
> +'
> +

Checking the error message is fine, but we are also interested in
seeing that we do not leave such a nonsense configuration, if not
more.  Shouldn't we check the resulting config as well here?

>  # Keep this test last, as it changes the current branch
>  cat >expect <<EOF
>  $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
