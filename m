From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 2/9] t5520: ensure origin refs are updated
Date: Mon, 18 May 2015 21:09:47 +0800
Message-ID: <CACRoPnR9Bgg2OXh4any6RihcDTDNZy_tmukGW-4ADr-G28egeg@mail.gmail.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
	<1431508136-15313-3-git-send-email-pyokagan@gmail.com>
	<xmqqegmkbliw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 18 15:10:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuKo7-0006Fm-4x
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbbERNJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:09:55 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35480 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbbERNJw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:09:52 -0400
Received: by wgfl8 with SMTP id l8so35885955wgf.2
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZUZIOaXwnu9pFmLDtPmuPNII2MnCzpZ0V+CVhlLGLcY=;
        b=W1+Iju8ipCgQouKT3StMz5pK9RTkleUlpJKoEBzvbezHycAQoQRHTDPRusK62FsdC1
         AnJNRQLQjzOprCBZScncyf+ytbgh5NeGVBLXHpZLCc7lNBfBBtsfPy7pQiIh+C//uR7/
         HlnOSV7n6PFTx3ykDJxWEQy2HVZLtjza3+WL3CPWv7DGJdllg4KHtK/VfUYu+4Shxifj
         9h1LroJy4CEGtck8kUu5NCLXk1vfHw6EGSF5kmBU45h1n8QKC0qPq83wfc1xnWPBF6aQ
         jduM/B9rrfUA5aL97E/VoN+M66co952Dx+ZUC7v/ccjQD5pcgCmHomiG3BMdWPG0upau
         B8ng==
X-Received: by 10.194.176.225 with SMTP id cl1mr43626343wjc.45.1431954588085;
 Mon, 18 May 2015 06:09:48 -0700 (PDT)
Received: by 10.194.85.113 with HTTP; Mon, 18 May 2015 06:09:47 -0700 (PDT)
In-Reply-To: <xmqqegmkbliw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269233>

Hi Junio,

On Wed, May 13, 2015 at 10:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> It is not unusual when the change is trivially correct.
>
> I do not think this hurts, but I do not think that this is vastly
> better, either.  If you suspect that the previous one may fail but
> you at the same time are so trusting that the one before that one
> would succeed, yes, this will help in that case.  But if you suspect
> the previous one may fail, the one before that may have also failed,
> in which case this may not be sufficient (the result of fetching may
> not match what this test expects to see).
>
> It all depends on where our paranoia ends. The current code is very
> much trusting all previous ones equally, and accepts "upon the first
> error, all bets are off for the later ones". With this patch, it
> becomes slightly less trusting.
>
> If everything else were equal, I would say this change is a "Meh" to
> me,

Yeah, thinking about it, it's a "meh" to me too. While this patch will
improve consistency in the attempt to recover from failure, I don't
think it will be useful in practice, and it's also not relevant to the
goal of this series.

Will drop this patch.

> but I think the change improves this test in a different way.
>
> It begins with "Run 'git rebase --abort', just in case"; which is a
> signal that it does consider that the previous one may have failed
> and attempts to prepare for that possibility, while trusting the one
> before that would have succeeded.  And under that assumption, what
> it currently does is _not_ consistent; the previous "pull --rebase"
> may have failed in the "rebase" phase, in which case "abort just in
> case" is a good measure to go back to the clean state, but it may
> have failed in the "fetch" phase, in which case "abort" does not
> help.  And this patch is needed to fix that inconsistency.
>
> If justified in that way in the log message, then I wouldn't have
> said "I do not think that this is vastly better", I think.
>

Thanks,
Paul
