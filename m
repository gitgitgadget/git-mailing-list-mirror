From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: sharing git work while downstream from svn?
Date: Tue, 11 Aug 2009 23:03:47 +0000
Message-ID: <32541b130908111603v1e3f6c42peac792caf7097e0d@mail.gmail.com>
References: <auto-000020209577@sci.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tfogal@sci.utah.edu
X-From: git-owner@vger.kernel.org Wed Aug 12 01:04:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb0O9-0003wU-Rb
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 01:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542AbZHKXEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 19:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbZHKXEH
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 19:04:07 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:38114 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbZHKXEH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 19:04:07 -0400
Received: by yxe5 with SMTP id 5so5173750yxe.33
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 16:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=u5P1rHE+3qNDB1L7PI6nfXt+jYfiqa6x8MUsv72wUxM=;
        b=NJNVOhc9E7aKREsn5EfqzYP2obotQfGoXO1WGV6DDrfKGjhzhi+ltEZTQTwpG4JriF
         4R7g9J5mbmEgnTVnRq41sFxhzFYMEL2QBCFFxcwK37oEQ5MyU5DB41Ui7nuMEXMCbd4W
         uU3aak2dTwJSZY7LYRXQuW58rkRVP4LoqPFnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UD0PvNbT/y73ODYshRM0DYZfLGgipxnqqDyTcDdcwBmqbbEWv0bGZhpmcKXeUMKfLB
         9yIOtap+1P/PbQW1uvUTnzhpYehSVSER7effh8o4vLIIhEN7ln2II+wwzgRSvaMLTO6Y
         6bj7UbO8e3ST51KkGOHgCuJYbryuMoCplV9Wc=
Received: by 10.150.219.18 with SMTP id r18mr5082481ybg.224.1250031847068; 
	Tue, 11 Aug 2009 16:04:07 -0700 (PDT)
In-Reply-To: <auto-000020209577@sci.utah.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2009 at 10:55 PM, tom fogal<tfogal@alumni.unh.edu> wrot=
e:
> This gets to be a mess when trunk changes: I'll rebase + potentially
> fix some conflicts. =A0Other developers with some of the experimental
> patches will svn update, and get similar conflicts. =A0These might di=
ffer
> in subtle ways, and now exchanging patches gets more difficult.

We use git-svn at Versabanq, and our process is very simple: never use
rebase, period.

Instead, do all your work in a branch *other* than the git-svn main
branch.  When you're ready to merge your stuff into svn, do:

git checkout git-svn
git svn rebase
git checkout myworkingbranch
git merge git-svn
   # and resolve any conflicts
git checkout git-svn
git merge --no-ff myworkingbranch   # the --no-ff is very important her=
e!
git svn dcommit

This basically results in a *single* commit getting sent to svn,
rather than the batch of all the git commits you've been working on.
Most svn users don't care about this, because they lose all that
granularity whenever they merge a branch anyhow.  Meanwhile, all your
git users never have to worry about rebasing *anything* and can use
the normal git merge/pull stuff.

Have fun,

Avery
