From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/8] strbuf: add strbuf_addv
Date: Thu, 24 Feb 2011 16:05:13 +0100
Message-ID: <AANLkTi=cBkH5=fmH-k=Sid_4Pwzoa9A4T9z8dcMAjirL@mail.gmail.com>
References: <20110224142308.GA15356@sigill.intra.peff.net>
	<20110224142711.GB15477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 16:05:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psckx-0004ab-F3
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 16:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256Ab1BXPFR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 10:05:17 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51641 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756272Ab1BXPFP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 10:05:15 -0500
Received: by wwb39 with SMTP id 39so849648wwb.1
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 07:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bg9rG+ovJcYN3HnMOPXgYo09inK5jI/VbacHpZoKVPU=;
        b=Z5I3D7IKSctF2UT30jfOFsxh3y9CqVXMP1qu99zO+K+xz5Vf/TsgyYCAg6eql51MkP
         kiV8OFm3v8QHRoRp4QIpYWMnbpnaqLbbbCaQEtb4Z7cFMxhgVHhAkQX9OhHZoWmrGob7
         T4bZPt7g1xEUvYs3IozmOLxd/HgYT5ZuVNBGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kLR8ZPtrzMTY93qmzBULLl8sryKjer81mzKKjKFzBl/g/hzEI/Mto126M92EdwE6Sb
         vaBNcIV9ST5kuYdT2JSNPU2StO+nOY1K+gAV6z6k2RkzmnEYKUepAaUWZ2SRR+im+oBk
         EjonXkOT5AeMDI6hkIQxZ/857dXRwNUw0B08k=
Received: by 10.216.174.69 with SMTP id w47mr6008284wel.41.1298559914022; Thu,
 24 Feb 2011 07:05:14 -0800 (PST)
Received: by 10.216.241.78 with HTTP; Thu, 24 Feb 2011 07:05:13 -0800 (PST)
In-Reply-To: <20110224142711.GB15477@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167819>

Hi,

On Thu, Feb 24, 2011 at 3:27 PM, Jeff King <peff@peff.net> wrote:
> +void strbuf_addv(struct strbuf *sb, const char *fmt, va_list ap)
> +{
> + =A0 =A0 =A0 int len;
> + =A0 =A0 =A0 va_list cp;
>
> =A0 =A0 =A0 =A0if (!strbuf_avail(sb))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_grow(sb, 64);
> - =A0 =A0 =A0 va_start(ap, fmt);
> - =A0 =A0 =A0 len =3D vsnprintf(sb->buf + sb->len, sb->alloc - sb->le=
n, fmt, ap);
> - =A0 =A0 =A0 va_end(ap);
> + =A0 =A0 =A0 va_copy(cp, ap);
> + =A0 =A0 =A0 len =3D vsnprintf(sb->buf + sb->len, sb->alloc - sb->le=
n, fmt, cp);
> + =A0 =A0 =A0 va_end(cp);
> =A0 =A0 =A0 =A0if (len < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("your vsnprintf is broken");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("BUG: your vsnprintf is broken (ret=
urned -1)");

Minor nit: why not:

 +               die("BUG: your vsnprintf is broken (returned %d)", len=
);

Thanks,
Christian.
