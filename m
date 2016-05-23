From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v6 3/3] bisect--helper: `write_terms` shell function in C
Date: Mon, 23 May 2016 20:03:19 +0530
Message-ID: <CAFZEwPPbCBAXq6ri1Ew8-+vY-iAJKtyJB_Nf+Syv4WB+2ktc1w@mail.gmail.com>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-4-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cS=zcSVLwARZ5A8hdiE0wqgYPU2Jwnr0OcjDXZFO--cZw@mail.gmail.com>
	<alpine.DEB.2.20.1605161508230.3303@virtualbox>
	<CAFZEwPNkPZ6JnzqbTyhYMwEF-hor2rm39NcB84omrh+uCiVPNw@mail.gmail.com>
	<alpine.DEB.2.20.1605231301560.4122@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 23 16:33:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4qv8-0008MB-3G
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 16:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbcEWOdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 10:33:21 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33999 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbcEWOdV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 10:33:21 -0400
Received: by mail-yw0-f181.google.com with SMTP id c127so55333795ywb.1
        for <git@vger.kernel.org>; Mon, 23 May 2016 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=pmXFJ1P720hOoTVOb9lvGjvoTYGOXMrPJRleUiuDCxQ=;
        b=PNc7uoQN4FMmUNhd+EH2SbxPnezvFP8vdyiAnL0k2VKbRYmDA66ZUB78mVfCL0SW22
         kJgOBOKOkvX6Z8eI91KkyQlz/9WEzEYIXg8cn1MvJwyyg5VCoSruhLglzH3oBbVN6HZB
         0divzkj6S5sYtWa4UaZgigiL1frVJEgRwxuVKeVb/3/o3Lc9Hb9/qVDTMI7w8Ms02Jbx
         J9fQmdRaRMgKPa7IM0lw2hza7+TCWRYddzig0vtpaRedfJpCC4w0rLvBiTmcUEcnkrDF
         IRg+WVlbnhJvMjjHZpIvdqyCZ65zt5lwX4V00KqN/GYl0xLlxv3r23MeTkLiB4cBRr2Q
         Vg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=pmXFJ1P720hOoTVOb9lvGjvoTYGOXMrPJRleUiuDCxQ=;
        b=mlRt7MlOnd6uUv+ZSjhmPPqfg/r1RHTCOXe1v46dGIdD5bthGJEa+7Tx5XeuSStWAV
         yL8nXjF7DsRqe9YK+LosbRguKPkXaNPNysa8QoMv9V7Ics0Umb2GdeoFb47Evq+NLgST
         z+7QD1MkskuymYaP0lkNDYdnrFXyPIQoi9Yb5FFNLAn9RYDKh3B1+bLkai3djZ4ctLzk
         My9F8dDhIfWQg5pgvGjfEp1i7j3kQf/eknQxujP+A13ZZunAhYhE+zGwjPdnwYF6WEZ8
         Q8yeaLAUu99tG++OqlEuUAXpjyXFv7idv+PPp7UPRZgO8gB26Xf6ivTrzoYYQ16swBAb
         wmTw==
X-Gm-Message-State: AOPr4FW0BcLhlj0uddV3qBZjUJUWN+6c8SYlZo5IVI2thaTAgCLgxadNp7Bw8txIfSJ/K75ZDj9ngQdY8drjfg==
X-Received: by 10.13.198.5 with SMTP id i5mr10491366ywd.263.1464013999583;
 Mon, 23 May 2016 07:33:19 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Mon, 23 May 2016 07:33:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605231301560.4122@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295326>

Hey Johannes,

On Mon, May 23, 2016 at 4:37 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Pranit,
>
> On Fri, 20 May 2016, Pranit Bauva wrote:
>
>> Frankly, I have no idea what you mean by libification but I will use
>> error() since efforts for libification have already started.
>
> The term "libification" is frequently used in the Git project: it means to
> convert code that was formerly used in a standalone program to make it
> usable as a library function.
>
> The main differences:
>
> - in the standalone program, you can get away with calling die() when
>   anything goes wrong. Not so in a library function: you need to give the
>   caller a chance to fail gracefully, or even to continue.
>
> - in a standalone program, you can be sloppy and "let exit() clean up",
>   i.e. omit free() calls or even close() calls. In library functions, this
>   is not possible.
>
> - in a standalone program, you may mess with the stdio handles. This is
>   an absolute no-go in library functions.
>
> There are other differences, of course. The gist is that you have to be a
> lot more careful for library functions.

Thanks for the explanation. It seems a bit clearer to me now.

Regards,
Pranit Bauva

>
> Ciao,
> Johannes
