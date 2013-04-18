From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: fix commit messages
Date: Thu, 18 Apr 2013 10:43:18 -0700
Message-ID: <7vhaj368g9.fsf@alter.siamese.dyndns.org>
References: <1366265191-20815-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Simon Ruderich <simon@ruderich.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 19:43:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USsrq-0000Gj-Aq
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 19:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154Ab3DRRn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 13:43:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33738 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753938Ab3DRRnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 13:43:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B59A717E5B;
	Thu, 18 Apr 2013 17:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=W2KJd4T3Is0ABNho1F9w0nyzJ/c=; b=w8iG8zOMQny37Dldh1to
	EI6G2ejepkV9dbLnjznuqAWBX0b5+QjdA8wshmy7druwOWfi2+luVv4/NSfxeZri
	qYszPKRbbEwkxAQ0MM4P1cvmcXXYSxtJfTf8HP8vUS5GuuzpSA8l9lNF4LRWEqBT
	SSutZsfTjwK6iwMF8limIU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hHBUgEl4zloZ+TNetdi0JwZcnyo+yviwa8zQcYGzaRVYXO
	n0f+KZCogAlcJuIbW5r01+jPUsmwA6CrGAlLgSdd0UZSCLDS+zUDTlTRn/A2HCBn
	O9yW9aN0+Xm5j4iG04voGuYgLtm7k4G9MHlwdJ/p1aN85ixlJivuohilLZseg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A99DC17E59;
	Thu, 18 Apr 2013 17:43:23 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F7C117E53;
	Thu, 18 Apr 2013 17:43:22 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 773A86E6-A84F-11E2-9A60-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221677>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> git fast-import expects an extra newline after the commit message data,
> but we are adding it only on hg-git compat mode, which is why the
> bidirectionality tests pass.
>
> We should add it unconditionally.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Without knowing that hg-git compat mode is what is used in bidi test
(the only mode that supports bidi), "which is why" was ungrokkable.

This is a trivial change without downside risk so I do not mind
applying it to 'maint', as you say it is an appropriate there.

>  contrib/remote-helpers/git-remote-hg | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index a5f0013..5481331 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -362,6 +362,8 @@ def export_ref(repo, name, kind, head):
>          else:
>              modified, removed = get_filechanges(repo, c, parents[0])
>  
> +        desc += '\n'
> +
>          if mode == 'hg':
>              extra_msg = ''
>  
> @@ -385,7 +387,6 @@ def export_ref(repo, name, kind, head):
>                  else:
>                      extra_msg += "extra : %s : %s\n" % (key, urllib.quote(value))
>  
> -            desc += '\n'
>              if extra_msg:
>                  desc += '\n--HG--\n' + extra_msg
