From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] read-cache: fix wrong 'the_index' usage
Date: Mon, 03 Jun 2013 10:09:48 -0700
Message-ID: <7v4ndfi0ir.fsf@alter.siamese.dyndns.org>
References: <1369922181-31016-1-git-send-email-felipe.contreras@gmail.com>
	<1369922181-31016-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:10:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYGd-00038g-SD
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759154Ab3FCRJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:09:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45146 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758101Ab3FCRJw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 13:09:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A9AC241B7;
	Mon,  3 Jun 2013 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uaeNzlfyvAHcqmvkreS7oFTwWNc=; b=xDwJyD
	z8PcLECaD31spAfk/unrcR9Suzz6911KESGv7Vh5gcImmEQdefu4yMJ42v0SFd4G
	yUKwevIyEKCdPIx9uK8yTrgjW6H1JfYop4lOhFwtW+T9f8m8hHJtvcnjdXAPgNXV
	cH7qvPnW8Ip3mVcaNpMxfrhIraKTGLW2rjrrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=chRP952T8wOBie+unap1O4/3/xT17oKf
	KvRZBdUC+sxdCYrtLr2EGI3U8UTh8JR5w0zgKdmp8HXA0UwH36BUKZTMqchyS7bF
	dZHJDn7iUfa2OZitz6PwVEWTkLO68ZHbwpk1uVnIR/666qI2UKiaTNmUr1ByVKSq
	sxbzJKtjfv4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F7FA241B6;
	Mon,  3 Jun 2013 17:09:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72E6C241B3;
	Mon,  3 Jun 2013 17:09:50 +0000 (UTC)
In-Reply-To: <1369922181-31016-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 30 May 2013 08:56:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66B3BCEE-CC70-11E2-B0DB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226236>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> We are dealing with the 'istate' index, not 'the_index'.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Good catch; will apply.

>  read-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 04ed561..5253ec5 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -626,7 +626,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>  			if (*ptr == '/') {
>  				struct cache_entry *foundce;
>  				++ptr;
> -				foundce = index_name_exists(&the_index, ce->name, ptr - ce->name, ignore_case);
> +				foundce = index_name_exists(istate, ce->name, ptr - ce->name, ignore_case);
>  				if (foundce) {
>  					memcpy((void *)startPtr, foundce->name + (startPtr - ce->name), ptr - startPtr);
>  					startPtr = ptr;
