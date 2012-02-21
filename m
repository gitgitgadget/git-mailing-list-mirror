From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: Allow dash as the first character for
 __git_ps1
Date: Tue, 21 Feb 2012 12:40:46 -0800
Message-ID: <7vty2jgbsh.fsf@alter.siamese.dyndns.org>
References: <1329740273-5580-1-git-send-email-info@christian-hammerl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Hammerl <info@christian-hammerl.de>
X-From: git-owner@vger.kernel.org Tue Feb 21 21:40:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzwW6-0002v8-N2
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 21:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483Ab2BUUku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 15:40:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56072 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424Ab2BUUkt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 15:40:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 911706034;
	Tue, 21 Feb 2012 15:40:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IfoQSNpWJPlTNQ1zsZJEKQaZ8us=; b=KGEyL8
	ges9fP7PECDWv+QRrpEIrvMGkaAuB+M/X7eE5tI23c4ughkTWIPBI3XF3bm1PRn0
	GFFYV+kA3i79XCtf0nCBP47eUPLisKAccoo8EmkU/xcVNwOK0o621PuK/XQyx6V4
	MWcDoLMYnTPoapihNRgE+OcTkC0QyR994HU3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iiruMq4CUl4iRBt/2yVfaD22z9671EbP
	aFGBx+5A+oX2Eiu23qeXbhuAMN/mxmXg0t6tVrCz7aB2e5pJDlFZlCbScvl5nFpW
	lMq/6OCnHZyQqAsoS/e4/2BEkTs9g0+9yj0dtQvBZtdbu9F+bMxPXJLUnpXh9Cgl
	nI0ijeqI5DA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86D166033;
	Tue, 21 Feb 2012 15:40:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C8BC6032; Tue, 21 Feb 2012
 15:40:48 -0500 (EST)
In-Reply-To: <1329740273-5580-1-git-send-email-info@christian-hammerl.de>
 (Christian Hammerl's message of "Mon, 20 Feb 2012 13:17:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 55DA64FA-5CCC-11E1-ABCE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191180>

Christian Hammerl <info@christian-hammerl.de> writes:

> If the argument for `__git_ps1` begins with a dash, `printf` tries to
> interpret it as an option which results in an error message.
> The problem is solved by adding '--' before the argument to tell
> `printf` to not interpret the following argument as an option.
> Adding '--' directly to the argument does not help because the argument
> is enclosed by double quotes.
>
> Signed-off-by: Christian Hammerl <info@christian-hammerl.de>
> ---
>  contrib/completion/git-completion.bash |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 91c7acb..61ff152 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -313,7 +313,7 @@ __git_ps1 ()
>  		fi
>  
>  		local f="$w$i$s$u"
> -		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
> +		printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
>  	fi
>  }

Hmm, so you may be doing something like PS1='\W$(__git_ps1 "-%s")'?
OK, and thanks.  
