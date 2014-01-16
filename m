From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH v4 1/6] submodule: Make 'checkout' update_module explicit
Date: Thu, 16 Jan 2014 21:07:22 +0100
Message-ID: <CALas-ig4=qKqpopaP163gVdBG39seWH61qqA5Jx0CR6AZkE6ZA@mail.gmail.com>
References: <20140114224246.GA13271@book.hvoigt.net> <43e8f3bfdaffefca9edd7a23574816630690e1e5.1389837412.git.wking@tremily.us>
 <xmqqwqhzzrw3.fsf@gitster.dls.corp.google.com> <20140116192252.GT2647@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 16 21:07:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3tEC-0005f8-KZ
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 21:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbaAPUHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 15:07:45 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:50685 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbaAPUHn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 15:07:43 -0500
Received: by mail-oa0-f52.google.com with SMTP id o6so3524310oag.11
        for <git@vger.kernel.org>; Thu, 16 Jan 2014 12:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0CZZ2YEi1/P8BEZVbZjlx+oTNO6/aakRulgK0r9B5W4=;
        b=x+u3FYPUgBiot+oK9KFwEYH2yoL7s/uGCiJnRhsgt2xSbH+fxRxisyTRT/WpQyrKuA
         LZBmIl8OozS9rm5EYBhoLyKUkD9wDAoQKbkKDZxpP4dI3pptE+0OtaGuIV9CgFKSGD/q
         Fmvmp2+f42qZ47y3btXF0kDsIfbkMyfYsWr1pSmPY5pjHObVh/BzQwFpfRM1vYtuG6OM
         InvwVtLPhq/lfaKyy+f7HD2uUo8g9DOs0c1RDIN1tv/JVLsT6l+31OcIUkiX9dNbLIFQ
         IKpvGHHV0zJcCsG3M7qB0XT3y5D/5ozPy+3LtYaucyNMNoia0a6RwBWl9+z/71lNatSU
         G6rg==
X-Received: by 10.182.213.166 with SMTP id nt6mr8753345obc.53.1389902863435;
 Thu, 16 Jan 2014 12:07:43 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Thu, 16 Jan 2014 12:07:22 -0800 (PST)
In-Reply-To: <20140116192252.GT2647@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240527>

2014/1/16 W. Trevor King <wking@tremily.us>:
> Avoiding useless clones is probably more important than avoiding
> duplicate "Invalid update mode" messages.

No, it's not duplicate code. I'll explain, please follow me:

> @@ -803,17 +803,10 @@ cmd_update()
>                         update_module=$update
>                 else
>                         update_module=$(git config submodule."$name".update)
> -                       case "$update_module" in
> -                       '')
> -                               ;; # Unset update mode
> -                       checkout | rebase | merge | none)
> -                               ;; # Known update modes
> -                       !*)
> -                               ;; # Custom update command
> -                       *)
> -                               die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
> -                               ;;
> -                       esac

This is a *validation*. It's done before going more through the code
and die early.

>                       *)
> +                             die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
>

This should be an *assert* -> it means if you reach this case
statement you (programmer) have messed the code something in the code
before. In fact in my original patch I wrote something like "invalid
update_module at this flow".

Please keep both as Junio said.

Thanks,
Francesco
