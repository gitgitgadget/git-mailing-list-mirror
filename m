From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] mingw-multibyte: fix memory acces violation and path
 length limits.
Date: Thu, 3 Oct 2013 19:25:51 +0200
Message-ID: <CALWbr2zDi6XjMCRimUHu2=1qrA_=3ATq+50KBa1aNoBf4X_L9g@mail.gmail.com>
References: <1380403036-20413-1-git-send-email-wnoguchi.0727@gmail.com>
	<alpine.DEB.1.00.1309290112380.1191@s15462909.onlinehome-server.info>
	<524796DC.5020302@gmail.com>
	<5249AE2A.3050302@web.de>
	<524ACFAE.4040701@gmail.com>
	<524C9D8F.2090107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>, msysgit@googlegroups.com
To: Wataru Noguchi <wnoguchi.0727@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 03 19:25:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRmey-0006ZG-83
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 19:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab3JCRZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Oct 2013 13:25:52 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:65095 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab3JCRZv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Oct 2013 13:25:51 -0400
Received: by mail-qa0-f53.google.com with SMTP id k4so206612qaq.5
        for <git@vger.kernel.org>; Thu, 03 Oct 2013 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JXcMS/i7i4xKHWE9pFlEYEiUOil0qaZjkukDEcKx6as=;
        b=t0tSd3JIjfAp4iLpFRf52UiUGeofWNLuxCAcM1W/xC67WifpH4VXd9J9BUQzXsR152
         kiNMZdN1yRNo1zk9+xdF92rb1kjM6FqR2ZZlHA/dawstLbjKKrW4/R4YWx637aFpaXEG
         YyI7Xs4Js/qamfdVf2Gt25scnyZUCGCiAqQeAuS4lyl5TffE5CS1TPK72FDQy+LeIgga
         3Ih81VH9ObIKPb7R0me0LzNeWY+Ok4zAVoFrv9iYNdNk9M2rUmKxq+olc29leYjtQGs7
         qX8ltDN2iCor9Kv1cMkOgP08l8pHb9zbZhJjWb6p8ImOkvjYhzo/WG6Iq0fxD7qIS1R4
         J3Sg==
X-Received: by 10.49.71.45 with SMTP id r13mr11119336qeu.33.1380821151187;
 Thu, 03 Oct 2013 10:25:51 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Thu, 3 Oct 2013 10:25:51 -0700 (PDT)
In-Reply-To: <524C9D8F.2090107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235685>

I've not followed the thread so much but, in that
entry.c::checkout_entry,() we do:

memcpy(path, state->base_dir, len);
strcpy(path + len, ce->name);

which can of course result in memory violation if PATH is not long enough.

On Thu, Oct 3, 2013 at 12:26 AM, Wataru Noguchi <wnoguchi.0727@gmail.com> wrote:
> Hi,
>
> At last, I foundfollowing Makefile optimization suppression works fine in my
> case.
>
> CFLAGS = -g -O2 -fno-inline-small-functions -Wall
>
> Following optimization option cause crash,
>
> -finline-small-functions
