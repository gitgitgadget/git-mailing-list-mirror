From: tarmigan+git@gmail.com
Subject: possible regression (or me abusing git) in v1.5.5
Date: Fri, 11 Apr 2008 12:21:41 -0700
Message-ID: <905315640804111221k53dd7063sae5710ed690114f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 21:22:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkOpd-0001zM-7V
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 21:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758366AbYDKTVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 15:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758217AbYDKTVo
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 15:21:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:9852 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757903AbYDKTVn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 15:21:43 -0400
Received: by nf-out-0910.google.com with SMTP id g13so266005nfb.21
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 12:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=4IUrhGoVIX7D1OOCvJX3VN+35d1I+A70R93XqNr5Hkg=;
        b=pnEDeqY1VFJE5Kt5sMGVYe3A7DQ3mAp1FDhZZJMg5qcpeV3GmSIGEtYb+zw+0CTdiIihnqdffzn3ulrJCyz0CFinkdR5Lz7QV9HNrqn7zTnlj9kv1oTEYJapels+ycM8ZqpFJmcV2cNL01rCZMPHfgg6xNHyFlchkqR33BBn3Q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Zzg7qnhMxODVWjwUHfm4lIMvid0ejLNUUY0k22GYk0OjIzhL3bfUNJe+jbk40Jh5FQeUJBqsmmkAeZc/3nFi/2bgfF5IYh7dOElA9eaEy9uOwfgvgeXeQYf9DVdvR+wSOsXvLEG/YeVABShT48GOGAOZ3W1CuRlcvfWfP4EQ3sQ=
Received: by 10.82.155.10 with SMTP id c10mr974808bue.50.1207941701902;
        Fri, 11 Apr 2008 12:21:41 -0700 (PDT)
Received: by 10.82.175.8 with HTTP; Fri, 11 Apr 2008 12:21:41 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: ec967e499096e1de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79289>

Hello,

After upgrading to v1.5.5, I noticed a change in the way that git
treats symbolic links.

Git will follow symbolic links to directories when they were added as follows

$ git init
$ mkdir foo
$ touch foo/bar
$ ln -s foo foo1
$ git add foo1/
#               Note the trailing slash above.

In v1.5.5 (but not v1.5.4.5 and earlier),
$ git add -u
will remove foo1/bar from the index.

I have bisected this down to f58dbf (diff-files: careful when
inspecting work tree items).

The ability for git to follow links (instead of recording them) was a
useful feature for me, but I may have been abusing this "feature".  If
that is the consensus, it might make sense to have
$ git add foo1
and
$ git add foo1/
 behave the same way?

Thanks,
Tarmigan
