From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in
 pack directory
Date: Wed, 13 Jan 2016 14:19:05 -0600
Message-ID: <CAEtYS8RA2HONEARQ03EiT8Ch+F2am+YJuRz2hNiSGO25N8Lf4g@mail.gmail.com>
References: <1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
	<CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
	<xmqq37zhg8la.fsf@gitster.dls.corp.google.com>
	<xmqqbnbilw9u.fsf@gitster.mtv.corp.google.com>
	<CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
	<CAEtYS8Q1T-ig2KqZUoCCODs1YbjOmF__vbiH5rL-s6hNaUhZeA@mail.gmail.com>
	<xmqqr3k5a76v.fsf@gitster.mtv.corp.google.com>
	<CAEtYS8Rp0Eb7uHB8kJ=muVWy6u+beB7kAAWZqPgTYqfuKx3P2A@mail.gmail.com>
	<20151104200249.GC16101@sigill.intra.peff.net>
	<CAEtYS8S_ys3jT5ziWd7_u6Dn8b3LwnZYO7Pz6EegsmWpUM5riw@mail.gmail.com>
	<20151230073759.GA785@sigill.intra.peff.net>
	<CAEtYS8Qs2B3rP1PDGhoWGAgcj2c_pOTpt=s8qj9tWMjkLLFyhQ@mail.gmail.com>
	<xmqqvb6xmedw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:19:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJRsw-0001VR-S6
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 21:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758618AbcAMUTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 15:19:10 -0500
Received: from mail-qg0-f67.google.com ([209.85.192.67]:36255 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758619AbcAMUTG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 15:19:06 -0500
Received: by mail-qg0-f67.google.com with SMTP id 6so48691725qgy.3
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 12:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=v6Z+xMFB/QJitbDnDpZBFZJiVPwxIbEje2G6KPBnvU0=;
        b=aGy2rv1sgWJ2si0VXeJND/7dOEriLFy8sDyTtKrhQnsaM0jpv1ngWFSj2HyNEDCotH
         hixRBxLo5mHQWGLlQ2RqwDghPgZ+16zwNbx55J3or2MXnMvXjwq7cYhqnjUgrNKjlNWq
         FrdnF9xLofrxVwQK60nF827au8Xux+/v4W9xtx0Q7u+P2lHahO6MVizDkcCetDhTjLDv
         ZXCKOPaex9THI7pwj68TQCiKi+cxnHuneT2OaRjtcy012BHQOyhkwiCj3WoV/N0y6iGp
         n5AnmjXTBTOd0ZqwTyfcgXWxnphEoo5+929IdChI93vlW9NXBO9m59LtGb/Cr0LrFQdq
         WsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=v6Z+xMFB/QJitbDnDpZBFZJiVPwxIbEje2G6KPBnvU0=;
        b=GyjXJoZFTjx9y04ooNDTwIlkkQeIUY29yr0e9mJ/QW1scG1oJ34Hm/k7c94B6e0EFf
         1CVfsSpEGWXpAFUFG+qDTz/DKaVUHJDubAEwzE8zOlTnrBTgh0E95cjdOTXbk/ttSfcf
         vL9w9mHtK701wOrNOG+6smFrZilqU5DgfqAMpnQgArVB5B0TMFQ4N3W/khRvewksBm/6
         /E6eF5Z733siuPJoVJampCz4B3+pBukV5HdxYOs+8owVnGds9ckvHhd35cIfizCdmIr9
         1yIMwb9ZLm5FFzASOjQAwP0/SKMLS19nZwC3cNYENx7xcwnlTtxavhSTifGB4uXfonpx
         VzEw==
X-Gm-Message-State: ALoCoQkthrTGmM75nF23Kxt9HswZgunlFE2EJ3JzdlGVh3GokW8QQNPig23BDsqJ7iErOvMbfRgsr/Xego/JNgDmrpd65r6nrA==
X-Received: by 10.140.165.7 with SMTP id l7mr149406qhl.101.1452716345075; Wed,
 13 Jan 2016 12:19:05 -0800 (PST)
Received: by 10.55.15.148 with HTTP; Wed, 13 Jan 2016 12:19:05 -0800 (PST)
In-Reply-To: <xmqqvb6xmedw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283982>

On Wed, Jan 13, 2016 at 2:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Doug Kelly <dougk.ff7@gmail.com> writes:
>
>> Yeah, I know I never got to adding the mtime logic, but for a simple (naive,
>> hard-coded) case, I did come up with a basic patch today.  I think this could
>> be extended to a configuration option(?) which would allow a default longer
>> than 10 seconds (an hour? a day?), then during the regression tests, we
>> could provide a shorter timeout to ensure the guarding both works and also
>> not wait forever for tests to complete.  Thoughts?
>
> Please do not sleep in the tests.  Instead, please try to see if you
> can use test-chmtime to set the timestamps of these files to the
> necessary ages for the purpose of your tests.
>
> Thanks.

Ah, thanks -- I actually didn't know about that.  I didn't intend this
to be a formal
patch (although I'm sorry the mail client clobbered all the
whitespace), but I will
keep this in mind for when I continue to refine this change.

However, back to the point: should the wait value be hard coded? Configurable
as a new option?  What should our default wait be?

Thanks!
