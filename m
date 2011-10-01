From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Sat, 1 Oct 2011 14:27:01 +1000
Message-ID: <CACsJy8DVBVpDMgT7e1Mx70eUOznhifQHWR+zwg-=qPQMkzNRQA@mail.gmail.com>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com> <20111001022544.GA31036@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Oct 01 06:27:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9rAt-0005E3-O0
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 06:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979Ab1JAE1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 00:27:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56875 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab1JAE1e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 00:27:34 -0400
Received: by bkbzt4 with SMTP id zt4so2474624bkb.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 21:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GjCVQ8fX58Mh0m8RFBZoPYsL+qecSS8nL2FrTc9wlrc=;
        b=QB3FqY+JZP9/7jMwIhVpQa5cMGxUID1l7Pj4ZA6wniGrqm1nCWYB+Wd+tueSq/W/3S
         nhs9lvVlAkT8G9ubf+CdRnSoS7Z11LkMJuz493uGALhsIm4HyYgnSjsb4Hyr/DEcr+pP
         PviZfyHiLQb/tT2OmKz7lEddVHzIB3p7S9E10=
Received: by 10.223.95.148 with SMTP id d20mr1283786fan.59.1317443252101; Fri,
 30 Sep 2011 21:27:32 -0700 (PDT)
Received: by 10.223.88.202 with HTTP; Fri, 30 Sep 2011 21:27:01 -0700 (PDT)
In-Reply-To: <20111001022544.GA31036@LK-Perkele-VI.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182535>

2011/10/1 Ilari Liusvaara <ilari.liusvaara@elisanet.fi>:
> What about sticking code to return an error to git daemon instead of this?
>
> Here's what happens if I try to push to one of repos on this computer
> over git://:
>
> $ git push git://localhost/foobar
> fatal: remote error: W access for foobar DENIED to anonymous
>
> So send-pack can deal with ERR packet (and yes, that error message
> is really from Gitolite).

I'm dealing with git.gnome.org and not sure what's the server behind.
I had a look at git-daemon and it does allow push, but disabled by
default. So yes, maybe updating git-daemon is better.

> Aside: git archive seemingly can't deal with ERR packets. And worse
> yet, it doesn't even print what it received, resulting this:
>
> $ git archive --remote=git://localhost/foobar HEAD
> fatal: git archive: protocol error

Yes, builtin/archive.c seems only recognize either ACK or NACK.
pack-protocol.txt does not mention about ERR either, which seems to be
introduced in a807328 (connect.c: add a way for git-daemon to pass an
error back to client).
-- 
Duy
