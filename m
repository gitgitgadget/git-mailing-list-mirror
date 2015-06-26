From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v9 4/5] bisect: add the terms old/new
Date: Fri, 26 Jun 2015 06:11:57 +0200
Message-ID: <CAP8UFD1EWYzg7-O4BDgUTQPJOoo6TEAF49amakgfR8K6CX886A@mail.gmail.com>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 26 06:12:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Kzk-000273-Hh
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 06:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbbFZEMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 00:12:00 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37846 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbbFZEL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 00:11:59 -0400
Received: by wicgi11 with SMTP id gi11so6515226wic.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 21:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cVCQU5Qmgi529T/QBSOzkRokANuCHJmVH3vgJvGVw9s=;
        b=WvpJIDr1Oq3F6qJT5NiWlOV0IHh0Gzj+zYExpnoWIwZ144Fft43/FvReo2ycJRs+eM
         rwX+IyrboZLipqqJwwrKqdSAtdUrPFbf0TnMseJ/qMMO+1ccwjm0W9GVrtx1aVFTxgqW
         yvpYq1p9HBYEJ1vy9S6aWPDLlDNft2PU7gW/eqYPgVOtXkqxn8aUL+Ku+M2UwvP9lqJy
         Wyw4xAlH5cnw/CoIufNCAYoio9UWxjtK5I8rPXbH9deSiTfRPd5g5fKAh6CLYS4xm2r7
         M5N49jZLdXUxtaVCRhIq2I1HZEgBUU1FFcJADHBQFmevWL3bzUpyHODK4m6/j3otcsZY
         /PnQ==
X-Received: by 10.194.2.68 with SMTP id 4mr83835140wjs.82.1435291917963; Thu,
 25 Jun 2015 21:11:57 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Thu, 25 Jun 2015 21:11:57 -0700 (PDT)
In-Reply-To: <1435258257-29047-5-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272759>

On Thu, Jun 25, 2015 at 8:50 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:

[...]

> @@ -178,7 +183,7 @@ bisect_start() {
>         } &&
>         git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
>         eval "$eval true" &&
> -       if test $revision_seen -eq 1 && test ! -s "$GIT_DIR/BISECT_TERMS"
> +       if test $must_write_terms -eq 1 && test ! -s "$GIT_DIR/BISECT_TERMS"
>         then
>                 echo "$NAME_BAD" >"$GIT_DIR/BISECT_TERMS" &&
>                 echo "$NAME_GOOD" >>"$GIT_DIR/BISECT_TERMS"

You are writing BISECT_TERMS here...

> @@ -543,14 +548,22 @@ check_and_set_terms () {
>                         fi
>                         NAME_BAD="bad"
>                         NAME_GOOD="good" ;;
> +               new|old)
> +                       if ! test -s "$GIT_DIR/BISECT_TERMS"
> +                       then
> +                               echo "new" >"$GIT_DIR/BISECT_TERMS" &&
> +                               echo "old" >>"$GIT_DIR/BISECT_TERMS"
> +                       fi
> +                       NAME_BAD="new"
> +                       NAME_GOOD="old" ;;

...and here nearly in the same way.

So perhaps you could use a function like:

write_bisect_terms() {
      if test ! -s "$GIT_DIR/BISECT_TERMS"
      then
            echo "$NAME_BAD" >"$GIT_DIR/BISECT_TERMS" &&
            echo "$NAME_GOOD" >>"$GIT_DIR/BISECT_TERMS"
      fi
}
