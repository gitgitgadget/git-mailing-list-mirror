From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: don't leak variable from the prompt into
 environment
Date: Wed, 09 Nov 2011 05:11:26 -0800
Message-ID: <7vd3d1widd.fsf@alter.siamese.dyndns.org>
References: <1320832970-26239-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Nov 09 14:11:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RO7wE-0006Ff-Hg
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 14:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747Ab1KINLa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Nov 2011 08:11:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655Ab1KINL3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2011 08:11:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D5005CBC;
	Wed,  9 Nov 2011 08:11:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Xp5LKYaEYeZY
	3ke9X7IT2kfIeD8=; b=Uvs61FbRn8LypCwQFN9Wu0KtbOc56GPa9NMZnOlKTFB8
	WVqTuypWmex2SOcO/4NxF3zIZCRTWGlG2WgwKyUBDi9sFfdlDvw/1GsYi2D5d8kj
	bb/aikcCfVkrI7uTgDnOO2Mj/li0mieeD2uipCfWXGZhe7jRbnnCO6EBArKdPLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=O0uyzg
	7Tlkk5JgiT9qFdtG3toN7+4BIThjT2sKW/qTlN77v3ZHufKu57kntFARn9cFUUHM
	ZclS68yLmDw51wIbPCtMnp4meGSrciYmZs0TQ2ZLqjIxIAs19eKAK9Xgad3FQG2j
	zSjCYG8dU366wwRRscoxBP8h8f/E2xujO6BYs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 958425CBB;
	Wed,  9 Nov 2011 08:11:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B58C5CBA; Wed,  9 Nov 2011
 08:11:28 -0500 (EST)
In-Reply-To: <1320832970-26239-1-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 9 Nov 2011 11:02:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 55840F28-0AD4-11E1-90F3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185155>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Commit e5b8eebc (completion: fix issue with process substitution not
> working on Git for Windows, 2011-10-26) introduced a new variable in
> __git_ps1_show_upstream(), but didn't declare it as local to prevent
> it from leaking into the environment.
> ---

Thanks; I'd consider this signed-off?

>  contrib/completion/git-completion.bash |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index b3571ab4..d18895b1 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -110,7 +110,7 @@ __git_ps1_show_upstream ()
>  	local upstream=3Dgit legacy=3D"" verbose=3D""
> =20
>  	# get some config options from git-config
> -	output=3D"$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\=
=2Eshowupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
> +	local output=3D"$(git config -z --get-regexp '^(svn-remote\..*\.url=
|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
>  	while read key value; do
>  		case "$key" in
>  		bash.showupstream)
