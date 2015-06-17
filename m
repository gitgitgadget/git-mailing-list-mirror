From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 05/11] ref-filter: add parse_opt_merge_filter()
Date: Thu, 18 Jun 2015 00:42:16 +0530
Message-ID: <CAOLa=ZQ-4VGunAAjrN6KPgA5hEg8JFhCrb-pobGitydeB9pNLg@mail.gmail.com>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
 <1434464457-10749-1-git-send-email-karthik.188@gmail.com> <1434464457-10749-5-git-send-email-karthik.188@gmail.com>
 <vpqmvzz7hjq.fsf@anie.imag.fr> <CAOLa=ZS_gY-MuGJ86TFpHhMXNYJ1gHWQWyfv71gDCVm1sMXZNw@mail.gmail.com>
 <vpqzj3yzqma.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:13:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5IlY-000195-Qj
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756814AbbFQTMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:12:48 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34709 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbbFQTMr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:12:47 -0400
Received: by obbsn1 with SMTP id sn1so39580234obb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 12:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vu7ujK3BP6i65dxvFsuO0qzTnV+DzgcbVE3R5YXkAW4=;
        b=UFU6qgZknLjgPxcNz78P44H2Hcs4aDnEyAnqyxIZniBAK+xvviY5rEswSBzyZTaf4g
         Dkw6viPKylLBtlluMZMsuZOp/LYiIK5T2azHm/goE6dj9NjuczEp7yblwp9xeKdzMZvz
         LWI13xxo25A1qojotFJfgaO+OI5lI7khkewGIrRUbRNnuh/2FUjRQqpWcvEGIcymVdkG
         Ouwkjb6p9Q6Vbpz9RBzzhB3XyoTuy9TDntEL6k8YKpICdJ9OEdxQylSMSrbIJEFhhOQM
         kOLyIKg7M2/7z4mAXk5i58heeGJAustS4D4ivQvjKYMI4SB+x28JW9Ne4C9LC3qQoRd1
         Qmxg==
X-Received: by 10.60.58.136 with SMTP id r8mr5982275oeq.30.1434568367058; Wed,
 17 Jun 2015 12:12:47 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Wed, 17 Jun 2015 12:12:16 -0700 (PDT)
In-Reply-To: <vpqzj3yzqma.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271883>

On Wed, Jun 17, 2015 at 1:57 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Err, for-each-ref already uses it before this series, no?
>
> So, you don't need any extra option to get for-each-ref, because it is
> already there. Having these extra options is a good side effect, though.
>
> To make sure I'm clear enough, what you're doing is
>
> - add all options to for-each-ref
> - port tag.c
> - port branch.c
>
> What I'm suggesting is to prioritize this way
>
> - add all options required for tag.c
> - port tag.c
> - add all options required for branch.c
> - port branch.c
>

I meant somewhat on those lines only.  Let me clear that out.
The steps I plan to take are:
1. Move code from for-each-ref to ref-filter.
2. Add options to ref-filter which is available in tag.c and branch.c
(--points-at, --contains, --merged)
3. Add there options to for-each-ref.
4. Add options required for functioning of tag.c alone to ref-filter
5. Port tag.c
6. Add options required for functioning of branch.c alone to ref-filter
7. Port branch.c

Now why i want to complete step 2 right after 1 is so that while
porting tag.c and branch.c
I do not want to focus on making those common options available.
Because I rather
work on getting their specific options (verbose in branch.c, -n in
tag.c and so on)
working before porting over tag.c/branch.c.

>
> Not only the challenge, but also the way to validate your work. Think of
> it as a rather comprehensive set of tests that you get for free once you
> ported a command.
>
> BTW, talking about tests, did you do some coverage analysis on git
> branch and git tag? If not, I'd suggest that you do this to make sure
> that the pieces of code you're rewritting using ref-filter are well
> tested before being rewritten (a bit like Paul's work on shell -> C).
> You don't have to actually do this before porting, but it should come
> befor the port in the patch series to make sure that tests pass both the
> old and new implementation.
>

Yes good point.

I did not do a deep coverage analysis on git tag and its tests. You are right
this would be a crucial step for porting. I had a glance over the tests. Will
look into it. As for git branch I'll do that after porting tag.c over to using
ref-filter.

-- 
Regards,
Karthik Nayak
