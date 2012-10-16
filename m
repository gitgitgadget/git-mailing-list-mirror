From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Change colors to be based on git status -sb in color
 mode
Date: Tue, 16 Oct 2012 08:58:07 -0700
Message-ID: <7vvceatnn4.fsf@alter.siamese.dyndns.org>
References: <7vlif7wqqb.fsf@alter.siamese.dyndns.org>
 <20121016053257.GA8366@simaj.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git@drmicha.warpmail.net, spearce@spearce.org,
	artagnon@gmail.com, schwab@linux-m68k.org, soosthoek@nieuwland.nl,
	junio@pobox.com
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Oct 16 17:58:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO9XC-0002DJ-H2
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 17:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674Ab2JPP6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 11:58:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53155 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754371Ab2JPP6K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 11:58:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E2CE8451;
	Tue, 16 Oct 2012 11:58:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JSEOxqViiZYXDmqJRGbR7eSLA0U=; b=PQUkVC
	+6K3zFYjXPs6Xje46rYJUlvXh6GPLrKow0Sv3DcXR6GLfCWao8alMXmuonEcqU0s
	/v9FVKyNIF3EtJakP1Oe6VswWNC/auAmKH0sPp+j9km1hLvBg9lRMxHhtwb81Q1M
	OZ9tE36zefYlvFQLdb/kBSoD3N88csVtXMjT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DIsNGq3lVIwgyIvjjy8rZhdWQLc0v1MU
	/sPh/0gGe+ChmSlD4/8DdGhUOInqjUttJ+2veeFueY202ziXFX+OoKPE3PPeU6gl
	wyhyVI1eD/YPvklAHrOQKYhWzc5OmXw6jD2xZSJj3rVQiYfU/fxMMZcYzjcroSRQ
	Yr/UTwJ/hvY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 388868450;
	Tue, 16 Oct 2012 11:58:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0ACE844F; Tue, 16 Oct 2012
 11:58:08 -0400 (EDT)
In-Reply-To: <20121016053257.GA8366@simaj.xs4all.nl> (Simon Oosthoek's
 message of "Tue, 16 Oct 2012 07:32:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 478AA6D2-17AA-11E2-A700-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207839>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

> this patch is an additional patch to the previous series of two.


> @@ -325,35 +323,45 @@ __git_ps1 ()
>  
>  		local f="$w$i$s$u"
>  		if [ $pcmode = yes ]; then
> +			if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
>  				local c_red='\e[31m'
>  				local c_green='\e[32m'
>  				local c_lblue='\e[1;34m'
>  				local c_clear='\e[0m'
>  				local branchstring="$c${b##refs/heads/}"
> +				local branch_color="$c_clear"
> +				local flags_color="$c_lblue"
>  
> +				case "$b" in 
> +					\(*\))	branch_color="$c_red"
> +					;;
> +					*)	local branch_color="$c_green"
> +					;;
> +				esac

Why "local" only on one side and not the other?

Also switching on "$b" and relying on how it happens to be formatted
inside parentheses when detached (which can very well change in the
future) looks like a fragile bug waiting to be triggered.

>  				# Setting PS1 directly with \[ and \] around colors
>  				# is necessary to prevent wrapping issues!
> +				PS1="$ps1pc_start (\[$branch_color\]$branchstring\[$c_clear\]"
> +
> +				if [ -n "$w$i$s$u$r$p" ]; then
> +					PS1="$PS1 "
> +				fi
> +				if [ "$w" = "*" ]; then
> +					PS1="$PS1\[$c_red\]$w"
> +				fi
> +				if [ -n "$i" ]; then
> +					PS1="$PS1\[$c_green\]$i"
> +				fi

You gave nice symbolic names to branch_color and flags_color, but
these two use hardcoded colors?
