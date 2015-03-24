From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Sparse checkout not working as expected (colons in filenames on Windows)
Date: Tue, 24 Mar 2015 08:21:12 +0700
Message-ID: <CACsJy8BOuhohQzaGzD+4cthqOaL4sz1ADRD-ekhFhKt4wMcg7A@mail.gmail.com>
References: <BE2660C974C9415E997F20A49ABC766E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Yue Lin Ho <yuelinho777@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:21:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaDXQ-0004pF-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 02:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbbCXBVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 21:21:44 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33443 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbbCXBVn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 21:21:43 -0400
Received: by iecvj10 with SMTP id vj10so49877744iec.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 18:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mPs9HzpE+8tuR2er3s0P8c41UXT5cqPSKAHEOv8YZSU=;
        b=VgjQQrZi1g0U/TWNhUlOvCDUmADM99dyJxlsrFR6ujlRKIzxbIjLHM7dZpyHDDZwUx
         AthU8LIZP8w6D0UbRHwG22U3QdcA0xtd7kQIXDwXU5ybAo9o4wTEWVBwQY/Ie4mY/r0h
         xkSuUJ9/KkC+rhWr2O31RyoJFX93/uQuIW7v4HeiULBqoUt8JmnLxSKPFmPR/q5hDouc
         SaBYhxX1E8F4JCxeVVGUZIro6cW5m+cYIcjJCPhcCILGld2aIAqJ0neoMAP+FuA/b1OC
         la1PVaeowNTiNXmVLjfbcdovF36rd4ZDZfWIiMQppnn3cO27NLgDV4BaI0zl57d5QCEq
         yEbg==
X-Received: by 10.50.137.99 with SMTP id qh3mr18597413igb.7.1427160102913;
 Mon, 23 Mar 2015 18:21:42 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Mon, 23 Mar 2015 18:21:12 -0700 (PDT)
In-Reply-To: <BE2660C974C9415E997F20A49ABC766E@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266172>

On Fri, Mar 20, 2015 at 6:07 AM, Philip Oakley <philipoakley@iee.org> wrote:
> Hi, I was expecting that sparse checkout could be used to avoid the checking
> out, by git, of files which have colons in their name into the worktree when
> on Windows.
>
> Yue Lin Ho reported on the Msygit list [1] that he had a repo where there
> was already committed a file with a colon in it's name, which was a needed
> file and had been committed by a Linux user. The problem was how to work
> with that repo on a Windows box where such a file is prohibited to exist on
> the FS (hence the expectation that a sparse checkout would suffice). Yue has
> created a short test repo [2]
>
> Even after getting the pathspec escaping right, I still haven't been able to
> make this expected behaviour work [3].
>
> Am I wrong to expect that sparse checkout (and the skip-worktree bit) can be
> used to avoid files with undesirable filenames hitting the OS's file system?
>
> If it should be OK, what's the correct recipe?
>
> --
> Philip
>
> [1]
> https://groups.google.com/forum/?hl=en_US?hl%3Den#!topic/msysgit/D4HcHRpxPgU
> "How to play around with the filename with colon on Windows?"
> [2] Test repo https://github.com/t-pascal/tortoisegit-colons
>
> [3] test sequence::
> $ mkdir colons && cd colons
> $ git clone -n https://github.com/t-pascal/tortoisegit-colons
> $ cd tortoisegit-colons/
> $ git config core.sparseCheckout true
> $ cat .git/info/sparse-checkout # external editor
> /*
> !ifcfg-eth0\:0

Colons have no special meaning in gitignore rules and therefore need
not be escaped. The backslash is considered a literal character in
this case, probably not what you want.

> $ git update-index --skip-worktree -- ifcfg-eth0\:0
> Ignoring path ifcfg-eth0:0
> $ git checkout -b test 7f35d34bc6160cc # tip commit, we are still unborn!
> error: Invalid path 'ifcfg-eth0:0
> D       ifcfg-eth0:0
> Switched to a new branch 'test'
-- 
Duy
