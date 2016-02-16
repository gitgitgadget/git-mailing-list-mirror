From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 05/18] convert trivial cases to ALLOC_ARRAY
Date: Mon, 15 Feb 2016 23:22:12 -0500
Message-ID: <CAPig+cRTz4Fb10JDWLjmTEXzQ+FbvmKU51A9B3vmwBepDX+BYA@mail.gmail.com>
References: <20160215214516.GA4015@sigill.intra.peff.net>
	<20160215215154.GE10287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 05:22:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVX9W-0000ZL-GA
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 05:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbcBPEWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 23:22:14 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35485 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbcBPEWN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 23:22:13 -0500
Received: by mail-vk0-f45.google.com with SMTP id e6so123001481vkh.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 20:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bapDoUFzWwYGpTWnNAyvqtp9CTDYtXI/Kzg5f161dRg=;
        b=huXtM49r6pRjiyc5KEageETCyOtDt7TwCCVnOsICN1CdeNZ7y63QgD4hjngm/amx5a
         Bbb6BA3cUGcgrSY4Me7e4EDvId1Hxo+ziAMKMpX2r8sNHlTr1Z/eAy2Pq07+Q1UpyIOs
         MS3czPrSP//i1QRx15oAa6EdTZLQZ3RiQfdQd7FOzpdy349UiSu3H/LptiuUF6RKfa5X
         IQTWnKHNvG0wJdCwH8vQwZnDXP8mjhc71V2/DuPyqB8kmABpMe05l8RtdcCJGlh+fAm2
         Zq3RmIVbWtoiZm1BJwnS6vgv0C0MsjoN+m7iL4VQMueMTFUyRfl1AjzbcfaAEYby/Qyn
         OOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bapDoUFzWwYGpTWnNAyvqtp9CTDYtXI/Kzg5f161dRg=;
        b=I7FKgfDVAVPQsn0UamI7UhpKm29j/UgpygDseOAfbF1EZie1yA16R6z8IFhv7aveQQ
         5xkUCB+E+4e2lpxDDD7MVUHb3+qlfbABPOydFKugM1/kJU/K9iyHD8k2qB6CzbU2JRNe
         UE043Bfz4NhqGigWw83WvQwrbtP7ot279rNEngmqJhmXp8+plVYoxsolec88IAgLArNn
         lDka/A9V6GG7ImtfPEwRgb32LVXXWpJ2uP+V6UFxBw06+oJfQ+/RboKpqU4EPDg3MZKh
         11dDr3PKnzIKUnMvMq1klhvtGWa8JkeFhsaKfR9fxnbPvx35dAzpDCY04H6gGyDm3Bod
         JCVQ==
X-Gm-Message-State: AG10YOTqunY1VKI7ylK95f5p3x0NhNtXGGKi2rA/ZYwsaPAl7Tf+fK3MZ7Y3xAvvev9FmOfgE7p3CakP15FnqQ==
X-Received: by 10.31.141.2 with SMTP id p2mr15992974vkd.37.1455596532492; Mon,
 15 Feb 2016 20:22:12 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 15 Feb 2016 20:22:12 -0800 (PST)
In-Reply-To: <20160215215154.GE10287@sigill.intra.peff.net>
X-Google-Sender-Auth: O5rhJSvHmHsPDa4rj_qvs_AR4SI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286316>

On Mon, Feb 15, 2016 at 4:51 PM, Jeff King <peff@peff.net> wrote:
> Each of these cases can be converted to use ALLOC_ARRAY or
> REALLOC_ARRAY, which has two advantages:
>
>   1. It automatically checks the array-size multiplication
>      for overflow.
>
>   2. It always uses sizeof(*array) for the element-size,
>      so that it can never go out of sync with the declared
>      type of the array.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 77a51d3..0eabe68 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -854,7 +854,7 @@ static char **get_path_split(void)
>         if (!n)
>                 return NULL;
>
> -       path = xmalloc((n+1)*sizeof(char *));
> +       ALLOC_ARRAY(path, n+1);

Elsewhere in this patch, you've reformatted "x+c" as "x + c"; perhaps
do so here, as well.

>         p = envpath;
>         i = 0;
>         do {
