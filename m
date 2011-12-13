From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 2/2] change all unchecked calls to setenv to xsetenv
Date: Tue, 13 Dec 2011 19:55:32 +0100
Message-ID: <CABPQNSbL2wWFeg8A+H9c2ZzgYaWPMtuYpsPLMp_S-5_tv20cXw@mail.gmail.com>
References: <1323778227-1664-1-git-send-email-kusmabite@gmail.com>
 <1323778227-1664-2-git-send-email-kusmabite@gmail.com> <20111213181946.GC1663@sigill.intra.peff.net>
 <7v1us8wccm.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 19:56:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaXWU-0006Ts-6p
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 19:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab1LMS4O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Dec 2011 13:56:14 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41081 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab1LMS4M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2011 13:56:12 -0500
Received: by pbbb2 with SMTP id b2so334586pbb.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 10:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=Wia82J11R8c07sgSzPrJQq4DiEMVMAcmiT2qBTNmgDk=;
        b=Aw4p1kHMglcBvhy7gLTT1QW7Tev51RXQaqqT3dL9vdr/lSGm5Ltuar1v47Fjqs9JrH
         5zQKP9kYZzrHZmEzLwlzZifpFxuyRsc+IBjnnWDyugUHrPRVOuqojSALwyno2a9rGQEB
         hZhtaCzs2/NIbaNbmvJAru6bu1Gg5cHQJaOx8=
Received: by 10.68.72.9 with SMTP id z9mr35582378pbu.124.1323802572175; Tue,
 13 Dec 2011 10:56:12 -0800 (PST)
Received: by 10.68.21.39 with HTTP; Tue, 13 Dec 2011 10:55:32 -0800 (PST)
In-Reply-To: <7v1us8wccm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187044>

On Tue, Dec 13, 2011 at 7:33 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jeff King <peff@peff.net> writes:
>
>> On Tue, Dec 13, 2011 at 01:10:27PM +0100, Erik Faye-Lund wrote:
>>
>>> While reviewing some patches for Git for Windows, I realized that
>>> we almost never check the return-value from setenv. This can lead
>>> to quite surprising errors in unusual sitations. Mostly, an error
>>> would probably be preferred. So here we go.
>>>
>>> However, I'm not at all convinced myself that all of these make
>>> sense; in particular settings like GIT_EDITOR and GIT_PAGER could
>>> perhaps benefit from having a warning printed rather than a hard
>>> error.
>>>
>>> Thoughts?
>>
>> I wrote almost the same patch once[1], but failed to actually push i=
t
>> through to acceptance.
>
> In both cases, the patches are _designed_ to fail to attract any
> attention. =A0Your earlier one had this preamble:
>
> =A0Here is a patch. I still feel a little silly writing this. The cha=
nces
> =A0that you will run out of memory doing setenv but _not_ doing any o=
f the
> =A0other git operations seems very low.
>
> which rather *loudly* says "ignore me, please!" ;-)
>
> Erik's patch this round is no better; if its log message said somethi=
ng
> like "On platform X, the environment space is merely nKB and setenv h=
as
> much higher chance of failing than on typical Linux boxes", it would =
have
> been a no brainer for me to respond with "makes perfect sense but don=
't we
> also use putenv?" immediately.
>

It could be because I treated this completely like a theoretical
patch; I haven't seen it actually happen.

But you are right, Windows 32 kB environment limit makes this much
more likely than your average Linux box. So perhaps I should add a
notice about that in the next round...
