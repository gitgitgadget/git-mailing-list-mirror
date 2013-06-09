From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sun, 9 Jun 2013 10:40:32 -0500
Message-ID: <CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
	<20130609151235.GA22905@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jun 09 17:40:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulhjg-0008UR-4t
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 17:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701Ab3FIPkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 11:40:35 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:40407 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab3FIPke (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 11:40:34 -0400
Received: by mail-la0-f43.google.com with SMTP id gw10so5056269lab.30
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PxhS345M9JD1Df/uaMXyMbIlWCu1boWFSUXrd7qQwqU=;
        b=BEa11dWPntGsJuV+zAPhL1W+DWihHwi0gkdYxfqqmKY4yvD2JjxUcXt+yJI7cgJdEW
         5tzb/YIFVnhw1z37OG1m9Hq0fARYx5LJMNQlyysGsha56OufxbzlRyGkIQQAxa27FTHO
         VnhQ8GHlQisACedzETKt2GNyfswFLX+Yi2L4KWhlu07geEVbRM8a1vHbO9MBohjBkqKP
         QPZH0q8HTB9plt+QHConZJB1PEEEG5H88Fn2Q4DUEFu+SKlaB2+5EKHrXmrxnxRGPk4W
         UTRx97lg4r46rsOlSU/YpRIurrHw379sTRJO4ofIkP666nA7Ht6UUuTYysfljYy/8I88
         KBYQ==
X-Received: by 10.152.7.74 with SMTP id h10mr3128350laa.83.1370792432695; Sun,
 09 Jun 2013 08:40:32 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 08:40:32 -0700 (PDT)
In-Reply-To: <20130609151235.GA22905@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226966>

On Sun, Jun 9, 2013 at 10:12 AM, John Keeping <john@keeping.me.uk> wrote:
> On Sun, Jun 09, 2013 at 08:26:32PM +0530, Ramkumar Ramachandra wrote:
>> Felipe Contreras wrote:
>> > The plan is simple; make libgit.a a proper library, starting by
>> > clarifying what goes into libgit.a, and what doesn't. If there's any
>> > hopes of ever having a public library, it's clear what code doesn't
>> > belong in libgit.a; code that is meant for builtins, that code belongs
>> > in builtins/lib.a, or similar.
>> >
>> > Give this a try:
>> >
>> > --- a/sequencer.c
>> > +++ b/sequencer.c
>> >
>> > libgit.a(sequencer.o): In function `copy_notes':
>> > /home/felipec/dev/git/sequencer.c:110: undefined reference to
>> > `init_copy_notes_for_rewrite'
>> > /home/felipec/dev/git/sequencer.c:114: undefined reference to
>> > `finish_copy_notes_for_rewrite'
>>
>> This is a good example: yes, I'm convinced that the code does need to
>> be reorganized.  Please resend your {sequencer.c ->
>> builtin/sequencer.c} patch with this example as the rationale, and
>> let's work towards improving libgit.a.
>
> Why should sequencer.c move into builtin/ to solve this?  Why not pull
> init_copy_notes_for_rewrite and finish_copy_notes_for_rewrite up into
> notes.c?

Because finish_copy_notes_for_rewrite is only useful for builtin
commands, so it belongs in builtin/. If there's any meaning to the
./*.o vs. builtin/*.o divide, it's for that. Otherwise we should just
squash all objects into libgit.a and be done with it.

-- 
Felipe Contreras
