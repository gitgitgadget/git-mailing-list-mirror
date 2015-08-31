From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/8] diff.h: extend "flags" field to 64 bits because we're
 out of bits
Date: Mon, 31 Aug 2015 17:22:37 +0700
Message-ID: <CACsJy8BaCWgQa=1bc-_6BHQJLUk4_GsiKQchJRpFMTrxp4Np6g@mail.gmail.com>
References: <1440205700-19749-7-git-send-email-pclouds@gmail.com>
 <1440205874-20295-1-git-send-email-pclouds@gmail.com> <xmqqy4gzz2qa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Plamen Totev <plamen.totev@abv.bg>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 12:23:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWMF7-0001kK-7v
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 12:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbbHaKXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2015 06:23:09 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38157 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbbHaKXH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2015 06:23:07 -0400
Received: by igbuu8 with SMTP id uu8so23663427igb.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 03:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Sk4SdjzyLk79BgihiJp41kH1w9qt7Lt6jo1TShquk/s=;
        b=oEngTYiSb62QkLb1IDb11Iy7dKSX6km0K0TTEgoHESwA6zoK7eCTFXOYhE78WoGDFE
         ltTgeGM6ZJLc7F5HwFDrdLL6EfTsZo3pcWV1NqUQeZi+CuYG1lYpm3hJ8W2AeUrxBqW/
         L7yOcYWJkoDpTleMkXsjGtTqw/uVg+x25Mlx81YI93FCeNK7S1FgFDds+QGccJ9muFfW
         WCnRhBqAX85RGzjoD4ml4rTspRKeyrYlENhn0qD5LcsDbPWqe2vtU72v9dPHoZFGahq0
         jAeB8f3A//id8JKq+8UEtjsvAEaMIWb7+a+61se5NTqpGI1ZLYqjY1RR+U4geoEWVhvE
         AQdQ==
X-Received: by 10.50.26.66 with SMTP id j2mr12913521igg.42.1441016587263; Mon,
 31 Aug 2015 03:23:07 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 31 Aug 2015 03:22:37 -0700 (PDT)
In-Reply-To: <xmqqy4gzz2qa.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276869>

On Wed, Aug 26, 2015 at 12:39 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> I renamed both "flags" and "touched_flags" fields while making this
>> patch to make sure I was aware of how these flags were manipulated
>> (besides DIFF_OPT* macros). So hopefully I didn't miss anything.
>
> It is a bad taste to use user_defined_t typedef (I think it actually
> is a standard violation), isn't it?

Yeah I think you posted a patch somewhere updating CodingGuidelines abo=
ut this..

> The diff-struct is not like objects where we need million copies of
> in-core while running.  What do you need many more flags for?

We already use all 32 bit flags and I need one more flag. I guess I go
with flags because it's how we add features in diff struct. Adding a
new field instead of extending flags could be dangerous: elsewhere
people copy flags out to a temporary place, do something then restore.
If it's a separate field, it's left in place and bad things could
happen.
--=20
Duy
