From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 1/3] match_pathname: avoid calling strncmp if baselen is 0
Date: Sat, 9 Mar 2013 10:06:29 +0100
Message-ID: <CALWbr2xJfgba9_nyy609mhMOY3vq_ckZwb5C2nSsZJNNFRCLTA@mail.gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
	<1362802190-7331-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 10:07:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEFkH-0004B7-Cr
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 10:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145Ab3CIJGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 04:06:33 -0500
Received: from mail-qa0-f41.google.com ([209.85.216.41]:55038 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917Ab3CIJGb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 04:06:31 -0500
Received: by mail-qa0-f41.google.com with SMTP id bs12so204555qab.14
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 01:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=9LGoZOuJmrz2mEBjDddg8ey9HLBOVu7uKpPhb2X006M=;
        b=gXDmEyznpoqy17BuBKVLQpQb3uLxSPdM7kCF6FY+yiqmSoWk2NJlAhm4/Q76IRDRwn
         XvxW5YvqH3xOVdFn2Z6tF/++4Qa9FutTXCvXSM4F/YYRa47VgaDTs9yM0mhDuo30wx4f
         5fXGpHZadk9Cn4oyir/vrtS8PiyyW9BLP3C0PQN6Vp/DyLPqwJcRBZG0I8nZilSclDKv
         elx5OrK1gBi1CWifrvSwjHOWDiiIgyexCDu+omCr0Wo+rVRb6Cv9tLBed3tGp4uvbQMe
         nwCqXRm0PyDylZn1Rdjsde3PbaxY6bZUq+zCkBFgV/s6K7pFBuwzBa8vpLmFsChhdAEO
         NGfw==
X-Received: by 10.229.111.79 with SMTP id r15mr1717281qcp.133.1362819990049;
 Sat, 09 Mar 2013 01:06:30 -0800 (PST)
Received: by 10.49.70.163 with HTTP; Sat, 9 Mar 2013 01:06:29 -0800 (PST)
In-Reply-To: <1362802190-7331-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217715>

> diff --git a/dir.c b/dir.c
> index 57394e4..669cf80 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -663,7 +663,7 @@ int match_pathname(const char *pathname, int pathlen,
>          */
>         if (pathlen < baselen + 1 ||
>             (baselen && pathname[baselen] != '/') ||
> -           strncmp_icase(pathname, base, baselen))
> +           (baselen && strncmp_icase(pathname, base, baselen)))

Shouldn't you factorize by baselen here ? For readability reasons, not
performance of course.

>                 return 0;
>
>         namelen = baselen ? pathlen - baselen - 1 : pathlen;
