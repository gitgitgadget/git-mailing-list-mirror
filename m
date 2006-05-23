From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: file name case-sensitivity issues
Date: Tue, 23 May 2006 22:43:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0605232239070.15915@dildano.hawaga.org.uk>
References: <20060523210615.GB5869@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 24 00:43:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FifbL-0003wQ-Im
	for gcvg-git@gmane.org; Wed, 24 May 2006 00:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWEWWnj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 18:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWEWWnj
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 18:43:39 -0400
Received: from dildano.hawaga.org.uk ([81.187.211.37]:40154 "EHLO
	dildano.hawaga.org.uk") by vger.kernel.org with ESMTP
	id S932256AbWEWWnj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 18:43:39 -0400
Received: from dildano.hawaga.org.uk (localhost.localdomain [127.0.0.1])
	by dildano.hawaga.org.uk (8.13.6/8.13.6/Debian-1) with ESMTP id k4NMhGxS030664;
	Tue, 23 May 2006 22:43:16 GMT
Received: from localhost (benc@localhost)
	by dildano.hawaga.org.uk (8.13.6/8.13.6/Submit) with ESMTP id k4NMhFdS030660;
	Tue, 23 May 2006 22:43:15 GMT
X-Authentication-Warning: dildano.hawaga.org.uk: benc owned process doing -bs
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060523210615.GB5869@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20645>


On OS X using whatever filesystem it comes with by default, I get the 
following, which doesn't seem right (but in a different way).

$ mkdir case-sensitivity-test
$ cd case-sensitivity-test
$ git init-db
defaulting to local storage area
$ echo foo > foo
$ echo bar > bar
$ git add foo bar
$ git commit -m initial\ commit
Committing initial tree 89ff1a2aefcbff0f09197f0fd8beeb19a7b6e51c
$ git checkout -b side
$ echo bar-side >> bar
$ git commit -m side\ commit -o bar
$ git checkout master
$ rm foo
$ git update-index --remove foo
$ echo FOO > FOO
$ git add FOO
$ git commit -m case\ change
$ ls
FOO bar
$ git pull . side
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging HEAD with e1f1e78035b099fad2bbfb82af7ec31864d8e4c1
Merging: 
5d70969775bf595dd5144a2bacc25d32cc288352 case change 
e1f1e78035b099fad2bbfb82af7ec31864d8e4c1 side commit 
found 1 common ancestor(s): 
e35c42fad4f08c2ccf61d93409a0208e92028a51 initial commit 

Merge 98bf1cae75776c141ad3b61dc2cb938c71c303ef, made by recursive.
 bar |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
$ 
$ ls
bar
$ git ls-files -d
FOO
$ git ls-tree HEAD
100644 blob b7d6715e2df11b9c32b2341423273c6b3ad9ae8a    FOO
100644 blob 5f8b81e197a2cb27816112fb5a6b86b7031ffde8    bar

The checkout is losing the FOO file but the merged tree object has the 
merged FOO in it.

-- 
