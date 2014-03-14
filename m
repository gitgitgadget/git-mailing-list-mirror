From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH 3/3] reset: Print a warning when user uses "git reset"
 during a merge
Date: Fri, 14 Mar 2014 17:35:19 -0400
Message-ID: <CADgNjakXANkNPyO6n5CH3=R-Heuf2qQ0STyJU4zSgTw63C19-A@mail.gmail.com>
References: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
	<1394771872-25940-4-git-send-email-andrew.kw.w@gmail.com>
	<5323131C.7070506@xiplink.com>
	<CADgNjan9kCTMPczFzO4jQvM63EU4x7KnJKszhno5PjHivE9ENg@mail.gmail.com>
	<xmqqa9csh54f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:35:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOZlJ-0003JE-99
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 22:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673AbaCNVfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 17:35:22 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:59313 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754927AbaCNVfU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 17:35:20 -0400
Received: by mail-we0-f179.google.com with SMTP id x48so2573732wes.24
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 14:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7ZVpk5tvDkkXPD/BwSQlm3DhGNqr+2yfl7x+08Ne6wk=;
        b=a8KDVl6yBSM7U3etTs+kGImC9kGR20gm4PWkWlHA+CQCSuf6IB/EL3JYcnTuwcQX/V
         QMjpkSKasfuxUxmDlHDbcnQip+p9j1XqRCdo89kvfpTXoX8IFKRAFoAXz7zMjSrhaBTj
         5wYxdQtuVtacP1QDbI04wGO43I0vT/3e0IdHtqLaAt57MvLY4+1K8GhfqizkDP8Tp7Tb
         G0gySfd2hC0lCxLZCG8dVluAN1CEAd16/XqnDx2tVcZGy6KhFSi5FGmvUt7/t/o3Qb6s
         XTodcsC8mP0MzRh+enCGn/NDSlZ6RWw5p36Ei/wd5Y75kX5Cn6MgJCNJbzp0eujxCzjQ
         omqg==
X-Received: by 10.180.89.136 with SMTP id bo8mr125085wib.52.1394832919145;
 Fri, 14 Mar 2014 14:35:19 -0700 (PDT)
Received: by 10.194.81.65 with HTTP; Fri, 14 Mar 2014 14:35:19 -0700 (PDT)
In-Reply-To: <xmqqa9csh54f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244114>

On Fri, Mar 14, 2014 at 4:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> For the users that really did mean "--merge", the warning is silly.
>> It's basically saying "We know that you're about to mess up your work
>> tree, but we let you mess up anyway. Learn the correct way so that you
>> don't mess up next time".
>
> I suspect that you meant "--mixed" instead of "--merge" here.

No, I did mean "--merge". It's silly for inexperienced users because
it's too late to use "--merge" by the time they realized they should
not have used the default. The work tree has already become a mess. So
they'd immediately think "if git was smart enough to warn me about the
mess, why not prevent me from getting into the mess in the first
place?"

For the experienced users, they would understand the warning, because
they would be aware of the index, and the effect that "--mixed" and
"--merge" have on it.

> So I am OK with "eventually error out by default", but not OK with
> "we know better than the user and will not allow it at all".

Again, I didn't mean "we know better than the user". However, from a
new user's perspective, they won't understand why "git reset" gives
the warning, but still "knowingly" messes up their work tree.

And "we don't know better than the user" is exactly why I think we
should "eventually error out" rather than automatically switching to
"--merge". As Matthieu was saying, automatically switching to
"--merge" could discard conflict resolutions, which would be
undesirable. So it's better for git to error out then having git
decides what the user (probably) wants.
