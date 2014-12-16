From: Anastas Dancha <anapsix@random.io>
Subject: Re: [PATCH] remote: allow adding remote w same name as alias
Date: Tue, 16 Dec 2014 09:57:29 -0500
Message-ID: <CAChhagAFTxmFVvCUiKp3a369awPJtZEuVsfFMcdiqeB9ZwYnKg@mail.gmail.com>
References: <20141216021900.50095.24877@random.io> <alpine.DEB.1.00.1412160944180.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 16 15:57:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0tZS-0001L1-Uw
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 15:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbaLPO5v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Dec 2014 09:57:51 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:40120 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbaLPO5u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Dec 2014 09:57:50 -0500
Received: by mail-ob0-f172.google.com with SMTP id va8so23278506obc.3
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 06:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=YjPsHIwJVHzq2AdEMAtxzjIfJZZriOjj4Vy0vD8iHy0=;
        b=g/gatHgu8dM7/79cZpUPCoPJK234yYiF9IkzCDs2hBPhl+JDWhOv3J9lRmoGP/oQri
         3n7ODHKdwhBuPGs4+tY07wkSYftbe3oG5ASk66bhZEduZLJePP95F3Sa+cozVLBwLRh0
         R01XYGrR8BpBCf0obGauOA7Juxh1CKh2wap39KS/SDEaTcbIkgBv3MG4UiawXWtJIgNp
         F+9NGnM6cYo1PuOrSA700y3uNXRxxzYQ3gIJbhmk1++1UHRhb14NO5MoYuQg48w1DlcV
         HIpVAHNrKSQCI9jE+0WOTptRMc/JveNAQuoZUxmUmqgMwVw8R6cl/0PotyM/G42NcW2G
         2Clg==
X-Received: by 10.202.217.138 with SMTP id q132mr7908156oig.35.1418741869763;
 Tue, 16 Dec 2014 06:57:49 -0800 (PST)
Received: by 10.76.183.104 with HTTP; Tue, 16 Dec 2014 06:57:29 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1412160944180.13845@s15462909.onlinehome-server.info>
X-Google-Sender-Auth: CXPn6Ybc1Hos4Pf4uw0ZRk4FaL4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261442>

My bad Johannes,

Then I wrote "alias", I've meant the following:
```
[url "git@githost.com"]
insteadOf =3D myalias
pushInsteadOf =3D myalias
```
Unfortunately, your suggested fix will not allow my [poorly] described =
use case.
Hope this makes more sense now.

Thank you for looking into this.

-Anastas

On Tue, Dec 16, 2014 at 4:01 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Anastas,
>
> On Tue, 16 Dec 2014, Anastas Dancha wrote:
>
>> When ~/.gitconfig contains an alias (i.e. myremote)
>> and you are adding a new remote using the same name
>> for remote, Git will refuse to add the remote with
>> the same name as one of the aliases, even though the
>> remote with such name is not setup for current repo.
>
> Just to make sure we're on the same page... you are talking about
>
>         [remote "myremote"]
>
> not
>
>         [alias]
>                 myremote =3D ...
>
> yes? If so, please avoid using the term "alias"...
>
> Further, I assume that your .gitconfig lists the "myremote" without a=
 URL?
>
> Also:
>
>> -       if (remote && (remote->url_nr > 1 || strcmp(name, remote->ur=
l[0]) ||
>> -                       remote->fetch_refspec_nr))
>> -               die(_("remote %s already exists."), name);
>> +       if (remote && (remote->url_nr > 1 || remote->fetch_refspec_n=
r))
>> +               die(_("remote %s %s already exists."), name, url);
>
> The real problem here is that strcmp() is performed even if url_nr =3D=
=3D 0,
> *and* that it compares the name =E2=80=93 instead of the url =E2=80=93=
 to the remote's URL.
> That is incorrect, so the correct fix would be:
>
> -       if (remote && (remote->url_nr > 1 || strcmp(name, remote->url=
[0]) ||
> +       if (remote && (remote->url_nr > 1 ||
> +                       (remote->url_nr =3D=3D 1 && strcmp(url, remot=
e->url[0])) ||
>                         remote->fetch_refspec_nr))
>                 die(_("remote %s already exists."), name);
>
> In other words, we would still verify that there is no existing remot=
e,
> even if that remote was declared in ~/.gitconfig. However, if a remot=
e
> exists without any URL, or if it has a single URL that matches the
> provided one, and there are no fetch refspecs, *then* there is nothin=
g to
> complain about and we continue.
>
> Ciao,
> Johannes
