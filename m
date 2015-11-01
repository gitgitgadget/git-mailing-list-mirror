From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] checkout: add --progress option
Date: Sun, 1 Nov 2015 14:29:16 -0500
Message-ID: <CAPig+cQvsXMqAzV_59sZdqDEh_SRfOMh+BY3XLmzSPdfWwugdg@mail.gmail.com>
References: <1446400076-9983-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cSLC_xkpXEznzPQdA=FE6GV5VSuwSrFy62Nzybv7jQf1g@mail.gmail.com>
	<20151101191902.GA19594@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Edmundo Carmona Antoranz <eantoranz@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 01 20:29:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsyJg-0004Q6-JE
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 20:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbbKAT3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 14:29:18 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36652 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbKAT3R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 14:29:17 -0500
Received: by vkex70 with SMTP id x70so73797483vke.3
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 11:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=i7B2ByaEWoBE4gOi+wH9Zj20dozdgbjKIZhWfLLuKYw=;
        b=bs8H5OAfqig2SnjROVegCbchkrPPcAqKZQnX+L8nh1cR1n46dPtCbb0XxYwHISJt/x
         sBQwPd500XCJKThtQ1bswBPnzq6pFyO4/yvtnjEBx8Nr7hvs4fnp4VhyHR9vycUWQMN9
         fW1Li3gS2T9uormFPyr8fiZYB+3Fpi8d0xERYLR/RURYHQzFd9lpCa+XooR8MoU0BCHK
         gDxOnZhrqNkSXl5VB5JPZRF1M6wOId/NrBcEefiSDtusizH1Ayixx6thT/qw3Nkays+W
         Lfhq5GGmPnbwediqbjfsDhaNUaj7oaHe8btzGGF6c4vh11j/Xnn/tLR/8IuBlICCNV+w
         ZyZA==
X-Received: by 10.31.56.75 with SMTP id f72mr12856395vka.115.1446406156751;
 Sun, 01 Nov 2015 11:29:16 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Sun, 1 Nov 2015 11:29:16 -0800 (PST)
In-Reply-To: <20151101191902.GA19594@sigill.intra.peff.net>
X-Google-Sender-Auth: JSGkzzJV2DXkI-5WVltCNiDU5ZI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280656>

On Sun, Nov 1, 2015 at 2:19 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 01, 2015 at 12:52:57PM -0500, Eric Sunshine wrote:
>> > +--progress::
>> > +       Progress status is reported on the standard error stream
>> > +       by default when it is attached to a terminal, unless -q
>> > +       is specified. This flag forces progress status even if the
>> > +       standard error stream is not directed to a terminal.
>>
>> What this kind of implies, but neglects to say explicitly, is that the
>> logic implemented by this patch also overrides --quiet. It probably
>> should say so explicitly.
>
> I was the one who suggested originally that --progress should override
> --quiet[1]. However, that was just based on what I thought was
> reasonable. I didn't look at what clone or other commands do.
> Consistency between commands is probably more important than any
> particular behavior.

I did check git-clone during my v4 review, and --progress does
override --quiet (see transport.c:transport_set_verbosity()), so your
suggestion to make --progress override --quiet in git-checkout at
least keeps it consistent.

Aside: Specifying both --quiet and --progress with git-clone doesn't
give great results since (it seems) that no flushing is done until the
newline is emitted, thus you only see the end result rather than a
running progress meter.

> [1] To be honest, this is kind of a crazy corner case anyway. It was
> more just that it has to do _something_.

An alternative would be to error out stating that --quiet and
--progress are mutually exclusive.
