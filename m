From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 03/14] msvc: Fix build by adding missing INTMAX_MAX define
Date: Thu, 9 Dec 2010 20:19:48 +0100
Message-ID: <AANLkTi=_9kT9taLF97cngJ81sBCN9RDkzpk8uN-NW6tG@mail.gmail.com>
References: <4CFA8F1A.3040402@ramsay1.demon.co.uk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Dec 09 20:20:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQm2O-0003lK-H9
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 20:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705Ab0LITUM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 14:20:12 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:34750 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708Ab0LITUL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 14:20:11 -0500
Received: by fxm18 with SMTP id 18so2803634fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 11:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=oUMCvzH0h2niojPUpmaA6P7Z2EtWBxdaR3868PqhmTg=;
        b=uQmAiibvgdvscfv6NkyRgqbO1M1FzuzJWZ8o5vTtCNGH1aMAblbRQdZr2zO/UqpOuF
         FAExHfRxhE5MhGpm1uAuMUeyjh+co0eO2JS0HfAaQR0NS/ADM8HU3QK4ZjKUPvWpElKi
         zYqbOkfz+J1UGTC0o6XMKiTpgmipdqdLOeHwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Tj2Hid6DU0SovxrC41SwhrF+QrjdhyavbKURrJzkNQ2lu6MLi/e0NxGKtnq4jGc6e9
         j2n6o/Iaz/aNbvKaz8EiT3yqccT93PAMPZZVg+BIDOW8Xvoc8RXFAmNWH+ukDuEvENLA
         CyKYSGI7HFzI/76Hv6W2m4Bdr3RB+edM5B18Q=
Received: by 10.223.73.199 with SMTP id r7mr3020317faj.76.1291922409944; Thu,
 09 Dec 2010 11:20:09 -0800 (PST)
Received: by 10.223.95.202 with HTTP; Thu, 9 Dec 2010 11:19:48 -0800 (PST)
In-Reply-To: <4CFA8F1A.3040402@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163305>

On Sat, Dec 4, 2010 at 7:57 PM, Ramsay Jones <ramsay@ramsay1.demon.co.u=
k> wrote:
>
> Commit c03c831 (do not depend on signed integer overflow,
> 05-10-2010) provokes an msvc build failure. The cause of the
> failure is a missing definition of the INTMAX_MAX constant,
> used in the new maximum_signed_value_of_type(a) macro, which
> would normally be defined in the C99 <stdint.h> header file.
>
> In order the fix the compilation error, we add an appropriate
> definition of the INTMAX_MAX constant, along with INTMAX_MIN
> and UINTMAX_MAX, to an msvc compat header file.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
> =A0compat/vcbuild/include/unistd.h | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include=
/unistd.h
> index 2a4f276..b14fcf9 100644
> --- a/compat/vcbuild/include/unistd.h
> +++ b/compat/vcbuild/include/unistd.h
> @@ -45,6 +45,10 @@ typedef unsigned long long uintmax_t;
>
> =A0typedef int64_t off64_t;
>
> +#define INTMAX_MIN =A0_I64_MIN
> +#define INTMAX_MAX =A0_I64_MAX
> +#define UINTMAX_MAX _UI64_MAX
> +
> =A0#define STDOUT_FILENO 1
> =A0#define STDERR_FILENO 2
>

Looks good. You only really need to define INTMAX_MAX, but INTMAX_MIN
and UINTMAX_MAX are nice additions for future code. I guess you
*could* have added UINTMAX_MIN for completeness, but I doubt anyone
will ever bother to use it, as it's always 0. So for what it's worth:

Acked-by: Erik Faye-Lund <kusmabite@gmail.com>

In case someone is curious of the definitions; they are documented at
http://msdn.microsoft.com/en-us/library/k15zsh48.aspx
