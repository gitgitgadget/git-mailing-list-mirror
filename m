From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [RFC/PATCH 1/3] strbuf: Add strbuf_vaddf function
Date: Sun, 11 Apr 2010 14:42:29 +0200
Message-ID: <n2i40aa078e1004110542kcfba8b6dw8848cd8f5647fda7@mail.gmail.com>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
	 <20100411113733.80010.78232.julian@quantumfyre.co.uk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Eric Raymond <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 11 14:42:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0wUm-0006rK-8g
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 14:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812Ab0DKMmb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 08:42:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46195 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab0DKMma convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 08:42:30 -0400
Received: by wyb39 with SMTP id 39so960017wyb.19
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 05:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lZzV2NNY/AHMGGzevmKssgwZhp4KDoanKDWk4Qs1sPI=;
        b=hWYhBl60+GmpZP9saTqFexrl9Ut/6JTsmuhxSe6JQr5WjWWMnwZ9+J28fnzIQYczyC
         3xlV8bHtGZnfxySD92x0EEoIITPzw3RxPfHMDumpdUeerUtvOcBPbF8a6T+8OkCJWtDd
         8IlmHK+LzdxIF2ZYK4dn8UEGRxC5cWUetNtwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=mIKlom2aQ9Y2QJgAY9j6uvHRlbgdEoEU4p7PtQhSqxKmrax7PMPkgsELGHM7txbcqj
         AlXTtGQjDK22ECOOaSUYRlw515DHUAkGNl641uqRIxn+5KAoL3N34sojHcSFImiIa2WJ
         wzFW/ex9XVksYVj8S02SA2aZPvGzQIr6q/m2o=
Received: by 10.216.73.8 with HTTP; Sun, 11 Apr 2010 05:42:29 -0700 (PDT)
In-Reply-To: <20100411113733.80010.78232.julian@quantumfyre.co.uk>
Received: by 10.216.90.135 with SMTP id e7mr1559688wef.34.1270989749097; Sun, 
	11 Apr 2010 05:42:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144645>

On Sun, Apr 11, 2010 at 1:37 PM, Julian Phillips
<julian@quantumfyre.co.uk> wrote:
> Add strbuf_vaddf which is to strbuf_addf as vprintf is to printf.
>
> Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
> ---
> =A0strbuf.c | =A0 13 +++++++++++--
> =A0strbuf.h | =A0 =A01 +
> =A02 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index bc3a080..8f312f8 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -194,19 +194,28 @@ void strbuf_adddup(struct strbuf *sb, size_t po=
s, size_t len)
>
> =A0void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
> =A0{
> + =A0 =A0 =A0 va_list ap;
> +
> + =A0 =A0 =A0 va_start(ap, fmt);
> + =A0 =A0 =A0 =A0strbuf_vaddf(sb, fmt, ap);
> + =A0 =A0 =A0 va_end(ap);
> +}
> +
> +void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list args)
> +{
> =A0 =A0 =A0 =A0int len;
> =A0 =A0 =A0 =A0va_list ap;
>
> =A0 =A0 =A0 =A0if (!strbuf_avail(sb))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_grow(sb, 64);
> - =A0 =A0 =A0 va_start(ap, fmt);
> + =A0 =A0 =A0 va_copy(ap, args);

Isn't va_copy C99? The only other place we use this is in
compat/winansi.c, but that file is only compiled on Windows. Both
compilers we support on Windows supports va_copy (or some way of
emulating it).

IIRC, strbuf_vaddf() has been attempted added multiple times before
(by me, for one), and the efforts have always ended up being scrapped
due to the lack of a portable va_copy.

--=20
Erik "kusma" Faye-Lund
