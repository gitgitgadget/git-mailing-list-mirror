From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [submodule] Add depth to submodule update
Date: Mon, 24 Jun 2013 22:07:55 -0700
Message-ID: <7vtxkm4w2c.fsf@alter.siamese.dyndns.org>
References: <1371974698-28685-1-git-send-email-iveqy@iveqy.com>
	<20130624224925.GC32270@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jun 25 07:08:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrLU3-00017P-LF
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 07:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234Ab3FYFH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 01:07:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab3FYFH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 01:07:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BCBC268E3;
	Tue, 25 Jun 2013 05:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eIaKqq+OccPIvilahVHoPiBFvMk=; b=onOL+c
	0bQItsEYzxMMptjlRvfsS9TNHY7GKBRkjdvSNRduGSZIQN4hcybBILJDLagUKy4n
	eiXODgmWmS/jeMPbN7gMS6hkJfzKWSc+7OkkjsVxAX69TgR7CpxrIBlBBzcLyJ35
	KJirZf5uppDZR+coTb2AM+4lgnKFS8Govbq0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yhms+oFAk7EecUYkyAaRcqbd7z5egWcT
	gQfjRKVpvsYprms34lrN9a39a9pnyJe7YcViV3JT3FqKA5QdNF+nIBJ2hhfKVP7S
	HMec0mghQyAxSgsfaj/ALjkOnuwpvNAkNjZ9GwvGgQlmUS4K6Rw32qHvJT9Q2KxY
	K8zAAbCl1tE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E54A268E2;
	Tue, 25 Jun 2013 05:07:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78E3F268DE;
	Tue, 25 Jun 2013 05:07:56 +0000 (UTC)
In-Reply-To: <20130624224925.GC32270@paksenarrion.iveqy.com> (Fredrik
	Gustafsson's message of "Tue, 25 Jun 2013 00:49:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3293FE06-DD55-11E2-A487-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228943>

Summoning area experts ;-)

Thanks.

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> Used only when a clone is initialized. This is useful when the submodule(s)
> are huge and you're not really interested in anything but the latest commit.
>
> Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
> ---
>  git-submodule.sh | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 79bfaac..b102fa8 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -211,12 +211,18 @@ module_clone()
>  	name=$2
>  	url=$3
>  	reference="$4"
> +	depth=$5
>  	quiet=
>  	if test -n "$GIT_QUIET"
>  	then
>  		quiet=-q
>  	fi
>
> +	if test -n "$depth"
> +	then
> +		depth="--depth=$depth"
> +	fi
> +
>  	gitdir=
>  	gitdir_base=
>  	base_name=$(dirname "$name")
> @@ -233,7 +239,7 @@ module_clone()
>  		mkdir -p "$gitdir_base"
>  		(
>  			clear_local_git_env
> -			git clone $quiet -n ${reference:+"$reference"} \
> +			git clone $quiet $depth -n ${reference:+"$reference"} \
>  				--separate-git-dir "$gitdir" "$url" "$sm_path"
>  		) ||
>  		die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path' failed")"
> @@ -676,6 +682,9 @@ cmd_update()
>  		--checkout)
>  			update="checkout"
>  			;;
> +		--depth)
> +			depth=$2
> +			;;
>  		--)
>  			shift
>  			break
> @@ -735,7 +744,7 @@ Maybe you want to use 'update --init'?")"
>
>  		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
>  		then
> -			module_clone "$sm_path" "$name" "$url" "$reference" || exit
> +			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
>  			cloned_modules="$cloned_modules;$name"
>  			subsha1=
>  		else
> --
> 1.8.0
