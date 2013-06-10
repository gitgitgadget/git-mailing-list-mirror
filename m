From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] push: make upstream, simple work with pushdefault
Date: Mon, 10 Jun 2013 14:13:45 +0530
Message-ID: <CALkWK0mesZay8Cpi6yTvhUG=136=9JLyFUZXm8t_fMOrY0F62Q@mail.gmail.com>
References: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
 <1370798000-2358-3-git-send-email-artagnon@gmail.com> <7vip1moq3k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 10:44:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlxiK-0005D5-Je
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 10:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab3FJIo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 04:44:28 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36298 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577Ab3FJIo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 04:44:27 -0400
Received: by mail-ie0-f175.google.com with SMTP id a13so2716535iee.20
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 01:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=J6T8j9Tf257iJCdi3DXPet47LBMdIFMH/WLBIPhfAnY=;
        b=UaTB8SH9qmMkiUJns0trYAx1e8J+t2j1wef13FP9QPYX3UE7vJyGPrmxOk6nXh/DgR
         hZYON45pjdJaFINoudE3TZWPzZzt0ukN+iS2L8BKGCbC4tCqjK1JXlaMER2TgNtd3TAb
         11GwYZxA72gnyrK2jNggoN/L6oPhzfCSVZ2oJ1WRTd5kLmJRDEkO6ZbytRmT22i6Fnd5
         Oy5OXSXb5K2I6XA0OBHZsX6/kGf1FLZx87oSO3R9e/Kgr9CNan2dJFcrejQKTr2YfYrN
         GsvsjdtlsNnqCAxfn1mgAV8+YMcXdFZ/5j/4jPeZDg+Q/vhr4phaWgw+UHauAwjok2ij
         Cz6A==
X-Received: by 10.50.25.194 with SMTP id e2mr3515035igg.111.1370853867160;
 Mon, 10 Jun 2013 01:44:27 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 10 Jun 2013 01:43:45 -0700 (PDT)
In-Reply-To: <7vip1moq3k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227263>

Junio C Hamano wrote:
> I am not sure what you mean by artificial.

By artificial, I mean that the precondition is absolutely unnecessary
for the code following it to work.  The precondition was introduced in
a separate commit, specifically denying one usecase because the author
(you) thought that made sense.

> If you have push.default set upstream or simple, then a push run
> while on the branch 'foo' will figure out what happens when you do a
> fetch by looking at 'branch.foo.merge' to find the branch we are set
> to integrate from 'branch.foo.remote' remote.  The simple further
> says that branch name must be the same as 'foo'.

I understand this perfectly well, as evidenced by the tests I've
written out in 4/4.

> And that is what setup_push_UPSTREAM() is designed to do.  Rejecting
> a call that breaks the precondition is perfectly the right thing to
> do: if you set to push to "upstream" and if you are trying to push
> to a different remote, for example.
>
> The triangle topic changed the precondition without updating the
> logic to check it, which was the bug, not the original check.

Did I claim otherwise?  :)
The topic is about fixing a bug introduced by rr/triangle.

> I actually am OK with 'upstream' that rejects triangular, while
> making 'simple' do something different [*1*].

Okay, so you haven't outlined a solution either.  Like I said in the
cover-letter, I've spent hours breaking my head and can't figure out a
better solution.  The bigger problem is that upstream/ simple were
designed with only central workflows in mind.  How do we deal with it
now?

Yes, upstream/ simple work only when @{u} resolves, and I haven't
changed this (because we don't have a well-defined meaning for what
branch.<name>.merge without a branch.<name>.remote means).  My
argument is very simple: no push.default mode should not dictate the
push destination; only the push refspec.  What makes sense to the user
is an upstream/ simple that works as expected with pushdefault: do the
tests I've outlined in 4/4 not make sense?  *scratches head*

I don't understand why upstream/ simple should _not_ push to a
different destination from the one being merged from.  I'll repeat:
push source/ destination is orthogonal to push refspec, and
push.default modes dictate the refspec.
