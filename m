From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] checkout: prefix --to argument properly when cwd is moved
Date: Tue, 29 Jul 2014 13:51:25 -0700
Message-ID: <xmqq8unb3n3m.fsf@gitster.dls.corp.google.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
	<1406641831-2390-1-git-send-email-pclouds@gmail.com>
	<1406641831-2390-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	git@drmicha.warpmail.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 22:51:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCEN1-0002WG-JZ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 22:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914AbaG2Uvf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 16:51:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52026 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbaG2Uve convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2014 16:51:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B1D62C8DD;
	Tue, 29 Jul 2014 16:51:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BixtEOMRo7ue
	Yn9FMCJUOsaJVNs=; b=S5F8DIcx34RkqOY5t13HkSVxS0HWtlFAkHzLk9ETQKlF
	VmpYA+3k0qXQm2ZqP9zkVApzmCqTA5m5mEymibN992QxAh0xOigx7OyTxjmEXzco
	bwPJ98XOAhR5TPacfEAgjmj99KzY4Uqbj41qFhNjItus8tmwt7/SheMheLcoZBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XRz+Vb
	dWLvFgkLzXiJUUTq7GClVRVAw4TVDD3iB2AuckIS4TwnW1vTmjpSchLaOYRj4PsO
	uTTaJN+qqOIXk7Ah4Q5kHJC6pnIz1f90HYJioGY9T0RFf4BrWCCUWHQuR4Q16S8E
	QDm47ZAy4Y9zNX+gPlm1ws557CSmWYMySH5zA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 20D662C8DC;
	Tue, 29 Jul 2014 16:51:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 478132C8CD;
	Tue, 29 Jul 2014 16:51:27 -0400 (EDT)
In-Reply-To: <1406641831-2390-8-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 29
 Jul 2014 20:50:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1C10D54E-1762-11E4-BCF5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254469>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/checkout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 173aab1..4fbb9c1 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1342,7 +1342,7 @@ int cmd_checkout(int argc, const char **argv, c=
onst char *prefix)
>  			 N_("do not limit pathspecs to sparse entries only")),
>  		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
>  				N_("second guess 'git checkout no-such-branch'")),
> -		OPT_STRING(0, "to", &opts.new_worktree, N_("path"),
> +		OPT_FILENAME(0, "to", &opts.new_worktree,
>  			   N_("check a branch out in a separate working directory")),
>  		OPT_END(),
>  	};

Good thinking.  Otherwise this would not work from within a
subdirectory.  Perhaps you would want a test for it?

An unrelated tangent, but would we want to further enhance
OPT_FILENAME() to understand ~/path and ~user/path perhaps?
It is easy to rely on users' shells to do so, so it is not a big
deal and it certainly is unrelated to this particular topic.
