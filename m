From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] Introduce a hook to run after formatting patches
Date: Tue, 18 Nov 2014 07:40:07 +0100
Message-ID: <CAP8UFD3m9aouYKXfk-vE4AGbTxdyH6=k8ey5n-kF1OLux2Ah0g@mail.gmail.com>
References: <1416012460-4459-1-git-send-email-sbeller@google.com>
	<xmqqzjbryonp.fsf@gitster.dls.corp.google.com>
	<xmqqlhn9y7dn.fsf@gitster.dls.corp.google.com>
	<xmqqd28ly6p1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 07:40:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqcSV-0003FX-Et
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 07:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbaKRGkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 01:40:09 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:63558 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbaKRGkI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 01:40:08 -0500
Received: by mail-ig0-f171.google.com with SMTP id uq10so494328igb.10
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 22:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JH7Bq/yKSxyTLPb/cI34bPuGc1cOrlRLDkSF1eI/7PA=;
        b=CtQw/k5vo7Qo0P6bhGaIpmrL8afesglXEXHSIp039zQfr4NLIMlaM96+CzFTwPJFfP
         ThdKJnnSjtYnSVfTthjkVqW1vZogoRwbZ38HolQ6/Zbs7XXUwfmYkRVUgCFq+Z360vmW
         NfIEEbjHa3CtyM23TjJgNAQVaO0bj5RJsOHsJjudP8JJI0lFu9vXaqbmFdjuTRbp5wXp
         xCKvfArkyjBWqaSXy0GwoSzmKs7XnFLv8jgVbmR0O64/c1IMudX+2mh2fkmorGM5cSSR
         gJUhDfQ2qnun0wsK0DwUtdqd2UGzq+2bNsBKXGzHCKY497jwNr2HhPPPikrMkIdzhFhz
         C41A==
X-Received: by 10.107.170.98 with SMTP id t95mr4748721ioe.7.1416292807424;
 Mon, 17 Nov 2014 22:40:07 -0800 (PST)
Received: by 10.50.250.179 with HTTP; Mon, 17 Nov 2014 22:40:07 -0800 (PST)
In-Reply-To: <xmqqd28ly6p1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 17, 2014 at 8:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> (I am not saying that there should be an easy way to drop cruft left
>> by third-party systems such as "Change-id:" line) ...
>
> Heh, that was "should not be", but I guess it was probably obvious.
>
> Sorry for the noise.

I am not sure it is very easy yet but as Change-id: ... line are
trailers, you can do that with git interpret-trailers.

For example:

$ echo -e "\nChange-id: stuff\nOther: thing"  | git -c
trailer.Change-id.ifexists=replace interpret-trailers --trim-empty
--trailer Change-id=
>
> Other: thing

The idea is that the above command replaces an existing "Change-id:
stuff" trailer with an empty "Change-id:" trailer and then removes all
the empty trailers.

Best,
Christian.
