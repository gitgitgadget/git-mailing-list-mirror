From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/13] contrib/subtree: Handle '--prefix' argument with a
 slash appended
Date: Mon, 04 Feb 2013 21:16:33 -0800
Message-ID: <7vsj5bwdam.fsf@alter.siamese.dyndns.org>
References: <1360037173-23291-1-git-send-email-greened@obbligato.org>
 <1360037173-23291-13-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Nylen <jnylen@gmail.com>, git@vger.kernel.org,
	Techlive Zheng <techlivezheng@gmail.com>,
	Wayne Walter <wayne@tickzoom.com>,
	"Avery Pennarun \"" <apenwarr@gmail.com>,
	Jakub Suder <jakub.suder@gmail.com>,
	John Yani <vanuan@gmail.com>,
	"David A. Greene <greened@obbligato.org>"@b-sasl-quonix.pobox.com
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 06:16:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2atu-0001KT-Lq
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 06:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807Ab3BEFQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 00:16:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37298 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719Ab3BEFQf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 00:16:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64A1EBE96;
	Tue,  5 Feb 2013 00:16:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zfKLlCGH2N9B3vSjThoFZ98YXn8=; b=Nw/dco
	tAxVFL5nuAYo/Ng3iGG5f94ybSbryd1dxhvd2zSxDPe1Bf5jSRIqVqcbK4KZMfis
	2ItpgE9fVmMSCJWTXaz+akCr0vIxRr1wV9f0JDhBzTC/OJPhDIqmLzuDpW9IBCM9
	bNYnH4u7GCXFuwD321Vf2L3omqQNEXqbwGqvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TRX5XkCXRp+mDfNlVH99R+B05cUr68Gp
	HDJIeOyVqT3ZbU3NRkZBnPI9p0E9h6xcyo+CeOdVinPVSGLf2tlUjlgSuZt1kxU8
	tc/eNAViIMNA8AvD/mkEaGSJ9IfttXG0+qQ7yiZmuqbFtZSIJilj8sfTWUskC7j+
	AX0WZLXK2Cs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59B7DBE95;
	Tue,  5 Feb 2013 00:16:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBEE4BE90; Tue,  5 Feb 2013
 00:16:34 -0500 (EST)
In-Reply-To: <1360037173-23291-13-git-send-email-greened@obbligato.org>
 (David A. Greene's message of "Mon, 4 Feb 2013 22:06:12 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35B640E6-6F53-11E2-A93D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215460>

"David A. Greene" <greened@obbligato.org> writes:

> From: Techlive Zheng <techlivezheng@gmail.com>
>
> 'git subtree merge' will fail if the argument of '--prefix' has a slash
> appended.
>
> Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>  contrib/subtree/git-subtree.sh     |    2 +-
>  contrib/subtree/t/t7900-subtree.sh |   19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index c72af95..0493e47 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -82,7 +82,7 @@ while [ $# -gt 0 ]; do
>  		--annotate) annotate="$1"; shift ;;
>  		--no-annotate) annotate= ;;
>  		-b) branch="$1"; shift ;;
> -		-P) prefix="$1"; shift ;;
> +		-P) prefix="${1%/}"; shift ;;

While it may not be a bad change per-se, I have to wonder if it is
worth special casing "--prefix=foo/", that should have been spelled
as "--prefix=foo", while still failing misspelling like "--prefix=foo//"
and possibly other forms, perhaps "--prefix=foo//bar/baz"?
