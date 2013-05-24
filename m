From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Fri, 24 May 2013 21:47:19 +0100
Organization: OPDS
Message-ID: <9C8FD0BE27314D72A629025EFFF58848@PhilipOakley>
References: <20130522115042.GA20649@inner.h.apk.li><7v4ndukhx0.fsf@alter.siamese.dyndns.org><20130523090657.GB23933@inner.h.apk.li><CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com><20130523102959.GP9448@inner.h.apk.li><20130523110839.GT27005@serenity.lan><7vd2shheic.fsf@alter.siamese.dyndns.org><20130523164114.GV27005@serenity.lan><7vbo81e7gs.fsf@alter.siamese.dyndns.org><20130523215557.GX27005@serenity.lan><7vli75cpom.fsf@alter.siamese.dyndns.org><CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com><7vppwhb52f.fsf@alter.siamese.dyndns.org><CAMP44s0NmKO7qkxVDMqR7Lxutm19MdOQ+6u5_3MY6f18C_V3PA@mail.gmail.com><CAMP44s3Ba7L5fvEQPo0VADzNn9pJeyr2=f+OyW+_V5kkuKqEEw@mail.gmail.com> <7vli74baym.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"John Keeping" <john@keeping.me.uk>,
	"Andreas Krey" <a.krey@gmx.de>,
	"John Szakmeister" <john@szakmeister.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 22:47:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfytP-00068Z-UY
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 22:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab3EXUrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 16:47:09 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:25522 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753787Ab3EXUrI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 May 2013 16:47:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArYNAHPRn1FZ8Ylm/2dsb2JhbABagwiJKrkrBAEDAYEGF3SCHgUBAQUIAQEuHgEBIQsCAwUCAQMVAQslFAEECBIGBxcGARIIAgECAwEKh2ADE7EUDYhmjEaBbWqCemEDiGeGBIZqjgOFI4MQOw
X-IronPort-AV: E=Sophos;i="4.87,737,1363132800"; 
   d="scan'208";a="425014425"
Received: from host-89-241-137-102.as13285.net (HELO PhilipOakley) ([89.241.137.102])
  by out1.ip03ir2.opaltelecom.net with SMTP; 24 May 2013 21:47:00 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225399>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Friday, May 24, 2013 5:26 PM
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> ... but I don't see why something small like that
>> wouldn't make sense:
>>
>> The pull was not fast-forward, please either merge or rebase.
>
> OK, I think I got what John was getting at and this single liner
> message is a good summary of it.
>
> Instead of telling them "you cannot push this thing without losing
> history from the location you are pushing to; you need to become up
> to date with respect to them before pushing" upon seeing a non ff
> push failure, we can tell them "you cannot update your history to
> what the place you get new changes from has without losing your
> history; you need to integrate the two".
>
> Initially I said limiting "git pull" to "--ff-only" by default did
> not make sense, but when we view it that way, I now see how such a
> default makes sense.
>
> In another subthread, John Szakmeister mentioned that the "please
> 'git pull' first" message that a "push" gives when it stops due to
> non-ff nudges the users in a wrong direction, because they often
> take that 'git pull' too literally (e.g. 'pull --rebase' may be
> necessary in their project, not 'git pull<ENTER>').
>
> The original message deliberately avoided mentioning 'git pull' for
> that exact reason, but in mid 2010 we made it worse.  The log of
> that change says that it attempted to
>
>    ... remains fuzzy to include "git pull", "git pull --rebase" and
>    others, but directs the user to the simplest solution in the
>    vast majority of cases.
>
> but this thread shows that it did not work; the simplest solution
> was a wrong one.  The message also may need to be rethought to
> complement this direction being proposed for "pull".
> --

Perhaps offer "git pull ....", which suggests that the user should 
consider what pull parameters to provide and if taken literally should 
barf with the four dots.

Philip
