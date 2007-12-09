From: Wink Saville <wink@saville.com>
Subject: Re: How-to combine several separate git repos?
Date: Sun, 09 Dec 2007 15:44:21 -0800
Message-ID: <475C7DD5.9040209@saville.com>
References: <475B8C59.7050707@saville.com> <20071209104336.GA3163@steel.home> <475C3E25.30704@saville.com> <Pine.LNX.4.64.0712091445470.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 00:44:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1VpG-000459-F1
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 00:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbXLIXoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 18:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbXLIXoY
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 18:44:24 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:5028 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbXLIXoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 18:44:23 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1404162rvb
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 15:44:23 -0800 (PST)
Received: by 10.140.88.42 with SMTP id l42mr696362rvb.1197243862917;
        Sun, 09 Dec 2007 15:44:22 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id c36sm4495505rvf.2007.12.09.15.44.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Dec 2007 15:44:22 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <Pine.LNX.4.64.0712091445470.5349@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67664>

Daniel Barkalow wrote:
> On Sun, 9 Dec 2007, Wink Saville wrote:
>
>   
> I think that submodules do what you want. And they may not be ready for 
> neophytes to just use, but they're ready for neophytes to try using and 
> tell us where things get confused.
>   
<snip>
> 	-Daniel
I would like to try submodules and started to  read the man


I'll try submodules and I'll start by reading the man page,
I got to "add" and did the following:

wink@ic2d1:$ mkdir x
wink@ic2d1:$ cd x
wink@ic2d1:$ git init
Initialized empty Git repository in .git/
wink@ic2d1:$ git-submodule add ../android/StateMachine
remote (origin) does not have a url in .git/config
you must specify a repository to clone.
Clone of '' into submodule path 'StateMachine' failed

The documentation for "submodule add" says:

/git-submodule/ [--quiet] [-b branch] add <repository> [<path>]
Add the given repository as a submodule at the given path to the 
changeset to be committed next.

 From the above, <path> is ambiguous to me, is it referring to the 
source or destination. I continue reading and in the options section we 
find:

<path>

    Path to submodule(s). When specified this will restrict the command
    to only operate on the submodules found at the specified paths.


So it seems <path> is the for the source, but some how it can specify 
multiple paths. This seems to imply that I could add my three 
repositories with one command. But I have no idea how and there are no 
examples, but I can guess for my three repositories maybe:

wink@ic2d1:$ rm -rf *
wink@ic2d1:$ git init
Initialized empty Git repository in .git/
wink@ic2d1:$ git add submodule ../android StateMachine test2 test-annotation
fatal: '../android' is outside repository

Nope that didn't work, continue reading, ah I probably need to 
"submodule init" first.
It says:

init

    Initialize the submodules, i.e. register in .git/config each
    submodule name and url found in .gitmodules. The key used in
    .git/config is submodule.$name.url. This command does not alter
    existing information in .git/config.

This is garbally-gok to me (remember, neophyte) but it does leave a clue,
apparently I need to create .gitmodules so I do:

wink@ic2d1:$ cat .gitmodules
[submodule "StateMachine"]
        path = StateMachine
        url = ../android/StateMachine

[submodule "test2"]
        path = test2
        url = ../android/test2

[submodule "test-annotation"]
        path = test2
        url = ../android/test-annotation

So now I:

wink@ic2d1:$ cd ..
wink@ic2d1:$ rm -rf x
wink@ic2d1:$ mkdir x
wink@ic2d1:$ cd x
wink@ic2d1:$ git init
Initialized empty Git repository in .git/
wink@ic2d1:$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
wink@ic2d1:$ cp ../gitmodules .gitmodules
wink@ic2d1:$ cat .gitmodules
[submodule "StateMachine"]
        path = StateMachine
        url = ../android/StateMachine

[submodule "test2"]
        path = test2
        url = ../android/test2

[submodule "test-annotation"]
        path = test2
        url = ../android/test-annotation

wink@ic2d1:$ git submodule init
wink@ic2d1:$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true


That's not what I expected according to the documentation I was
expecting .git/config to now contain the [submodule "xxx"] sections
from .gitmodules? But maybe I've got to "submodule add" first or ...

Well, this isn't getting me anywhere so Daniel, I hope that gives
you some insight from a newbies point of view.

My first comment is that needs to be some examples in git submodule help.
Second, I'd suggest .gitmodules be called .gitsubmodules and that
the documentation have a related name. I went into the git/Documentation
directory in my clone of git and looked for "find . -iname '*sub*' and
the only relevant the files were for git-submodule I see no reason for there
not be a a .gitsubmodule. Actually, at the moment I see no reason for
this file at all, but that will probably become apparent soon:)
 
Note, my git current version is:

wink@ic2d1:$ git --version
git version 1.5.3.5.622.g6fd7a

I've cloned git and built locally so I can change to what ever version
is appropriate. For now I'll search around on the web


Thanks,

Wink Saville
