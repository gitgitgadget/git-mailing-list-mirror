From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] branch: add --unset-upstream option
Date: Thu, 23 Aug 2012 14:20:03 -0700
Message-ID: <7vpq6h2tmk.fsf@alter.siamese.dyndns.org>
References: <1345470460-28734-1-git-send-email-cmn@elego.de>
 <1345470460-28734-3-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Aug 23 23:20:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4ep5-0003iQ-SJ
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 23:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412Ab2HWVUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Aug 2012 17:20:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40222 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756381Ab2HWVUH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 17:20:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C335482D9;
	Thu, 23 Aug 2012 17:20:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=186FzK9QWBkC
	c9xKaXkEn/Uga9g=; b=fUtBe2xq1uMBVRTgRuK9/2KOcdQ8EA/s2aYShz50yyRD
	T/t0Bn6KScpVaveACFanmt54KY2GhOyfI8iohxiS1t3qPU0ofYTQAgjRxxpK3S1R
	/n/c9qV1txJTiX32iM6yl7E2w7FXNK0Ovrxj1rEWUS5X+HS31vC/SF+Tn+P3DS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MqzHKr
	IvlZk4yU+cN6NvJUepDzOto/QvARC+T7SzfNQQWsRGAlmrwcOLYlUcgjDVXOmeNQ
	wMMRzzjzKjNvwA/gkJwOvBnxKAPUXSjyQWKn3NfNTPo8BzWyKGuRrPUOdxH4B4HM
	V7VvFEpmlUayowuhbxDA6tCYApzl0mx27ilDA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFE2B82D8;
	Thu, 23 Aug 2012 17:20:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14AA382D5; Thu, 23 Aug 2012
 17:20:04 -0400 (EDT)
In-Reply-To: <1345470460-28734-3-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Mon, 20 Aug 2012 15:47:39
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4EB88BB6-ED68-11E1-85D1-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204173>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index e9019ac..93e5d6e 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -383,6 +383,22 @@ test_expect_success 'use --set-upstream-to modif=
y a particular branch' \
>       test "$(git config branch.my13.remote)" =3D "." &&
>       test "$(git config branch.my13.merge)" =3D "refs/heads/master"'
> =20
> +test_expect_success 'test --unset-upstream on HEAD' \
> +    'git branch my14
> +     test_config branch.master.remote foo &&
> +     test_config branch.master.merge foo &&
> +     git branch --set-upstream-to my14 &&
> +     git branch --unset-upstream &&
> +     test_must_fail git config branch.master.remote &&
> +     test_must_fail git config branch.master.merge'
> +
> +test_expect_success 'test --unset-upstream on a particular branch' \
> +    'git branch my15
> +     git branch --set-upstream-to master my14 &&
> +     git branch --unset-upstream my14 &&
> +     test_must_fail git config branch.my14.remote &&
> +     test_must_fail git config branch.my14.merge'
> +

What should happen when you say "--unset-upstream" on a branch B
that does not have B@{upstream}?  Should it fail?  Should it be
silently ignored?  Is it undefined that we do not want to test?
