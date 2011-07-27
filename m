From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 16/18] revert: Remove sequencer state when no commits are pending
Date: Wed, 27 Jul 2011 20:00:06 +0530
Message-ID: <CALkWK0k8Lra7LkGJXoXScnGUjrag-xgNptaB_JCiAsgemTq0eQ@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-17-git-send-email-artagnon@gmail.com> <20110727051755.GK18470@elie>
 <CALkWK0noPtLgr_t=DC_XFdLrWUNCLhUd00Mw1HbmWRJjeT4jew@mail.gmail.com> <20110727141006.GA24785@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 16:30:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm58E-0007sY-F6
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 16:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265Ab1G0Oag convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 10:30:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51778 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab1G0Oa1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 10:30:27 -0400
Received: by wyg8 with SMTP id 8so1022032wyg.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 07:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NTz5gpY2f/s9OUH+ztM2HKARgGj9bn1Duo0O24PHaAE=;
        b=Hap2Il1vNlBGTFNO1g5tIEjU4Ilfm9UiFWD+2xZELKCjwTrCFgdQsaV7P5MJtcAjT2
         vZuT5mAa/oEZcT5pkHNAD+/elSQD9Z/UjEMygs1UQSuJSbcNzo3uCxO8Tix+udAk6HWv
         yVHhUlcs+IyZDImlBoortuudzmD/EkV4+8s6c=
Received: by 10.216.175.206 with SMTP id z56mr101303wel.66.1311777026121; Wed,
 27 Jul 2011 07:30:26 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Wed, 27 Jul 2011 07:30:06 -0700 (PDT)
In-Reply-To: <20110727141006.GA24785@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177967>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> For reference:
>
>> My sequencer state was blown away just because of a stray
>> .git/remove-sequencer-state-after-commit from a previous operation!
>> This is horrible. =C2=A0One can then argue: the file should only eve=
r abort
>> *that* sequencer operation, and now we run into the problem of
>> assigning a UID for each sequencer operation. =C2=A0Unnatural and ug=
ly.
>> Conclusion: Making "git commit" remove the sequencer state is WRONG.
>
> That is a compelling argument for not using a
> .git/remove-sequencer-state-after-commit file, but I don't see why on=
e
> would want such a file anyway. =C2=A0Why can't "git commit" just call=
 a
> function or use a command that examines .git/sequencer and looks at
> how many commits are left to pick?

Hm, yes.  I'd definitely like to see a tighter coupling between "git
commit" and the sequencer as it becomes more generalized.
Would you advocate this specific change now?  If so, I'll write an
implementation right away.  I was wondering whether you'd like such a
tight coupling at this stage.

> Looking at it from the other side, "My sequencer state was blown away=
"
> is a bit dramatic. =C2=A0If it's a problem in "git commit", why isn't=
 it a
> problem in "git reset", too? =C2=A0If I just commited after resolving=
 a
> conflict from applying the last commit in the series, what cherry-pic=
k
> sequence state is going to be useful to me now?

Er, no.  I said "stray .git/remove-sequencer-state-after-commit" --
something that's left over from a long-forgotten sequencer operation*.
 Since "git reset" has already been established as a command that
removes the branch state, it's not as dramatic when "git reset"
removes the sequencer state; more so when "git commit" does it
accidentally.

> And how is this any less unnatural than making the 'abort cherry-pick=
'
> facility unusable when and only when cherry-picking the last commit i=
n
> a sequence? =C2=A0I don't get it.

I don't want to make it unusable! I was asking for suggestions (like
=2Egit/SEQUENCER_HEAD).

* I realize now that we can remove this file before starting a fresh
sequencer operation.

Thanks.

-- Ram
