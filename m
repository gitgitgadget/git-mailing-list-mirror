From: Patrick Palka <patrick@parcs.ath.cx>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight
 unevenly-sized hunks
Date: Thu, 18 Jun 2015 18:25:45 -0400
Message-ID: <CA+C-WL97BeK3JmSPdyOdg1j=QOFTht_R=hUoAA30Vq6Nqx-wdQ@mail.gmail.com>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx>
 <xmqqwpz1f22b.fsf@gitster.dls.corp.google.com> <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
 <xmqq1th8ga9b.fsf@gitster.dls.corp.google.com> <20150618190417.GA12769@peff.net>
 <alpine.DEB.2.20.8.1506181536070.4322@idea> <20150618204505.GD14550@peff.net> <20150618212356.GA20271@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 19 00:26:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5iGD-0002tW-Ei
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 00:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbbFRW0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 18:26:07 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35948 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbbFRW0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 18:26:06 -0400
Received: by oigb199 with SMTP id b199so26388730oig.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 15:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=90/uhSEeyNF0/Z2gwxcznAaGyx2fjYW5zVbf1fE7hL8=;
        b=eDdlml38mQuRDU7ob/tLMyH97bYqzsq2I1/9vFk7I0ECZXO7BWSZX7Sq0+d2kr8GPh
         IXV4hOKNsnbPsPENghKgoH7VSH+9mp//SPHNAivEmrE3khOyo1/ufDuRo78rrIZAEXCa
         43j9BJpnQ1Mv2V0oi9GUjHvhaxoD3r6Od+xp+688pAqpKXeNlUEFY0rukZ9x5vQ3H42B
         I8WKgO/1PfLEg3ov++iwk9by8/W6ymLUZwrmUSfE72dCuv1Z9YlQhaF0sKTqqryGsPRR
         sbtV05kTPvDPU7HrmQ+Bci1EfE9WQY5dX9339UgpiimuW4YHBEMCk1ICjsmsl6RUMerj
         0dqQ==
X-Gm-Message-State: ALoCoQksTnOPyzRgT+PpLDvYo9wqzUGUdt1w9srLIFuK61xSCrRY+6A6AMUgreOsb2RH4CiNZWM1
X-Received: by 10.60.47.113 with SMTP id c17mr10850966oen.64.1434666365682;
 Thu, 18 Jun 2015 15:26:05 -0700 (PDT)
Received: by 10.182.96.167 with HTTP; Thu, 18 Jun 2015 15:25:45 -0700 (PDT)
X-Originating-IP: [67.83.172.216]
In-Reply-To: <20150618212356.GA20271@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272087>

On Thu, Jun 18, 2015 at 5:23 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jun 18, 2015 at 04:45:05PM -0400, Jeff King wrote:
>
>> Still, I think this is probably a minority case, and it may be
>> outweighed by the improvements. The "real" solution is to consider the
>> hunk as a whole and do an LCS diff on it, which would show that yes,
>> it's worth highlighting both of those spots, as they are a small
>> percentage of the total hunk.
>
> I've been meaning to play with this for years, so I took the opportunity
> to spend a little time on it. :)

Cool!

>
> Below is a (slightly hacky) patch I came up with. It seems to work, and
> produces really great output in some cases. For instance, in 99a2cfb, it
> produces (I put highlighted bits in angle brackets):
>
>   -               <hash>cpy(peeled, <sha1>);
>   +               <oid>cpy(<&>peeled, <oid>);
>
> It also produces nonsense like:
>
>   -       <un>s<ign>ed <char >peeled<[20]>;
>   +       s<truct obj>e<ct_i>d peeled;

That's not even so bad.  The diff of the change itself is... interesting.

>
> but I think that is simply because my splitting function is terrible (it
> splits each byte, whereas we'd probably want to use whitespace and
> punctuation, or something content-specific).

I hope you can polish this.  It definitely has potential.
