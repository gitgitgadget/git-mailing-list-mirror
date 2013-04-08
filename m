From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/2] transport-helper: check if remote helper is alive
Date: Mon, 8 Apr 2013 14:08:02 -0500
Message-ID: <CAMP44s0DjJL44uavM44sxgSyrgbTLpUarEPB6=-imvw1rewOOA@mail.gmail.com>
References: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
	<1365320706-13539-3-git-send-email-felipe.contreras@gmail.com>
	<20130408005155.GA24030@sigill.intra.peff.net>
	<CAMP44s0PYARrCQxyBOiGzCAKTXqGp5yrKyfVwLjE1CyuxVSU2A@mail.gmail.com>
	<20130408023351.GA32558@sigill.intra.peff.net>
	<CAMP44s1cphJ5wojt2OeZjWJVOi5AMQJR2jN_BCkQw0B0BxpUfA@mail.gmail.com>
	<7vtxngyl30.fsf@alter.siamese.dyndns.org>
	<CAMP44s2PJGJQBM86CGsA5BOn1RLi4mqNsq+d0oyY0jA=XHQGDA@mail.gmail.com>
	<7vwqscx3l5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 21:08:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPHQP-0006qs-JT
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 21:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935702Ab3DHTII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 15:08:08 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:39837 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935628Ab3DHTIF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 15:08:05 -0400
Received: by mail-la0-f46.google.com with SMTP id fq12so5623256lab.5
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=RqDMdfvg/FN7JM28/2dHAY/qA/QdqPfVUrmoPtk/xTE=;
        b=Av+R/pQaYoPlXIg3Mi1o20VcPIn8M6HvfJjm1i49nePA29wxPripIzIqWM9t67CLAD
         0Sm3VmBOoa18NOqcMh5OwaYVaZXUehRETigIxpKYTCv5PYcCnq19x3A+6VUPVH4pBwe2
         EHIp5KVYQo2AyQRmltAkHxA7iXIzc9OX5EMdEGHhUGczzTj8IMkcrBmoCU/6e99Wlx00
         Q1t+Hs+keFEYqlD2CVG9STsvOhqBZUl4GvbZbbigRjAbp29wuT9Y1bXBxRKqq6jcQFnr
         S7hw/SGR785NnhweyvjJUhN8DMlVSUEECvWV+oH12J/O5Mq6YBVrcRmMPwWPuLqhyxJA
         K8vg==
X-Received: by 10.152.29.102 with SMTP id j6mr5786209lah.47.1365448082706;
 Mon, 08 Apr 2013 12:08:02 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 8 Apr 2013 12:08:02 -0700 (PDT)
In-Reply-To: <7vwqscx3l5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220497>

On Mon, Apr 8, 2013 at 1:46 PM, Junio C Hamano <gitster@pobox.com> wrote:

>>> ...  But if we keep
>>> helper running, who will be communicating with it via these open
>>> pipes?  The process that is calling finish_command() on fast-import
>>> and disconnecting from the helper won't be, as read/write to the
>>> pipe, even if we do not disconnect from here, will result in errors
>>> if the helper has already exited at this point.
>>
>> Nobody will send any further input, but in theory we could redirect
>> the pipe and send more commands. That's how it was designed.
>
> Who does the redirection to whom?

The one that is doing all the redirections, transport-helper.

> How would the process tree and
> piping constructed around the current system?

I cannot parse that correctly, but transport-helper is already
receiving the output from the remote-helper.

> I am not trying to say it is just theoretical mental exercise (which
> I have seen you do not do at all on this list). I am trying to find
> out what the practical use case is that you have in mind, because
> disconnecting will prove to be not an improvement but a regression
> for that use case.  But you do not have to answer this question
> directly, because...

As the gitifyhg developers effusively pointed out, it's useful to see
which mercurial revision corresponds to certain git revision, and this
is best achieved through notes. Implementing this in the remote-helper
doesn't make much sense (I won't go into details).

>> And in fact, I'm thinking doing exactly that, so we can send another
>> command to fetch the foreign commit ids and append notes with them.
>
> ...we will see the answer in that change anyway.

That doesn't change the fact that transport-helper would end up with
mixed and matched design. Maybe the use-case above wouldn't be
prevented by this change, but I think further changes would need to be
done to the file to not end up in this weird state.

Cheers.

--
Felipe Contreras
