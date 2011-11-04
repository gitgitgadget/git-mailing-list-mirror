From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: don't always prompt for password
Date: Fri, 04 Nov 2011 12:06:49 -0700
Message-ID: <7vwrbfbtbq.fsf@alter.siamese.dyndns.org>
References: <7vfwi6jucg.fsf@alter.siamese.dyndns.org>
 <1320390188-24334-1-git-send-email-stefan.naewe@gmail.com>
 <7vlirvdeb2.fsf@alter.siamese.dyndns.org>
 <20111104174303.GA22568@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Naewe <stefan.naewe@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 04 20:07:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMP6R-0007F2-KN
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 20:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686Ab1KDTGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 15:06:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51948 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093Ab1KDTGx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 15:06:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 282756003;
	Fri,  4 Nov 2011 15:06:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KSVr89/PKKX6kvA7fZH3AckOqLA=; b=FZioxm
	RqRjdPtKcsh9bJ1fmezqmn4Y54lpt7JUtDaOzYy4/htKXFWMzzSTJCf9tAQpKdTZ
	wMkoQ06pWn9Emh9sUat1SDOonFPcZfHgdXlcXPGsFD/7dqmj1bxZEBX33ya2Fn8N
	vOsmFuzlCk4DsOgwY7B/kLfocs7a9xrn6TboY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rJ1WHpCyJUuzrpjEyuq5YWz+496ku5s0
	fDpvkTIV5BiEOT5c+pcn1mppDuQrzhNYjS42jwAdg7DA3p9O1O1IX9s2O6tnbj/G
	3as/KDK4trZrO0hm94rjunEIzWMc19To/Vmw5GwD0IWTiHKeQ+CJllFVZT6aJNoy
	b4Jk8y3ML+o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16DDB6002;
	Fri,  4 Nov 2011 15:06:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D31A5FFE; Fri,  4 Nov 2011
 15:06:51 -0400 (EDT)
In-Reply-To: <20111104174303.GA22568@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 4 Nov 2011 13:43:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2708250E-0718-11E1-A496-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184798>

Jeff King <peff@peff.net> writes:

> Since we now only call init_curl_http_auth when we know we need auth, I
> think it would make more sense to just move the user_name asking there,
> too, like:
>
>   static void init_curl_http_auth(CURL *result)
>   {
>           struct strbuf up = STRBUF_INIT;
>
>           if (!user_name)
>                   user_name = xstrdup(git_getpass_with_description("Username", description);
>           if (!user_pass)
>                   user_pass = xstrdup(git_getpass_with_description("Password", description);
>
>           strbuf_addf(&up, "%s:%s", user_name, user_pass);
>           curl_easy_setopt(result, CURLOPT_USERPWD, strbuf_detach(&up, NULL));
>   }
>
> And then it's easy to swap out the asking for credential_fill() when it
> becomes available. But I admit I don't care that much now, as I'll just
> end up doing that refactoring later with my credential patches anyway.

Yeah, let's not over-churn this part for now as we know it will change
anyway.

Thanks both!
