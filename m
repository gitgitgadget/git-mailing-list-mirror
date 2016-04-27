From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 47/83] builtin/apply: move applying patches into apply_all_patches()
Date: Wed, 27 Apr 2016 17:51:33 +0200
Message-ID: <CAP8UFD0Q3USKhXMZrxTxQc0hr3kjBP517_KBqc7CS--4eTbJww@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-48-git-send-email-chriscool@tuxfamily.org>
	<CAGZ79kZ4UprHxtmO-rgiOo=od0U2nraq6m6wYcm_g87bsrL-Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 17:51:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avRka-0005hL-3H
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 17:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbcD0Pvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 11:51:35 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37668 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbcD0Pve (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 11:51:34 -0400
Received: by mail-wm0-f49.google.com with SMTP id a17so21908434wme.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 08:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=/7nROWzpq4jtHDEBUYvv1MW+deJZspGDLHoiG5n73Vs=;
        b=n3P21PZSccfxxs7H/awMjDLZ4zZRZ0ApvtgqvuT1FD9AZnl4fO9XeK5JZpdRmSOsuk
         q4FfyHC9tvEXDlmbAeVPx/kkXDG5QVORM3auVTuTiqGiFPTsrQ8LAviDav7eyah1ybJn
         6nCGuHE582nm/pVCvPt3iltDgRZREjVrX9hte5AxhmJJgke4jwJlLG48Y5ljUzP0Kybe
         l2N9OsydGwsRdRPNXzLWDpLpOsUUqNodjS5Q610NAawr5eQSp07WLsAHZ7FfafaMfcSy
         gm6BaiJ3USNg/EzXf12BynX+gpuReuXbED2GfuKIKfSppsjY9ANnT2Zv9K2rUo0eCF9Y
         +yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/7nROWzpq4jtHDEBUYvv1MW+deJZspGDLHoiG5n73Vs=;
        b=X4U89Rl1PNUur97wfOGzFyeSQAhIfy54yOk0SmBGN/mvOGdQLpqU/3mHIKWhg6LZl7
         yHryrvNz16XY7ek4ykiLFYb3zRN5RK7NRYTx2iojxMarLtwl1S88NkvSnul73T2MifLR
         mCjnX6APMxnFnGJ8z8puGXFyrxYyfK2EUHy3tQWtjifGaqKPJPYhypXGvs3N84KRqI9w
         Dzn/nP1aBbAiTP1qKaITziz7ACW0CQUZtB3XHpCpf19ZMI2M3DbnWGd9TsCUJT4EcOXC
         z6TbyeLITQyHfzwgMeVmhPo98VVhHHIjcxutpTZeAxE6+SFk7DNrNPrt+GEJv+i+wDGI
         bS+A==
X-Gm-Message-State: AOPr4FXTiF0bnYDgibBogUN9iJi/9wVwcm+4hfAAX3n0qZAmnFiw4UIvJ9zdlZCq0wdGNmZ6g+vwurUKrR0T0g==
X-Received: by 10.28.128.83 with SMTP id b80mr11311503wmd.89.1461772293448;
 Wed, 27 Apr 2016 08:51:33 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Wed, 27 Apr 2016 08:51:33 -0700 (PDT)
In-Reply-To: <CAGZ79kZ4UprHxtmO-rgiOo=od0U2nraq6m6wYcm_g87bsrL-Wg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292736>

On Tue, Apr 26, 2016 at 12:00 AM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Apr 24, 2016 at 6:33 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> Up to this patch, have a
> Reviewed-by: Stefan Beller <sbeller@google.com>
> in case you want to split the series in here (as indicated in the
> cover letter, this was the last
> patch rerolled, the next patches are new and may need more discussion).
>
> I had some nits, but they cleared up in later patches.

Thanks for your review! I will add your Reviewed-by in the next reroll.
