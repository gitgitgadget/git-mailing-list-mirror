From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 07/13] remote-hg: redirect buggy mercurial output
Date: Thu, 04 Apr 2013 09:07:45 -0600
Message-ID: <515d9741985ca_69fd13fde181671a@nysa.mail>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
 <1364929382-1399-8-git-send-email-felipe.contreras@gmail.com>
 <7vehesd7rl.fsf@alter.siamese.dyndns.org>
 <CAMP44s1C37+drw3HhysO4aRgxUt=knAKnT+Bk0JCqLr=CL5yjQ@mail.gmail.com>
 <7v8v50brfn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 17:11:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNlpD-0003NS-7f
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762305Ab3DDPLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:11:10 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:45774 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762243Ab3DDPLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:11:09 -0400
Received: by mail-oa0-f52.google.com with SMTP id k14so2913762oag.11
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=UHufWNxUtpAszAELxnkbc5nYaOANJWwzsh/QALeSByU=;
        b=C5GnSHdI4GnwtZW30tUnmVydYmPiQ6uIawT6/oH/KvZ402Ew+vx7M+JWDzTkNGzGG6
         1aq3ZFaKI37Zp4flC9xucNiugcCMNNMXDhBOsKo5ETiXKdBqUVVcu+BK9CeSf0bX70sC
         z4YlkC72TpbPYhi3huvANgVyoUD6Ftq1GjeZHxY2XRYZ+f0oF5wr221t7gob+qBk8rRr
         lbjUbIa9+eMO2taTFPIHYAVQWTyoRx/KVow2qgrJrmErHh2uavUjGk3G6Usi1q9ME/9v
         0HT22JQbJRwKXpxtRKtIrQwaQOGv3NRQuui9FGXiK6ERkkjzRN87gN1TeTtd4UIWiN7R
         +yDA==
X-Received: by 10.60.37.229 with SMTP id b5mr4680295oek.21.1365088268722;
        Thu, 04 Apr 2013 08:11:08 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id w10sm7007480oed.2.2013.04.04.08.11.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:11:07 -0700 (PDT)
In-Reply-To: <7v8v50brfn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220002>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > On Tue, Apr 2, 2013 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >>
> >>> We can't use stdout for that in remote helpers.
> >>>
> >>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >>> ---
> >>
> >> You may want to clarify "buggy output" a bit.  Will mercurial
> >> forever be broken?  Some versions of Hg emit [[[it is unclear for
> >> Junio to tell what it is to fill this blank]]] to its output that
> >> we want to ignore?
> >
> > The problem is that mercurial's code is kind of hardcoded to run under
> > mercurial's UI, so it throws messages around willynillingly, like:
> >
> > searching for changes
> > no changes found
> >
> > And they can't be turned off. Theoretically we could override
> > mercurial's UI class, but I think that has the potential to create
> > more problems, it's not worth at this point in time.
> 
> Oh, I totally agree with you _after_ reading that explanation.
> 
> You just shouldn't let me waste your time to explain that to me in
> this exchange, and you could have done so by writing a clearer log
> message.  That's all.

I saw that you update the commit message without consulting here first to:

---
remote-hg: redirect unnecessary mercurial output
    
Mercurial emits messages like "searching for changes", "no changes
found", etc. meant for the use of its own UI layer, which is of no
use for our remote helper.  Squelch them.
---

This is not correct. This patch does _not_ squelch the output, it's redirecting
it to standard error, so the user actually sees it now, and we do that not
because the output is "unnecessary", but because it *breaks* the pipe between
the transport helper and remote helper. I'll reroll with the updated commit message.

Cheers.

-- 
Felipe Contreras
