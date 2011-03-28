From: Andrew Garber <andrew@andrewgarber.com>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 10:29:38 -0400
Message-ID: <AANLkTin1QCda9BV+gND1kcXRTZBF7hj3Chce5OkLX2a9@mail.gmail.com>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 16:30:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4DSJ-0002c7-Fv
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 16:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229Ab1C1OaA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 10:30:00 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36285 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982Ab1C1O37 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 10:29:59 -0400
Received: by eyx24 with SMTP id 24so1168930eyx.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=aIqnlQ29/imzx0ngIdJ2g46tkR4tsSrSziI1lpO/pVQ=;
        b=XyyreHGwNxIuUMgl3vFloI2elxxCZ+vouYFMW2yVQKkulc5l67/IJkle+luLFSaZhE
         amnqFd8toSxYAvOk1Y5p1N+VOoRfaSPVMzXg/zEE/aBnZUHhGTQliXy1aPhp5Bxs8hXr
         BbyrRbYEMomKQs5w/BsZ9ssiVQz3RlkRknqYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=i1gKdiYNh7SiRYvMMbSCHziRoIGpfczVW9G3+m8MU5no94wK2IDEGJg8SMNKpcjPR0
         wBFmm79p19Yx7XBYbH6fJ4+7AV1kxFGt6StwzcDx479yfBOiTHWJ1yI6gASB8Dg11qWp
         zptm0IlWknmFyS6HCkGyIRCYRZjCPoaRXDAow=
Received: by 10.213.15.141 with SMTP id k13mr1230232eba.144.1301322598100;
 Mon, 28 Mar 2011 07:29:58 -0700 (PDT)
Received: by 10.213.105.76 with HTTP; Mon, 28 Mar 2011 07:29:38 -0700 (PDT)
In-Reply-To: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
X-Google-Sender-Auth: Aw-oW8NVP0u1XfcZXox0Yp4A9m8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170131>

> I'd expect this to work:
>
> =C2=A0 =C2=A0$ git bisect start
> =C2=A0 =C2=A0$ git bisect good
> =C2=A0 =C2=A0$ git bisect bad HEAD~100

So would I. I think the behavior of git bisect should be changed.
Right now, it's trying to find the first bad commit. Instead, it
should be trying to find the first commit where the code's good/bad
state *changed*. IOW, it should be able to handle both of the
following cases:

good <--- oldest
good
good
bad <--- the commit we want bisect to find
bad
bad <--- newest

bad <--- oldest
bad
bad
good <--- the commit we want bisect to find
good
good <--- newest

It shouldn't matter which end we start on, so long as one end gets
marks good, and the other end gets marked bad.

Andrew
