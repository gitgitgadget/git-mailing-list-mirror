From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 6 May 2013 22:49:28 -0500
Message-ID: <CAMP44s0VBiWN5fZachCDkg9EHZKHRU5idNBdktV2a5wBMJvxjQ@mail.gmail.com>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
	<1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
	<20130506123111.GB3809@sigill.intra.peff.net>
	<7v7gjctabm.fsf@alter.siamese.dyndns.org>
	<CAMP44s2rdkND40QDQA9T7MNGoKPtnr50nV98aExUe4bCOXZGyA@mail.gmail.com>
	<7vppx3q0z6.fsf@alter.siamese.dyndns.org>
	<CAMP44s2wh71vW6GaCfyCO398BWvVbYnwSE76bO=46XVJF3jWNg@mail.gmail.com>
	<7vmws7o8hx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 05:49:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZYuI-0007vw-BX
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 05:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757152Ab3EGDta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 23:49:30 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34413 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998Ab3EGDta (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 23:49:30 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so244609lbi.32
        for <git@vger.kernel.org>; Mon, 06 May 2013 20:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=AfT37rNaaCf9f86ItcvBT54M18ZRlpr8Mf+0otBFVR0=;
        b=aR5dcjrJXsEbeBS3ukPHEgMOA+igZiMf+5XC2Zcdp7pGlOpuOJscOLOPa8y0CGra5l
         Hflnh+FjWvoQ0Wqk9ZdrQFZmSGp6YYbaZ1izFKjkIqAYEfghSGLiqosRk4XlkkoFwGPc
         tY8ARmAne1uYQZ005KBNQfoTrrP/XdIuNa3Mhr+57xU/SdD5p4IIO5RfGkNobCpzuJpv
         6im+2qvJJnhEP+3Koo3szM3+pI6QSZ9GZkd+jhCQ3LwpEJmt9TS+wMXVdhJjJd1O3lr+
         wTObW8A08bT/feFvw/1HGUupET/QEflaOpO/z/Sg0OkT6B7Y0ZhygYsLokeBqJORgwfi
         RecA==
X-Received: by 10.112.154.98 with SMTP id vn2mr266242lbb.8.1367898568225; Mon,
 06 May 2013 20:49:28 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 6 May 2013 20:49:28 -0700 (PDT)
In-Reply-To: <7vmws7o8hx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223536>

On Mon, May 6, 2013 at 8:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>>> How?
>>>
>>>  * if we teach fast-import to optionally not write marks for blobs
>>>    and trees out, your remote-bzr can take advantage of it,
>>
>> I already said remote-bzr is irrelevant. *Everybody* benefits.
>
> Everybody who does _not_ need to look at marks for non-commits from
> previous run does.

IOW; everyone.

> What about the others who do?

Like who?

> Surely, some lucky ones may get the benefit of a new optimization
> for free if you turn it on uncondtionally without an escape hatch,
> but that goes against our goal of not to knowingly introduce any
> regression.

That's different. One thing is to turn it on unconditionally, and
another thing is to turn it on by *default*.

> Michael's cvs2git might have a way to work the breakage
> around (I will let him comment on your suggested workaround), but as
> long as he has been coding it using the documented feature, why
> should he even change anything for no gain at all in the first
> place?  Even if you have a workaround, that does not change the fact
> that a removal of a feature that somebody has been depending on is a
> regression.

Who is depending on it? Michael didn't say that he used that feature,
merely that it was documented in cvs2git, because Windows doesn't have
'cat'. He claimed that other people *might* be using that "feature",
but we don't *know*.

Is a couple of commands somebody wrote in some documentation which can
be easily fixed, reason enough to punish everyone else?

> What's so difficult to understand that by default the responsibility
> of making sure an optimization applies safely to a program that uses
> a new optmization lies on that program, in other words, a new
> feature is by default an opt-in?

Is that written in some git bible descended from some god that I
missed? If not, everything are guidelines, and guidelines are there
for a reason, and those reasons can be challenged, and so can the
guidelines.

Sometimes it makes sense to make a new feature opt-in, sometimes it
doesn't, there are no absolutes, there should be no dogmas.

-- 
Felipe Contreras
