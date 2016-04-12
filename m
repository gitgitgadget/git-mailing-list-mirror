From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 11/21] bisect: use struct node_data array instead of
 int array
Date: Wed, 13 Apr 2016 01:02:53 +0200
Message-ID: <CAP8UFD2foPEUXDD4_Y8K6hN1bWLJk11iqYXS=tM+M3eF430o7A@mail.gmail.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-12-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:03:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7Km-0002sL-I4
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbcDLXC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:02:56 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33413 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933991AbcDLXCz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:02:55 -0400
Received: by mail-wm0-f42.google.com with SMTP id f198so206117399wme.0
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 16:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=0kRHAaTwk2iDNIPQewhsxba8jCj6MzWRvJExURYbCSs=;
        b=iRZ9fBi7cP8ObvqicFy9skbSwmJU7xj+oVlF+xz/O1Nk7qYx9z6ZMz/ykcNLIkmLt0
         plyXJIGEsHFZesRyTbUmikWcaVDBuNaVraw9l9uXkviPgrZ78T5eLbLNYm2F0Wz/Vd+O
         LttO1LTa0bAlQkw9JDHsopDb3PjeP1vdZnlrH3luqfbmFSpNBrdbJ5UpBzDm+c2W+Hr6
         /r9v/uolqazXTP7eRfKeW/u0Lyx4yJ/sD+RmKTdetyJ6yYfPA9qgiL9NNrLXGc4wMyNS
         Qxouq/KGP5M+ooeCU5YplSXzZT5k1yuKSFr3R/2IoU31XlUvKf13KSRUM6b5r8kH+xJO
         ayvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=0kRHAaTwk2iDNIPQewhsxba8jCj6MzWRvJExURYbCSs=;
        b=KOAOAw23+EV+YuO75TX9Emep5PEPhn+xMvH3D080mPqfRbtAHMEoXfe5HePvKlkoSU
         liL8K83fGAB4WtN0ShDLFi2GQ/vnD6J5pfQ0N31n6XSOACl7EO3MbV3fLOtUHdAo1zgT
         +G51t7vH/2nbfpIoZvK7ebWynHQafXsG2GP5meD+7gubj5sQ0+GxutWy4bQdrIVv7/ha
         ncNbqHfDoRpCGtGl+mnC6Bcc/TKSmMYwKCzgfzgUL8KURcNvlk3SP2U+CP8Kli4yxhIg
         sXXSluu1pniinUazsTmnbmkYGtCwzMYgEwhOh4tstQHVEoylyVCxsYBZMN3mH03qdsKK
         HsLw==
X-Gm-Message-State: AOPr4FXoCzVgyc+GiZJRiNIkUOx5c+ZJgN22m/XHTD+3HtOjLWiRPTGilUdOaa2SUz5b89XFhGFUNmz3p8E5fA==
X-Received: by 10.28.26.73 with SMTP id a70mr7051473wma.89.1460502173536; Tue,
 12 Apr 2016 16:02:53 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Tue, 12 Apr 2016 16:02:53 -0700 (PDT)
In-Reply-To: <1460294354-7031-12-git-send-email-s-beyer@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291315>

On Sun, Apr 10, 2016 at 3:19 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
>
> @@ -321,14 +321,13 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>                          * add one for p itself if p is to be counted,
>                          * otherwise inherit it from q directly.
>                          */
> +                       node_data(p->item)->weight = node_data(q->item)->weight;
>                         if (!(flags & TREESAME)) {
> -                               weight_set(p, weight(q)+1);
> +                               node_data(p->item)->weight++;

It is not so easy to see that the above does the same thing as before.

Maybe review would be easier if this part of the code was simplified
in a separate patch and/or if the weight() and weight_set() function
were kept, maybe like this:

static inline int weight(struct commit *elem)
{
       return node_data(elem)->weight;
}

static inline void set_weight(struct commit *elem, int weight)
{
       node_data(elem)->weight = weight;
}

>                                 counted++;
>                                 show_list("bisection 2 count one",
>                                           counted, nr, list);
>                         }
> -                       else
> -                               weight_set(p, weight(q));
>
>                         /* Does it happen to be at exactly half-way? */
>                         if (!find_all && halfway(p, nr))
