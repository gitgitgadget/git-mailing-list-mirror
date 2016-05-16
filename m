From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 01/12] commit.c: use strchrnul() to scan for one line
Date: Mon, 16 May 2016 16:19:45 -0700
Message-ID: <CAGZ79kbeXCsCs35hva2FWUhOD2F37ZDrzupEZLGBVbqnMxPjXQ@mail.gmail.com>
References: <20160516210545.6591-1-gitster@pobox.com>
	<20160516210545.6591-2-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 01:19:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Rnm-0005YT-3q
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 01:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbcEPXTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 19:19:47 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34782 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbcEPXTr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 19:19:47 -0400
Received: by mail-io0-f172.google.com with SMTP id 190so2592409iow.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 16:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=X22HoZp8XpO5rszMl/i5h7l4gsuoeaUrcLdH+3dKJg4=;
        b=WEMR670KtfIC75ww0vEzAIotsm9jNZvBI9dfuiaTxCa33dtkHBglFnAyWQ1NhzIhDe
         gThUPIl2JBni0UF6GFOzJw8iaYUxhpLBfXmDHdMrI1PSWUoyXFdFvkRQt8frWhLCLc+s
         krpoLHmU2xkk/Mk6dCG01FyZ29aigdhfd0YGD/ynxhqwmKGX3DcwDHr46W4r7LpsEevr
         w6PllTirW9KmvPEUzAs/y1XiqryGaLY6aBexkT+pH1fMC81W4YYE9jkkOyN45XzHoKH7
         HlTfJV6vT6ZkYDFyNtxWgsC+XcJPce0Cfx3u5m0L7opz2dsfYWsij+RLTukHsVT7HCMK
         UXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=X22HoZp8XpO5rszMl/i5h7l4gsuoeaUrcLdH+3dKJg4=;
        b=W7ANv+TEnUEFJxdGZgkh1S4bsNsalNs12XendTjx5/RFk3ojeuNfnICSYPdV0lB98A
         xS2NrDDz5xNMS6W/j4+Qs63RbW6fwBjY15bsCDcr4TmUr89PPRDBqE4l4ancAGPfrfb+
         yqzWM26n8upxZMLoPFY3kQbkroIZzVhIvmf5Wj7ubMYMsaDOPQ/DfzIYhQLCjY+9o89x
         ighykKsJNThm7103lExfnY+ag74ksmfR3NPpql3/MRiQCfVqco9HvB+joAK07DSltdmp
         8+HFIvxFMc2coFJpUYxS2u3IWT0iJw/qsO1pgwrZRPQWx156mJs7BAKL612aoMVX0kGT
         tTBw==
X-Gm-Message-State: AOPr4FXfcxvta3yq0Nd+bvCYVfotoP1TWcaS5mxpcIoVWWdPzgSwgiZSllyHyoup46ZrOfCb5W+oXjyzLeGIWgaB
X-Received: by 10.36.253.9 with SMTP id m9mr11828441ith.52.1463440785983; Mon,
 16 May 2016 16:19:45 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 16:19:45 -0700 (PDT)
In-Reply-To: <20160516210545.6591-2-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294815>

On Mon, May 16, 2016 at 2:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  commit.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 3f4f371..1f9ee8a 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -415,8 +415,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
>                 p++;
>         if (*p) {
>                 p += 2;
> -               for (eol = p; *eol && *eol != '\n'; eol++)
> -                       ; /* do nothing */
> +               eol = strchrnul(p, '\n');

Nit:
You could include the +2 into the arg of  strchrnul,
such that you can drop the braces.

>         } else
>                 eol = p;
>
> --
> 2.8.2-748-gfb85f76
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
