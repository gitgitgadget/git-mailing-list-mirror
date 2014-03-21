From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] builtin/apply.c: use iswspace() to detect
 line-ending-like chars
Date: Thu, 20 Mar 2014 22:48:52 -0400
Message-ID: <CAPig+cTw8pyRVOHToGRPBdxv+TX8Vcj5OrX-CmLWRCigZRS4MA@mail.gmail.com>
References: <1395344384-7975-1-git-send-email-g3orge.app@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: George Papanikolaou <g3orge.app@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 03:48:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQpVy-0001su-AT
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 03:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933732AbaCUCsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 22:48:54 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:40780 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759621AbaCUCsw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 22:48:52 -0400
Received: by mail-yh0-f54.google.com with SMTP id f73so1831868yha.27
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=LRxyYyAGQM5Zi6Zb4pOhZjKck9bcqG6pw+jZx6CNCOA=;
        b=HAgpCeK48oD4I6n3G/Je018S3wfYr8VjK7S7J71Q8Ox4+8xxIEUmj/Ye+KJI+CV/o2
         3e/Q5EXu9QMsdBB/pctYUCRXDbU8Jvho5yVerksYxMd7MQwFTZeGQdu0nChFdPmTYGgU
         pYX8uLqBmCAHMBPiD6sGyj7sViOR/fUYHvhliW0ReCVBWKjT81urg/oCobte3KoAW9qy
         gguVeLd6W+7sls9a1MI2EzI77TVkCGkTWMRTOldG15rdNI+wSDZNYg7NI1gIEh/ZQNkZ
         fQwJxmDz74B3w1iENBQtxuqsJpTgwNvmyVv486lpzM86HrNeysWLDGWVk1TD0Bbtlmhs
         uBOg==
X-Received: by 10.236.83.194 with SMTP id q42mr39230160yhe.56.1395370132216;
 Thu, 20 Mar 2014 19:48:52 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 20 Mar 2014 19:48:52 -0700 (PDT)
In-Reply-To: <1395344384-7975-1-git-send-email-g3orge.app@gmail.com>
X-Google-Sender-Auth: CJWBusHrAlDiLRchoJyNms2So3g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244630>

On Thu, Mar 20, 2014 at 3:39 PM, George Papanikolaou
<g3orge.app@gmail.com> wrote:
> Removing the bloat of checking for both '\r' and '\n' with the prettier
> iswspace() function which checks for other characters as well. (read: \f \t \v)

Use imperative mood. "Remove" rather than "Removing".

Bloat? Prettier? Subjective stuff.

Did you verify that it is safe to strip all whitespace characters
rather than only line-endings? Perhaps say so in the commit message.

Why the choice of iswspace()? These are normal-width character
strings, so why apply a wide-character function?

More below.

> ---
>
> This is one more try to clean up this fuzzy_matchlines() function as part of a
> microproject for GSOC. The rest more clarrified microprojects were taken.
> I'm obviously planning on applying.
>
> Thanks
>
> Signed-of-by: George 'papanikge' Papanikolaou <g3orge.app@gmail.com>
>
>  builtin/apply.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index b0d0986..912a53a 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -295,9 +295,9 @@ static int fuzzy_matchlines(const char *s1, size_t n1,
>         int result = 0;
>
>         /* ignore line endings */
> -       while ((*last1 == '\r') || (*last1 == '\n'))
> +       while (iswspace(*last1))
>                 last1--;
> -       while ((*last2 == '\r') || (*last2 == '\n'))
> +       while (iswspace(*last2))
>                 last2--;

Doesn't this change turn the comment preceding this code into a
half-truth? Perhaps update the comment?

>         /* skip leading whitespace */
> --
> 1.9.0
