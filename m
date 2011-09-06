From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH git] http: avoid empty error messages for some curl
 errors
Date: Tue, 06 Sep 2011 15:49:50 -0700
Message-ID: <7vehzt70c1.fsf@alter.siamese.dyndns.org>
References: <20110905222202.GA32071@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 00:50:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R14St-0006iA-Ih
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 00:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab1IFWtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 18:49:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753843Ab1IFWtx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 18:49:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95CDF492D;
	Tue,  6 Sep 2011 18:49:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xdGOPn9KbnP5+O/GHMs/Dj4q6j4=; b=at0vqz
	y6gK8Jibyq0a6Ysq3j+Ls5+VfnihpQtsq0envMY+ERbYB70m2SZ0Co2K7cyBTIlW
	rkIhUWKjgC98uxEevFwFWLmVNwNZgjPhGMM2WoFFaq2+kDVmjWi7HwF4Otg1oimi
	mc4VtPQxXkKcKqsd1httclFRUtQ9mXJqBQmaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M1OoE7/dEwCskDqP82VYx1qb8pt31j9F
	EHiBhJp9Gh36lOA0VEfiLKzsR4tSGWMA23rW326coxpCohSuofl5fyDH0E8cMbOD
	2HTHvz3O9ev39ISuiFNB4QYfM4GH+PfvKyDaGXmDUq/mPqMxqgCmfkVI6pyZQdT8
	2vObVXeMzhM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D813492C;
	Tue,  6 Sep 2011 18:49:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23AAE492A; Tue,  6 Sep 2011
 18:49:52 -0400 (EDT)
In-Reply-To: <20110905222202.GA32071@elie> (Jonathan Nieder's message of
 "Mon, 5 Sep 2011 17:22:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88416950-D8DA-11E0-AE7F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180844>

Jonathan Nieder <jrnieder@gmail.com> writes:

> When asked to fetch over SSL without a valid
> /etc/ssl/certs/ca-certificates.crt file, "git fetch" writes
>
> 	error:  while accessing https://github.com/torvalds/linux.git/info/refs
>
> which is a little disconcerting.  Better to fall back to
> curl_easy_strerror(result) when the error string is empty, like the
> curl utility does:
>
> 	error: Problem with the SSL CA cert (path? access rights?) while
> 	accessing https://github.com/torvalds/linux.git/info/refs
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi,
>
> I ran into this error today because this machine has no certs enabled.
> I'm not thrilled with the following patch because the error string
> buffer is not cleared very often so it seems possible for it to be
> not empty but stale at the relevant moment.  I would be happier if we
> could rely on libcurl always filling the error buffer on errors.

Will queue both patches; thanks.
