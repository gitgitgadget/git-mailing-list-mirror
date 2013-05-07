From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Mon, 6 May 2013 23:49:56 -0500
Message-ID: <CAMP44s3OZX=f8=MdXq8jr57o94ubzqf0O3EVFKn4QdTXdg+A=Q@mail.gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
	<CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
	<518785B3.3050606@alum.mit.edu>
	<87ip2wflg0.fsf@linux-k42r.v.cablecom.net>
	<518789D1.4010905@alum.mit.edu>
	<CAMP44s1Nk7YAjNkTq=ShQbzkMasw6bpcEPTXLb8x+2q-vXLRGg@mail.gmail.com>
	<518874A5.5050002@alum.mit.edu>
	<alpine.DEB.1.00.1305062332470.8213@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 07 06:50:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZZqk-0004f3-DS
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 06:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758273Ab3EGEt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 00:49:58 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:47420 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580Ab3EGEt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 00:49:57 -0400
Received: by mail-la0-f53.google.com with SMTP id eo20so139431lab.12
        for <git@vger.kernel.org>; Mon, 06 May 2013 21:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Qq+rEwvNVbHYd3T1ZepIvbR1oYLTDieM1ao18jnHgWQ=;
        b=qkGBBBWXNBhHNKoD4Xe50m74awGM0HEA2NuQMhE+f0cRSqBmXDXt0SLEaDa3PF+r3k
         CaqFJbRMpj820grJa8C47WHYkNNmUsvsJre3+U8QjuPUdmxwM+H72G/Vi9kaK7r7eQa9
         DS48rEztrL2wGFGXOU2Tfw1zQ3GnBdhlmHbbOLtZitqt7rBkxXuJdl9K6LUfXn+2cATP
         QtgF4jpS/j7GyJ7B1deiY3WCo9EYTbvSq5DQnoMNrsqlrVHYcpSRRqjsVMBca/LaOsVn
         /+97DvGAr1RJJmj0Ie0MgNAO/CMLU1IDtw0vsGyM+OjcmCHRafqT56eH+8QCdwLvvFk5
         pJYw==
X-Received: by 10.112.1.166 with SMTP id 6mr283778lbn.135.1367902196134; Mon,
 06 May 2013 21:49:56 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 6 May 2013 21:49:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1305062332470.8213@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223547>

On Mon, May 6, 2013 at 11:39 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 7 May 2013, Michael Haggerty wrote:
>
>> On 05/06/2013 11:04 PM, Felipe Contreras wrote:
>> > On Mon, May 6, 2013 at 5:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> >> On 05/06/2013 12:32 PM, Thomas Rast wrote:
>
>> >> So the proposed change would break a documented use of cvs2git.
>> >
>> > It's documented as an alternative. How many people actually use this
>> > form over the other? Is there really any advantage? It's possibly that
>> > basically nobody is using this form, and there's no benefits.
>>
>> You conjectured earlier that nobody uses blob marks, and I provided a
>> counterexample.  Then you proposed a workaround that would require
>> changes to the cvs2git documentation, and I even explained how your
>> proposed workaround is not as flexible as the status quo.  Do you want
>> to go through the same argument with every possible user of
>> git-fast-import?
>>
>> It would be insanity to change the default behavior when a workaround on
>> the Git side (namely adding an option that tells git-fast-import *not*
>> to emit blob marks) would be quite straightforward to implement and have
>> little maintenance cost.
>
> I really wonder how many more counterexamples are required to settle this
> discussion.

One. I haven't seen one use-case that *requires* blob marks, I haven't
seen one tool that utilizes blob marks. And no, cvs2git doesn't use
marks at all.

> There is no good reason to artificially limit Git's capabilities here,
> especially when it has been demonstrated that supporting that capability
> is not only possible, but also outright easy.

Strawman. Nobody is arguing that there shouldn't be an option to
enable blob exporting, the argument is that there's no point in making
that the *default*.

-- 
Felipe Contreras
