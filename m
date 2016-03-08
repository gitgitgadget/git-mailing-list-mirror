From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/15] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date: Mon, 7 Mar 2016 22:04:23 -0800
Message-ID: <CAPc5daVvD53KcX3RQkLiUtc5fe+hksYtQw7dK5+C=1eQdTT24w@mail.gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
 <1457265902-7949-3-git-send-email-Karthik.188@gmail.com> <xmqq7fhdoqd3.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZSFD39HXSw8jo1=ehiKpeqjLUSfc0NkRJD0BSbqAvDwuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 07:04:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adAlE-00041Z-9Z
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 07:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbcCHGEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 01:04:44 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34268 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbcCHGEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 01:04:43 -0500
Received: by mail-yw0-f195.google.com with SMTP id f6so329499ywa.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2016 22:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=p0csZiUF+e+zyE0GRS2viI5PiEhs7qiSK3aVPy+uLGs=;
        b=0RTxs6DOj8xoX4nvvB4510QutmfnyekMl1V3UzbzXQyYnUC7OcV74ZqsQ+1e6Hum87
         nCYMIT6AxRox2pb96Rpo/b8+JHFN8b0C4VxVuugZdhbM0Cu+PTskh+TfAbcSOhYHtkI0
         6JcHFyEv5X84nmmFYv2ZDDvJ/XJJEF+MfcxnCptwmMK/u0+AkjBn7rDt4f0zwO2U8DJA
         VCsfx4vRYCfUWFrkT8je0DJ7pCbPQg1n5/Say78Ecu1UuP0gunuDcDeDmR0nSviC19+c
         7VN348H+TOBnT8mkVPi0U/914z1qYb7EwcHICe+EXeIhDZo/hdffgcamyN8vj5dEbQTo
         Tnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=p0csZiUF+e+zyE0GRS2viI5PiEhs7qiSK3aVPy+uLGs=;
        b=Aoqwc91MP1aN6Fofwb9UQeYK/+eHyWlsLQ664oW211C1ZDNe60wi6NFlJJjJAOfQ6q
         rexi3oCxiAVqfrTfGhk6MLeIUpC3kJ9542tl1T9D6eg/tMM25RA7vZDRFoQZWaCAW6+M
         6F9+qqVyb1uhzDgNPfAKTSiQpx0H3hVgZFQ9SQRMAfPyjXBgGhEBSuEDKKa03Vyzisnm
         Zl9SSYgAgZYpz/pQct2Qg26sv3RxrLiZHVRYCVYG+7hPqDELaGip1UuyfjOk3VQOTzNf
         REIbuepL8NkMm6sC9NM8ZDJ14TeZx8lly/tCY8BHzad5zWU82K2rUcYsCKPZIqDmdZoS
         VSxg==
X-Gm-Message-State: AD7BkJI+VKwuG2mYJp0GMYB8F8HHw4y2KuGRmIwjXXDrvSmmQ0qiKh2NP9H/dzzZ81m5n6qDP49iOGga8H/naw==
X-Received: by 10.13.245.135 with SMTP id e129mr16330505ywf.106.1457417082565;
 Mon, 07 Mar 2016 22:04:42 -0800 (PST)
Received: by 10.129.116.131 with HTTP; Mon, 7 Mar 2016 22:04:23 -0800 (PST)
In-Reply-To: <CAOLa=ZSFD39HXSw8jo1=ehiKpeqjLUSfc0NkRJD0BSbqAvDwuQ@mail.gmail.com>
X-Google-Sender-Auth: 0IjK_3TTzIbZCQPQShqQ3WxqM0k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288418>

On Mon, Mar 7, 2016 at 9:41 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> You're correct, the "handler" functions run once for each "ref". But WRT
> to the %(if)...%(then)...%(else)...%(end) atoms, it needs to be. Because
> each outcome of these atoms depend on the current outcome of the fields
> used between then WRT to the current ref.

Yeah, there is no argument against that part at all.  My comment was purely
about preparsing the if_equals field. All other fields are preparsed in *parse()
helper functions and it looked strange that only these two are scanned in the
handle() function every time it is evaluated for each ref, only to yield the
same result.
