From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] Move copy_note_for_rewrite + friends from
 builtin/notes.c to notes-utils.c
Date: Wed, 12 Jun 2013 14:18:25 -0500
Message-ID: <51b8c9816155a_501d1297e8483820@nysa.mail>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
 <1370995981-1553-1-git-send-email-johan@herland.net>
 <1370995981-1553-3-git-send-email-johan@herland.net>
 <CAMP44s2pUW_+w6B_R-A=vxOg1Ay6iLmc4MQsA_sfDF+GP-XsWw@mail.gmail.com>
 <CALKQrgfxrKz5bB=AAmL1ZtBFRK2Bx6TrRd1AsMEVv8bTAH0KCg@mail.gmail.com>
 <CAMP44s3KAeDPo1Cw8eFsU=A6H7oUGmf+eLAMvGV+R2_hPXHLbw@mail.gmail.com>
 <CALKQrgfPktWOcUKnWecQcE-wMVwTqMES112nHcqnCrZzLLqOeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, jrnieder@gmail.com,
	pclouds@gmail.com, artagnon@gmail.com, john@keeping.me.uk,
	vfr@lyx.org, peff@peff.net, torvalds@linux-foundation.org,
	Thomas Rast <trast@inf.ethz.ch>
To: Johan Herland <johan@herland.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 21:39:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umqtb-000083-H5
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 21:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221Ab3FLTjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 15:39:47 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:60526 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab3FLTjq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 15:39:46 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so13966628obb.11
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=8ZKu5Fzb+Rlli4raBbnxHK+NJ1VH9H5pK8+aoW+Px9o=;
        b=NZQrbXxGCUann/oUXfL9jVL/wbqgCo7DH/f6MctfYoNojikIF/4h2kFJbRW8sQG0or
         UuhvNWdKstTXigSjJhB8300gZfDktN4CaRmeaXg8E1trYVzyKnCfETKeRNeC4JvYtyMB
         lDwVmU6tspYItQvCa+YsiVU3FRo8zdcoBTuTvBXeR36+MZElvyJDu0jK9U4w4TDTHxic
         yfyyMRxQq0T2tI64dpR7HlUyy9bw4ADuD3KskZHIeC9eO3/htXuTxQOamygyWUqBdz10
         Hw8MJsi1ki5et9mn1IX7lHcGGxbWrKTfkpFqyzEx6zLFHgJs6+p/UIv+7/e7qgn8Tn+C
         WygA==
X-Received: by 10.182.219.166 with SMTP id pp6mr16131964obc.66.1371065986279;
        Wed, 12 Jun 2013 12:39:46 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id dz4sm34776499obb.14.2013.06.12.12.39.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Jun 2013 12:39:45 -0700 (PDT)
In-Reply-To: <CALKQrgfPktWOcUKnWecQcE-wMVwTqMES112nHcqnCrZzLLqOeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227668>

Johan Herland wrote:
> On Wed, Jun 12, 2013 at 8:28 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > On Wed, Jun 12, 2013 at 2:10 AM, Johan Herland <johan@herland.net> wrote:
> >> On Wed, Jun 12, 2013 at 2:32 AM, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> >>> On Tue, Jun 11, 2013 at 7:13 PM, Johan Herland <johan@herland.net> wrote:
> >>>> This is a pure code movement of the machinery for copying notes to
> >>>> rewritten objects. This code was located in builtin/notes.c for
> >>>> historical reasons. In order to make it available to builtin/commit.c
> >>>> it was declared in builtin.h. This was more of an accident of history
> >>>> than a concious design, and we now want to make this machinery more
> >>>> widely available.
> >>>>
> >>>> Hence, this patch moves the code into the new notes-utils.[hc] files
> >>>> which are included into libgit.a. Except for adjusting #includes
> >>>> accordingly, this patch merely moves the relevant functions verbatim
> >>>> into the new files.
> >>>>
> >>>> Cc: Thomas Rast <trast@inf.ethz.ch>
> >>>> Signed-off-by: Johan Herland <johan@herland.net>
> >>>
> >>> I wonder where you got that idea from. Did you come up with that out thin air?
> >>
> >> Obviously not. I should add
> >>
> >> Suggested-by: Junio C Hamano <gitster@pobox.com>
> >
> > You are still not explaining where the idea came from. And you are
> > doing that with the express purpose of annoying.
> 
> Truly, I am not trying to annoy anyone. I have not followed the
> preceding discussion closely, and I wrote the patch based solely on
> one paragraph from Junio's email[1].

Here is another pagraph:

> Moving sequencer.c to builtin/ is not even a solution.  Linking
> git-upload-pack will still pull in builtin/notes.o along with cmd_notes(),
> which is not called from main(); as you remember, cmd_foo() in all
> builtin/*.o are designed to be called from git.c::main().

Which clearly refers to:
http://article.gmane.org/gmane.comp.version-control.git/226752

> > Where did the idea come from?
> 
> I got it from Junio. I do not know if I might have accidentally
> plagiarized something you already submitted to the mailing list,
> although I would be surprised if that was the case, since - as far as
> I understand - you are opposed to this solution.

You are aware I opposed this *solution*, yet were not aware that I sent the
first patch in this thread, which clearly states the *problem*?

> This way there will not be linking issues when top-level objects try to
> access functions of builtin objects.

http://article.gmane.org/gmane.comp.version-control.git/226845

> Originally-envisioned-by: Felipe Contreras <felipe.contreras@gmail.com>?

Do I have to do it for you? Your commit message is all wrong, because nowhere
are you pointing out *why* you are making the change.

---
Move copy_note_for_rewrite + friends to notes-utils.c

In order to make these functionas available to top-level objects (e.g.
sequencer.o), we need to move them out of the builtin/ subdirectory.

Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
---

-- 
Felipe Contreras
