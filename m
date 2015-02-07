From: Junio C Hamano <gitster@pobox.com>
Subject: Re: read() MAX_IO_SIZE bytes, more than SSIZE_MAX?
Date: Sat, 7 Feb 2015 14:13:29 -0800
Message-ID: <CAPc5daUnKcktv0xcz-fGEApckbkQksKuZO53ZL20E1MhtZmn4w@mail.gmail.com>
References: <loom.20150207T174514-727@post.gmane.org> <54D64939.4080102@web.de>
 <loom.20150207T182443-33@post.gmane.org> <54D67662.7040504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Feb 07 23:14:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKDdX-0007d6-0H
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 23:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165AbbBGWNv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2015 17:13:51 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:54124 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756069AbbBGWNu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Feb 2015 17:13:50 -0500
Received: by mail-oi0-f43.google.com with SMTP id z81so17280479oif.2
        for <git@vger.kernel.org>; Sat, 07 Feb 2015 14:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=NWKmmqxpXFCcJZk2eTDmwaOD3WdYKF0FQVQUj6UqAVc=;
        b=okRlX2EFDw0eQxkuGbCQNp8c1m9EeK/88jQWsp/hs0sfW/UniBHWESGCFHGGWfkgig
         /UEylRKW6Yke6z3zb+FMeRo9GEYhmdXAKzq0kIkal03VvXB2NerTL6QFuBG7bDdDVfOO
         GLFyQIMW3PQWsloXpqGt4if9O0NNKqn7Ux34+cwCeec97EVruzQ5xLHAcTp1bfooWf4k
         l5AoeWJQXjUCw9HUD0QSDdieUCB3XIlGrMLWoeqKzQ3Lm83B8PMEB1nEjIsMrQuDw0RL
         TjReWdPiVmSlU3B+Z5vU18VzF1mxIb40m268Xn5YzsUsHR8VIcDOCOHoV6638Z60qAtr
         HDXg==
X-Received: by 10.202.85.17 with SMTP id j17mr136250oib.65.1423347229847; Sat,
 07 Feb 2015 14:13:49 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Sat, 7 Feb 2015 14:13:29 -0800 (PST)
In-Reply-To: <54D67662.7040504@web.de>
X-Google-Sender-Auth: hXAdO3_zuzeWrv6SZuU5gA6deys
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263457>

On Sat, Feb 7, 2015 at 12:32 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> I don't know every platform of the planet well enough to be helpful h=
ere,
> especially the ones which don't follow all the specifications.
>
> In other words: As long as we can not guarantee that SSIZE_MAX is def=
ined,
> (and is defined to somethong useful for xread()/xwrite() )
> we should be more defensive here:
>
> tweak only on platform where we know it is needed and we know that it=
 works.

Yup, I agree that is a sensible way to go.

 (1) if Makefile overrides the size, use it; otherwise
 (2) if SSIZE_MAX is defined, and it is smaller than our internal
default, use it; otherwise
 (3) use our internal default.

And leave our internal default to 8MB.

That way, nobody needs to do anything differently from his current buil=
d set-up,
and I suspect that it would make step (1) optional.
