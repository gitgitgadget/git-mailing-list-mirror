From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] add: add --bulk to index all objects into a pack file
Date: Fri, 4 Oct 2013 19:38:57 +0700
Message-ID: <CACsJy8BLyOtWck1ZidnBZo+KuBiSa5a4mZtbG6LQxTnv3sQXQw@mail.gmail.com>
References: <1380772811-15415-1-git-send-email-pclouds@gmail.com> <1380869871-31631-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 04 14:39:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VS4fN-0000Rm-PW
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 14:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523Ab3JDMja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Oct 2013 08:39:30 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:37550 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab3JDMj3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Oct 2013 08:39:29 -0400
Received: by mail-oa0-f47.google.com with SMTP id i1so3799523oag.20
        for <git@vger.kernel.org>; Fri, 04 Oct 2013 05:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mPLMnnbyyQWlS13iZomr6N1H2sRSvzpnovfOb3eTvks=;
        b=VfTFjMnT9I1lM3pelwn55lLc2BUVBqgZf3uIxxyZYrfYiz/X7liUMTR3hFO42Znuxn
         0RrIePwebj779ZNTuPJZn6CNEhjP9JR8PdM1L4FvJD2c+kl79zcjMV6AkjhfuaadPOdd
         atbjtmh+E8K9zj0rUks03AYQLefLaSSXGrh3yUOgiSPEszDecQEXxQ4ANXxNneaxzQga
         Jf5TFzdomAQbCjIFhZA0KoKU1VcRWkdEfzI5g2JtNc3mkDKdd2dGZSWM3yX7QYlEMpQS
         Iz1A65KAUWJvfvgN6fxden7MFYBuYtFexGGEhnG6p1M8viYJKMyXLcvUa3si4Uh4dRFT
         Cj9Q==
X-Received: by 10.60.117.225 with SMTP id kh1mr21328363oeb.15.1380890368017;
 Fri, 04 Oct 2013 05:39:28 -0700 (PDT)
Received: by 10.76.131.130 with HTTP; Fri, 4 Oct 2013 05:38:57 -0700 (PDT)
In-Reply-To: <1380869871-31631-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235709>

On Fri, Oct 4, 2013 at 1:57 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> It's not an all-win situation though. --bulk is slower than --no-bulk
> because:
>
>  - Triple hashing: we need to calculate both object SHA-1s _and_ pack
>    SHA-1. At the end we have to fix up the pack, which means rehashin=
g
>    the entire pack again. --no-bulk only cares about object SHA-1s.

Oops, it's quadruple hashing: one for object sha-1 (1), one for pack
sha-1 while writing pack (2), two for pack header fixup: one after the
the header fixup (3), and one repeating the same (2) just to verify
that it matches (2) exactly (4). Do we have to be this paranoid? I
think we could drop (2) and (4) in this case.
--=20
Duy
