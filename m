From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 03/10] transport-helper: add 'force' to 'export' helpers
Date: Thu, 31 Oct 2013 11:21:06 -0700
Message-ID: <xmqqa9hp714d.fsf@gitster.dls.corp.google.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:21:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbwrr-0000ox-9N
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab3JaSVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:21:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59550 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390Ab3JaSVI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:21:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78A724E894;
	Thu, 31 Oct 2013 14:21:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PhJ9PWcXZNZPb4G6FUSFW+C6X0o=; b=eovnu8
	dOxS13YTEa2479rE4OC3xktUx5DBMp+YYfFZcoHKTtvwJ+HzhwOoOM+l6wJolykO
	12nBBDjb+bvUBDV6Fc3kXTN9cj5jTS/ipfaOTbsffrjmSDq1zeXPRHTRVNb3cxJx
	pi/B8Q6lN3mv1JKU9cauOt0FVcFPYBHNNGv6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iXKvkKObTns6wPjgrrJlfghLNrm7AV6H
	ThW/Ch0lsArHGUBbMU8hC0V4M9oGnTz7ceIWGQlwdfovN61WKqClVLML9Z6YzpfB
	DaVGnjqEn28GBOTnU2L3WlcPHzoBTy1rHdAaFFblUE9EfjB7Ja5n6cPBu9aJcVPg
	XOYWCZ4YGeI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AD614E893;
	Thu, 31 Oct 2013 14:21:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB1514E892;
	Thu, 31 Oct 2013 14:21:07 -0400 (EDT)
In-Reply-To: <1383212197-14259-7-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 31 Oct 2013 03:36:33 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 361989E2-4259-11E3-B27B-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237145>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Otherwise they cannot know when to force the push or not (other than
> hacks).
> ...
> diff --git a/transport-helper.c b/transport-helper.c
> index d05fc7c..ed238e5 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -854,6 +854,11 @@ static int push_refs_with_export(struct transport *transport,
>  			die("helper %s does not support dry-run", data->name);
>  	}
>  
> +	if (flags & TRANSPORT_PUSH_FORCE) {
> +		if (set_helper_option(transport, "force", "true") != 0)
> +			die("helper %s does not support 'force'", data->name);
> +	}
> +

Does this cause a "git push --force $there A:B" to fail when $there
is a destination that goes via an existing helper does not suport
"force" option?

Should it fail even when the current value of B is an ancestor of A
(i.e. when an unforced push would succeed)?
