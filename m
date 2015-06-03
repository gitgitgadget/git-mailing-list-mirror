From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH 1/2] test for '!' handling in rev-parse's named commits
Date: Wed, 3 Jun 2015 23:44:59 +0100
Message-ID: <CAAKF_uYrjBsVY8YOmRtMU8jB5rA57r+-N_KboqwWL3YRRqeKAg@mail.gmail.com>
References: <1433364854-30088-1-git-send-email-wmpalmer@gmail.com>
 <1433364854-30088-2-git-send-email-wmpalmer@gmail.com> <xmqqbngwwjbd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 00:45:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0HPb-0000cN-FI
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 00:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbbFCWpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 18:45:23 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33456 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998AbbFCWpV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 18:45:21 -0400
Received: by wiwd19 with SMTP id d19so3164948wiw.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IpB6ecUdHyUzowVzAKNe/XBBzvXDa2Q3kc/sBQdOBuo=;
        b=Uw7lICZ2JUeJPCQ23ak5MLVhl8G9aNXGjSXuFxfQFeX07ZJUyATtc1TXqIzuOiImSs
         Bpn3QmkDm/zQxcne0uLjc4Ye+ETkioWJB34poXG/tQ6tJnXFviFg5Pf2mfkdmnz849qp
         F8qy8dPjYr4u8OETiNkwVlCskKpuR3h26CIJBHmmp2beU6+DSW16UFTmaeIhpZilL4zD
         jfacN1xF+Aczmd37WSngX7HF7TqN1awUOfQzlayfuHuKRnK/KQmrhC4yenJ7WzY2UvbH
         yT3ED6lEBiK/CATk9saQ/qd6PspRLOTb/mGBqWKX+oO7pw3mlkqD84BN2Wa8zuupvyo4
         SjpA==
X-Received: by 10.180.83.6 with SMTP id m6mr46104765wiy.72.1433371520232; Wed,
 03 Jun 2015 15:45:20 -0700 (PDT)
Received: by 10.28.170.73 with HTTP; Wed, 3 Jun 2015 15:44:59 -0700 (PDT)
In-Reply-To: <xmqqbngwwjbd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270747>

On Wed, Jun 3, 2015 at 10:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The /! sequence being reserved does not mean it was planned to be
> used only for a single thing in the future, though.
>
> (snip)
>
> cf. http://thread.gmane.org/gmane.comp.version-control.git/40460/focus=40477
>

Thank you for that additional context, which I didn't see previously.

> Using "/!Message" to match commits that do not match Message
> directly goes against that extensivility design.
>
> We need to always remind ourselves that our latest shiny new toy
> will not be the final new feature.  There always will be need to add
> yet another new thing, and we need to keep the door open for them.
>
> Perhaps
>
>         /!-string       -> find commit without "string"
>
> or something?
>

What I'm thinking now is that "@^{/foo}" can be thought of as a
potential "shorthand-form" of what could be "@^{/!(m=foo)}", in which
case "@^{/!-foo}" could similarly be thought of as a potential
shorthand-form of what could be "@^{/!(m-foo)}".

So with that in mind, I agree that a syntax of "@^{/!-foo}" could indeed give
me the results I'm looking for, while leaving room for the previously
mentioned forms of future extension.

I don't know if I consider those potential extensions to be commendable
as a unified (and chain-able) syntax for finding revisions in the graph,
or to be needless clutter which would only add "yet another way to specify
the same thing". I mean, I like the idea of being able to specify that
I want "The third parent of the first commit authored by Fred which is
also an ancestor of a commit which touched a file in the libraries
subdirectory", it sounds like maybe it would be good to be able to do
that sort of thing without bringing xargs and shell expansion into the
picture... but I certainly don't have a clue what it might be good for!

In any case, it sounds like we have a good way forward for this smaller
change, at least. I'll re-submit with the suggested syntax.
