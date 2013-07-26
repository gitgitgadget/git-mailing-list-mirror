From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Sat, 27 Jul 2013 02:47:47 +0530
Message-ID: <CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
References: <1374862320-22637-1-git-send-email-artagnon@gmail.com> <20130726191631.GD29799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 26 23:18:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2pPR-0001gU-FS
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 23:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760419Ab3GZVSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 17:18:31 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:49444 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760487Ab3GZVS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 17:18:28 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so5252218obc.23
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 14:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=175/Yxi8o3c/h3dt+FDL6Lm0w+rZmpjh+Utx5OllFJs=;
        b=kMpaZx0WR59LTPy2BoOKlMGfk7DjM4M/f4n4oNKNvIFXkmiCTKm/yrcc5Ogcj8GmuY
         9B5uZfvL5GTCoNfuPvOpVP7geoGrPvEfluJrAV/PV1oc565Bs4hVnBGFwBnbdf5sr38W
         AShjJ7zkToj7L7fxjjYx0v3KEW8KstvJXmNgDlvZQSzTw0t2sw2FWXLqxyiHjb9ZxBlG
         /IpHYIl9kvxGxG4K/Pj4njT9akLOp2yngaKNCv+aljSUMkLMKYPs1t91Xguyr5ONfNN5
         0op0cqcJtBXzAvXu1M15crhEiGSyYda90/q71DF/vp7n7GF++sbOVRzIKbkul5qetrAX
         dKVQ==
X-Received: by 10.43.15.68 with SMTP id pt4mr20855236icb.35.1374873507896;
 Fri, 26 Jul 2013 14:18:27 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 26 Jul 2013 14:17:47 -0700 (PDT)
In-Reply-To: <20130726191631.GD29799@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231204>

Jeff King wrote:
> Hmm. I don't think I've run across this message myself, so perhaps I do
> not understand the situation.

It's very simple.

  # on branch master
  $ git checkout -b test
  $ git cherry-pick master
  $ ls .git/sequencer
  # missing

In the pseudo multi-pick case (I say "pseudo" because there's really
just one commit to pick):

  # on branch master
  $ git checkout -b test
  $ git cherry-pick master~..
  $ ls .git/sequencer

cat .git/sequencer/todo if you like.

>   2. Skip this commit and continue the rest of the cherry-pick sequence.

Nope, this is unsupported afaik.

> Those are the options presented when rebase runs into an empty commit,
> where (2) is presented as "rebase --skip". I'm not sure how to do that
> here; is it just "cherry-pick --continue"?

No, --continue will just print the same message over and over again.

Yes, the whole ranged cherry-pick thing can use a lot more polish.

>   1. What happened (the cherry-pick is empty).
>
>   2. How to proceed from here (allow-empty, abort, etc).
>
> You still want to say (1), but (2) is useless to old-timers.  Probably
> something like advice.cherryPickInstructions would be a good name for an
> option to squelch (2), and it should apply wherever we tell the user how
> to proceed. Potentially it should even be advice.sequenceInstructions,
> and apply to rebase and am as well.

Good suggestion.  I'll pick advice.cherryPickInstructions when I
decide to polish sequencer.c a bit.

Thanks.
