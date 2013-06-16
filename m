From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 1/3] rebase: guard against missing files in read_basic_state()
Date: Sat, 15 Jun 2013 22:45:17 -0700
Message-ID: <CANiSa6hUV-xMMASbJf67j0Zn+Mu25CRcvQThNd1EuemhSBB6Rg@mail.gmail.com>
References: <1371139573-28047-1-git-send-email-artagnon@gmail.com>
	<1371139573-28047-2-git-send-email-artagnon@gmail.com>
	<7vy5adskz3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 16 07:45:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo5mF-0007PJ-8O
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 07:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871Ab3FPFpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 01:45:19 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:53533 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab3FPFpS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 01:45:18 -0400
Received: by mail-wg0-f42.google.com with SMTP id z11so2685647wgg.1
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 22:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dkFLAt2OTFL6f8BIogj3nLEK+GL0RFzrheUh6Yi5TnE=;
        b=K96F/5AS+SnKVde8oXTRPbnhUfTciy5ZyUkVZuYcvgMpnGCvbRMhcytqmw1PSWAJUN
         VDPHbPHJAP6q14pPwEjbWJEjgQltH41PLwsRJMqHJ67YfXfaLhd9E9KaDlyMmgzJy5QZ
         P9ky/jNUsoy8iFAR/YYbZZSPulBP7ewMWK2j8kDhOXccSoPOnRObfWrx4PHHBp8yLS9p
         jGYTQMfTMLawuKbq10N3stpyt8qpPFojbHEzGq2+Bjbm1cDvSXMY5ZXmNPzkddiIAP49
         b+6VmfyZKZczxkERe13UQfZu2oCU4c2EJcqZts+o/a1PObsDF1heA0gNLx83dJP23Oyb
         Y5pg==
X-Received: by 10.194.78.110 with SMTP id a14mr2660076wjx.84.1371361517471;
 Sat, 15 Jun 2013 22:45:17 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Sat, 15 Jun 2013 22:45:17 -0700 (PDT)
In-Reply-To: <7vy5adskz3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227987>

On Thu, Jun 13, 2013 at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
> A more troublesome is that nobody seems to check the return value of
> this function.  If head-name, onto or orig-head is missing, is that
> an error condition that should make the callers of read_basic_state
> stop and refuse to proceed?

Since we unconditionally write those three (and 'quiet'), it seems
reasonable to require all of them to be there when continuing, so I
think you're right that we should fail fast.

> The way the && cascade is used seems to indicate that, but up to the
> point where it sents $verbose. If and only if head-name, onto, orig-head
> and quiet can be read in state-dir, verbose in state-dir is checked
> and only then $verbose is set.
>
> Martin, this seems to be from your series around early Feburary
> 2011.  Do you recall why these checks are cascaded this way?
> I do not offhand think of a good reason.

Neither do I. I think the cascading after 'quiet' is just a mistake on
my part. The consequences are probably close to none, since if one of
earlier commands fail, the other files will probably not be there
either. (Not defending it; I'm happy if it gets fixed, e.g. by making
it fail fast.)
