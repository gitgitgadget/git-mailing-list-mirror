From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 02/12] attr.c: use strchrnul() to scan for one line
Date: Mon, 16 May 2016 16:28:54 -0700
Message-ID: <CAGZ79kbSFp5e6-AeSbqk4hFxcuzTo-4oSG_z5nGTpAY0uvLAuw@mail.gmail.com>
References: <20160516210545.6591-1-gitster@pobox.com>
	<20160516210545.6591-3-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 01:29:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Rwa-0001Lz-OX
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 01:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbcEPX24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 19:28:56 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34355 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbcEPX2z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 19:28:55 -0400
Received: by mail-io0-f170.google.com with SMTP id 190so2795888iow.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 16:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=GiZKoxQZpWivViz3JjjCNIBa7xgD/A9zOBogCIJ8aus=;
        b=UknASrpaYh+674WBcjX7BzVDGKa7t4ROd6AWDQCa5ufLpn1rvyGJ2Zg0rRXgfmhdE7
         wvlDbSodOjFF6TUTW3CGEbcyFP3wlv2iK0cy4V5Cjr2i34BgjSMUx3DQpyhE8ZfwMJe3
         HfewZbxMR5bKkq8jSC0sMPdWc4Gb13encCUqd8mlDqfOCVMFQj6uKvduOGRBIwVhfWr4
         2U21DtwTzvcfX1UJVm0dUJ1nga663KYDJX2mScBgicUTwKp7Mlec/I1AhUnDDmKyybtm
         gf8rWWqSUId3ipfhbfeo3vYnGH83TU+6eaYxWyJ7h3PmM/JG8L7gJEkcPzAL8FY+ZoZJ
         qvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=GiZKoxQZpWivViz3JjjCNIBa7xgD/A9zOBogCIJ8aus=;
        b=ek97kL715n0d1/2YbedZ5pY0ccTQgRoXUUURI/e0FZXkY0rXnwhxhjvUBTs+1oSimT
         K6LzZ8jS+9eQy2VxFoh8euejQt7BKye4K6EWeOHCRkUe19dsZoT7tpZRSfX6m1ImelPi
         YLfdOZHaX/qo8BgQ3tJyPf7R9zRiUlba7/H6Sdp4kJLjfMnFntBzl1Cd5gd33od1WhBw
         0TI9AxRTVyNT4ae3WgzpCSwLMuGy615Z/GBuYuU8KVKUUr6GkW4H51gz9tSxenqyw3KT
         2pEQqUSpakXCdXKnTUt7XOJ7wlSUwnOF6oNqZxji855V4IW/a7GYFnQSWcCD7J3dC6Ba
         5eWA==
X-Gm-Message-State: AOPr4FXnFHJk5GHIhyVa5LRBOHRsL/upxQRIWVgq+Kfb30pC5Br7A7TT3uixFp9h0vWF3+2H1GBUkatiDbIa4TpV
X-Received: by 10.107.53.204 with SMTP id k73mr20858262ioo.174.1463441334891;
 Mon, 16 May 2016 16:28:54 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 16:28:54 -0700 (PDT)
In-Reply-To: <20160516210545.6591-3-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294816>

On Mon, May 16, 2016 at 2:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  attr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index eec5d7d..45aec1b 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -402,8 +402,8 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
>         for (sp = buf; *sp; ) {
>                 char *ep;
>                 int more;
> -               for (ep = sp; *ep && *ep != '\n'; ep++)
> -                       ;
> +
> +               ep = strchrnul(sp, '\n');

(Even lesser nit as in patch 1)
You could directly assign ep and more when declaring them.

>                 more = (*ep == '\n');
>                 *ep = '\0';
>                 handle_attr_line(res, sp, path, ++lineno, macro_ok);
> --
> 2.8.2-748-gfb85f76
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
