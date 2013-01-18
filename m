From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] fix clang -Wtautological-compare with unsigned enum
Date: Fri, 18 Jan 2013 10:52:25 -0800
Message-ID: <CA+55aFzTy0x6X_dK54RO13s+zG9ynWG_8Ei=ZwT8a5B4=LQ94A@mail.gmail.com>
References: <20130116182449.GA4881@sigill.intra.peff.net> <1358376443-7404-1-git-send-email-apelisse@gmail.com>
 <1358376443-7404-2-git-send-email-apelisse@gmail.com> <CALWbr2wk+78zxGKCo-hCOwMuMOzdGspYvMu7PA6o0OYM3Y3m4A@mail.gmail.com>
 <20130117110008.GD4574@serenity.lan> <CA+55aFxYSX2iYPSafKdCDSfWSMfQxP3R3Hqh8GuiiR6EbWfk3w@mail.gmail.com>
 <CABURp0pj35j7+W_0gYNud2uuEoahugOMBW9ezTgPZ7YvgnBz8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Keeping <john@keeping.me.uk>,
	Antoine Pelisse <apelisse@gmail.com>, Max Horn <max@quendi.de>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 19:53:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwH3r-0000WW-KR
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 19:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab3ARSwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 13:52:46 -0500
Received: from mail-vc0-f170.google.com ([209.85.220.170]:55578 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab3ARSwq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 13:52:46 -0500
Received: by mail-vc0-f170.google.com with SMTP id fl11so3948936vcb.15
        for <git@vger.kernel.org>; Fri, 18 Jan 2013 10:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=BiYY7kfZp/YDf4EPuLv5Zgblcvip7R9p9UNtTYaCObw=;
        b=kvz9pLrssjLXtG9Lh27+WPzPBoXt4qk48WxuMnYcAg3cwxZpyoZH2JHYnLugjCxZjl
         fJVP4lof5O//16082gbgzrW0vLIdtvHcHRcDt7GPS2LSQfxBOlaQ51BOCfET40g25kRB
         sGV0104DHqgKirRgEU5fJdiKXjL5I1tJDjXXJ0vYGcYcO3HTpUyjFp/PwwASZeVWnvej
         yKFtdDJQ5vMCU1hyKovvGc5Gp7v2vS+pQocupOr+ResuNlSPhD4yoHhXW7kKR/Du0wrg
         v7Hs5lrq6Ry4tmua8NPfH173o/dSLPt45ASZi/711UclXUBSOPc/VXv6QdwDXCleJwGw
         Ik3g==
X-Received: by 10.52.96.3 with SMTP id do3mr4036130vdb.100.1358535165273; Fri,
 18 Jan 2013 10:52:45 -0800 (PST)
Received: by 10.220.249.199 with HTTP; Fri, 18 Jan 2013 10:52:25 -0800 (PST)
In-Reply-To: <CABURp0pj35j7+W_0gYNud2uuEoahugOMBW9ezTgPZ7YvgnBz8w@mail.gmail.com>
X-Google-Sender-Auth: YmmvvOlqy9qdzJlTcBculdghrnY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213922>

On Fri, Jan 18, 2013 at 9:15 AM, Phil Hord <phil.hord@gmail.com> wrote:
>
> Yes, I can tell by the wording of the error message that you are right
> and clang has a problem.  But the git code it complained about does
> have a real problem, because the result of "signed int a = ULONG_MAX"
> is implementation-defined.

Only theoretically.

Git won't work on machines that don't have 8-bit bytes anyway, so
worrying about the theoretical crazy architectures that aren't two's
complement etc isn't something I'd care about.

There's a whole class of "technically implementation-defined" issues
in C that simply aren't worth caring for. Yes, the standard is written
so that it works on machines that aren't byte-addressable, or EBCDIC
or have things like 18-bit words and 36-bit longwords. Or 16-bit "int"
for microcontrollers etc.

That doesn't make those "implementation-defined" issues worth worrying
about these days. A compiler writer could in theory make up some
idiotic rules that are still "valid by the C standard" even on modern
machines, but such a compiler should simply not be used, and the
compiler writer in question should be called out for being an ass-hat.

Paper standards are only worth so much. And that "so much" really
isn't very much.

                Linus
