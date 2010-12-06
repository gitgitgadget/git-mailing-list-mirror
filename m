From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] parse-remote: handle detached HEAD
Date: Sun, 05 Dec 2010 19:33:31 -0800
Message-ID: <7vfwubtw1g.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=yfuiFuatshYuS2Q0EV0Ytj-QFKpuXAWeGerQB@mail.gmail.com>
 <1291593517-4406-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Dec 06 04:34:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPRq2-0001zh-4c
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 04:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab0LFDdo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Dec 2010 22:33:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab0LFDdn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Dec 2010 22:33:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 559402294;
	Sun,  5 Dec 2010 22:34:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=c7ZtE1CjSIfD
	QA5JVZp34HY0MOk=; b=wzzqE11QMtvUBQNcCq59yQi5oKZWl8fY1NuL/5rxIPb6
	DFk+3veHEPwc1AUy/zca3tJwVOoniCublw9HpQFh0SCHr3ufm3lYdnMqa6J5Dxbn
	rXHo88tqLUlMYt3ZHwLdqkoC4yu1QV4RvrbvOiWBXZu0y1k5yH46BJPj75PDm44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N/SHiq
	I8ULB/VO/kzO+h/dX+VhRJXziNXi/SbmoPKTW3Ms91yap1XBbMYzUgqiVLjMKXMv
	Ub6G3Df2iPOHprpFYeo5m01sgYar4NWTN04SnSOwbCZV08y0lnhG2jd8r+d+Mlwo
	6MIjetRvE8KsmSfuib2vS1dqV9cRaodDRSKa4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 261372293;
	Sun,  5 Dec 2010 22:34:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B14772292; Sun,  5 Dec 2010
 22:33:55 -0500 (EST)
In-Reply-To: <1291593517-4406-1-git-send-email-santi@agolina.net> ("Santi
 =?utf-8?Q?B=C3=A9jar=22's?= message of "Mon\,  6 Dec 2010 00\:58\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA082E44-00E9-11E0-AC99-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162970>

Santi B=C3=A9jar <santi@agolina.net> writes:

> In get_remote_merge_branch 'git for-each-ref' is used to know the
> upstream branch of the current branch ($curr_branch). But $curr_branc=
h
> can be empty when in detached HEAD, so the call to for-each-ref is
> made without a pattern.
>
> Quote the $curr_branch variable in the git for-each-ref call to alway=
s
> provide a pattern (the current branch or an empty string) Otherwise i=
t
> would mean all refs.

What output do you want to see in this case?  "Nothing needs to be
reported because on detached head you are not tracking anything?"

If that is the case, shouldn't we be not calling "echo" at all to begin
with?  IOW, shouldn't the code read more like this?

	curr_branch=3D$(git symbolic-ref -q HEAD) &&
        test "$origin" =3D "$default" &&
	echo ...

> Reported-by: Sverre Rabbelier <srabbelier@gmail.com>
> Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
> Tested-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
> Changes since v1:
>   Tags for Reported-by and Tested-by.
>
>  git-parse-remote.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index 5f47b18..07060c3 100644
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -68,7 +68,7 @@ get_remote_merge_branch () {
>  	    test -z "$origin" && origin=3D$default
>  	    curr_branch=3D$(git symbolic-ref -q HEAD)
>  	    [ "$origin" =3D "$default" ] &&
> -	    echo $(git for-each-ref --format=3D'%(upstream)' $curr_branch)
> +	    echo $(git for-each-ref --format=3D'%(upstream)' "$curr_branch"=
)
>  	    ;;
>  	*)
>  	    repo=3D$1
