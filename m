From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: Scripted clone generating an incomplete, unusable .git/config
Date: Thu, 11 Nov 2010 08:55:06 +0100
Organization: ATLAS Elektronik GmbH
Message-ID: <4CDBA15A.6090301@atlas-elektronik.com>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 08:54:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGRzi-0004R9-MA
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 08:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757797Ab0KKHyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 02:54:49 -0500
Received: from lxsrv96.atlas.de ([194.156.172.86]:48774 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757771Ab0KKHyt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 02:54:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 57A3810072;
	Thu, 11 Nov 2010 08:54:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Md8xNFYN7ClB; Thu, 11 Nov 2010 08:54:46 +0100 (CET)
Received: from mgsrv01.atlas.de (unknown [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu, 11 Nov 2010 08:54:44 +0100 (CET)
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mgsrv01.atlas.de (Postfix) with ESMTP id BADF52716A;
	Thu, 11 Nov 2010 08:54:44 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161213>

On 11/11/2010 12:21 AM, Dun Peal wrote:
> This is a weird issue I ran into while scripting some Git operations
> with git 1.7.2 on a Linux server.
> 
> When running the git-clone command manually from the command line, the
> resulting repo/.git/config had all three required sections: core,
> remote (origin), branch (master).
> 
> When running the exact same git-clone command manually from the Python
> scripted, the resulting repo/.git/config was missing the `core` and
> `remote` sections.
> 
> Here's a bash log fully demonstrating the issue:
> 
>   $ python -c "import os; os.popen('git clone
> git@git.domain.com:repos/repo.git')"
>   [...]
>   $ cat repo/.git/config
>   [branch "master"]
>           remote = origin
>           merge = refs/heads/master
>   $ rm -Rf repo
>   $ git clone git@git.domain.com:repos/repo.git
>   $ cat repo/.git/config
>   [core]
>           repositoryformatversion = 0
>           filemode = true
>           bare = false
>           logallrefupdates = true
>   [remote "origin"]
>           fetch = +refs/heads/*:refs/remotes/origin/*
>           url = git@git.domain.com:repo/repo.git
>   [branch "master"]
>           remote = origin
>           merge = refs/heads/master
> 
> What's causing this?  Is it a bug?

Same for me with git version 1.7.3.2 on Debian Etch.
Seems to be a problem with the popen() returning too early or
the interpreter dying too early.

This works though:

$ python -c "import subprocess; subprocess.call(['git', 'clone', 'git://host/repoo.git'])"

Regards,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: I is knot dain bramaged!
