From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/4] run-command: add new check_command helper
Date: Mon, 1 Apr 2013 23:22:36 -0600
Message-ID: <CAMP44s3oVJs_sWpemFVGSkj-u_SrjsxE1mYja+Scx3PTBXC67Q@mail.gmail.com>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
	<1364852804-31875-2-git-send-email-felipe.contreras@gmail.com>
	<20130401232326.GA30935@sigill.intra.peff.net>
	<CAMP44s3NxBexkaQa=KxJ963L29T4BAn7e+-3YVz-vgUp8jrb4A@mail.gmail.com>
	<20130402022214.GA719@sigill.intra.peff.net>
	<CAMP44s3-DnBM7Tm_+igLN+c5MGrbJNXUBwcj1HvGCPEJEwJSBQ@mail.gmail.com>
	<20130402051407.GA21906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 07:23:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMtgY-00038v-6p
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 07:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759704Ab3DBFWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 01:22:38 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:41932 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757172Ab3DBFWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 01:22:37 -0400
Received: by mail-la0-f47.google.com with SMTP id fj20so39156lab.20
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 22:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=EucEkm7HAZpX4XLwTtg2yqCE1isa3caV2GI/4mcW2zM=;
        b=EK4gLN6OvVVA/T1fmP7yU9OyOlSTYCfOG1BT2ibky7GLKKsWKZbamhA1Lfloh95nMc
         QxypANHaZa4mRfrk2oPS9KBacg1nqOyBjDvqc9rkl2E3HoO7nMeQg1niLCwaA8/AEEJ6
         YyrkT1YjA/d5PPujurquzSwYHwtXMySQ7ky8hF/NaQQzgGXbh/uZy4aQL5QLhyTWvufE
         kjI0G5aqAoBhUNJqu3+JozCcBai341XBq1s/5ux7u/KmFBuYjaNgM29cG1XcMNg8r3Xj
         pJ60RFA/4Q6wlQS14o6DTinpHwAhidnLyAhn88VE/Zdw/342Z0IHfxzNPFYnqyAP5vOz
         VNEA==
X-Received: by 10.112.41.136 with SMTP id f8mr6778696lbl.121.1364880156136;
 Mon, 01 Apr 2013 22:22:36 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 1 Apr 2013 22:22:36 -0700 (PDT)
In-Reply-To: <20130402051407.GA21906@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219740>

On Mon, Apr 1, 2013 at 11:14 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 01, 2013 at 11:11:20PM -0600, Felipe Contreras wrote:
>
>> > But if we know from reading waitpid(3) that waitpid should only fail due
>> > to EINTR, or due to bogus arguments (e.g., a pid that does not exist or
>> > has already been reaped), then maybe something like this makes sense:
>> >
>> >   while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
>> >           ; /* nothing */
>>
>> But we don't want to wait synchronously here, we just want to ping.
>
> Yeah, sorry, I forgot the WNOHANG there.

It still can potentially stay in a loop for some cycles.

>> > After the fix above, yes; in the original we would always have exited
>> > already.
>>
>> No:
>>
>> +       if (waiting != cmd->pid)
>> +               return 1;
>>
>> If waiting < 0, waiting != cmd->pid, and therefore this return is not
>> triggered, and there's only one more return at the end of the
>> function.
>
> Are my eyes not working? If waiting < 0, then waiting != cmd->pid, and
> therefore this return _is_ triggered.

Oh, right, it's only after the modification that the code works.

-- 
Felipe Contreras
