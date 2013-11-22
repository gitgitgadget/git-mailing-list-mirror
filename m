From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git issues with submodules
Date: Fri, 22 Nov 2013 23:41:25 +0530
Message-ID: <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
References: <CAErtv26Q_YN+U+trjNac1aKLi9BvNHNNuaUkrr2RE0nB+yxWsw@mail.gmail.com>
 <CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com>
 <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
 <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
 <20131122151120.GA32361@sigill.intra.peff.net> <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
 <CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
 <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com> <CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 19:12:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjvDA-00057i-UR
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 19:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755619Ab3KVSMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 13:12:08 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:60799 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526Ab3KVSMH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 13:12:07 -0500
Received: by mail-ie0-f176.google.com with SMTP id at1so2586568iec.7
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 10:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gxwIOgf/Hp8rwBoTG3KY+PIW09b1f9sHKQpsPRXy/wY=;
        b=meaujgYhXlqvBxYqmbcvuYhNFh8mwg4n5yTaCl5N5PR69VICzZ0SK4TqGbZHifQtYZ
         VBHJgnGhD1dMPKp53smJa01arvh+yA4+ld433Hx7v4oVf0IsyT3fYdovHchLWi6lzdYV
         jEf9JVHtnx0gbepQnGIO3qN1oc2dPg9IE5mY0GW/GX9lwP1NcwNUGZhsY2MyJeOYCeKk
         2Su00FPrZnKm472qsP9o0MV86cQktK4DwOPD1vFlCUUfb5M5ZSSRGpz8VxMlWg1kveMr
         8pAhiPuzG13QJ6Z0VCPP2GDkeM+xWIW5H36pNrIww+oBk8xUZo0x/vLXA1rS9/xoOihG
         50zg==
X-Received: by 10.50.73.74 with SMTP id j10mr3495415igv.50.1385143925411; Fri,
 22 Nov 2013 10:12:05 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Fri, 22 Nov 2013 10:11:25 -0800 (PST)
In-Reply-To: <CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238204>

Sergey Sharybin wrote:
> To reproduce the issue:
>
> - Run git submodule update --recursive to make sure their SHA is
> changed. Then `git add /path/to/changed submodule` or just `git add .`
> - Modify any file from the parent repository
> - Neither of `git status`, `git diff` and `git diff-files --name-only`
> will show changes to a submodule, only changes to that file which was
> changed in parent repo.
> - Make a git commit. It will not list changes to submodule as wll.
> - `git show HEAD` will show changes to both file from and parent
> repository (which is expected) and will also show changes to the
> submodule hash (which is unexpected i'd say).

Thanks Sergey; I can confirm that this is a bug. For some reason, the
`git add .` is adding the ignored submodule to the index. After that,

  $ git diff-index @

is not showing the ignored submodule. Let me see if I can dig through
this in greater detail.
