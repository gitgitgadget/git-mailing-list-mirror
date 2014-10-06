From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 5/5] add tests for checking the behaviour of "unset.variable"
Date: Mon, 6 Oct 2014 12:28:55 -0700
Message-ID: <CAPc5daXa_Maz3nTr4s=fxxL9FYs8VbndqX-2R_iwo4KRHCKQhA@mail.gmail.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
 <1412256292-4286-6-git-send-email-tanayabh@gmail.com> <xmqqr3yqmdxa.fsf@gitster.dls.corp.google.com>
 <542DB2FE.609@gmail.com> <xmqqmw9emdax.fsf@gitster.dls.corp.google.com>
 <542DB711.9040503@gmail.com> <xmqqiok2m494.fsf@gitster.dls.corp.google.com>
 <vpqeguptz5k.fsf@anie.imag.fr> <xmqq1tqpm2na.fsf@gitster.dls.corp.google.com>
 <vpq4mvlgchj.fsf@anie.imag.fr> <xmqqeguolxow.fsf@gitster.dls.corp.google.com> <5432E67B.8070604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 21:29:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbDyD-0007gK-UF
	for gcvg-git-2@plane.gmane.org; Mon, 06 Oct 2014 21:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbaJFT3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2014 15:29:18 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:61785 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbaJFT3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2014 15:29:16 -0400
Received: by mail-lb0-f182.google.com with SMTP id z11so4899061lbi.13
        for <git@vger.kernel.org>; Mon, 06 Oct 2014 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=yvue6zmfYJ4H2FyXyBDjvB0eJ6x+HL5BDiQNHKvtxH0=;
        b=inOvZowQyJac/vb9UuYCkgyASpDvU1XWhdjIhotTDEnaFfp8dn2IPBqnIi/fGG7qg3
         TYmaKFVPHxt1OAO4t6zixG66N7IJHM2vFcUGNPawavnIJzJbtOrvCxX3UJiSwx6IbPJ6
         haHo5SCVKttdShb8qkNQPsyBEHuIqaEkN2Yx7NkOr96x4LkkFESMW5IEqg42Jj3S8VmZ
         pNW482kq8K7WjO+1Jv2wuBG6eXO6+uxXlyu8/tIrwmBiK3Av5s68apVYw+z1Uh0uWo+M
         DNNs8xrYHmfk6QyMohuDmB4q9OdAtiT1Wt9KC1tqBbogubpNr7EJFGlazKpGZ3XtT29r
         beOA==
X-Received: by 10.152.6.40 with SMTP id x8mr27116768lax.18.1412623755083; Mon,
 06 Oct 2014 12:29:15 -0700 (PDT)
Received: by 10.112.209.35 with HTTP; Mon, 6 Oct 2014 12:28:55 -0700 (PDT)
In-Reply-To: <5432E67B.8070604@gmail.com>
X-Google-Sender-Auth: vh0qQfpkbBGMuBJdcqGXWCKR8ts
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257916>

On Mon, Oct 6, 2014 at 11:59 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
> 3> Special case "unset.variable", so that git config unset.variable foo.baz
> pastes it on the top of the file. The implementation should be trivial, but,
> Junio had said in an earlier mail that he doesn't think this approach would
> do much good.
>
> Other than this approach, Junio had suggested to append it after the last mention
> of "foo.baz",...

Just to make sure there is no misunderstanding.

"it" in "append it" above does not refer to unset.variable, and
"the last mention of "foo.baz"" is not "[foo]baz=value"

The point is to prevent"git config --add foo.baz anothervalue" starting from

--- --- ---
[foo]
  bar = some
[unset] variable = foo.baz
--- --- ---

from adding foo.baz next to existing foo.bar. We would want to end up with

--- --- ---
[foo]
  bar = some
[unset] variable = foo.baz
[foo]
  baz = anothervalue
--- --- ---

So "When dealing with foo.baz, ignore everything above the last unset.variable
that unsets foo.baz" is what I meant (and I think that is how I wrote).
