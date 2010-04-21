From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: weird fatal on push when post-receive hook exists but is empty
Date: Wed, 21 Apr 2010 10:46:08 +0200
Message-ID: <4BCEBB50.7020003@drmicha.warpmail.net>
References: <g2x2e24e5b91004200921mc5b0ffoc1c1ec2af25f71c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 10:49:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4VcV-0000sF-59
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 10:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab0DUItO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 04:49:14 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37521 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752983Ab0DUItM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 04:49:12 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 731C7EB303;
	Wed, 21 Apr 2010 04:49:12 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 21 Apr 2010 04:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=nCOVQd4kK5xCDUZXeisgC/gkS/0=; b=UesSmYLCpsAqKRG+F5IZ4xbXS+2c8bSOjcuoMdCQyd1JmXr1f4ZgbTYAJTDM5KXvAGRj1cZqVfnhiBS31felsfJlCST2JYUJxz22ypm5GYfZXjyX4D0vsPtkAw5M4noBdA5X/TrrXCfJrvxh07dHY+FK5TSOSa/pCmfqvMiJcFg=
X-Sasl-enc: UeqUFk5iI7WQGcu/H9TqecGDc6AZYGYAH38wp7Fb/eQc 1271839752
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E0EDF4C525A;
	Wed, 21 Apr 2010 04:49:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <g2x2e24e5b91004200921mc5b0ffoc1c1ec2af25f71c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145419>

Sitaram Chamarty venit, vidit, dixit 20.04.2010 18:21:
> 21:47:05 sita-lt:t $ rm -rf a b c
>     21:47:10 sita-lt:t $ git init --bare b
>     Initialized empty Git repository in /home/sitaram/t/b/
>     21:47:23 sita-lt:t $ git clone b a
>     Initialized empty Git repository in /home/sitaram/t/a/.git/
>     warning: You appear to have cloned an empty repository.
>     21:47:29 sita-lt:t $ cat > b/hooks/post-receive
>     #!/bin/bash
>     # dummy
>     21:47:55 sita-lt:t $ chmod +x b/hooks/post-receive
>     21:48:00 sita-lt:t $ cd a
>     21:48:02 sita-lt:a (master) $ date > foo;git add foo; git commit
> -m foo; git push origin master
>     [master (root-commit) f55bd25] foo
>      1 files changed, 1 insertions(+), 0 deletions(-)
>      create mode 100644 foo
>     Counting objects: 3, done.
>     Writing objects: 100% (3/3), 232 bytes, done.
>     Total 3 (delta 0), reused 0 (delta 0)
>     Unpacking objects: 100% (3/3), done.
>     fatal: The remote end hung up unexpectedly
>     error: error in sideband demultiplexer
>     error: .git/objects/f5/5bd251325ad1647a29869e75a8080fee1a5d97 died
> of signal 13
>     To /home/sitaram/t/b
>      * [new branch]      master -> master
>     error: failed to push some refs to '/home/sitaram/t/b'
>     (rc=1)21:48:23 sita-lt:a $

With git version 1.7.1.rc1.248.gcefbb and this script:

#!/bin/bash
rm -rf a b c
git init --bare b
git clone b a
cat > b/hooks/post-receive <<EOF
#!/bin/bash
# dummy
EOF
chmod +x b/hooks/post-receive
cd a
date > foo;git add foo; git commit -m foo; git push origin master

I get this output:
Initialized empty Git repository in /tmp/t/b/
Initialized empty Git repository in /tmp/t/a/.git/
warning: You appear to have cloned an empty repository.
[master (root-commit) 020a1fb] foo
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo
Counting objects: 3, done.
Writing objects: 100% (3/3), 241 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
To /tmp/t/b
 * [new branch]      master -> master

What are we doing differently?

Michael
