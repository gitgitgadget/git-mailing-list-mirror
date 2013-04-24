From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 04:14:55 +0530
Message-ID: <CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <7vvc7baahc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 00:45:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV8RY-0000eX-RE
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 00:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758521Ab3DXWpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 18:45:36 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34917 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758491Ab3DXWpg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 18:45:36 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so2748753iec.8
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bcBIGuvihe0F+OD3dekMIfLsHfK4UWMRCBcYMUllIH8=;
        b=VkZcdbiP6xhpK5X76HGFVXumHa6a6VMOuHzA/umdYO3pq4QGztJiKnyk1XSJdmv+MS
         GCudYmR3t6dWc+bocGNvutwNUx81FVMMdW87wJ0WUXLcctP8lCe6YRUH/5OpZbPvMwRU
         iyvAnReUL3e2igrK+kV/IXoPe0TcMx8HtimGVYu1ftYFi5ymfcZOVZO1L3O2oSSSzhjh
         dU4RMJCdUwsCVuVE+2rUSf4OBzGXvxD6mp8ewsDTYfr5pdMvgh/9qSQawe88uAMB8C3w
         pp1HCbawmg4MkelzlasbXOGj0JtaEw1Rx5nOV1Hz2Y1LivdLU/WnPRlgFZzVAKodxiv7
         rtFA==
X-Received: by 10.50.66.197 with SMTP id h5mr6548600igt.63.1366843535596; Wed,
 24 Apr 2013 15:45:35 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 15:44:55 -0700 (PDT)
In-Reply-To: <7vvc7baahc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222335>

Junio C Hamano wrote:
> How is it different from "git log master..rebase.autostash"?
>
>     git log A..B
>
> is already a perfectly fine way to spell your "A~B", which is
>
>     git log B --not $(git merge-base --all A B)
>
> when written in longhand [*1*], no?
>
> So I do not think your A~B helps "log".

They are equivalent if you use --all, which I didn't originally
propose.  I'll present a slightly contrived example, because I don't
personally merge much in the real world:

pu is based on master~10.  rebase.autostash is based on master~5 and
master~3 merges in pu.  I merge pu into rebase.autostash while
working.  Now, master..rebase.autostash will exclude commits reachable
from master (and therefore pu), but master~rebase.autostash will show
the commits in pu that I merged in.

Ofcourse, I now see that this is probably useless, and .. fits my bill.

When packaged with a good default for LHS (which .. currently doesn't
have), it might be a slightly better candidate.  I was thinking origin
instead of [nearest-fork-commit].

> It does not help "diff" either, because we already have A...B and we
> are not going to remove it (people are used to what it means).

Yeah, the invention arose as way to find a replacement for this inconsistency.

> So I think your A~B is still a solution that is looking for a
> problem.

Yeah, so it looks like the problem is entirely a minor cosmetic
detail: we're just clothing existing functionality with a consistent
new refspec.

We might still want it.  I mean what are we losing?
