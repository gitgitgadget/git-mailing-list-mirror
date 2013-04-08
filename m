From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 13:37:26 +0530
Message-ID: <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 09 00:03:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPK9K-0002Am-8m
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 00:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229Ab3DHIIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 04:08:09 -0400
Received: from mail-bk0-f50.google.com ([209.85.214.50]:51984 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760798Ab3DHIIH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 04:08:07 -0400
Received: by mail-bk0-f50.google.com with SMTP id jg1so2953938bkc.37
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 01:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=AjOM3KJrGTI4CGppO08B65sFuXtwgn3Ant31wMrZnGc=;
        b=TeGBjD+cWhjqGS/Ye2CwJHj51z6hXU7TbCn3wDszN7zZ/HoEhzxSAZSvZD/TcX2XXD
         Ytii1PTcTGpYjI2DIC3eTFKkupXI5zWC9elYQEV2AcEQUeLqZMg4vBiyL3jWduX/WD9h
         6kKfMt2qpd3tvVUhJYzM0eSEPYemmbgSKRX561eYVKm5/9X7zns2P9mX+wbfs8FI4pAo
         /2BR4GfBduQUQ57v3xplYHHLbBgOn0gR+DC+6PoJNanNR3HzhjjZHLN54ac1Z8iFcwIf
         EmW+PG6PNp5DLrMmBGTStWovSOWrNBzOkL5d5GJyWULPbzRiyaC7US1vfxMQY3iPw7i5
         j1qw==
X-Received: by 10.205.25.136 with SMTP id ri8mr10523189bkb.62.1365408486399;
 Mon, 08 Apr 2013 01:08:06 -0700 (PDT)
Received: by 10.204.37.69 with HTTP; Mon, 8 Apr 2013 01:07:26 -0700 (PDT)
In-Reply-To: <5162763D.5030708@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220406>

Jens Lehmann wrote:
> Hmm, at least the unstaged .gitmodules file has to be parsed from
> the file system.

You seem to be touting it as a distinct advantage.  In my opinion,
.gitmodules is a wart that needs to be done away with: it should _not_
be on the filesystem, just like a commit object isn't on the
filesystem.  Getting links to unstage is two hours of work, tops.  And
I'm the one writing the whole thing, so I don't see what everyone else
is complaining about.

> And Heiko's current work on parsing .gitmodules
> directly from the object store will help here too, right?

Ofcourse, you _can_ parse a blob into a struct.  It's just extremely
gross to treat a blob located in a certain tree path differently from
other blobs.  It's a perverse violation of git's fundamental design,
and I'm strongly against such a change.

What I still fail to understand is why you keep mentioning
work-in-progress.  You've had five years in which you haven't been
able to do things that I did in two days.  Yes, you _can_ keep
.gitmodules and hack around everything, but why do you _want_ to do
that?  Preserving backward compatibility is not *that* important, in
my opinion.
