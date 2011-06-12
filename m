From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH v2] revert: Implement --abort processing
Date: Sun, 12 Jun 2011 18:21:57 +0530
Message-ID: <BANLkTi=gYSJgG-Yu-+-5wPetpb0-AW=X+g@mail.gmail.com>
References: <1307774186-14207-1-git-send-email-artagnon@gmail.com>
 <20110611112213.GA25268@elie> <BANLkTi=T0wCg1bKzmtQEQ-J-5ogqRZaqRg@mail.gmail.com>
 <20110612122145.GA20495@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 14:52:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVk9Q-0001Li-GI
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 14:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab1FLMwT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2011 08:52:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37378 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556Ab1FLMwS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2011 08:52:18 -0400
Received: by wya21 with SMTP id 21so2688469wya.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 05:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=zG2uJpFnSpi5SVZ6ZwJfk7kf43CwXTdsK+UH8CT+Ksg=;
        b=MwBD/FEu3Ik9nN/zj9jjEZTEgXrdTsuh05plh+CRTdi0XuwJQtjIlD1NOWdYHoTsb/
         dzgGgaCWLEoKzl2bUnw78VksDexATGtC8IM7SL9x3ehxjCmJC8DMEczLPRJib4yJZVtZ
         q7yuotYwCfsKEt3XJJwo5GugSy946DqulTyCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FYCbGzWtQDg/+8LrVKLCvlm4uQFPJ+CV5gsB81osyxVSeVTCIllSwt+bu3vCa8yTaK
         SOpn6i6eQ24GdBngjA488C+axMHMDfOOsslDRLNqab/+cBgQyvP5zbcrnTkC8xwvvxd8
         9Shad/kQLKZJ4nqvQ0TryrxjGxYjH4ZD9+dzk=
Received: by 10.216.79.5 with SMTP id h5mr3912453wee.110.1307883137118; Sun,
 12 Jun 2011 05:52:17 -0700 (PDT)
Received: by 10.216.1.20 with HTTP; Sun, 12 Jun 2011 05:51:57 -0700 (PDT)
In-Reply-To: <20110612122145.GA20495@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175659>

Hi again,

Jonathan Nieder writes:
> Would this person expect:
>
> =C2=A0- that "git diff --cached" would return a pile of changes
> =C2=A0- that "git reset --keep", "git reset --merge", "git checkout",
> =C2=A0 "git merge", and various other commands would refuse to do muc=
h,
> =C2=A0 for fear of clobbering the new "local changes"
> =C2=A0- that the worktree would be unchanged
> =C2=A0- etc
>
> Would they be happy about it? =C2=A0Just put yourself in their shoes.=
 =C2=A0A
> soft reset is near the most intrusive behavior possible.

Okay, it sounds pretty terrible when you put it like that :p

> And that is a good way to think about the UI for any new facility. =C2=
=A0If
> you disregard about how flexible it is in abstract, how easy to
> implement, how elegant-sounding and just think about a person using i=
t
> will find her quality of life improved or worsened, that is (1) a goo=
d
> sanity-check on a design and (2) basically the only way to explain it
> to other people.

=46rankly, I'm still trying to understand how other people work -- I
don't use the porcelain much, and I dislike anything but the most
minimalistic automation.  I didn't even like the change to cherry-pick
where you can simply "git commit" after resolving a conflict; I still
prefer and use the more explicit "git commit -c" after removing the
CHERRY_PICK_HEAD.  Also, I *always* use rebase with --onto, because I
explicitly want to know how many commits I'm picking, and I often
don't remember if I've rewritten the ref I'm rebasing onto.  While
rebasing, I use reset --hard a lot, because it's a very effective and
well-understood hammer; I then cherry-pick the refs I want from the
reflog.  I don't know how others work; I think I'm completely confused
about UI because I'm trying to mix my personal tastes, historical
conventions, and suggestions from others.
</rant>

Long story short: I'm hopeless at UI design. I'll think about the
sequencer UI from a fresh perspective again, and hopefully post
something sensible soon.

-- Ram
