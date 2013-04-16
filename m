From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Wed, 17 Apr 2013 02:23:14 +0530
Message-ID: <CALkWK0nVfRETgT9U83Nn0QMg8MvdYWcFLzPELCj=8r6ZrR_KOw@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr> <7vobdfztz9.fsf@alter.siamese.dyndns.org>
 <CALkWK0=cNEkE0bUoWJg119o+FaQywJhgkUxiFfLGPSsLrFVZ=A@mail.gmail.com>
 <7vr4ibu14j.fsf@alter.siamese.dyndns.org> <CALkWK0=6E=s6kJysMo2yC22c3pvCWn90S5neRyP0jpzpYrZboA@mail.gmail.com>
 <vpqli8je8w0.fsf@grenoble-inp.fr> <CALkWK0ndk7hPYk4pN8gmLxLOJR0XsLo1gwHB=n0QkK6DHgLzKQ@mail.gmail.com>
 <CABURp0qgxtcf_RCrobWr5Q_yiBraVOMDq9hWHrzP=EbZV46xiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 22:54:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USCt6-0008N8-1h
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 22:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164Ab3DPUxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 16:53:55 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:46483 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965094Ab3DPUxy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 16:53:54 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so1095883iea.38
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 13:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Hqn3B7u9vA4kzOjpXPte6LlHwDMf0VuezPTGw1T22vQ=;
        b=MfIGD/fCQY38f+WGUywqShOdSujM7bNFxGYGgUzTcebwqH+gh+6DEzh70vJmWUEXjA
         3TOSUuFNaTIdtfl8e8chFpSHPtwLkZs02Ry0ccvMxItUjD8mBCj7+ZxWxouTUlquF6FC
         vrOsk0X7K6KeOT4IUWGAl2b5xwfF+JA937PoPgMoSTIWWJeZMo48LyBz4e9tN2WJygO8
         5/vX5kSkSICCrLq+z+t/2wgDavFYINI3n5FBK1NGlsrzKBw7Ln7bd5lPY3NvZ2k3j38h
         7Dtho4fEW3Cx7CxFjViNfzWdpgw7oXxjk0+hSoZrz0iBzM4zTB3w73MSQmW+Wh02jc87
         jLsg==
X-Received: by 10.50.117.3 with SMTP id ka3mr8463106igb.107.1366145634269;
 Tue, 16 Apr 2013 13:53:54 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 16 Apr 2013 13:53:14 -0700 (PDT)
In-Reply-To: <CABURp0qgxtcf_RCrobWr5Q_yiBraVOMDq9hWHrzP=EbZV46xiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221471>

Phil Hord wrote:
> If I follow the latter advice about 'rm -rf', who will remember that
> 'rebase' had something stashed, and what will they do with it when
> they do?
>
> What if it is weeks or months later?  I would be surprised to see
> long-forgotten wip show up in my workspace all of a sudden.

Ultimately, I think an ideal implementation requires this entire
autostash implementation to reside completely within the $state_dir.
The issue of a long-forgotten WIP is then the same issue as a
long-forgotten rebase, and a rm -rf $state_dir will get rid of the WIP
as well.

The other reason is that it shouldn't interact with the rest of git.
This means no touching any refs or reflogs, and this can be
problematic if we decide to use the standard git stash.  I'm currently
working towards seeing if it's possible to get stash to create "named
stashes" that we can predictably retrieve later, to avoid rolling our
own homegrown stash.

Yes, the problem is much more complex than I initially thought.  It
was much simpler to implement it for git-pull.sh.
