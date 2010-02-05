From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: simple test for operation in a bare repository
Date: Thu, 04 Feb 2010 22:50:37 -0800
Message-ID: <7vd40kjhvm.fsf@alter.siamese.dyndns.org>
References: <4B69BD7C.4010608@lsrfire.ath.cx>
 <4B6A0BDE.2050908@lsrfire.ath.cx> <4B6B653A.8060909@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:06:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL3a-0003Bj-Fq
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933212Ab0BEGus convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 01:50:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933167Ab0BEGur convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 01:50:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CB4D79670E;
	Fri,  5 Feb 2010 01:50:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=o2LJz6hJq2WW
	vpOG9tj9qs0dDq4=; b=l+fJxwZCjzVSPQLBwqCCIsObQouJNtvTaFD07hF7d3Mq
	xhRJQfi2TOOrLmbtnVLNYRmXGMuMdfGxAfHTfydA39SDFlVeFVm4NhRor03HGtqA
	OEwvGq+85J5sleg1Z+axivBaeAqRfCyufWeyomHxaIEjodSf61VzA7MQYApslQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wd/cmG
	dhEEkUwRfhUXa6UwqkUS/JwSrornjMWoyfTLwK0pOBzGIL6oahhWGqwUc8SJiBPi
	5DqJBD3kxNOKvn6UZ/QFhmZY48qj41aBj+F/TqwcmfQmsEh/6WYnACEQVAciy7fy
	gyhoRhEJPwNPNQUdOYIxi8qBeNq5TwH12slKw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A88C79670D;
	Fri,  5 Feb 2010 01:50:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEC649670B; Fri,  5 Feb
 2010 01:50:38 -0500 (EST)
In-Reply-To: <4B6B653A.8060909@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Fri\, 05 Feb 2010 01\:24\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C751AD42-1222-11DF-99EC-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139032>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> There are five more sites in git.c, path.c and setup.c where $GIT_DIR
> is set directly with setenv().  I wonder if they should better call
> set_git_dir() instead, too.
>
>
> diff --git a/setup.c b/setup.c
> index 710e2f3..5fb9b25 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -406,7 +406,7 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
>  				cwd[offset] =3D '\0';
>  				setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
>  			} else
> -				setenv(GIT_DIR_ENVIRONMENT, ".", 1);
> +				set_git_dir(".");
>  			check_repository_format_gently(nongit_ok);
>  			return NULL;
>  		}

Yeah, shouldn't the other setenv() we see in the context need a similar
change as well?
