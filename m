From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] attr.c: simplify macroexpand_one()
Date: Mon, 16 May 2016 09:13:09 -0700
Message-ID: <CAGZ79kanUufPKHK3-QGoTK8jju_iRGokpXpR4-7Zwc+tAodC4A@mail.gmail.com>
References: <xmqqmvnr3p62.fsf@gitster.mtv.corp.google.com>
	<CAPig+cST7phEvTodEDoYk2UpDOssKg9OVcpddT0sZPy-0aMqsg@mail.gmail.com>
	<CAPc5daVH_qveYBnxybvZYTuVKNBhG7PnJxeY9f8zVXqNxpvzVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 18:13:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2L8x-00075U-02
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 18:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348AbcEPQNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 12:13:13 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35976 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285AbcEPQNL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 12:13:11 -0400
Received: by mail-io0-f177.google.com with SMTP id i75so210345752ioa.3
        for <git@vger.kernel.org>; Mon, 16 May 2016 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=i+qfjcHPeHuPC5eYbCR5BK2M73ablGUFgdEmol8ViM8=;
        b=ctpn5FfeNbk4huaqxhJl/8woc7cm1nDhyDnkuk4Bi64VfhMsxVOvwY8dZF2Ju656Wm
         S+I/PEXUfM27yOt1ILP+ZCUtK+NKt6nMZOPJELGYflIxEAb7bExt/RefNpSXdvoGJaSS
         vp3uWBHc+FcNF5A5d1pu/2llBngz/o2KoRi81TTkgXOkETZH3E0gFR4w9eT0U/c0+fQc
         CfEAPv0y3+QGjn8ZOcp7W9x5QKzv2pGCMlxG2VXL1+Mdb5JlowsHBrcZ6I0dSGEda/Np
         uAVL1LYxWc1ZcQOUt+JGYr6chCxy5rUcSaUate17lhibW9z0hktYXSUfI9n9yMPBVOcG
         mbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=i+qfjcHPeHuPC5eYbCR5BK2M73ablGUFgdEmol8ViM8=;
        b=RJU6MFXZIQ6wdU0fX6kPc8W5z7JhkAX1ARob/l07KjgcaFliUPeEZJyEq7XMyh6ucU
         Yc88AwRGXIr2QQnnaRdmesvLl+NC5b4cE2tHZw1Q3rV1FkgUk4ddwxaJPORMafqZTZGM
         Lfu/KqeRcUelUQaHhtVlJsEgETJxfHCBdPlCUWRlxrhKNeZIvVjHpAXQP/vbSEpgeZVX
         3YuBhigVaD8OoaRBi/qAnirluZiJeDBkN84/BcxE/lbE74/pzC9BFRDNEVsqBPw+MLKW
         3bQjPSb+tPWjrB2/e8cEf1b3qupIMQLTxLsFTSUWSqU24X6+h4kws3T/nI2Jo8nrFMCv
         61Bw==
X-Gm-Message-State: AOPr4FX966WfjT0ugWpbeM+zvIt/nue0xz2PzxEM0BA98TWrfrbONKqmuL4jRu7qjCsGqFqO918gkI0ZAbT/qkqJ
X-Received: by 10.107.53.204 with SMTP id k73mr19658889ioo.174.1463415189966;
 Mon, 16 May 2016 09:13:09 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 09:13:09 -0700 (PDT)
In-Reply-To: <CAPc5daVH_qveYBnxybvZYTuVKNBhG7PnJxeY9f8zVXqNxpvzVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294751>

On Sun, May 15, 2016 at 9:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Sun, May 15, 2016 at 8:31 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, May 15, 2016 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> The double-loop wants to do an early return immediately when one
>>> matching macro is found.  Eliminate the extra variable 'a' used for
>>> that purpose and rewrite the "assign found itme to 'a' to make it
>>
>> What's "itme"?
>
> item.

The code looks good.

Thanks,
Stefan
