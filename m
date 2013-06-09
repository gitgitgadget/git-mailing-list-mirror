From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sun, 9 Jun 2013 11:22:06 -0500
Message-ID: <CAMP44s0Zsejk4Ex6QfzOFOom3cyWv_hziWGkAK-LawSUkT9V3Q@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
	<20130609151235.GA22905@serenity.lan>
	<CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
	<20130609160225.GB22905@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jun 09 18:22:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UliNj-0000bc-57
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234Ab3FIQWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:22:10 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:41488 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab3FIQWI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:22:08 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so2866970lbi.40
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=o76W8gwr+88T3siesGo1z4m0pRh+QDSCa7z7Avre3fA=;
        b=DDonVgo3HB1Z2H0+AJWdzRtDg+9QthnK+IVZEYZfhss7NCVonOQBDfdNsMrIFkHD+g
         QruwmCSJkSn34uEj5gvise8BjeS1DoWFVEvnZ+zk7Z9RFvovqhfJw31sf1J+5zdEqsLx
         RPnlQ/Q20CvI/aFDEFsY7t4yYh+km7KEGh/R8nEnrlk4O7Rf4wDh0T+aM8DAljzsiHKF
         k8ow3UQStvs/C38ZuzNcEF+izCKGwI3Y8J0BxLJ4pmZz+AFrasu9G2cm5wn/tZkPieN4
         kAQgD80IV2Zn2g4IfYbPnEEQmsXPVXnLFu9aG6G4+WXj2g1dwkjNQQqYvZLFHocRvR+7
         3zMQ==
X-Received: by 10.152.26.225 with SMTP id o1mr3215097lag.43.1370794927028;
 Sun, 09 Jun 2013 09:22:07 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 09:22:06 -0700 (PDT)
In-Reply-To: <20130609160225.GB22905@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226969>

On Sun, Jun 9, 2013 at 11:02 AM, John Keeping <john@keeping.me.uk> wrote:
> On Sun, Jun 09, 2013 at 10:40:32AM -0500, Felipe Contreras wrote:
>> On Sun, Jun 9, 2013 at 10:12 AM, John Keeping <john@keeping.me.uk> wrote:
>> > On Sun, Jun 09, 2013 at 08:26:32PM +0530, Ramkumar Ramachandra wrote:
>> >> Felipe Contreras wrote:
>> >> > The plan is simple; make libgit.a a proper library, starting by
>> >> > clarifying what goes into libgit.a, and what doesn't. If there's any
>> >> > hopes of ever having a public library, it's clear what code doesn't
>> >> > belong in libgit.a; code that is meant for builtins, that code belongs
>> >> > in builtins/lib.a, or similar.
>> >> >
>> >> > Give this a try:
>> >> >
>> >> > --- a/sequencer.c
>> >> > +++ b/sequencer.c
>> >> >
>> >> > libgit.a(sequencer.o): In function `copy_notes':
>> >> > /home/felipec/dev/git/sequencer.c:110: undefined reference to
>> >> > `init_copy_notes_for_rewrite'
>> >> > /home/felipec/dev/git/sequencer.c:114: undefined reference to
>> >> > `finish_copy_notes_for_rewrite'
>> >>
>> >> This is a good example: yes, I'm convinced that the code does need to
>> >> be reorganized.  Please resend your {sequencer.c ->
>> >> builtin/sequencer.c} patch with this example as the rationale, and
>> >> let's work towards improving libgit.a.
>> >
>> > Why should sequencer.c move into builtin/ to solve this?  Why not pull
>> > init_copy_notes_for_rewrite and finish_copy_notes_for_rewrite up into
>> > notes.c?
>>
>> Because finish_copy_notes_for_rewrite is only useful for builtin
>> commands, so it belongs in builtin/. If there's any meaning to the
>> ./*.o vs. builtin/*.o divide, it's for that. Otherwise we should just
>> squash all objects into libgit.a and be done with it.
>
> How is it only useful for builtin commands?  By that logic everything
> belongs in builtin/ because it's all only used by builtin commands (I
> realise that is what you're arguing towards).

Which is precisely the point of this patch. If everything is for
builtin commands, then we don't have a git library, and git.a should
contain everything under builtin/*.o.

> But we make a distinction between things that are specific to one
> command (especially argument parsing and user interaction) and more
> generally useful features.

No, we don't. Everything under ./*.o goes to libgit.a, and everything
under ./builtin/*.o goes to 'git'. So builtin/commit.o can access code
from builtin/notes.o, but sequencer.o can't.

-- 
Felipe Contreras
