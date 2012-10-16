From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Change colors to be based on git status -sb in color
 mode
Date: Tue, 16 Oct 2012 15:04:58 -0700
Message-ID: <7vhapuqdit.fsf@alter.siamese.dyndns.org>
References: <7vvceatnn4.fsf@alter.siamese.dyndns.org>
 <20121016193405.GA12073@simaj.xs4all.nl>
 <7vtxtuqf3z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git@drmicha.warpmail.net, spearce@spearce.org,
	artagnon@gmail.com, schwab@linux-m68k.org, soosthoek@nieuwland.nl,
	junio@pobox.com
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Oct 17 00:05:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOFGG-0008Es-Ty
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 00:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966Ab2JPWFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 18:05:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976Ab2JPWFB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 18:05:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5396971F;
	Tue, 16 Oct 2012 18:05:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CZQhyDc8TKqxUBYndtLTmEb2goE=; b=oYGppF
	0cHR/i9KLXbPbex2U1YDLyPqrKquNWk/2apHOiiutxtuAE4Lv87p68tKz9Mfjd6W
	C3p+Gionw60JLBOtCCrztJlG5mkJKDud4DuLv4i1pOwKMi48ktMkRhUIYvVDtthw
	OuenYZZphPV1zNRTIzkI7HrcCqbrA8gL6i2Rg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ptNstiKa16gEgKDmVAJp1cR8RocV4+rl
	tliVjLVXiqoRG0R/wJ9RtyzM1KnkBDBREhFj0LWBaTPgcD3zafzPDnQ9+UhpacTx
	MOX++TeWKfqW+e+9DUwJHBGF46jiokGjd1xJ09HBnCrllv7cGZd4IHcEmM/Yboh1
	3mI0utTcVuU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2B43971D;
	Tue, 16 Oct 2012 18:05:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4399971B; Tue, 16 Oct 2012
 18:04:59 -0400 (EDT)
In-Reply-To: <7vtxtuqf3z.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 16 Oct 2012 14:30:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 874F2328-17DD-11E2-A155-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207882>

Junio C Hamano <gitster@pobox.com> writes:

> Simon Oosthoek <s.oosthoek@xs4all.nl> writes:
>
>> Hi
>>
>> Fixed the mistakes of the last one, and I'm now using the symbolic names "ok_color" and "bad_color".
>> The test for headless state is now more direct, and I hope it is still correct.
>>
>> /Simon
>
> Will apply with a bit more readable log message.
>
> I think it would be a good idea to squash something like the
> attached into this patch, though.

The reason for this suggestion is not to avoid running symbolic-ref
twice (which is a good side effect, though).  When you are in the
middle of bisection or multi-commit cherry-pick, for example, you
would conceptually be working on the original branch, but the HEAD
pointer may be detached.  Earlier parts of the existing code in the
function makes this distinction, and the same distinction should be
carried over to the new code that decides the color to paint things
in.

>  contrib/completion/git-prompt.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git i/contrib/completion/git-prompt.sh w/contrib/completion/git-prompt.sh
> index dced628..9f0b6bb 100644
> --- i/contrib/completion/git-prompt.sh
> +++ w/contrib/completion/git-prompt.sh
> @@ -215,7 +215,7 @@ __git_ps1_show_upstream ()
>  __git_ps1 ()
>  {
>  	local pcmode=no
> -	#defaults/examples:
> +	local detached=no
>  	local ps1pc_start='\u@\h:\w '
>  	local ps1pc_end='\$ '
>  	local printf_format=' (%s)'
> @@ -264,7 +264,7 @@ __git_ps1 ()
>  			fi
>  
>  			b="$(git symbolic-ref HEAD 2>/dev/null)" || {
> -
> +				detached=yes
>  				b="$(
>  				case "${GIT_PS1_DESCRIBE_STYLE-}" in
>  				(contains)
> @@ -335,8 +335,7 @@ __git_ps1 ()
>  				local flags_color="$c_lblue"
>  				local branchstring="$c${b##refs/heads/}"
>  
> -				if git symbolic-ref HEAD 2>/dev/null 1>&2
> -				then
> +				if [ $detached = yes ]; then
>  					branch_color="$ok_color"
>  				else
>  					branch_color="$bad_color"
