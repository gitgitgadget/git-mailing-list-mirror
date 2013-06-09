From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sun, 9 Jun 2013 12:35:04 -0500
Message-ID: <CAMP44s2Sg3D4kjXM2v0_kU+Y_OeTMbiEtbSWcLQj1bWuRPOxhw@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
	<20130609151235.GA22905@serenity.lan>
	<CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
	<51B4BBB7.8060807@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:35:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljWU-0007yC-G9
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab3FIRfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:35:10 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36559 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471Ab3FIRfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:35:07 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so3607164lbi.33
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ExHUybkribOLhYtm5dWaqxyHKGOx+KD7BYLo8KWaKxA=;
        b=tgr2PKUtz3yOU4Urxg2p7hknkQ5SY5fY+ovtfpgJYLzjljM09w4Jm6Z9EmoRqWdM8m
         vp/1CHKuj1EBFNPid8Z/fNW/R79xR93NVk/loyfURpCW179/vCRjo6kZ6vGaNKatVWoK
         fXgOjsTWva5kxYtVtcDzO2r05PUgWNQg9siJT2NB2zvrel+doRC4yJDz109rJPFEHwBr
         JO7zA3MztfqoelPMUFI+OcRlP/mazbzKnfOHuUxmHOaS4Rx4FvUTI9Peq4qyKvpWCbfu
         X+kV0x2ZYg3fX3CuHepyzWO3tFsfnP4LvTa05s2uBfzquSvn+hvSNpV8YLG5iPA47rYx
         +Gew==
X-Received: by 10.112.166.67 with SMTP id ze3mr5013744lbb.25.1370799304522;
 Sun, 09 Jun 2013 10:35:04 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 10:35:04 -0700 (PDT)
In-Reply-To: <51B4BBB7.8060807@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227043>

On Sun, Jun 9, 2013 at 12:30 PM, Vincent van Ravesteijn <vfr@lyx.org> wrote:
> Op 9-6-2013 17:40, Felipe Contreras schreef:
>
>> On Sun, Jun 9, 2013 at 10:12 AM, John Keeping <john@keeping.me.uk> wrote:
>>>
>>> On Sun, Jun 09, 2013 at 08:26:32PM +0530, Ramkumar Ramachandra wrote:
>>>>
>>>> Felipe Contreras wrote:
>>>>>
>>>>> The plan is simple; make libgit.a a proper library, starting by
>>>>> clarifying what goes into libgit.a, and what doesn't. If there's any
>>>>> hopes of ever having a public library, it's clear what code doesn't
>>>>> belong in libgit.a; code that is meant for builtins, that code belongs
>>>>> in builtins/lib.a, or similar.
>>>>>
>>>>> Give this a try:
>>>>>
>>>>> --- a/sequencer.c
>>>>> +++ b/sequencer.c
>>>>>
>>>>> libgit.a(sequencer.o): In function `copy_notes':
>>>>> /home/felipec/dev/git/sequencer.c:110: undefined reference to
>>>>> `init_copy_notes_for_rewrite'
>>>>> /home/felipec/dev/git/sequencer.c:114: undefined reference to
>>>>> `finish_copy_notes_for_rewrite'
>>>>
>>>> This is a good example: yes, I'm convinced that the code does need to
>>>> be reorganized.  Please resend your {sequencer.c ->
>>>> builtin/sequencer.c} patch with this example as the rationale, and
>>>> let's work towards improving libgit.a.
>>>
>>> Why should sequencer.c move into builtin/ to solve this?  Why not pull
>>> init_copy_notes_for_rewrite and finish_copy_notes_for_rewrite up into
>>> notes.c?
>>
>> Because finish_copy_notes_for_rewrite is only useful for builtin
>> commands, so it belongs in builtin/. If there's any meaning to the
>> ./*.o vs. builtin/*.o divide, it's for that. Otherwise we should just
>> squash all objects into libgit.a and be done with it.
>>
> I think that libgit.a should contain all code to be able to carry out all
> functions of git. The stuff in builtin/ is just a command-line user
> interface. Whether or not sequencer should be in builtin depends on whether
> the sequencer is only part of this command-line user interface.

The sequencer is only part of the command-line user interface.

> I think that the sequencer code is at the moment unusable if you do not use
> the code in builtin/ so that would advocate to move it into builtin/. If
> sequencer is in libgit, and I write my own (graphical) user interface, I
> expect to be able to use it.

As do I, but it appears all other Git developers disagree; libgit.a is
not really a library, and will never be used by anything other than
Git's core.

Hence this patch.

-- 
Felipe Contreras
