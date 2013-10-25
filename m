From: David Aguilar <davvid@gmail.com>
Subject: Re: git grep: search whole tree by default?
Date: Thu, 24 Oct 2013 19:23:49 -0700
Message-ID: <CAJDDKr5G_dpk5s6EMBF=iU+yHkr7TKYRUBJAxBQY9Y9jy6FmCA@mail.gmail.com>
References: <CAA01CsqgNKdDAc9OL9zdk=3tnK9GAG=6w+wP_XSoiefBOgfzRQ@mail.gmail.com>
	<vpqbo2guff7.fsf@anie.imag.fr>
	<xmqqmwlzrjdh.fsf@gitster.dls.corp.google.com>
	<87hac7hmrb.fsf@mcs.anl.gov>
	<xmqqob6fq0q1.fsf@gitster.dls.corp.google.com>
	<87zjpzg592.fsf@mcs.anl.gov>
	<vpqy55jogzr.fsf@anie.imag.fr>
	<20131024022736.GA24992@sigill.intra.peff.net>
	<xmqqd2muo3sz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jed Brown <jed@59a2.org>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 04:23:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZX46-0007mt-Vy
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 04:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724Ab3JYCXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 22:23:50 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:56033 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755710Ab3JYCXt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 22:23:49 -0400
Received: by mail-pd0-f171.google.com with SMTP id w10so1482647pde.2
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 19:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yQFYfsCnEdJ+crIOf5wQ82pfRS488KrkkGqUiU8wMCM=;
        b=ay9yFd3RldNFKC359o6aD38C1iLEdwupAt+afm/l/JBAOT0p1ddt5dseo6o53dpTCk
         SX8hLjQkz/1ggiBNnAJG2mXLnsA2NHRpPr4T4tMNvHbzGcBZjnyBQ4KBQPaLoQzb5qAW
         s1muJDxOk3ce5rtaVHrL0ZerkIFoAN35x1mFAYLb7R1g9d0lP1TBTMVmGoAdPiPhwoJg
         TNKJ65K7QPO4EQhG1rJsoZZ3XI3HKbXX+DUbgC7Q+tZCJOYGFFtPOuP/34yLwteCpAkk
         lMXn4uINCGGzi5eEc2SHKQkdsUbqOeTJQCchD5c2DTKvFGpCvroeDg6W+weOVhVQ8By3
         rW0Q==
X-Received: by 10.66.140.40 with SMTP id rd8mr7134152pab.119.1382667829320;
 Thu, 24 Oct 2013 19:23:49 -0700 (PDT)
Received: by 10.70.125.197 with HTTP; Thu, 24 Oct 2013 19:23:49 -0700 (PDT)
In-Reply-To: <xmqqd2muo3sz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236642>

On Thu, Oct 24, 2013 at 12:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> That would also provide people who do not like the change of default an
>> escape hatch to keep the current behavior. And I do not think scripted
>> use will be inconvenienced; they will already have to use "." or ":/" to
>> be explicit (if they care) since the behavior is changing.
>
> There is a big difference between "scripted use will have an escape
> hatch" and "scripted use will not be inconvenienced".  We *know*
> scripts will be inconvenienced with or without such a configuration
> variable, as they *have* to be updated if they rely on the current
> behaviour of "git grep" that limits its search to the current
> directory when fed no pathspec (and if their users want to keep the
> current behaviour of such scripts).  Anything short of a warning (or
> even erroring out) that is designed to annoy the users during the
> transition period will help ease the pain of transition of scripts.
>
> An annoying warning still can only *ease*, but cannot eliminate, the
> pain of transition. The scripts need to be updated to adjust to the
> new behaviour; there is no getting around to it.
>
> Even if we ignore the "helping your colleague at her terminal", cf.
>
>     http://thread.gmane.org/gmane.comp.version-control.git/133570/focus=133683
>
> issue for now, adding a new configuration variable from day one
> makes the transition of scripts somewhat worse, I am afraid.  Doing
> so robs us a way to add such an annoying warning to help people
> foresee problems in their existing scripts before the default
> changes (the configuration presumably will disable the "this command
> line will behave differently after the default changes" warning).
>
> As I said, I think we can train people without an annoying warning,
> as hits outside their current directory will serve as an annoyance
> already, and people who set such a configuration in their repository
> (or $HOME/.gitconfig), get used to the chosen behaviour too much,
> and get surprised when they get to use a vanilla intallation of Git
> (either helping colleague or setting up a new work environment) have
> only themselves to blame, so it may not be too big a deal.
>
> But I do not think the same reasoning extends to scripted uses X-<.

The set of people that script "git grep" may in fact be pretty low /
almost non-existent so it may be a non-issue, but here's my one data
point:

For git-cola, this change in behavior would not make any difference.
It already jumps to the top-level during startup so its grep feature
is unaffected.

It'd be good to hear from other script writers but that's my $.02.
-- 
David
