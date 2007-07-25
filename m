From: Steffen Prohaska <prohaska@zib.de>
Subject: easy repository initialization that turned out not to be that easy
Date: Wed, 25 Jul 2007 22:05:10 +0200
Message-ID: <0EAD32C5-11DA-4B99-919D-87C0006A389C@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 22:04:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDn5o-0007xV-Dx
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 22:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbXGYUES (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 16:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbXGYUES
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 16:04:18 -0400
Received: from mailer.zib.de ([130.73.108.11]:36799 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbXGYUER (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 16:04:17 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6PK4FtW029164
	for <git@vger.kernel.org>; Wed, 25 Jul 2007 22:04:15 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1b655.pool.einsundeins.de [77.177.182.85])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6PK4Epl004070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 25 Jul 2007 22:04:15 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53711>

I stumbled about some tasks that I expected to be easy but
turned out not to be that easy ...

(with git version 1.5.3.rc2.29.gc4640f)


1) How can I switch a private repository to shared as if it
was created by 'git-init --shared' in the first place?

Just executing 'git-init --shared' in the repo doesn't
adjust permissions as needed.

Cloning it to shared doesn't work either because the meaning
of 'git-clone --bare --shared' is different from
'git-init --shared'.

So I created a fresh repository

    mkdir shared.git
    cd shared.git
    git --bare init --shared

and tried to naively fetch all by executing

    git fetch ../private.git

Hmm... it does a lot of things, but I ended without branches.
fetch apparently has nothing like '--all'.

... but push has, so I finally did

    cd ../private.git
    git push --all ../shared.git
    git push --tags ../shared.git

Note, 'git push --all --tags' refused to work, so I needed
to push branches and tags separately.

Is it really that hard, or did I miss something?


2) How can I set up an empty bare repository that shares
objects with an existing repository? I'd like to do that
to save space and bandwidth.

I started to search for something like 'git init --reference'
or 'git init -l', similar to what 'git clone' provides.

I don't remember all approaches I tried, but finally I used

    git clone --bare -l existing.git new.git
    cd new.git
    mv refs/head/master .
    rm -rf refs/heads/* refs/tags/*
    mv master refs/heads

I remember that I needed to leave the master in place because
otherwise a 'git push' didn't recognize that objects are already
present and transferred everything, which is quite annoying over
a slower network connection. With master in place the first push
to new.git worked as expected. Only the additional objects were
sent.

Did I miss something?

	Steffen
