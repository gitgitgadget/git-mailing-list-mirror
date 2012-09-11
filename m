From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] build: don't duplicate substitution of make
 variables
Date: Tue, 11 Sep 2012 10:27:38 -0700
Message-ID: <7vtxv4h3lh.fsf@alter.siamese.dyndns.org>
References: <1be62f9a7bbe728e6422e668d982ddf313d016eb.1347378209.git.stefano.lattarini@gmail.com> <1c54b744c0ec6987f7987a41853ab0ae00513d03.1347378210.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 19:27:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBUFe-0005md-W2
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 19:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759232Ab2IKR1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 13:27:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759129Ab2IKR1l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 13:27:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 001208719;
	Tue, 11 Sep 2012 13:27:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i7tOsWN5YZGb8gtySf6PSPXVoYg=; b=qASWqX
	5KomNXNAcTq8NOi4x0GIwT3ObKS1zRZbkGcTXpoPMnpjQH7/gX1o4tp9WNLxzhMb
	zyBIrdxfLNkIe6MCPOBA3665ZQQSg2B8uBbohwLXDePIdVSmkSegJSlevoHxuIUg
	/RwUpwtwJArE8zgAvjj9Q7DYMDPmEerXaqCbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZU3fcUvUIpxi0+ZeDFlSEI5rjCYnI/VN
	en/ahg6JefsOlrud/Gy4x7UcUKOHd36Z+MqFh5DntP1C9SORopQH+KuRuqDf/xtZ
	RHZTVdaE5EemFUlM3ZQnMwFOBIYeMaBK7OEX+thgVPjr41PZlTNo3BigLGXDXpU9
	1DtZAOrRn90=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E07BB8718;
	Tue, 11 Sep 2012 13:27:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B4B78716; Tue, 11 Sep 2012
 13:27:40 -0400 (EDT)
In-Reply-To: <1c54b744c0ec6987f7987a41853ab0ae00513d03.1347378210.git.stefano.lattarini@gmail.com> (Stefano Lattarini's message of "Tue, 11 Sep 2012 17:45:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCCBC994-FC35-11E1-BDF7-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205254>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> Thanks to our 'GIT_CONF_SUBST' layer in configure.ac, a make variable 'VAR'
> can be defined to a value 'VAL' at ./configure runtime in our build system
> simply by using "GIT_CONF_SUBST([VAR], [VAL])" in configure.ac, rather than
> having both to call "AC_SUBST([VAR], [VAL])" in configure.ac and adding the
> 'VAR = @VAR@' definition in config.mak.in.  Less duplication, less margin
> for error, less possibility of confusion.
>
> While at it, fix some formatting issues in configure.ac that unnecessarily
> obscured the code flow.
>
> Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
> ---
>  config.mak.in |  49 --------------------
>  configure.ac  | 144 +++++++++++++++++++++++++++++++---------------------------
>  2 files changed, 76 insertions(+), 117 deletions(-)

Whoa ;-).

> diff --git a/configure.ac b/configure.ac
> index 450bbe7..da1f41f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -267,6 +267,8 @@ AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and hea
>  	USE_LIBPCRE=YesPlease
>  	LIBPCREDIR=$withval
>  	AC_MSG_NOTICE([Setting LIBPCREDIR to $LIBPCREDIR])
> +        dnl USE_LIBPCRE can still be modified below, so don't substitute
> +        dnl it yet.
>  	GIT_CONF_SUBST([LIBPCREDIR])
>      fi)
>  #
> ...
>  AC_CHECK_FUNC([hstrerror],
> -	[],
> +    [],

Is there some consistent policy regarding SP vs HT in the
indentation you are using in this patch?  These two hunks suggest
that you may be favoring spaces, but other places you seem to use
tabs, so...
