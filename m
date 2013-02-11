From: Ethan Reesor <firelizzard@gmail.com>
Subject: Re: Pushing a git repository to a new server
Date: Mon, 11 Feb 2013 13:18:38 -0500
Message-ID: <CAE_TNi=NW1F3ZjYD3CF6y5qRb=6eQwdmX2ZY4g0SExn-k7Ez-g@mail.gmail.com>
References: <CAE_TNin0Kb_38gnx9W36VZ8CTxYBZ9T1Dkhar1DUFHyQUq7ebg@mail.gmail.com>
 <20130211075040.GJ5210@localhost.localdomain> <CAE_TNin6-weutRDToZ7-BBGJTCcf0dwJn0ChUbFcACRU=SbjzA@mail.gmail.com>
 <20130211164518.ad0a21aff672ad0e4f03a6bb@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Cc: git <git@vger.kernel.org>
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Mon Feb 11 19:19:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4xyO-0003Tc-4j
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 19:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758753Ab3BKSTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 13:19:00 -0500
Received: from mail-qc0-f169.google.com ([209.85.216.169]:36387 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758748Ab3BKSS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 13:18:59 -0500
Received: by mail-qc0-f169.google.com with SMTP id t2so2342087qcq.14
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 10:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=7JJ+sxu6vZnyi77NHPYejAEJzPvohqdISFU1kkB/MZk=;
        b=v7ZwVpSRBt/m+JyewhwDT9/MBpL7vBlY0H2cTaDkWyBQJ9aQNdf83smt3BGqyUGYp4
         k1k20w3OGx+lNbF/Wss73HM4mle6HAcvKM3wTjezof36PONWPQVlC0lvyAQZi6skPM7s
         hPzCcnvkMifGklhMisa0Ob1jYuTk05ivUN3sau0qkT1neE77V9xg/W8UOggTNk/EJ5hB
         EnblRxFA9glD9vwbByZF9ysLSvPTr4ysfeYbYkR0XtGPH0f/L0GeORA7ejPNFlm3dMZS
         83xze+fzai5Vbjbr5bo0sEsB7pHNILZG4UWO6+HXRUcU+32M0uTVciMiZxXpmmMNKCig
         3fgg==
X-Received: by 10.224.210.135 with SMTP id gk7mr5852675qab.57.1360606738898;
 Mon, 11 Feb 2013 10:18:58 -0800 (PST)
Received: by 10.49.95.225 with HTTP; Mon, 11 Feb 2013 10:18:38 -0800 (PST)
In-Reply-To: <20130211164518.ad0a21aff672ad0e4f03a6bb@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216071>

On Mon, Feb 11, 2013 at 7:45 AM, Konstantin Khomoutov
<kostix+git@007spb.ru> wrote:
[...]
> OK, here's the sketch.
> On the server, in the home directory of your "git" user, you create a
> wrapper around git-receive-pack, like this:
>
> # mkdir ~git/git-shell-commands
> # cat >~git/git-shell-commands/git-receive-new-repo
> #!/bin/sh
>
> set -e -u
>
> if [ $# -ne 1 ]; then
>         echo 'Missing required argument: <directory>' >&2
>         exit 1
> fi
>
> mkdir "$1" && git init --quiet --bare "$1" && git-receive-pack "$1"
> ^D
> # chmod +x $_
>
> Then, on the client side, to push a new repo, you just do
>
> $ git push --receive-pack=git-receive-new-repo --all git@server:repo.git
>
> This will make `git push` to spawn not just `git receive-pack <dir>` as
> it usually does but your wrapper, which would first create and
> initialize a bare repository and then spawn `git receive-pack` on it
> which would then communicate with the client side and receive
> everything from it.
>
> You could then create a client-side wrapper script or a Git alias for
> such "creative pushing", like this:
>
> $ git config --add --global alias.push-new-repo \
>   'push --receive-pack=git-receive-new-repo --all'
>
> So the whole client call is now reduced to
>
> $ git push-new-repo git@server:repo.git

Thanks, that's what I was going for.
