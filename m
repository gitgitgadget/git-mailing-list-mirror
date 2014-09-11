From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 04/32] rollback_lock_file(): exit early if lock is not active
Date: Thu, 11 Sep 2014 12:13:16 -0700
Message-ID: <CAL=YDWn_PAbO5T+WFPTcFSVCvNp5EUd6egv76RQmheFYiMpPPg@mail.gmail.com>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
	<1409989846-22401-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 11 21:13:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS9o4-000679-S3
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 21:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbaIKTNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 15:13:19 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:49803 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbaIKTNR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 15:13:17 -0400
Received: by mail-vc0-f172.google.com with SMTP id hy10so6999945vcb.17
        for <git@vger.kernel.org>; Thu, 11 Sep 2014 12:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xSYWaKUJdTnXf4eSqpO6zphP6M5MD8HtRFkG4FCjz6s=;
        b=bofGwbnOv3RYSQTzqO7NEl6wdsWa30D7zKgLVjLePSSaHaBL7MQn6w+AUiaIF0fhEa
         b6EncLGjaeniaxYXirL0chvXuz7zarBF8RZrvTjdNJ4qK93AHUFJQiC2mHuV/6MrOVF4
         2NNRhsHKedXjRehXUkNm9NXjRnVHfOK6HCEEzRlsYAaDtqtR/ZxfdGRIY4dNIgWMaulY
         CbX67J6Sy5A44+iTQ8kEz5RmxpdEMrlOhMAYmDTVh3HmYPsYES+j54xMogiTPFUPzsS4
         HKKM1emgqz1RWj5cVCa9mrsAADW15iRtJxwiFExHS5ERELNwOCZOstUhk8MwJAo1Z4HK
         yW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xSYWaKUJdTnXf4eSqpO6zphP6M5MD8HtRFkG4FCjz6s=;
        b=TNiqjQ/ZE91gqiQ2Gfreb7erHaSmJbTk6/LjLsTU7rBlZWtyekAW4ut5ogYlXPtg6M
         61J5UxH4OoThe6pe///s9kiWqAQW4kETEmHnb2LgK3ZTLJ0uJObnGWlrZWtADJpfFi9t
         IUsLVz6XV5mIeKUplT+o2IUu8UX5cmCkiLPaHx9I2bQdt244vmAuO33MLZ3fQho3jHUH
         yMPdsRxYg3irdP86TR/R+spSEMnv7MP53eFi8eMqXlhJY+bWPunBSQ/FDrGCEpRjDAAP
         /OpNp0i/iVggA4CkedF8SqR65ucYfA7CwoxoOCCS3PPQQM3EaNSjwR13BGiqc6jkAFAy
         dd4A==
X-Gm-Message-State: ALoCoQk1/BhWPdK+ZTjWdUnvzZkJYS6OvdfHTvV5pLImrODj1T72L/JZ1RI7XitVF5Q5RK5PSWFm
X-Received: by 10.52.51.203 with SMTP id m11mr2060723vdo.72.1410462796554;
 Thu, 11 Sep 2014 12:13:16 -0700 (PDT)
Received: by 10.52.231.232 with HTTP; Thu, 11 Sep 2014 12:13:16 -0700 (PDT)
In-Reply-To: <1409989846-22401-5-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256863>

Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>

On Sat, Sep 6, 2014 at 12:50 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Eliminate a layer of nesting.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  lockfile.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/lockfile.c b/lockfile.c
> index a548e08..49179d8 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -272,10 +272,11 @@ int hold_locked_index(struct lock_file *lk, int die_on_error)
>
>  void rollback_lock_file(struct lock_file *lk)
>  {
> -       if (lk->filename[0]) {
> -               if (lk->fd >= 0)
> -                       close(lk->fd);
> -               unlink_or_warn(lk->filename);
> -               lk->filename[0] = 0;
> -       }
> +       if (!lk->filename[0])
> +               return;
> +
> +       if (lk->fd >= 0)
> +               close(lk->fd);
> +       unlink_or_warn(lk->filename);
> +       lk->filename[0] = 0;
>  }
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
