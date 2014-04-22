From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.c: treat RUN_SETUP_GENTLY and RUN_SETUP as mutually exclusive
Date: Tue, 22 Apr 2014 12:37:30 -0700
Message-ID: <xmqqvbu140lh.fsf@gitster.dls.corp.google.com>
References: <1398127676-12311-1-git-send-email-mcgrof@do-not-panic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 21:37:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcgVf-0005SR-KR
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 21:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbaDVThg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 15:37:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60810 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbaDVThe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 15:37:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54B357FB2B;
	Tue, 22 Apr 2014 15:37:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zJfeCBfT9KO5NPe0aPQyF5Cp14M=; b=r8fyFC
	lxolBHx7BUahdedwjWN6YwR095Md7w3yD76/6jakYS3HpfiSvViQEbl8eM/R9hzu
	Avzco56VsTX5vMN01VAYAVlSm5LOLZiVIUSJn0ROHvNpYslmyc9W2z2EhxAZYn7t
	OPvfC+tNRI0RzL33Zpsgnm3iC4a4CIXkz7e3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NqT2zdUWiVY7oqVp6HthvTsa3QoDWbfS
	3WQq+B286rRG/3KUZh+bAmlLu2Dm+Ab7p7F/O5fvdW1LAP0xSystW7SpcBTunpn3
	MjE5faIF+TwDHc5ZT5b6JHt8uaDiy6p+1REoEDFT3f+VReFlY6zAjHtTLWmTV83x
	eOwBymuODKc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 395E97FB29;
	Tue, 22 Apr 2014 15:37:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5ED3D7FB24;
	Tue, 22 Apr 2014 15:37:32 -0400 (EDT)
In-Reply-To: <1398127676-12311-1-git-send-email-mcgrof@do-not-panic.com> (Luis
	R. Rodriguez's message of "Mon, 21 Apr 2014 17:47:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8C30CAB4-CA55-11E3-B56B-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246776>

"Luis R. Rodriguez" <mcgrof@do-not-panic.com> writes:

> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> This saves us a few branches when RUN_SETUP is set up.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---

Makes sense, especially because there is no sane reason to set both
bits on.

>  git.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git.c b/git.c
> index 9efd1a3..7780572 100644
> --- a/git.c
> +++ b/git.c
> @@ -290,7 +290,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  	if (!help) {
>  		if (p->option & RUN_SETUP)
>  			prefix = setup_git_directory();
> -		if (p->option & RUN_SETUP_GENTLY) {
> +		else if (p->option & RUN_SETUP_GENTLY) {
>  			int nongit_ok;
>  			prefix = setup_git_directory_gently(&nongit_ok);
>  		}
