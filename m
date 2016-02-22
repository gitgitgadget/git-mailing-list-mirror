From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] Correct conditions to free textconv result data
Date: Mon, 22 Feb 2016 20:00:18 +0700
Message-ID: <CACsJy8D-2kuBRhiMEVTeHOz2V=wE20pwd=jL5L=x0gHjA_OWMw@mail.gmail.com>
References: <1456145545-5374-1-git-send-email-pclouds@gmail.com> <1456145545-5374-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 14:01:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXq7E-0005ls-Io
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 14:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbcBVNBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 08:01:23 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33580 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbcBVNAt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 08:00:49 -0500
Received: by mail-lf0-f43.google.com with SMTP id m1so93849174lfg.0
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 05:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=B1Xzs+u9AIBaY6SRGU++K9QpAAiQxFibatcAJYUvgcs=;
        b=yLHZTV7fsJ99x7PUP6PoLXb/xGAoa3D5+O0qA/rkl97ojAbUlOyVtdl2nvByexCi9u
         gqn00i1aMOpJ+sg5L5JnicrQOyRSftz9BN/JBAX82frqCxIztk7yhjBneVn0KBzBgAbJ
         ZGPksrudOJ4jXVwkWshUYIg+NDUY2GbDfTjPLptDq98W2BLnYypbHt9p3m06kBz365CF
         wsyPFsIV5dvts/5mKo96R9a577Aq2nG/+V1pMWzdFJRRAExPqJLhwRR2cCKCKkfo34eY
         n4jpdqn8k6cXnKAEEDYvG95OCZp62uElizAUu1Eq7Gl5N5u++xVWfBmmESH4R+Wg8VO5
         cBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=B1Xzs+u9AIBaY6SRGU++K9QpAAiQxFibatcAJYUvgcs=;
        b=LiSJhfMhh9ul0GyI5CfR7WQM1ZPsikKs+hO7nWJ6wyUrwPoDWpj72aXDgoqo7cagch
         4uR4fH1VdJeNSJ8ZwTCrbNgEf94NJcH9zx0iNI4mUecCXHEeemNeMU9MVFC4etz8/SdY
         mjJet56kShAndFgUpFqMa++091uLzo8T9SZmWbuyOlQa9XQq4cF0w8LyA67ZT+frcxrm
         YcQ4MNEj51RXG0YO8ENRITcF2fVncvisCGSsro1D594F000rZiC1THpB0OBk/TBeChCJ
         pe3dAdynLkwbgdGo+xNKhlklfNcy3Dnpfy3HCuDJk+8VJmu19vGE39B88LOCUZTzcOiY
         gejA==
X-Gm-Message-State: AG10YOTem5laUcR06eJC82gk2q6HM+10DHWKhSvDH07ugeyWcj01ghLUzAdiPbgvXyW2Bq/sKeBLxSI2KKIuRw==
X-Received: by 10.25.5.6 with SMTP id 6mr8182611lff.3.1456146048310; Mon, 22
 Feb 2016 05:00:48 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Mon, 22 Feb 2016 05:00:18 -0800 (PST)
In-Reply-To: <1456145545-5374-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286929>

On Mon, Feb 22, 2016 at 7:52 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> fill_textconv() have four code paths to return a new buffer.

I forgot to add. Thanks to -Wwrite-strings pointing to '*outbuf =3D ""'
line in this function. I wouldn't notice otherwise.
--=20
Duy
