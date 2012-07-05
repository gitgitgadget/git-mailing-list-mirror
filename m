From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/12] git-remote-mediawiki: change return type of
 get_mw_pages
Date: Thu, 05 Jul 2012 16:18:38 -0700
Message-ID: <7vehoppzjl.fsf@alter.siamese.dyndns.org>
References: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
 <1341473772-28023-9-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 06 01:18:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmvJv-0006UV-AV
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 01:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933435Ab2GEXSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 19:18:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933323Ab2GEXSk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 19:18:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EFF09CDF;
	Thu,  5 Jul 2012 19:18:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/tW/zkE78f42oO3UAoNDiE5brWM=; b=W6VJGj
	SsBxi8z9rrP95l3ILazxoW5TyC0rxyDyM5nIsnO5LFD+AXoZDpoUypJdrmH/a0w8
	OYJEOA1i+Q+VVKYQeojMC7FKOpNWCoy3yeAPnGVpABbpiZSmZeKjuTqD3/vp66dk
	dllLxYdQLDJ86HyeFSbf94Yoo8uU+pJBCD+2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DswePM0ylBRCIEgvMzD6GrqTKUuQJq8k
	dPHi6ScAK/q1oCfaipXp6nrm+wjbdKGxUpCs5ai9mimbREoFkAtIEAg8DmdOqDE1
	xsOZKvk7DZs1VoPspY3CqVpRsO5tXDd/jQunWFbYhDK+6fXYNwbXaQVOvv5C6PN+
	DzveCoATD0U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 671139CDE;
	Thu,  5 Jul 2012 19:18:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE8719CDC; Thu,  5 Jul 2012
 19:18:39 -0400 (EDT)
In-Reply-To: <1341473772-28023-9-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Thu, 5 Jul 2012 09:36:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C149B250-C6F7-11E1-BB84-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201078>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The previous version was returning the list of pages to be fetched, but
> we are going to need an efficient membership test (i.e. is the page
> $title tracked), hence exposing a hash will be more convenient.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
> index 76b78bc..3f57598 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki
> +++ b/contrib/mw-to-git/git-remote-mediawiki
> @@ -377,7 +377,7 @@ sub get_mw_pages {
>  			get_all_mediafiles(\%pages);
>  		}
>  	}
> -	return values(%pages);
> +	return %pages;
>  }
>  
>  # usage: $out = run_git("command args");

This suggests the series is not based on 'master', which is not
fatal per-se ("am -3" guesses that came from b3d98595), but then
applying the series on mm/mediawiki-file-attachments topic will show
that the index line recorded in [PATCH 09/12] is useless.

On what commit was this meant to be applied???
