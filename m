From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] CYGWIN: Use a TCP socket for pipe()
Date: Thu, 27 Jun 2013 10:38:47 -0700
Message-ID: <7vvc4zsbbs.fsf@alter.siamese.dyndns.org>
References: <201306271831.13865.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ramsay@ramsay1.demon.co.uk, mlevedahl@gmail.com,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 27 19:39:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsG9w-0008IB-IO
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 19:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547Ab3F0RjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 13:39:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40296 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab3F0Ri7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jun 2013 13:38:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 614D329AB7;
	Thu, 27 Jun 2013 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/GQgOhi2GoEV
	e4FSE5D3Feamvbk=; b=R3k69KOZ/vqiN612IPQq/zItJrp/LVF/wb1fhyVghBNY
	t2mfJAxFjj7H5X2tP3z6UIo4Xr69ZFnqwn/CagPoFh9/rpGdBdLfbmcsYoefQ0VR
	MdYXVHbg8SHj71Uavr0hJ9ct+Zki51acpbGHGuFxlmS3gkJZoPOKu2x1tqJVtbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JtWL5q
	v/cM6G5y/q8Ezu3vjDg8k9lUC1ruDISve1ytZ1ByOxE3lUf8QtIBCjQGWdccSNK1
	6Z5+BDHBwrJqLBbyNVRrp4So7fsq5AFcga71+30BHImpBUK2eUqm5SBcPuKriQ1y
	gOinkklsdgFIZjlhwnz2688OAKhNVO08WpowA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5554929AB6;
	Thu, 27 Jun 2013 17:38:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A98A429AB3;
	Thu, 27 Jun 2013 17:38:57 +0000 (UTC)
In-Reply-To: <201306271831.13865.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 27 Jun 2013 18:31:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71F8D880-DF50-11E2-A2B0-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229133>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Work around issues that git hangs when doing fetch or pull under
> various protocols under CYGWIN.
>
> Replace pipe() with a socket connection using a TCP/IP.
> Introduce a new function socket_pipe() in compat/socket_pipe.c

Sounds like sweeping the real problem, whatever it is, under rug.
Is it that we are assuming a pipe buffer that is sufficiently large
and expecting a write that we deem to be small enough not to block,
causing a deadlock on a platform with very small pipe buffer, or
something?
> +	(void)setsockopt(fd_listen, SOL_SOCKET, SO_REUSEADDR,
> +									 (char*)&reuse_on, sizeof(reuse_on));

Broken indentation.

Either align (note: these are only to illustrate the column
alignment; I am not encouraging to indent with leading SPs) the
opening "(" of the "(char *)" cast with "f" in "fd_listen", like
this,

        (void)setsockopt(fd_listen, SOL_SOCKET, SO_REUSEADDR,
                         (char *)&reuse_on, sizeof(reuse_on));

by a run of HT with minimum number of SP, or push the beginning of
the second line past opening "(" after "setsockopt", like this,

        (void)setsockopt(fd_listen, SOL_SOCKET, SO_REUSEADDR,
                                (char *)&reuse_on, sizeof(reuse_on));

with a run of minimum number of HT without any SP.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index c1f8a47..88632ab 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -176,6 +176,10 @@ int get_st_mode_bits(const char *path, int *mode=
);
>  #endif
>  #endif
> =20
> +int socket_pipe(int filedes[2]);
> +#ifdef GIT_USE_SOCKET_PIPE
> +#define pipe(a) socket_pipe(a)
> +#endif

Shouldn't the function declaration be inside this #ifdef?

>  /* used on Mac OS X */
>  #ifdef PRECOMPOSE_UNICODE
>  #include "compat/precompose_utf8.h"
