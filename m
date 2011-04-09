From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Sat, 9 Apr 2011 17:15:12 +0700
Message-ID: <BANLkTi=yvA1Pa2dVa2zC4ED8ZXcWDoqLPQ@mail.gmail.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com> <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org> <20110408202404.GA16540@sigill.intra.peff.net>
 <7vmxk01izn.fsf@alter.siamese.dyndns.org> <20110408223206.GA7343@sigill.intra.peff.net>
 <7vei5c1iat.fsf@alter.siamese.dyndns.org> <7vaag01gdl.fsf@alter.siamese.dyndns.org>
 <BANLkTimCbr+hnJNGWDBVbjZKEBDW1KR4=g@mail.gmail.com> <7vy63kyp9n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 12:15:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8VCt-0006I2-N3
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 12:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab1DIKPp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 06:15:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56594 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156Ab1DIKPm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2011 06:15:42 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so3405477bwz.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 03:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=IdHlInsYZmw+kgd1kanC4MOFZJGo6ze8pPg/Mz4/u8M=;
        b=S4d4C82ACW+IxuJpb7Mtow74u9ey05/01olIk2nuZx11/Y7LSJRp98+42qHqzVun9K
         zuUeZvkrTr4FTIPlQzsfGaMjMYHWRJoxZ90um3bm/2x7IfPSEUJChjIt8LGkw/ei9mFj
         ttF9TeJBxnARTs75Y8FI01ALlUjsDki0y6xYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DimPjg+5QTEnBBE/Ygk+uYl6XRRz8EQvBZSA3VT7pjqEhoBj8Hx5h7NvTe9CB9AcUc
         GvzIftDk+dfPx8UmYAY3cm9FzSiDxnnVdFO9nt9QiyL6zr5QA72/n8G+iFNKdUIdVVFB
         aUD1fVXM9eGN/ub7uNxZT24kClzSSRI/KsZag=
Received: by 10.204.133.91 with SMTP id e27mr479467bkt.23.1302344142174; Sat,
 09 Apr 2011 03:15:42 -0700 (PDT)
Received: by 10.204.139.210 with HTTP; Sat, 9 Apr 2011 03:15:12 -0700 (PDT)
In-Reply-To: <7vy63kyp9n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171189>

On Sat, Apr 9, 2011 at 12:20 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> By the way, the field in "struct pathspec_item" would need to be upda=
ted,
> and the matcher would need to be changed, so that each item knows up =
to
> which part of the "match" string came from the prefix (and remainder =
is a
> user supplied pattern). =C2=A0Then from a subdirectory a?a/bbb,
>
> =C2=A0- "c" should parse into prefix "a?a/bbb/" plus pattern "c"
>
> =C2=A0- ":../c" should become prefix "a?a/" plus pattern "c"
>
> and the matcher should match the prefix part _literally_ without
> fnmatch(3), while using whatever magic (e.g. use_wildcard) to match t=
he
> pattern part. =C2=A0I think we currently match the whole thing with f=
nmatch(3),
> which in practice may be OK only because not many people use glob
> characters in their directory names, but what the current matcher doe=
s
> logically is wrong.

OK. Let's add nomagic_len (or plain_len) to pathspec_item for that. I
was thinking of noglob_len but changed my mind because the same can
also be applied for icase magic. We don't want to do strcasecmp on
prefix.

> Of course, both of the above are tasks after 1.7.5 ships, but I thoug=
ht I
> should mention them now, as you seem to be already thinking about the
> future.
--=20
Duy
