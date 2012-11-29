From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] If `egrep` is aliased, temporary disable it in
 bash.completion
Date: Thu, 29 Nov 2012 09:03:00 -0800
Message-ID: <7vpq2wqr3v.fsf@alter.siamese.dyndns.org>
References: <20121129151418.GA19169@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Adam Tkac <atkac@redhat.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 18:03:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te7WD-0005ZP-Us
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 18:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938Ab2K2RDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 12:03:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33942 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269Ab2K2RDE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 12:03:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F47BA074;
	Thu, 29 Nov 2012 12:03:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=je9aiEqAlq5mnC6F5TyIIy0RfWI=; b=XGP5Q0
	/sMgoie9Klisxcfj0GieWEPH/o/E35xZxbOEvPDq52jI0tTynRsQASjTOfn1tJ2h
	xYGPBV+BX5JLP1no7hDGvKm79pGstG6LrC6IN3KfN5iPa/dgVhmCWbBZT4jfyLxF
	6RdTwznwEYxXcirdS6yNox562QbKWHp30Atks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DqO842CwKljvVSxo2dmrskWENldUFObS
	A6JhK8DM2OHlzJ7NBb/2J7lWBTUG+Ryk/WQV70K9Moel32mDcusqVhNky3714ze0
	AenLwZ/Q0FW9q04URo/rcbjCHU7JoAY6Xej6ycNJIbTUDlPExjjSu9zoEu+O/nHM
	3c3yfs8hTvI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 898F5A072;
	Thu, 29 Nov 2012 12:03:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E84E8A06E; Thu, 29 Nov 2012
 12:03:01 -0500 (EST)
In-Reply-To: <20121129151418.GA19169@redhat.com> (Adam Tkac's message of
 "Thu, 29 Nov 2012 16:14:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A24CD63A-3A46-11E2-8A61-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210848>

Adam Tkac <atkac@redhat.com> writes:

> Subject: Re: [PATCH v2] If `egrep` is aliased, temporary disable it in bash.completion

The code does not seem to do anything special if it is not aliased,
though, so "If ..." part does not sound correct; perhaps you meant
"just in case egrep is aliased to something totally wacky" or
something?

The script seems to use commands other than 'egrep' that too can be
aliased to do whatever unexpected things.  How does this patch get
away without backslashing them all, like

	\echo ...
        \sed ...
        \test ...
        \: comment ...
	\git args ...

and still fix problems for users?  Can't the same solution you would
give to users who alias one of the above to do something undesirable
be applied to those who alias egrep?

Puzzled...

> Originally reported as https://bugzilla.redhat.com/show_bug.cgi?id=863780
>
> Signed-off-by: Adam Tkac <atkac@redhat.com>
> Signed-off-by: Holger Arnold <holgerar@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 0960acc..79073c2 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -565,7 +565,7 @@ __git_complete_strategy ()
>  __git_list_all_commands ()
>  {
>  	local i IFS=" "$'\n'
> -	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
> +	for i in $(git help -a| \egrep '^  [a-zA-Z0-9]')
>  	do
>  		case $i in
>  		*--*)             : helper pattern;;
> -- 
> 1.8.0
