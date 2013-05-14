From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-bzr: update old organization
Date: Tue, 14 May 2013 10:30:55 -0700
Message-ID: <7v1u99lb8w.fsf@alter.siamese.dyndns.org>
References: <1368505227-16661-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 19:31:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcJ43-0007zh-Vm
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 19:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab3ENRa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 13:30:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41765 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936Ab3ENRa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 13:30:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD8601EBD0;
	Tue, 14 May 2013 17:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AJW6gSUpusG1M7/CfQKVjgym5v4=; b=GhjKAU
	h+mu29EOmJFyTO5Xe48YoijOCwN+2JJDg1P+iNezmYI5dZhIu4mgpQ0n1Z/LeMxM
	UJgql6mltUuvc7flUZJ//QSH94nGJ7ikl0OlMuabIUBffTyZgaaAHqvFLIs1kSVZ
	ZTUvnb5LPqq9+JYw/ZIAhH92Zlw/oVLo7QR8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xURkRlAAdFR9R1DThXbuFp0PDPWtSjGx
	PQp+UFnMLDKWSkVeXgOmW8DhJpM5eXKD4ONMNGM6rPhT2n8ZNhLLHzfZQQzDC6QL
	H6b7NJ0znO3jY3yDZvuK/UY/f7cc0JRbcBZVF/2j/UzFk+JEa1SdT/YlBGw0PPNh
	coglIQPEa0w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2C761EBCF;
	Tue, 14 May 2013 17:30:57 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 081631EBCE;
	Tue, 14 May 2013 17:30:56 +0000 (UTC)
In-Reply-To: <1368505227-16661-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 13 May 2013 23:20:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 094C5ADE-BCBC-11E2-B755-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224302>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> If a clone exists with the old organization (v1.8.2) it will prevent the
> new shared repository organization from working, so let's remove this
> repository, which is not used any more.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

What happens with and without this patch to an existing user from
1.8.2 days, when she does what?

A sample answer (to show the level of descriptiveness, not the
content, I am epecting) might go something like "Because the
organization is different, it will barf whenever she tries to
incrementally update from the other side. By removing the old one
1.8.3 contrib/ does not understand, at least we can unstuck her; she
ends up reimporting the whole history, though."

Trying to see if this is a 1.8.3 "fast-track" material.

>  contrib/remote-helpers/git-remote-bzr | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
> index 3e452af..b295dd4 100755
> --- a/contrib/remote-helpers/git-remote-bzr
> +++ b/contrib/remote-helpers/git-remote-bzr
> @@ -830,6 +830,13 @@ def get_repo(url, alias):
>          clone_path = os.path.join(dirname, 'clone')
>          if not os.path.exists(clone_path):
>              os.mkdir(clone_path)
> +        else:
> +            # check and remove old organization
> +            try:
> +                bdir = bzrlib.bzrdir.BzrDir.open(clone_path)
> +                bdir.destroy_repository()
> +            except bzrlib.errors.NotBranchError:
> +                pass
>  
>      try:
>          repo = origin.open_repository()
