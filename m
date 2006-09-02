From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH][RFC] Add git-archive-tree
Date: Sat, 2 Sep 2006 22:13:14 +0200
Message-ID: <cda58cb80609021313p5156a14du4895e53387dd24dc@mail.gmail.com>
References: <44F977C0.4060901@lsrfire.ath.cx> <44F982BD.1050509@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Sep 02 22:13:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJbrn-0000mn-8y
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 22:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWIBUNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 16:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWIBUNR
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 16:13:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:18786 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751505AbWIBUNP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 16:13:15 -0400
Received: by ug-out-1314.google.com with SMTP id s2so1435364uge
        for <git@vger.kernel.org>; Sat, 02 Sep 2006 13:13:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o9q6iXCcsjrnoWUfjd+vTsO/xlTh7ew0mQoXuEWWYOL2P2J88gPpESJXQQ3FO1OvMWWlT+AD/KJQD0qHUaFqxdryj3+134SqzULvWAmGD+jFyAJQseqOwbt1Dlptva/ADFrxaoeja4ci2B5tJ67+9ghWB7BImOjkBjNaSj/Na8Q=
Received: by 10.66.216.20 with SMTP id o20mr1914118ugg;
        Sat, 02 Sep 2006 13:13:14 -0700 (PDT)
Received: by 10.67.95.4 with HTTP; Sat, 2 Sep 2006 13:13:14 -0700 (PDT)
To: "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44F982BD.1050509@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26354>

2006/9/2, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>:
> The two patches I sent are what I have been able to come up with so far.
> The next step would be to add archive-neutral upload and download support.
>
> Having thought a bit about it I propose to keep git-archive-tree for
> local operations, only.  It can be called by the uploader just like

Well I don't see why putting the remote operations in an other file. I
was more thinking on something like this:

git-archive --format=<fmt> [--remote=<repo>] <tree-ish> [path...]

This main porcelain function would call directly functions provided by
archivers lib. We will need to define an API which git-archive will
use for local operations.

Symetrically, on the sever side we would have:

git-upload-archive --format=<fmt> <repo> [path...]

used by git-daemon. It will deal with protocol, paths and use archiver's lib.

Eventually, we would have 2 commands:

git-archive
git-upload-archive

and get ride of

git-tar-tree
git-zip-tree
git-upload-tar
git-upload-zip

> git-tar-tree is now called by git-upload-tar.  As Franck suggested, the
> uploader should allow the list of archive formats it supports to be
> restricted in a config file.  The range of allowed compression levels
> should also be configurable.
>
> Does it make sense to change the wire protocol to simply send the
> command line options one by one?

That would make sense if the number of options grow up. Currently the
remote protocol had been written by Junio, I just pick up that part
from git-tar-tree and put it into git-archive. But if we allow
pathspec for remote operations, then  we need to send them to the
uploader.

>
> The interface could be something like this:
>
>    git-download-archive <repo> <git-archive-tree options...>
>    git-upload-archive <directory>
>
> Or, if the big number of git command names is a concern:
>

I think it is, IMHO. And that's why I think we could have only one
command for building localy/remotely archive whatever the format.
git-archive should be a main procelain command, and we should get rid
of git-{tar,zip}-tree commands.

-- 
               Franck

-- 
VGER BF report: U 0.742177
