From: Justin Spahr-Summers <justin.spahrsummers@gmail.com>
Subject: Re: Bug: Recursive submodules fail when the repo path contains
 spaces
Date: Sun, 29 Jul 2012 12:30:14 -0700
Message-ID: <FE466454ECCE48A19472B85D1C92E9E2@gmail.com>
References: <1CE02EC2D88646D48EE7B7D71AD36234@gmail.com>
 <500F00C7.4040209@web.de> <7va9yogb37.fsf@alter.siamese.dyndns.org>
 <9ADC1C4EF43A4237BC7971884C50C0EB@gmail.com>
 <CABURp0rM_zkA0Hb=kkJcEeqWBX0qgRqH-zviW8ofp-qQqkW6uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Phil Hord <phil.hord@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 29 21:31:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvZCg-00047O-0d
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 21:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab2G2TaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 15:30:20 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48797 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab2G2TaS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 15:30:18 -0400
Received: by pbbrp8 with SMTP id rp8so8532343pbb.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=UEpeev6aXE40ngAn0VCBRz2ViADoJjxCavALXa1ydOU=;
        b=QBklpQOmginAO1WiZ0wRqVCydWIvdtNUsRjPG4dYr1UaMnMhXAUkde1kYWV4ftvEFb
         RYQ6CuDFMTYg+RzwbzGj0bAo9BlwtMqiqfhtT8f7NVbRpyTm/x0IZnaNykwbfcmrUk0I
         GoCSi+dV67DD+g0UzKoK4hXokfkl9HDSWeBE0YiRDRhujWhTC8t4wo94JRuo1xfQNyMj
         BtcCby9Rl5iRRjma0HluYdSxkqiTeH+BJznwgRWaDScn83H01ffHWKirpt+TKp3a8Ydx
         6DAvC0ZsEdgjw0REdvcIt/S1Z+oFOLVcGw2CBGfIxOIExhFaluZDJG8bu4U/xMEGlhjG
         MFjg==
Received: by 10.68.125.228 with SMTP id mt4mr29930965pbb.21.1343590218258;
        Sun, 29 Jul 2012 12:30:18 -0700 (PDT)
Received: from [10.168.1.100] (c-24-16-145-254.hsd1.wa.comcast.net. [24.16.145.254])
        by mx.google.com with ESMTPS id gj10sm6310887pbc.18.2012.07.29.12.30.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jul 2012 12:30:16 -0700 (PDT)
In-Reply-To: <CABURp0rM_zkA0Hb=kkJcEeqWBX0qgRqH-zviW8ofp-qQqkW6uw@mail.gmail.com>
X-Mailer: sparrow 1.6.2 (build 1143.6)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202492>

On Sunday, 29. July 2012 at 11:31, Phil Hord wrote:
> On Tue, Jul 24, 2012 at 4:33 PM, Justin Spahr-Summers
> <justin.spahrsummers@gmail.com (mailto:justin.spahrsummers@gmail.com)> wrote:
> > On Tuesday, 24. July 2012 at 13:26, Junio C Hamano wrote:
> > > Jens Lehmann <Jens.Lehmann@web.de (http://web.de)> writes:
> > > 
> > > > Am 24.07.2012 21:01, schrieb Justin Spahr-Summers:
> > > > > This occurs on Mac OS X 10.7.4, on git versions 1.7.10.2 (Apple Git-33) and 1.7.11.3.
> > > > > 
> > > > > Steps:
> > > > > 1. Create or clone a repository to an absolute path that contains spaces.
> > > > > 2. Add a submodule to the repository, if it does not already have one.
> > > > > 3. Within that submodule, attempt to add another submodule.
> > > > > 
> > > > > The result is an error "fatal: Not a git repository", followed by the relative path to the submodule directory within .git/modules of the top-level repository.
> > > > > 
> > > > > Similarly, using "git submodule update --init --recursive" in a freshly-cloned repository that matches the above configuration will fail with the same error. "git clone --recursive" does not seem to suffer from the same problem at clone time, but will still fail to add recursive submodules.
> > > > 
> > > > Hmm, I don't understand how that is different from what t7407 does, it uses
> > > > "git submodule update --init --recursive" in to populate recursive submodules
> > > > in a freshly cloned repository whose path contains a space (in the trash
> > > > directory name) in test number 8.
> > > 
> > > 
> > > 
> > > 
> > > 
> > > I can see one codepath that would behave incorrectly, especially if
> > > the submodule path relative to the superproject has whitespaces in
> > > it. In module_clone(), you have:
> > > 
> > > # We already are at the root of the work tree but cd_to_toplevel will
> > > # resolve any symlinks that might be present in $PWD
> > > a=$(cd_to_toplevel && cd "$gitdir" && pwd)/
> > > b=$(cd_to_toplevel && cd "$sm_path" && pwd)/
> > > ...
> > > # Turn each leading "*/" component into "../"
> > > rel=$(echo $b | sed -e 's|[^/][^/]*|..|g')
> > > echo "gitdir: $rel/$a" >"$sm_path/.git"
> > > 
> > > I _think_ $sm_path is computed correctly by the codeflow leading to
> > > this place, and $b is also computed correctly, but notice the lack
> > > of quoting around $b when you echo it? It will be split at $IFS, so
> > > if b='/Program Files/My Stupidity/', the sed script will see a
> > > single SP between My and Stupidity, which is different from what you
> > > wanted to feed, I presume.
> > > 
> > > Having said that, I do not think git-submodule is prepared to take
> > > paths with path-unsafe characters in it, given that many part of it
> > > has loops like "while read mode sha1 stage sm_path" that reads from
> > > ls-files/ls-tree output without -z (which means it cannot handle
> > > pathnames with LF in them).
> > > 
> > > My recommendation at this point (i.e. not a long term) for people
> > > with problems Justin saw is "Don't do it then".
> > 
> > 
> > 
> > I appreciate the debugging work. Unfortunately, none of the relative submodule paths have had whitespace in them, so I'm not sure that's the issue.
> > 
> > Here's some real output, with a couple specific names removed, starting from the root of the top-level repository (where External/twui is a submodule):
> > 
> > $ cd External/twui
> > $ git submodule add git://github.com/petejkim/expecta.git (http://github.com/petejkim/expecta.git) TwUITests/expecta
> > Cloning into 'TwUITests/expecta'...
> > remote: Counting objects: 988, done.
> > remote: Compressing objects: 100% (404/404), done.
> > remote: Total 988 (delta 680), reused 842 (delta 535)
> > Receiving objects: 100% (988/988), 156.30 KiB, done.
> > Resolving deltas: 100% (680/680), done.
> > fatal: Not a git repository: ../../../../../../../../Volumes/drive name with spaces/Users/justin/Documents/Programming/project name with spaces/.git/modules/External/twui/modules/TwUITests/expecta
> 
> 
> 
> I saw something similar before but I was unable to reproduce the
> conditions. In my case, my superproject was cloned with an earlier
> version of git and some new submodule behaviors seemed to cause me
> problems.
> 
> Is "project name with spaces" a freshly cloned project also using,
> say, 1.7.11.3?
> 
> I am not able to reproduce the problem here on Linux using your same
> example command.

Hmm, you're right. After further investigation, this actually looks like a weird issue with soft links. Here's some exact output (with spacing only for clarity), using a public test repository at https://github.com/jspahrsummers/recursive-submodules-test:

justin:~/ $ ls -l HDD
lrwxr-xr-x 1 justin staff 34 5 Jan 2012 HDD -> /Volumes/fadelah data/Users/justin

justin:~/ $ cd HDD
justin:HDD/ $ pwd
/Users/justin/HDD

justin:HDD/ $ git clone git@github.com:jspahrsummers/recursive-submodules-test.git
Cloning into 'recursive-submodules-test'...
remote: Counting objects: 6, done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 6 (delta 1), reused 5 (delta 0)
Receiving objects: 100% (6/6), done.
Resolving deltas: 100% (1/1), done.

justin:HDD/ $ cd recursive-submodules-test
justin:recursive-submodules-test/ (git)-[master] $ git submodule update --init --recursive
Submodule 'objective-git' (git://github.com/libgit2/objective-git.git) registered for path 'objective-git'
Cloning into 'objective-git'...
remote: Counting objects: 2990, done.
remote: Compressing objects: 100% (981/981), done.
remote: Total 2990 (delta 2138), reused 2751 (delta 1915)
Receiving objects: 100% (2990/2990), 7.20 MiB | 1.21 MiB/s, done.
Resolving deltas: 100% (2138/2138), done.
Submodule path 'objective-git': checked out '58d0dc708876038e0db34447a176614956f3f480'
Submodule 'libgit2' (git://github.com/libgit2/libgit2.git) registered for path 'libgit2'
Cloning into 'libgit2'...
remote: Counting objects: 19703, done.
remote: Compressing objects: 100% (5743/5743), done.
remote: Total 19703 (delta 14448), reused 18712 (delta 13585)
Receiving objects: 100% (19703/19703), 5.87 MiB | 498 KiB/s, done.
Resolving deltas: 100% (14448/14448), done.
fatal: Not a git repository: ../../../../../../Volumes/fadelah data/Users/justin/recursive-submodules-test/.git/modules/objective-git/modules/libgit2
Failed to recurse into submodule path 'objective-git'
