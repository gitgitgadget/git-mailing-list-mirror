From: Phil Hord <phil.hord@gmail.com>
Subject: Re: odd behavior with git-rebase
Date: Mon, 26 Mar 2012 14:31:05 -0400
Message-ID: <CABURp0qeJEwELpg_YKxn9Ghb6EMphrwwfueM2XCqua3X_dacdA@mail.gmail.com>
References: <20120323185205.GA11916@hmsreliant.think-freely.org> <20120323195455.GB15063@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:31:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCEhY-0000gI-Oc
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 20:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822Ab2CZSb1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 14:31:27 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51843 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932796Ab2CZSb0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 14:31:26 -0400
Received: by lbbgm6 with SMTP id gm6so4204822lbb.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kvItZHFCqNymyk3BMtTdOq1itorPN87bIIxgPhQCugI=;
        b=tm58s9fpwMGDK3vLZP4QaMCwW5G6FJIYsMU5G933vgyjIE79sGw3wcfZQ7AVPlzqG3
         dSGjTl+YGvn09C67slhkR2B1wIJJg9/KwjevbEQgPpBZ9Xkh8a5ECv3BS2I5p0HLncSf
         yDc5rnHH42GrJFz8v/sDlsBaln/0RknWJdBuj71VYDg2Sb2RaNIj5TVr4YMSmAIxsPDG
         xCTAhSz6QLh5Gg+iVKy41D3E544XSFLxBSVlfmzfoAtIwpPHuXXNuRlhDuXKT2WZcixr
         KX4ABfiim87iaYRFO2chSn2n3rwNA2XtSk9BBOx9Vr1/xiXcIGY8aheFFPnGYzsmsF2s
         K1FA==
Received: by 10.152.112.100 with SMTP id ip4mr16988508lab.1.1332786685359;
 Mon, 26 Mar 2012 11:31:25 -0700 (PDT)
Received: by 10.112.55.43 with HTTP; Mon, 26 Mar 2012 11:31:05 -0700 (PDT)
In-Reply-To: <20120323195455.GB15063@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193951>

On Fri, Mar 23, 2012 at 3:54 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 23, 2012 at 02:52:05PM -0400, Neil Horman wrote:
>
>> =A0 =A0 =A0 I hit a strange problem with git rebase and I can't quit=
e decide if its
>> a design point of the rebase command, or if its happening in error. =
=A0When doing
>> upstream backports of various kernel components I occasionally run a=
ccross
>> commits that, for whatever reason, I don't want/need or can't backpo=
rt. =A0When
>> that happens, I insert an empty commit in my history noting the upst=
ream commit
>> hash and the reasoning behind why I skipped it (I use git commit -c =
<hash>
>> --allow-empty). =A0If I later rebase this branch, I note that all my=
 empty commits
>> fail indicating the commit cannot be applied. =A0I can of course do =
another git
>> commit --allow-empty -c <hash>; git rebase --continue, and everythin=
g is fine,
>> but I'd rather it just take the empty commit in the rebase if possib=
le.
>
> I think it is even odder than that. If you use plain rebase, the empt=
y
> commits are silently omitted. If you do an interactive rebase, you ge=
t
> the "could not apply" message (and just doing a "continue" creates so=
me
> funny error messages and ends up omitting the commit).

Coincidentally I ran into this same behavior this week.  But what
bothered me about it was the messages git gave me.  The empty commit
gave me cherry-pick hints instead of rebase ones, including advising
me to "use 'git reset'" to resolve the problem if I don't want this
commit after all.

$ git rebase -i HEAD~10
=2E..
The previous cherry-pick is now empty, possibly due to conflict resolut=
ion.
If you wish to commit it anyway, use:

    git commit --allow-empty

Otherwise, please use 'git reset'
# Not currently on any branch.
nothing to commit (working directory clean)
Could not apply d513504... Some commit message


I'm not sure if this is the norm or if it's a result of some other
things I did in this sequence.  But I've seen it several times now.
I've only tested it on 1.7.10 versions, including RC2.

Phil
