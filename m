From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: [PATCH 3/3] ewah: support platforms that require aligned reads
Date: Fri, 24 Jan 2014 00:49:42 +0100
Message-ID: <CAFFjANR=ZKmrf6QjkbiD3z1waoYjWV3eWR_1E-qJU9Nr65bFsw@mail.gmail.com>
References: <20140123212036.GA21299@sigill.intra.peff.net> <20140123212752.GC21705@sigill.intra.peff.net>
 <20140123234456.GF18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 00:50:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6U2F-00078c-5u
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 00:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbaAWXuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 18:50:04 -0500
Received: from mail-ve0-f171.google.com ([209.85.128.171]:43618 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbaAWXuD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 18:50:03 -0500
Received: by mail-ve0-f171.google.com with SMTP id pa12so1568090veb.30
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 15:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=INisM3nvn1a9zQ6cDUecUQOeTTuYWx8BgyKwuZaRcvo=;
        b=gM+pw49rryfYZ6hqAXJjRDocMqkU/JwCBwFoWoAX6wNQMUIJe5RrOW7ttGyXGp8B5z
         f4bJ8bfgoXXawCc/wdZSfZGofI36x4P0YEuh1pt2fac3a11GDVKONT2648dPHbVP64KG
         5ONOOKZcXvhrFBNj5Ce/Dd+e+QV6dVdz5BzL1qnU7atvCIWn9qqLwZ0hnz998bHg9h3W
         AygYrRD5zdxaIGrxYOYhJzpFXodHya2Qq2Emib45ZDd9TjV5j/24k0KqcRwOdIaiTyQm
         l43HLoxkYuIRPuaKvEiWnbbblPKa+Libq9c32lHCQhalOEGE25KlJjxMZnTxWSbfQBeF
         1Vfg==
X-Received: by 10.221.66.73 with SMTP id xp9mr5983914vcb.27.1390521002964;
 Thu, 23 Jan 2014 15:50:02 -0800 (PST)
Received: by 10.220.133.73 with HTTP; Thu, 23 Jan 2014 15:49:42 -0800 (PST)
In-Reply-To: <20140123234456.GF18964@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240976>

On Fri, Jan 24, 2014 at 12:44 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> --- a/ewah/ewah_io.c
>> +++ b/ewah/ewah_io.c
>> @@ -112,23 +112,38 @@ int ewah_serialize(struct ewah_bitmap *self, int fd)
> [...]
>> +#if __BYTE_ORDER != __BIG_ENDIAN
>
> Is this portable?

We explicitly set the __BYTE_ORDER macros in `compat/bswap.h`. In
fact, this preprocessor conditional is the same one that we use when
choosing what version of the `ntohl` macro to define, so that's why I
decided to use it here.
