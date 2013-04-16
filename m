From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Tue, 16 Apr 2013 12:50:18 -0400
Message-ID: <CABURp0qgxtcf_RCrobWr5Q_yiBraVOMDq9hWHrzP=EbZV46xiQ@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr> <7vobdfztz9.fsf@alter.siamese.dyndns.org>
 <CALkWK0=cNEkE0bUoWJg119o+FaQywJhgkUxiFfLGPSsLrFVZ=A@mail.gmail.com>
 <7vr4ibu14j.fsf@alter.siamese.dyndns.org> <CALkWK0=6E=s6kJysMo2yC22c3pvCWn90S5neRyP0jpzpYrZboA@mail.gmail.com>
 <vpqli8je8w0.fsf@grenoble-inp.fr> <CALkWK0ndk7hPYk4pN8gmLxLOJR0XsLo1gwHB=n0QkK6DHgLzKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 18:51:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US95s-0000ZH-F6
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 18:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013Ab3DPQum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 12:50:42 -0400
Received: from mail-vb0-f53.google.com ([209.85.212.53]:44940 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965000Ab3DPQuj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 12:50:39 -0400
Received: by mail-vb0-f53.google.com with SMTP id i3so551489vbh.12
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EYJh+9FipMWYKRcYDecOrcurEebVlCH03Vqn1Eefd/A=;
        b=BXvoGLnLWiKjYSIwWI0YEhCCBr+2IyhrFjdjQ4mrnO6vN+ZSgMI/wvInLOxD415XG4
         F6B0AaqBM6Bl0dU4kAX3YObb57dFDTaTSCuSJ/pCxQwHWzv47uLZoHjZH9X3AKBmdVBZ
         Ffu7DqKNqmn/7whgT/25FjGthOM71wwriq5XKgKGc5ddom5vRZS2aWGGY7IGQkTUOmgQ
         quXqYwjqXKmka7Xsm+XOUHqpD1aWl9+vYsZRjZ+4rTo/08fV1MW13Bi4vTFd/1f+XtLD
         yCFKtkcwzXxZZ/pirrwI3iSccXbENwuPosxwZVakFsa/JDZvqjGJf4COryaFXSPwrQoI
         pJ7g==
X-Received: by 10.52.230.197 with SMTP id ta5mr1797095vdc.103.1366131039088;
 Tue, 16 Apr 2013 09:50:39 -0700 (PDT)
Received: by 10.58.219.34 with HTTP; Tue, 16 Apr 2013 09:50:18 -0700 (PDT)
In-Reply-To: <CALkWK0ndk7hPYk4pN8gmLxLOJR0XsLo1gwHB=n0QkK6DHgLzKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221428>

On Tue, Apr 16, 2013 at 5:20 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Matthieu Moy wrote:
> No.  Ultimately, the entry point of all these invocations is
> git-rebase.sh.  The plan is to refactor calls from git-rebase.sh to
> git-rebase--*.sh scripts so that those scripts return control to
> git-rebase.sh, which will be the final exit point.  The logic is very
> simple: On the very first invocation of rebase (ie. no existing rebase
> in progress), stash.  If the return statement from the specific rebase
> script is 1 (which means that there are conflicts to be resolved),
> exit as usual.  If it is 0 (which means that the rebase completely
> successfully), pop the stash before exiting as usual.
>
> What's so complicated about that?  I'm against leaking the autostash
> implementation detail into specific rebases, because I value a clean
> and pleasant implementation over everything else.

It can be more complex than you realize.

   $ git pull --rebase --stash

    It seems that there is already a .git/rebase-apply directory, and
    I wonder if you are in the middle of another rebase.  If that is the
    case, please try
            git rebase (--continue | --abort | --skip)
    If that is not the case, please
            rm -fr .git/rebase-apply
    and run me again.  I am stopping in case you still have something
    valuable there.

If I follow the latter advice about 'rm -rf', who will remember that
'rebase' had something stashed, and what will they do with it when
they do?

What if it is weeks or months later?  I would be surprised to see
long-forgotten wip show up in my workspace all of a sudden.

Phil
