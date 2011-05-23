From: Anthony Foiani <anthony.foiani@gmail.com>
Subject: Re: [PATCH] Improve errors from 'git diff --no-index'.
Date: Mon, 23 May 2011 15:24:50 -0600
Message-ID: <BANLkTinmtJXo4jcnB1TAFPPtcGqun5rfoA@mail.gmail.com>
References: <4dd98da1.1bf98e0a.4eb4.6fc5@mx.google.com>
	<7vlixyw4cx.fsf@alter.siamese.dyndns.org>
	<BANLkTinKpSP5oEms914TWD7Tsjab1B87QQ@mail.gmail.com>
	<7vhb8mw1e6.fsf@alter.siamese.dyndns.org>
	<BANLkTi=Uf8X+Bkd+CZ9qz0wXhHn8wwYzrA@mail.gmail.com>
	<7vpqn9usqt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 23:24:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOccT-0002zk-U6
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 23:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030670Ab1EWVYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 17:24:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59619 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030586Ab1EWVYw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 17:24:52 -0400
Received: by bwz15 with SMTP id 15so5078780bwz.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 14:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4MNSALmJWNZ5sH46jNmldZY9zsEYyJLQxezDAwo+NgY=;
        b=EX5FmiOAwA3nGSCmK+b/Q4ThCB9YWV9IzhyXsR5p54g1te+PRtRIm7JVRH0JedtRrg
         WrhmycM/BWpa6dg7OHGthFgdGiPL7+Ga8s5RXyVT7tfIQfNtKH/a+1UlOV91lyZMRLHm
         2oqgOwsR0HCbJJpt4d8B1d6nSP8ZHWVYhy9SM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BLag+oFQehuMuLuIv71F+iT6fGlq+Y+py2X4pP8uu2FrDJtG6JuNzu1N/kr8B1JG8Y
         oIn/xdIxlCwUdN4Jgvys/m1h9yjK8Sk4fWty42GR5FjJEA+oUX42R2vhgPi478S9OXKQ
         ZcQae1bHDZL/3zCrZA9BnsgY8mOaMqv4tNHcA=
Received: by 10.204.84.142 with SMTP id j14mr2431312bkl.20.1306185890837; Mon,
 23 May 2011 14:24:50 -0700 (PDT)
Received: by 10.204.57.209 with HTTP; Mon, 23 May 2011 14:24:50 -0700 (PDT)
In-Reply-To: <7vpqn9usqt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174280>

Junio --

This fundamentally all started as me confusing myself, and the patch
was the result of me scratching that itch.  As such, I'm perfectly
willing to drop it, but I did want to address a few last things:

On Mon, May 23, 2011 at 1:22 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> $ # with my patch:
>> $ ../git/git-diff /tmp/{foo,bar}
>> warning: neither '/tmp/foo' nor '/tmp/bar' are tracked, forcing --no-index
>
> I actually consider this a regression. We are giving an output that the
> user wanted to see, and I do not see a reason why we need to warn.

No, we're not: the user did *not* ask for a no-index diff, but we're
giving them one anyway. That warrants a warn (or other message; if
there's a less-severe version of "warn", then that's fine) to tell
them that the software is trying to "do what you mean".

Please also keep in mind that you live and breathe git, and have done
so for years (and I'm very thankful for that!).  But not everyone has
the git mindset all the time; adding an extra message or two doesn't
seem like too much pain to help novices and dilettantes.

> But that consistency goes totally against what the users would expect.
> This inconsistency is not a fault of either the definition of "git diff"
> nor the user's expectation. They are fundamentally different and the root
> cause of it is that we support --no-index diff between randomly chosen two
> files.

Maybe we *should* drop the feature: I would have been *happier* had
the error message from my initial attempt been simply: "not in a git
repo, can't use git diff". (Since that was, fundamentally, the mistake
I made.)

Maybe install "diff-git" or even "gdiff" (although maybe that's used
by gnu diff on non-gnu platforms, dunno).

But I maintain that the current combination of options, assumptions,
and error output are insufficient, and I still feel that my patch(es)
improve that matter.  *shrug*  Your call, of course.

Best regards,
Tony
