From: Matthieu Tourne <matthieu.tourne@gmail.com>
Subject: Re: Git Interactive Rebase - Bug in error message ?
Date: Mon, 7 Jun 2010 17:06:30 -0700
Message-ID: <AANLkTinaUiHz8gRi5JF3n45aNCoPqiNxwExIga-cyYnw@mail.gmail.com>
References: <AANLkTikIKILZaGC9WZ45ZUC-lxeYIb3Mrf38qwlS2bVr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 08 02:06:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLmLJ-0007o2-Ph
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 02:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385Ab0FHAGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 20:06:53 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62572 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834Ab0FHAGw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 20:06:52 -0400
Received: by vws17 with SMTP id 17so672465vws.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 17:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=OX047tQUXfZvjGUZJxly/MG49ZYQU4+0xDNKdmQutQE=;
        b=JLj1a6h92G1v4PPEHW1TZuoiALT1PRHPCNFM5ddk3ARmV7mcJ3uRHBPnCDOnXC9ktO
         PaDbazw7+TEthQQGnOLJUlr/SJuPjxmuwUn63S5yFeFBErqccADkgp0+JiWvrlMEK5bQ
         7H0X6LSUY6ghcxhlkcRZUqxtx6gdp6iZnOpTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=ASNldWSQNXgmzZWT5KiB0AigZNzcY8x+0+aiX1eOmLuDjIZnqHZVmrUoK73r+0qkRl
         IN6xnlQG9RcErE4rPLs0IbSdwCk1RSJmWP9jdo70ZLy2qxT9Efdon/pJEVzVRDh8gnPV
         pjyOyzuYY6g5y/aDWFVbmAfKDu5+/B+nw+w8M=
Received: by 10.224.21.200 with SMTP id k8mr510752qab.210.1275955611146; Mon, 
	07 Jun 2010 17:06:51 -0700 (PDT)
Received: by 10.220.45.75 with HTTP; Mon, 7 Jun 2010 17:06:30 -0700 (PDT)
In-Reply-To: <AANLkTikIKILZaGC9WZ45ZUC-lxeYIb3Mrf38qwlS2bVr@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148635>

Hi,

I tried to perform an interactive rebase of several commits in my tree.
In one of my commits I had performed a git rm --cached, on several files.
The resulting message was :

error: Untracked working tree file 'foo' would be overwritten by merge.
shift: 1: can't shift that many

I eventually removed the file from the fs, and the rebase worked.
The fact that the rebase is not working is probably not a bug, but the
last line looks like an sh bug.

I can reproduce this with git 1.7.1, and also git HEAD (1.7.1.245.g7c42e)


this can be reproduced with :

$ mkdir dirA
$ echo "A" > dirA/A
$ git commit -a -m 'first commit'

$ mkdir dirB
$ echo "B" > dirB/B
$ git commit -a -m 'creating dirB'

$ mkdir dirC
$ echo "C" > dirC/C
$ git rm -r --cached dirA
$ git commit -a -m 'creating dirC, removing dirA'

$ git rebase --interactive HEAD~2
(then swapping the two commits)

pick creating dirC, removing dirA
pick creating dirB

error: Untracked working tree file 'dirA/A' would be overwritten by merge.
shift: 1: can't shift that many


Thank you,

Matthieu.

-- 
Matthieu Tourne
