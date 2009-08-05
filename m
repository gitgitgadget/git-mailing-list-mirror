From: Dan McGee <dpmcgee@gmail.com>
Subject: blame on a deleted/renamed file
Date: Wed, 5 Aug 2009 07:16:13 -0500
Message-ID: <449c10960908050516k25ef0a92sd8616de29a93ea5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 14:16:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYfPr-00007x-4k
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 14:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933688AbZHEMQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 08:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933622AbZHEMQO
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 08:16:14 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:44902 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933615AbZHEMQO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 08:16:14 -0400
Received: by ewy10 with SMTP id 10so47716ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=yif2F72aFlqYA2fXvVfKKtbBDtFFnsILOsO6iLkZ4PQ=;
        b=cGOsSSp6BeoAOjyTxDq/0ZeX+ti1O1ru6Cqxuit4bQEFf72rr2vomL45NIx+3FTiu9
         Ivz7aJ8+QiESKrt6hufEVO8oVs40r7FB5zT5DtkfcT4PIOhPZJ54FD/KUI/EGDn9ow9s
         CW9ZzD13ce+VDLXyQiO6zNrO3mjsE0I/6IaTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=nf3szvN0Ap4xn1IbLqtdtTkYzKt12fOBlCeAeIuYjHw4bHFDb57mmnrXzuYF7/bpJO
         z4dDNYwiEqrXodHtu0x9EA5YakjZ1XWx+6zuSl+aeRHKaDwGW9xt2kPKijCLU+Iq/x0K
         IKsH4qHD93yjnccqGbStTpHZpMqxcF832v6H8=
Received: by 10.216.29.208 with SMTP id i58mr1790136wea.85.1249474574012; Wed, 
	05 Aug 2009 05:16:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124900>

Is there no easy way in git to get a blame on a file that has either
been renamed or deleted? I'll step through my thought process, and a
quick google and read of the manpage returned nothing obvious. Here is
the repository in question if it matters:
git://projects.archlinux.org/pacman.git. I located a particular commit
I was interested using a plain git-blame:
$ git blame scripts/makepkg.sh.in

OK, looks like lines moved around enough that we got stuck here, let's
see what this patch did:
$ git show e19d7da4

OK, it did a move of a bunch of lines into functions that GIT couldn't
quite track:
$ git annotate --follow "scripts/makepkg.in" e19d7da4~1
fatal: cannot stat path 'scripts/makepkg.in': No such file or directory

$ git annotate --follow "scripts/makepkg.sh.in" e19d7da4~1
fatal: no such path scripts/makepkg.sh.in in e19d7da4~1

Help? Or do I need to think about writing some sort of patch for it?
This is the first thing I have seen svn be able to do[1] that git
can't. :)

-Dan

[1] svn annotate http://path/to/repo/path/to/file@2345
