From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: git-p4 submit, Can't clobber writable file
Date: Tue, 2 Dec 2008 23:51:48 +0000
Message-ID: <3f4fd2640812021551t5451e6e3i91e6d2694c89e085@mail.gmail.com>
References: <40586.80065.qm@web37902.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: garyyang6@yahoo.com
X-From: git-owner@vger.kernel.org Wed Dec 03 00:53:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7f3K-00037m-3U
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 00:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbYLBXvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 18:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753494AbYLBXvv
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 18:51:51 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:32610 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405AbYLBXvu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 18:51:50 -0500
Received: by wf-out-1314.google.com with SMTP id 27so3410561wfd.4
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 15:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zGLEq8RxNZYoXHCCuYxlUX/c6v2tTHGsbJQqhkbzAUs=;
        b=VkDBSTFR4R0jxvfGRgQYTv6ho2EBQ/JZ6oIF1wkiJY/C3LewpCK1JSaTblsQv6YyG7
         wGecB4nBOrJv9wolXD7OQRVj5ashOf6ZJ/U0hB9WGWXFs9wdgHkQOmhY7WyAXZ2zXNx9
         lUPBwwyKCdS3+R/QzjdsCWfPlfnVGi+xXMepI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QB5MuKhIiwxrVMtqAqs6+YD2NIx0zxlBIGiloJfSqlJLLmjE+z01ti8y5VS5pcdfHR
         1JtqwQpUeyQ9vTSdWBVgFvNpcm7Tx6Uu1X6piXFNukNnXKsfsjTubjq3R0X84BXDHe8P
         XSKJeFdjSnSOLlAtHJB3Z1XWx1ejNKO/i0NFw=
Received: by 10.142.163.13 with SMTP id l13mr5072480wfe.244.1228261909166;
        Tue, 02 Dec 2008 15:51:49 -0800 (PST)
Received: by 10.142.161.21 with HTTP; Tue, 2 Dec 2008 15:51:48 -0800 (PST)
In-Reply-To: <40586.80065.qm@web37902.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102190>

2008/12/2 Gary Yang <garyyang6@yahoo.com>:
>
> I followed the instructions at http://modular.math.washington.edu/home/mhansen/git-1.5.5.1/contrib/fast-import/git-p4.txt
>
> But, I am not able to git-p4 submit. Any idea?
>
> git-p4 clone //build/scripts build_scripts
> cd build_scripts
> vi foo.h
> git commit foo.h
> git-p4 rebase
> git-p4 submit
>
>  from sets import Set;
> Perforce checkout for depot path //build/scripts/ located at /home/gyang/workspace/build_scripts/
> Syncronizing p4 checkout...

This will be running a `p4 sync ...` command to ensure that the files
are up-to-date.

> //build/scripts/foo.h#1 - added as /home/gyang/workspace/build_scripts/foo.h
> Can't clobber writable file /home/gyang/workspace/build_scripts/foo.h
> //build/scripts/foo.c#1 - added as /home/gyang/workspace/build_scripts/foo.c
> Can't clobber writable file /user/home/gyang/workspace/build_scripts/foo.c
> ......
> command failed: p4 sync ...

Perforce will mark files as readonly when it does a checkout. When you
use `p4 edit` to say you have made changes to the file, Perforce
removes the readonly bit.

What is happening here is that the sync (checkout) command is trying
to write foo.h/c to your build_scripts directory, but because they
already exist there *and* are not readonly, Perforce is producing that
error as it does not want to overwrite any files that have changed
locally.

Not sure what is happening on the git-p4 side, though.

- Reece
