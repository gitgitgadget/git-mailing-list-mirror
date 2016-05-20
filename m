From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v6 3/3] bisect--helper: `write_terms` shell function in C
Date: Fri, 20 May 2016 13:15:51 +0530
Message-ID: <CAFZEwPNkPZ6JnzqbTyhYMwEF-hor2rm39NcB84omrh+uCiVPNw@mail.gmail.com>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-4-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cS=zcSVLwARZ5A8hdiE0wqgYPU2Jwnr0OcjDXZFO--cZw@mail.gmail.com>
	<alpine.DEB.2.20.1605161508230.3303@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 20 09:45:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3f88-0000mP-P7
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 09:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbcETHpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 03:45:53 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34251 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbcETHpw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 03:45:52 -0400
Received: by mail-yw0-f176.google.com with SMTP id j74so101943721ywg.1
        for <git@vger.kernel.org>; Fri, 20 May 2016 00:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=hriVWLjGwguYiFHXsLEjXLbhpNXjzjfEXlFNgOVNgQo=;
        b=sd60UVyta246kfCBo/HQJDRfbj3tZoyfeWaXQm311CkEXUHy5Bxa1tt4Tq2Kc4qdwg
         nElY6JSPHqPFDU+cRrO24GFml41E91Uk8Ank0+w10szzwPkYmWLOCJKjDjKzlvrQWBMo
         lSody4i/OJYlYBWF6mfECcEKgLwnd4OShyi7eNiEQnadSGzgbOWux7NaorBhawODEmo4
         bMtGIYGWMMdh8Xj3mDNNz5pY5ogr3apiHLDfkMsINS84juy88uNGyTMPPMvMaSMH57O+
         SWf4oNC32xNW63IoC8sQvYzomLQSF2OkIr8mkWFqSzhPcQHxfr1wKSZpc4hpjAYFV4Ky
         JP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hriVWLjGwguYiFHXsLEjXLbhpNXjzjfEXlFNgOVNgQo=;
        b=BFMz3ojcqMyRCVnsnB5wRKgyNvNhKF93QFriDd4YMYBeLwgtcM31GG2ZYms7sgikd8
         W5BBdqLH5FtjTlMt+8ExX+Xq7NuCu6RIYPZZrdju3n3Nvg1AgobTqk132cucnxt+Gqaa
         KEjx9cNxMu8XbE9POTrgrG+EwGdxATkWJpdeLnkmaiEb31Ld9A46o4xAdIHMBkBmPaSN
         usU/YisQqWuA54C/WHQ72cBXKyRuGlXycCM4rSBfbnSL9HcaQRMMi5++L+fqD5W2PiBJ
         Kk6eWBGMKBffM1g3uzD4TluNf4HQrorBmRkmwhugmZMIk8RxP7lFmFAIIosueVko+hHm
         7BNQ==
X-Gm-Message-State: AOPr4FVhUy7pasF3UIqC3qlfbdQL6/Yfl7GCwvBaohmsb+oehtggWlE2mr7M1CBQ0VXHFHp1BFAavqfILooYVA==
X-Received: by 10.13.198.5 with SMTP id i5mr966690ywd.263.1463730351848; Fri,
 20 May 2016 00:45:51 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Fri, 20 May 2016 00:45:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605161508230.3303@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295156>

Hey Johannes,

On Mon, May 16, 2016 at 6:46 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 16 May 2016, Eric Sunshine wrote:
>
>> On Thu, May 12, 2016 at 1:32 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>
>> > +       fp = fopen(".git/BISECT_TERMS", "w");
>>
>> Hardcoding ".git/" is wrong for a variety of reasons: It won't be correct
>> with linked worktrees, or when GIT_DIR is pointing elsewhere, or when ".git"
>> is a symbolic link, etc. Check out the get_git_dir(), get_git_common_dir(),
>> etc. functions in cache.h instead.
>
> Maybe in this case, `git_path("BISECT_TERMS")` would be a good idea. Or even
> better: follow the example of bisect.c and use
> `GIT_PATH_FUNC(bisect_terms_path, "BISECT_TERMS")`.

Thanks. I will look into this.


>> > +               strbuf_release(&content);
>> > +               die_errno(_("could not open the file to read terms"));
>>
>> "read terms"? I thought this was writing.
>>
>> Is dying here correct? I thought we established previously that you
>> should be reporting failure via normal -1 return value rather than
>> dying. Indeed, you're doing so below when strbuf_write() fails.
>
> The rule of thumb seems to be that die()ing is okay in builtin/*.c, but not
> in *.c. So technically, it would be okay here, too. However, I think that
> this code should be written with libification in mind, so I would also
> prefer it to error() and return, to give the caller a chance to do other
> things after an error occurred.

Frankly, I have no idea what you mean by libification but I will use
error() since efforts for libification have already started.

Regards,
Pranit Bauva

> Ciao,
> Dscho
