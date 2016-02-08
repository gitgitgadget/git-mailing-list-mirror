From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/8] pack-objects: produce a stable pack when --skip is given
Date: Mon, 8 Feb 2016 12:23:34 +0700
Message-ID: <CACsJy8CyFnUGdBQ4XQ5jvfc7GY08jQkB-z70bDSdSNAPigYDvQ@mail.gmail.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
 <1454662677-15137-3-git-send-email-pclouds@gmail.com> <xmqq1t8rdmky.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CkQPX4zqW39gpODSkU+habM7TGTJ85MU-S0UuNPk9SCw@mail.gmail.com> <CAPc5daXmci5TTc0zqKe+izbrQ5XmHd75V=ZKjoWN8hMPTJPSTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 06:24:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSeJX-0006h4-MT
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 06:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbcBHFYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 00:24:08 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36071 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbcBHFYG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 00:24:06 -0500
Received: by mail-lb0-f177.google.com with SMTP id dx2so76876609lbd.3
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 21:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HbacY3fl8K1CKxea2K14Y1FM7b5z9RGMtKu6E8Vb0To=;
        b=0FWs+HKwmVGFv/zbPH+UliQukDl/KLTStdotjnIbF1GiXx3cZ5xnw8dYJC1kxfU2Vc
         4LPTs4o1oChLpJimEzjUe+aSTqx/IFbdiBPxoN63+gOHeQPGG1QPuAoJasCLtZwY5x7L
         D050RU7MjGZdSLvHo1Oy2OprMauXtGWNrBpxWt/WvV2BdFnDMB3Ne40y2gYpE8ndV6mM
         jk3tPcSQtOPS6z8q4HeX1dKk7Glbc6XYWExk1HaznGj50DGOMF50IpEO0n3FcGPIV7FF
         O7fobaiQiKi9ubuYUs9CMtuuwirG3p5Kpr/AsPxqHsNcgdNmMkjAPSx6ST5Io87jiTN7
         CaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=HbacY3fl8K1CKxea2K14Y1FM7b5z9RGMtKu6E8Vb0To=;
        b=k0UKGEDDpKQwkqQozU6TwAiRlj+FDgn3pF+SaEthRPVhcWbLl6tyZ+4oIg3DDLOUaT
         Uax9ki39OzoaZlpsThUOX919zyGe9CwyUccI7qIXsXHZUOawLpJRGrm/NwNl+ZhRlJ7L
         YB+WeVy7k59ZrFJqOi2F5LBRPgEXS8vrea9vdXsdHrGX2JewPMNdk9eeiT1QO2bdQaH7
         Vv/xeoLXOetj000pXqWPUAofBYcQGp8Pu2Qz1NB6YC2IOXvie9Mr+BSaCH7mabq2rWgD
         0Vh8ih99Th2bnwiBm0KNRuHq93huewsRK+/5bXCv7WbythM96OnJctfVQ1bS3vHGGvTY
         NGOg==
X-Gm-Message-State: AG10YOTvzkBVA4gBT/UPWbcgbGe1pocBnBiimbb7yyW8S+nOrgFeAx5YyLwD4pKZOTD3+iVPA1IOtBXz+37l+A==
X-Received: by 10.112.209.99 with SMTP id ml3mr10247811lbc.26.1454909044577;
 Sun, 07 Feb 2016 21:24:04 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sun, 7 Feb 2016 21:23:34 -0800 (PST)
In-Reply-To: <CAPc5daXmci5TTc0zqKe+izbrQ5XmHd75V=ZKjoWN8hMPTJPSTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285749>

On Sat, Feb 6, 2016 at 7:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> You noticed that tying the behavior only happens when the user asks
>> for it, right? I don't expect people to do resumable fetch/clone by
>> default. There are tradeoffs to make and they decide it, we offer
>> options. So, it does not really tie our hands in the normal case.
>
> You misread me. I do not want to see us having to add
> "disable_this_feature = 1" next to that "delta_search_thread = 1"
> in this block, and then supporting code to actually disable that
> feature, only to support this block. You are declaring that "to
> support this mode, we must always have a way to produce a
> byte-for-byte identical output and keep supporting it forever".

My last defense is, this is an extension, not part of the core
protocol. If the burden becomes real we can always remove it.
Modem-quality connection users may yell a bit, but the majority of
broadband users won't notice a thing. But I understand if the answer
is still 'no'.

I find it unlikely that this cause much maintenance burden though, the
packing algorithm has not changed for a very long time (most related
change is pack bitmaps, which technically happen before pack-objects).
The next big change (at least in public) may be pack v4. We haven't
found a good algorithm for pack-objects on v4 yet, so there's a chance
of problems there.
-- 
Duy
