From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/10] submodule add: send messages to stderr
Date: Mon, 02 May 2016 16:26:40 -0700
Message-ID: <xmqqy47soxcf.fsf@gitster.mtv.corp.google.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
	<1461976845-18228-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 01:26:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axNEn-0007jq-BH
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 01:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbcEBX0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 19:26:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932260AbcEBX0o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 19:26:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B8BCB17B46;
	Mon,  2 May 2016 19:26:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+i9vicx8WR2iUK7SAWoRuK1J39k=; b=lPPEt3
	kB8FaK3i10d7P5jDldyVeQGM+G9WqFLnfG9wR7VspjlSMu7zBXxox6VOvtRy/fVM
	qsUFZNar+9tne47P+r33rvTmp2ufD09N+OZIWNJBGedKl9p9eZoBkRGkf9r6+8/f
	FSPalcLtq1ltVWR+jUXq+btl/Z3png1rPkW9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W4IUgJup8Ez088Al2L+ucyGlCjtzLpKm
	OqWDmw0j9Edss2q8YUaGueLU3y4ezRz1dquRvYtj8ECgkVnM/ishQCEWc2avFfxE
	c+MHB9m83fClxZa3rC8qVhFVNVFaypPFipguocnMtjsaq2+ULN8ze2p+f2gbfr6T
	hxz2cowDY7I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B01FC17B45;
	Mon,  2 May 2016 19:26:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F39F517B44;
	Mon,  2 May 2016 19:26:41 -0400 (EDT)
In-Reply-To: <1461976845-18228-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 29 Apr 2016 17:40:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 53ADFFB2-10BD-11E6-94ED-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293302>

Stefan Beller <sbeller@google.com> writes:

> Reroute the output of stdout to stderr as it is just informative
> messages, not to be consumed by machines.
>
> This should not regress any scripts that try to parse the
> current output, as the output is already internationalized
> and therefore unstable.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Sounds sensible.

>  git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index d689265..f4d500e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -271,7 +271,7 @@ Use -f if you really want to add it." >&2
>  				echo >&2 "$(eval_gettext "use the '--force' option. If the local git directory is not the correct repo")"
>  				die "$(eval_gettext "or you are unsure what this means choose another name with the '--name' option.")"
>  			else
> -				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
> +				echo >&2 "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
>  			fi
>  		fi
>  		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" "$reference" "$depth" || exit
