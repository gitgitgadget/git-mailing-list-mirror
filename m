From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/7] wrap-for-bin: Make bin-wrappers chainable
Date: Tue, 02 Jul 2013 16:01:15 -0700
Message-ID: <7vk3l8in2c.fsf@alter.siamese.dyndns.org>
References: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
	<1372804789-12732-3-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Wed Jul 03 01:01:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu9Zb-0001rO-Dr
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 01:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241Ab3GBXBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 19:01:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754077Ab3GBXBS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 19:01:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CDD82D660;
	Tue,  2 Jul 2013 23:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vRhYlu+dTby4h1SifW0ceWE7O8U=; b=RUeKcg
	De65M3xKv6LpFhsGecLwB8/ZG++igQbppcZ2eMwqftMS+l7Shrv35f2kwB67F68c
	nP8l1+M2h3MORCAgcx8zEPVFT7XaNNmTCKFQhpn+2LZw6tkAiF6USr7nux87Z6N5
	qwWr5GWIHDuh4tLrD984AE14Bb6pwQabSA84U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=icWcJkOIcVY3CG1/6NCw98PVU+AB5KMO
	fWIuktm/PI6H+SKldTIwc9sqvNg/54dNQ+HFwzHGWVSKtby9gaYK8rAOCia/AYKj
	wS1hURzyoai0wq0ErNDkXn1EaEYGpooNtG4SPfUNSHTG0xEARzia2PeMuEJ9RvpW
	SwZKl/ikmX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 835902D65F;
	Tue,  2 Jul 2013 23:01:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E674F2D65E;
	Tue,  2 Jul 2013 23:01:16 +0000 (UTC)
In-Reply-To: <1372804789-12732-3-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Wed, 3 Jul 2013 00:39:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D2099DE-E36B-11E2-BCF0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229446>

benoit.person@ensimag.fr writes:

> From: Benoit Person <benoit.person@ensimag.fr>
>
> For now, bin-wrappers (based on wrap-for-bin.sh) redefine some
> environnement variables (like $GITPERLLIB). If we want to chain to
> those scripts and define one of those variables before, our changes
> will be overwritten.
>
> This patch simply makes the bin-wrappers prepend their modifications
> rather than redefine the vars.
>
> Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  wrap-for-bin.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
> index 53a8dd0..dbebe49 100644
> --- a/wrap-for-bin.sh
> +++ b/wrap-for-bin.sh
> @@ -14,7 +14,7 @@ else
>  	GIT_TEMPLATE_DIR='@@BUILD_DIR@@/templates/blt'
>  	export GIT_TEMPLATE_DIR
>  fi
> -GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib'
> +GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib:'"$GITPERLLIB"

Do we want to add that ':' unconditionally?  Could GITPERLLIB be
empty?

>  GIT_TEXTDOMAINDIR='@@BUILD_DIR@@/po/build/locale'
>  PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
>  export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
