From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 05/83] builtin/apply: extract line_by_line_fuzzy_match()
 from match_fragment()
Date: Wed, 27 Apr 2016 15:31:49 +0200
Message-ID: <CAP8UFD3SMRqX2=gNZteOe1A0+LT=nfG4HFg+Udtnobp1t+gBPA@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-6-git-send-email-chriscool@tuxfamily.org>
	<CAGZ79kYi0seMF12+Y4VxHBJxTh9wo4LUw0A50PYRvZEBvj6SBA@mail.gmail.com>
	<CAP8UFD228joDLyomvae7rVs02TuTbmEHerwWvH=VR+FE-YFLRA@mail.gmail.com>
	<xmqqbn4wf7ft.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 15:31:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avPZM-0005Wk-C6
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 15:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbcD0Nbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 09:31:52 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35775 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbcD0Nbv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 09:31:51 -0400
Received: by mail-wm0-f54.google.com with SMTP id e201so39093945wme.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 06:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=/K/8JzkbXCG8AmomTY5tpgHcvWQ6i5l8iwlYBO0gDkE=;
        b=awi/Px7IFI0Dp6mMeP+tbH5w67czIzu8dDbd4oKXFdgw2TF90Oe1P05GaFpHgS1w7a
         T4B2h8vCzTwO3DdP821vNBeCEGKY7Em3LeDiwzo49i/1SK5XJH12zFkpFCpOQTf+CI94
         Xx+8ezAaQ2mkat4L+09a8ehCkmObEWaFPRJXcF+fHhXMZ+AHfBlN320n+ZajXrB8rEia
         Clx4Cax78OS9NqIV4EBCwbfCoggXprQ/uydZqO1+oFFrr4Jqj+dbKhA31/f+QYJoVgK7
         jY+z6axb6vo8QUFWy0qsZh6/xpqFBFyCv55aeGV7lx18nPkSuDWelP1Q+qzyXmm6++DD
         ndAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/K/8JzkbXCG8AmomTY5tpgHcvWQ6i5l8iwlYBO0gDkE=;
        b=N6aUU4P6abv2W/rEhB1keQCY7xQ55QcHuIMcEuOrP2aaT/RJYVv0Qoug2hVAIOjiGA
         Mq3H04YpYxcomi8ibuxa4kHbCz18pgDYqoYl0LK7Zvlqfno9nxvdelBQ9Ij+yIzUPQRp
         oWyo/aXbIztyH0462iuqkMenZCYRQSDzSzfMLyg4k5p+QtHD5unRV9hnHQpl+U6TPA0I
         bsLbO1WlcVb6YZj03F7NvFlDrzGCltJ0E+yLw/vh63nWJzU0nf9edHTUWOT2obtpTuPP
         tRNkzFi/LqIuH0k4D4qX+ozLmECCw9mFxhaZ8GcV6Piuy7aNf1AXy2vb9NvFiV0d+pzC
         6KBQ==
X-Gm-Message-State: AOPr4FVmek2ieGGNd1D22yVSvb0txLPs1SsCKX0eRyTH6+5BGNituIMH3zeY2wrKKHw/P6jInPxLQr/MfK1fSA==
X-Received: by 10.28.151.133 with SMTP id z127mr9632601wmd.79.1461763909945;
 Wed, 27 Apr 2016 06:31:49 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Wed, 27 Apr 2016 06:31:49 -0700 (PDT)
In-Reply-To: <xmqqbn4wf7ft.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292725>

On Tue, Apr 26, 2016 at 10:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>>> It's not clear why we need to declare buf here? Oh wait it is. It's just
>>> moved from the start of the function. But why do it in this patch?
>>> It seems unrelated to the general intent of the patch. No need to reroll
>>> for this nit alone, it just took me a while to figure out it was an unrelated
>>> thing.
>>
>> Yeah, I agree it's a bit unrelated. But rather than add another patch
>> to an already long series just for this,...
>
> Isn't not doing the unrelated move at all a more sensible
> alternative, if that change does not deserve its own place in the
> series after all?

Ok, I removed the unrelated move.
