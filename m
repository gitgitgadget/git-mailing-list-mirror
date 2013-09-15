From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Sun, 15 Sep 2013 14:44:03 +0200
Message-ID: <CAHGBnuOfYoosgWQdfF+L3=YCqO-MYEx-TpNzBAD-Zt0kqeR_Hw@mail.gmail.com>
References: <523094F0.9000509@gmail.com>
	<20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
	<20130912202246.GF32069@sigill.intra.peff.net>
	<xmqqr4ctokat.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOQ-y1beD_X_jiH+FrhPvLOVJqT0J=Wk988Q4NeCs1-9Q@mail.gmail.com>
	<xmqqppsckcsd.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMNDJhAqNfgVRHRE-7R=UZbd+fMExYeKDWWCFjyQJYYTQ@mail.gmail.com>
	<xmqqppscij8a.fsf@gitster.dls.corp.google.com>
	<CAHGBnuM=QqLxPNNZmoL1jG+oAm2y6o=AuBtkH+FRwZ_8ahGC+w@mail.gmail.com>
	<xmqqli30idfx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 15 14:44:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLBgR-0003vY-JE
	for gcvg-git-2@plane.gmane.org; Sun, 15 Sep 2013 14:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837Ab3IOMoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Sep 2013 08:44:07 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:38679 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab3IOMoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Sep 2013 08:44:05 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so2298880lab.33
        for <git@vger.kernel.org>; Sun, 15 Sep 2013 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GV4mFkSNLIUonl64MVLJ5mGZT0BtSAXPrfLOJkVeGoc=;
        b=carR4Dohd5ufn1PddtvmLRqcltJYvDa3PA945Vp3aQVU3RkIzY2craDDfVKGmd9P78
         mNaSecrdz8ez0+oVIHq2NkicRot6w93VG1wZ3F59kKrCSqZhlLPB89k6D+MbqbjDLN/c
         mp7JAAmKRw/BzUtZU4ozyug9iLg5Jqe6f8lNCxuBowPnXNeV7okr+jbuvd8w/GOhrF49
         hMD/DJopOmi35u2igl//osXRiYj+bVUbGBV1v7H5UMATaLNAOy53wcca6KJ5joH6n+xK
         MaaaEWz1DtGIcNItOpbZQNab1lWzhoWQ9GzRbvczAkLuqD6wyOe237PkSBoF2+7EuhU+
         F/ig==
X-Received: by 10.112.149.197 with SMTP id uc5mr20266680lbb.19.1379249043564;
 Sun, 15 Sep 2013 05:44:03 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Sun, 15 Sep 2013 05:44:03 -0700 (PDT)
In-Reply-To: <xmqqli30idfx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234815>

On Sat, Sep 14, 2013 at 12:06 AM, Junio C Hamano <gitster@pobox.com> wrote:

> You can explicitly include the system header from your compatibility
> layer, i.e.
>
>         === compat/mingw/string.h ===
>
>         #define __NO_INLINE__
>
>         #ifdef SYSTEM_STRING_H_HEADER
>         #include SYSTEM_STRING_H_HEADER
>         #else
>         #include_next <string.h>
>         #endif
>
> and then in config.mak.uname, do something like this:
>
>         ifneq (,$(findstring MINGW,$(uname_S)))
>         ifndef SYSTEM_STRING_H_HEADER
>         SYSTEM_STRING_H_HEADER = "C:\\llvm\include\string.h"
>         endif
>
>         COMPAT_CFLAGS += -DSYSTEM_STRING_H_HEADER=$(SYSTEM_STRING_H_HEADER)
>         endif
>
> People who have the system header file at different paths can
> further override SYSTEM_STRING_H_HEADER in their config.mak.
>
> That would help compilers targetting mingw that do not support
> "#include_next" without spreading the damage to other people's
> systems, I think.

I think this is less favorable compared to my last proposed solution.
While my work-around in git-compat-util.h from [1] already is quite
ugly, it's at least in a single place. You solution spreads the code
it multiple place, making it even more ugly and less comprehensible,
IMHO.

[1] http://www.spinics.net/lists/git/msg217546.html

-- 
Sebastian Schuberth
