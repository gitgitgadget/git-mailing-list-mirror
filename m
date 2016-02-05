From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 20/25] upload-pack: support define shallow boundary by
 excluding revisions
Date: Fri, 5 Feb 2016 00:05:50 -0500
Message-ID: <CAPig+cQ0V3KdHsJ2tNphkFx-2yDhtU4JFnrDU-zagXFz2jymbg@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-21-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 06:05:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRYah-000338-5A
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 06:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbcBEFFw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 00:05:52 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35067 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbcBEFFv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2016 00:05:51 -0500
Received: by mail-vk0-f68.google.com with SMTP id e185so2206861vkb.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 21:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=om504fsMCLpQVHiUplXYGusJfQ8NynvmhxP63SEdfbM=;
        b=y1/XPIGfhhZIiKvCegdZd/ws8+FvtnFxIQ45rvGEp/QTiKKzPBjpho5xmjgsJzMFzT
         s1ifY0a5fmUl7uUCGcGdT1J+jaRsoX6tji/iS1j43AV20D/GorP0fBARGJjwt3jsOMRs
         h/pmrW725eaBE1rr8qdDadXXcagNT3dKNBMwpAONuv/60reB6sOULekgfoDiAAM8jb3L
         Ab3nL2aA1APxcXEDlLRiu5lqkyHhK6mq0odjHuy+aQP7ZW7Eumey91ItVHkwPLCVNbJh
         wCjUKOSzUCDQrpAJeuNbPtsds3Su1RT2rUhPkJG28Y7lFfb1T2CT3tj4DC0vKIqDYY/R
         +yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=om504fsMCLpQVHiUplXYGusJfQ8NynvmhxP63SEdfbM=;
        b=Y/UwaGyyJ8RUPhf5it3G4qIIfhkL8uDeR4b3KdKNizXAupOobeSbZ7gKuzob8NmoRU
         jUQWq+yzoVnTDk4BiWdpI0YxIbAZo5dFt+uL6HYg+/OkgBgf8+6zuVDER7CH1qJ+yxoi
         Haa7QHtLz+NXkvZYmTcN95jKjlohNJ4DOd5CcaUpkcOewLxYBQEZNNEJzcJpv9LzxYQo
         /y6ZKQ39A+YkA3YDPs0F4xYNwRXb+8FZzC7yNlu1FPGTODj8/uHI0U/X/Vh3NjJIz+Jg
         b7A9rsXqMfCxtLsWEiuggZmlKji94x/cE1rYeJoEdsc4+QqgpeL0jxb9GaP89fy0tjmu
         /ooA==
X-Gm-Message-State: AG10YOQpZ7fL1smPVO5z2dpbIMBECjUdMUniYUwkZ7b/UgLgluQuh9fyOoMJDc3H3oBzogpQ2S3oe15akUXLzA==
X-Received: by 10.31.150.76 with SMTP id y73mr8115174vkd.84.1454648750431;
 Thu, 04 Feb 2016 21:05:50 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 4 Feb 2016 21:05:50 -0800 (PST)
In-Reply-To: <1454576641-29615-21-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 7OYopiKxgRiApSq5-OwxDNI2Zng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285539>

On Thu, Feb 4, 2016 at 4:03 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> @@ -732,7 +743,7 @@ static void receive_needs(void)
>         if (depth =3D=3D 0 && !deepen_rev_list && shallows.nr =3D=3D =
0)
>                 return;
>         if (depth > 0 && deepen_rev_list)
> -               die("--depth and --shallow-since cannot be used toget=
her");
> +               die("--depth and --shallow-since (or --shallow-exclud=
e) cannot be used together");

Also, does this change belong in patch 21/25?

>         if (depth > 0)
>                 deepen(depth, &shallows);
>         else if (deepen_rev_list) {
