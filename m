From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 01/10] ref-filter: introduce 'ref_formatting_state'
Date: Thu, 30 Jul 2015 14:48:21 +0530
Message-ID: <CAOLa=ZRyunhpXwW=YnmYS=yWdcyr0Fid2ZzO+1qq+PzSCrHVLA@mail.gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
 <1438065211-3777-1-git-send-email-Karthik.188@gmail.com> <CAPig+cS+w8ECma--ncJDoN1fEgrFZMvBC8GBgU6+tLYm_oGkaw@mail.gmail.com>
 <xmqqfv4691ui.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"christian.couder@gmail.com" <christian.couder@gmail.com>,
	"Matthieu.Moy@grenoble-inp.fr" <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 11:19:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKjzN-0000Ak-1u
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 11:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837AbbG3JSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 05:18:52 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35178 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606AbbG3JSv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 05:18:51 -0400
Received: by obbop1 with SMTP id op1so26572239obb.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XzkJ5y2odi4M4edVz1FOKGY3m8DUWTMdwrYE+Mcd6o4=;
        b=ToZEOqMlMxFffWIdw2jyGjLkuLU7X4hvkzQHlYg/mAmD98uIiXh9+OH1iccgMhJNVA
         OYUrkFhD1vF/sXLXIFkbBEGaViodrAy/4q2/V+f2lkQZN05uAlc6Mc0X6ClRv5e0sko6
         qqskidOleWI6MQ08kcNkq/KpGkt8u28zrbmhGD+is73hUMkopi5bKFipdwJQKQxt8nIo
         hx0iJ2Tgu+jb2wlDiRPcOqqnr/mPsH6XU1SeFH8WtV9qXRnKuAyI4Z3G9YITC1JesqeV
         eUMNgOiQK0x9nFQfnlYOYI7h4Y44bcCXOqHxeZc7mVzYT2sQYUisM1m3IRQQNNLNtv7d
         EjZQ==
X-Received: by 10.60.41.138 with SMTP id f10mr44189345oel.84.1438247930841;
 Thu, 30 Jul 2015 02:18:50 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Thu, 30 Jul 2015 02:18:21 -0700 (PDT)
In-Reply-To: <xmqqfv4691ui.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274975>

On Thu, Jul 30, 2015 at 1:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Actually, I think it is wrong to have this function in the first
> place.  It is a sign that the caller is doing too little before
> calling this function.
>
> If the act of printing an atom uses the formatting state that says
> "next one needs X", then it is responsible to clear that "next one
> needs X" part of the state, as it is the one who consumed that
> state.  E.g. if it used to say "next one needs to be padded to the
> right" before entering print_value(), then the function did that
> "padded output", then the "next one needs to be padded to the
> right" should be cleared inside print_value().
>

Hmm, something like what we did in version 5  I guess.

> And with that arrangement, together with calling emit() with
> formatting state, %(color:blue) can be handled as a normal part of
> the formatting state mechanism.  The pseudo/modifier atom should
> update the state to "Start printing in blue", and either emit() or
> print_value(), whichever is called first, would notice that state,
> does what was requested, and flip that bit down (because we are
> already printing in "blue" so the next output function does not have
> to do the "blue" thing again).

This makes sense, will work on this thanks :)

-- 
Regards,
Karthik Nayak
