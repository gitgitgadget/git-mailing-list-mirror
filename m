From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/2] git-bisect.sh : create a file if the bisection is in
 old/new mode, named "BISECT_OLDNEWMODE", so it can easily be seen outside the
 program without having to read BISECT_TERMS. This will have to be changed in
 further versions if new terms are introduced.
Date: Fri, 5 Jun 2015 22:24:48 +0200
Message-ID: <CAP8UFD1OSSxfQOLggRv-VjE-8U=Vg7X5oe_UeFi4_yqOfXvgPA@mail.gmail.com>
References: <1433522061-14532-1-git-send-email-stuberl@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	remi.lespinet@ensimag.grenoble-inp.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	j_franck7@msn.com, Valentin Duperray <valentinduperray@gmail.com>,
	Thomas Nguy <thomasxnguy@gmail.com>, lucienkong@hotmail.com,
	Christian Couder <chriscool@tuxfamily.org>
To: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:25:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0yAh-00043B-BP
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 22:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbbFEUYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 16:24:53 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35278 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbbFEUYt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 16:24:49 -0400
Received: by wiga1 with SMTP id a1so31823858wig.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Kz6pU6tkPNJTKJOOXGD7FjaAKa3SlgFubZzdbkjKcGM=;
        b=N5jIswqEk0gHUg53VtHWJoZu/+6uxKfZMbHITTlGNpZh6bNcr4Tc3OWt2XIB1J0Wco
         ifpiWWnGVWGI3/f/VrWfCNhJr68hejC2dxEJ/4OAvOV5EVOoGnA+AQFWPa77oMRbHYha
         8C1vHAcsEOLqFLiT6yQsEthAttH5s8E0EqyU6n1HY/+VFapNUuU5WKA5dKapkXKzJLq2
         0c/yOJ3C1m6BT5Q4XIAVWTF0ywuoWKYkBPthBhHppsW1UwskHCa4f1MxUhX8fHuwzW2V
         8LvRXql5OvedeXJdzvZ7AABtvpn11cmwFXv4k+MxD7MSxkKnP50I2xNmrk8wXdAKMtQK
         TQ8Q==
X-Received: by 10.194.95.132 with SMTP id dk4mr9725815wjb.88.1433535888710;
 Fri, 05 Jun 2015 13:24:48 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Fri, 5 Jun 2015 13:24:48 -0700 (PDT)
In-Reply-To: <1433522061-14532-1-git-send-email-stuberl@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270890>

On Fri, Jun 5, 2015 at 6:34 PM, Louis Stuber
<stuberl@ensimag.grenoble-inp.fr> wrote:
>
> Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
> Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
> ---

It looks like this patch applies on top of the bisect old/new series
posted by Antoine.
This should be stated somewhere.

>  git-bisect.sh |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 109bd65..d3d19cb 100644
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -183,6 +183,10 @@ bisect_start() {
>         then
>                 echo "$BISECT_BAD" >"$GIT_DIR/BISECT_TERMS" &&
>                 echo "$BISECT_GOOD" >>"$GIT_DIR/BISECT_TERMS"
> +               if test "$BISECT_BAD" = "new"
> +               then
> +                       echo "" > "$GIT_DIR/BISECT_OLDNEWMODE"
> +               fi

I am not sure it's worth it to have both BISECT_TERMS and BISECT_OLDNEWMODE.

Also please note that I suggested to Antoine that the BISECT_BAD and
BISECT_GOOD variables be renamed to something else, like I already did
in some C files.
