From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH v2] checkout: no progress messages if !isatty(2).
Date: Thu, 24 May 2012 14:46:42 -0400
Message-ID: <CAHqTa-3QUsW_AP67NWjc-Gu5FZ7xQZyOOM-=zea+vwZeT79=0A@mail.gmail.com>
References: <20120524061000.GA14035@sigill.intra.peff.net> <1337839944-4651-1-git-send-email-apenwarr@gmail.com>
 <7vy5ohwhy7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 24 20:47:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXd42-0004wK-Gp
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 20:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933912Ab2EXSrG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 14:47:06 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:59937 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933807Ab2EXSrE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 14:47:04 -0400
Received: by vbbff1 with SMTP id ff1so86458vbb.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5aKP2EDQlJSU4BrKSh38IvZRofo/gSSq7jIpi+awGdY=;
        b=l6r0NnJSca2yPuFwDK6Z4Hgffzs04V8DxhsPysahVOuahDEmaNOoAys92EXJyG1lMz
         R0PTM3c6jyB6w1jKb/4ZWPElQB+l0xGMPrDkCv21b2a610GQwTp0uDXIXYPFgtxuV3xb
         nXTs1N+zv8SDot5OnZfH2MAlM7XSz0rQoToIV+eXkorwhhe0KN21N5S9T1cX14raeNDu
         dbcCYhivJjmbJeqZSYVALfCpRdKon/giYKez3DLrfT3HyKiiM4yLQfh5OPhh1IHt7934
         CRdSQMnVd2FP6ZB3P006QLqOXAE9fMfcmmNJk1KT5izTwYBeAnPxurpowW5ylgS78YGt
         hbUg==
Received: by 10.220.91.74 with SMTP id l10mr483481vcm.41.1337885222874; Thu,
 24 May 2012 11:47:02 -0700 (PDT)
Received: by 10.52.38.200 with HTTP; Thu, 24 May 2012 11:46:42 -0700 (PDT)
In-Reply-To: <7vy5ohwhy7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198406>

On Thu, May 24, 2012 at 2:29 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Avery Pennarun <apenwarr@gmail.com> writes:
>> It would probably be better to have progress.c check isatty(2) all t=
he time,
>> but that wouldn't allow things like 'git push --progress' to force p=
rogress
>> reporting to on, so I won't try to solve the general case right now.
>
> Before that "It would probably be better" comment to give your opinio=
n,
> you need to describe what problem you wanted to solve in the first pl=
ace.
> I'll lift it from your original version of the patch:
>
> =A0 =A0If stderr isn't a tty, we shouldn't be printing incremental pr=
ogress
> =A0 =A0messages. =A0In particular, this affected 'git checkout -f . >=
&logfile'
> =A0 =A0unless you provided -q. =A0And git-new-workdir has no way to p=
rovide -q.

Do you want me to rephrase the commit message and resend?

> I do not seem to find a sane justification for
>
> =A0 =A0 =A0 =A0git $cmd --progress 2>output
>
> use case and I do not immediately see how that "output" file can be
> useful. =A0But we've allowed it for a long time, so probably this ver=
sion is
> safer. =A0Besides, it is more explicit.

Yeah, I have nothing against allowing --progress to work.  If I were
to clarify my comment above, it would be to say that I'm worried about
how *many* places we keep calling isatty().  It is (as we can see from
the need for this patch) error prone, since I think most naive coders
would expect the progress stuff to act correctly by default if
!isatty(2).

So maybe the "right" fix is to add a flag to start_progress_delay() to
"force" verbose mode; if it's not set, start_progress_delay() would
check isatty(2) and decide automatically what to do.  This wouldn't
save much code, but would make sure developers think about their
intentions.

Have fun,

Avery
