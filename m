From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 20/25] upload-pack: support define shallow boundary by
 excluding revisions
Date: Mon, 15 Feb 2016 10:31:11 +0700
Message-ID: <CACsJy8BFc=G0-4g+yk4otBfazEZT0V7y9DahEuZyE8MFzMTx3A@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
 <1454576641-29615-21-git-send-email-pclouds@gmail.com> <CAPig+cQ0V3KdHsJ2tNphkFx-2yDhtU4JFnrDU-zagXFz2jymbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 04:31:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aV9t8-0006Mw-VO
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 04:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbcBODbq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 22:31:46 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34943 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbcBODbm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Feb 2016 22:31:42 -0500
Received: by mail-lf0-f45.google.com with SMTP id l143so81233150lfe.2
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 19:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GvipK7iLx8+CXBGJYwDxoF18Zs7cZ3M6VEh1N5CM0GY=;
        b=TFcsQl5Y3dRlJHF8wCNo8uUbGoA+ezKgtrmQRo/EUllGdfvTrmdTQ/BOSxmFslSP50
         w8QtlfNp+sOb8/IoEKBTTMdZ++Jy6bNUGSImFp5e+noHFe9eJxjtxZ89CmIOOSxlLjiH
         Xn0wi3fOhHPqyBChEWP572rtnY+DxHsxZOQT1xkD4pFXMmW3JLFE4/Xk/E1Q4C+RbQ/N
         IpOmGNpi4Oj73gJsuff0cf3gzNatopKtcIEhn6PhC9PmoG6UYUBe9NXjNf0ODpGaouPU
         3/n8mu7LT3bpUek/GPeqAmOb378r5pYyMFb30FxSsmnu1H986pV38NhP2/yPRqOgJmRQ
         +jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=GvipK7iLx8+CXBGJYwDxoF18Zs7cZ3M6VEh1N5CM0GY=;
        b=CsrAu2ruVrBKkLw+t4r2ZHYSbKlp4G++TjBVzgoDg1DINneMlGPyU1YL1oFdQYkJOP
         CQEzztF1Zllw5JXqWQGa0VGfaEOpYWLjrhnimnJpcaWhLqGPraxrBWRGK8jx39p3oUV9
         RCAeGuxKLexsyqw9advKgiLwogcxwCNHMUdEupoqYB1P5qQyQyDz8ipvvmyiHwyQwmL5
         08PxOGUePrYeFYWAcYE7FqCV9IkP4WeVYAEjcnVDzSmHC7h/UURWlxok+P2I0kRw9Mqz
         e8T5y2YXLWD2FuHuRgMG0fYzn0d++85jcN1RMTgLdfV2m7bi5Ea7cBIJGyvK9D04ojwo
         Me3Q==
X-Gm-Message-State: AG10YOQBEH8aPJiDb3RFPabxoMr7BdJ76tNHiNEEu2u+xRn3Dtl3dDWuXIIsm8J2RlJBUqYqN5ED8aoIEQJzug==
X-Received: by 10.25.159.68 with SMTP id i65mr5640640lfe.94.1455507101443;
 Sun, 14 Feb 2016 19:31:41 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sun, 14 Feb 2016 19:31:11 -0800 (PST)
In-Reply-To: <CAPig+cQ0V3KdHsJ2tNphkFx-2yDhtU4JFnrDU-zagXFz2jymbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286168>

On Fri, Feb 5, 2016 at 12:05 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Thu, Feb 4, 2016 at 4:03 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> @@ -732,7 +743,7 @@ static void receive_needs(void)
>>         if (depth =3D=3D 0 && !deepen_rev_list && shallows.nr =3D=3D=
 0)
>>                 return;
>>         if (depth > 0 && deepen_rev_list)
>> -               die("--depth and --shallow-since cannot be used toge=
ther");
>> +               die("--depth and --shallow-since (or --shallow-exclu=
de) cannot be used together");
>
> Also, does this change belong in patch 21/25?

21/25 is about client side support, so no, it should belong here. But
I probably should not mention client's option names here. After all
upload-pack can be used with some other client that names things
differently. I think I'm going with something like "git upload-pack:
deepen and deepen-since (or deepen-not) cannot be used together".
--=20
Duy
