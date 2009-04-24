From: David Aguilar <davvid@gmail.com>
Subject: Re: How to sync changes in GIT to ClearCase or How to get the list
	of files changed in GIT for a specific branch
Date: Thu, 23 Apr 2009 21:31:15 -0700
Message-ID: <20090424043114.GC15612@gmail.com>
References: <23197522.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: ask4thunder <ask4thunder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 06:33:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxD5y-0005YJ-KE
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 06:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbZDXEba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 00:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754486AbZDXEba
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 00:31:30 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:24938 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756005AbZDXEb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 00:31:29 -0400
Received: by wa-out-1112.google.com with SMTP id j5so461016wah.21
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 21:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=s7KQGEHcuva0cyDxUCuMOWYcJ2mI7IwFI6gyhvchy74=;
        b=xSuLcGYkzA+N+/W4+mYBgBp5/HERa6LClT+kEQedoToS+hTbQXVGru4igL+h1jyp8N
         O7Yc9aYoevmPTmvbLIREeIfosz+UQtj12IhQbOB1OYbZpkSp08VMhGuc/h0GUTTfg7QT
         9SJhBSIEv9E0ElN9nfbTwaeSMaUmUqqYiymPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=It4NTvumWR89HTiUp8sXY55gAcQi21PYar1Zk7Z4SHuG9J/nISrnjxdbJxGpzlx9tN
         QGbiIialX7QQltTjcN3IbY9UyWNuOGtFQ1wam2iTO11ee1fpJH929Y5WrPK5WYQ79/GJ
         16St7NcsvhN6PxBtVmrlZJbhNSkSHWryHSoUo=
Received: by 10.115.32.8 with SMTP id k8mr1130182waj.54.1240547487369;
        Thu, 23 Apr 2009 21:31:27 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n40sm1085642wag.52.2009.04.23.21.31.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 21:31:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <23197522.post@talk.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117407>

On  0, ask4thunder <ask4thunder@gmail.com> wrote:
> 
> I am intending to use ClearCase in the background and GIT in the front.
> For syncing files from ClearCase to GIT i 
> checkout the git branch
> use rsync command to get the changed files in ClearCase
> and then i do the 'git add' and 'git commit'

To handle files that have been removed make sure to use
	rsync --exclude=.git --delete ...

and
	git add -u

to remove any deleted files from git.


> This works out well, but i want to get a list of files changed in GIt so
> that i can bring that to ClearCase and checkout and checkin files.
> 
> Can someone provide me the commands to
> 
> 1. Get list of files changed in GIT, after i do commit?


One possibility:

move to the root of the clearcase project

set GIT_DIR to point to the .git directory
(which, presumably is outside the clearcase project)

and some combination of:
	git diff --name-only
	git diff-index --name-status HEAD

If clearcase wasn't so painful you would ideally just
run 'git checkout -f' to make clearcase match git,
but clearcase is horrible and you have to explicitly
'clearcase checkout' each file.


> 2. Get list of files changed in GIT after commit, but files changed after a
> tag (baseline).

	git diff --name-only <the-commit>^!

	git diff --name-only <the-tag>..HEAD

(or diff-index, etc)


> 3. Sync these files to ClearCase?

	clearcase checkout the <path>
	git checkout HEAD -- <path>

	(assuming you've set GIT_DIR accordingly
	 and are sitting at the root of the project)


> Hope you gurus can help me....am in desperate need of these commands. 
> Appreciate your help  in this.

If you get this stuff working with native clearcase commands,
then others could benefit from your work.

bi-directional git<->cc can be tricky (and importing all of
branches can be even trickier), but even being able to import
one branch is better than nothing, no?

The reason I replied is that I, too, once wrote a similar
tool to suck cc projects into git.  One project
was so huge (and cc sucks so bad) that it
literally took a few weeks for it to import.

Our organization also ran vob backups at 2am everynight,
so I couldn't just let it run continuously since clearcase
would lock the script out at 2am.

It ran incrementally, and lots of other site-specific
hacks.  I don't know clearcase at all (our site used a bunch
of in-house wrapper commands) so I never bothered to make
it work with raw cc commands. That's why I have nothing
to share.  It was also a total hack and once I got the stuff
I wanted out of it, you can bet that I never looked back
(which is why the bi-directional part was not important
 to me at all).


clearcase.. wow <shudders>

All it does is remind me of this horrible, horrible cc mvfs
kernel module bug that was going around deleting automounts...

okay.. enough scary thoughts.


kudos for fighting the good fight,

-- 

	David
