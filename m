From: david@lang.hm
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 12:11:35 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810241159290.27333@asgard.lang.hm>
References: <gdok16$vh2$1@ger.gmane.org> <4901077A.7050904@gmx.ch> <cb7bb73a0810232355u6de0479cyc260c80227f44e59@mail.gmail.com> <m38wsei8ne.fsf@localhost.localdomain> <7vabct3l1e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jean-Luc Herren <jlh@gmx.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 21:12:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtS5U-0002Us-0H
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 21:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbYJXTLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 15:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbYJXTLd
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 15:11:33 -0400
Received: from mail.lang.hm ([64.81.33.126]:37575 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505AbYJXTLc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 15:11:32 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m9OJAr5g020410;
	Fri, 24 Oct 2008 12:10:57 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7vabct3l1e.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99051>

On Fri, 24 Oct 2008, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
>>> On Fri, Oct 24, 2008 at 1:23 AM, Jean-Luc Herren <jlh@gmx.ch> wrote:
>>
>>>> If you decide against a shared repository, maybe you want to
>>>> consider to not use ".zit.file/", but ".zit/file/" as the
>>>> repository?  This would reduce the clutter to a single directory,
>>>> just like with ".git".  And moving files around wouldn't be that
>>>> much complicated.
>>>
>>> Right. I'll give that a shot.
>>
>> By the way RCS which I use for version control of single files use
>> both approaches: it can store 'file,v' alongside 'file' (just like
>> your '.zit.file/' or '.file.git/'), but it can also store files on
>> per-directory basis in 'RCS/' subdirectory (proposed '.zit/file/' or
>> '.zit/file.git/' solution)
>
> I am not opposed to the wish to track a single file (but I have to say I
> am not personally in need for such a feature), but I have to wonder from
> the technical point of view if one-repo-per-file is the right approach.
>
> Running "git init" in an empty directory consumes about 100k of diskspace
> on the machine I am typing this on, and you should be able to share most
> of them (except one 41-byte file that is the branch tip ref) when you
> track many files inside a single directory by using a single repository,
> one branch per file (or "one set of branches per file") model.

the reason to use seperate repos is to ease the work involved if you need 
to move that file (and it's repo) elsewhere.

with the git directory being under .zit, would it be possible to link the 
things that are nessasary togeather?

hmm, looking at this in more detail.

about 44K of diskspace is used by the .sample hook files, so those can be 
removed

the remaining 56K is mostly directories eating up a disk block

find . -ls
200367    4 drwxr-xr-x   7 dlang    users        4096 Oct 24 12:00 .
200368    4 drwxr-xr-x   4 dlang    users        4096 Oct 24 12:00 ./refs
200369    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00 ./refs/heads
200370    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00 ./refs/tags
200371    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00 ./branches
200372    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00 ./hooks
200373    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00 ./info
1798469   4 -rw-r--r--   1 dlang    users         240 Oct 24 12:00 ./info/exclude
1600716   4 -rw-r--r--   1 dlang    users          58 Oct 24 12:00 ./description
200374    4 drwxr-xr-x   4 dlang    users        4096 Oct 24 12:00 ./objects
200375    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00 ./objects/pack
200376    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00 ./objects/info
1600717   4 -rw-r--r--   1 dlang    users          23 Oct 24 12:00 ./HEAD
1600719   4 -rw-r--r--   1 dlang    users          92 Oct 24 12:00 ./config

how many of these are _really_ nessasary?

tags, info, hooks, branches, and description could probably be skipped for 
the common zit case, as long as they can be created as needed.

If git has problems with these not existing, would it make sense to make 
git survive if they are missing and create them if needed?

the objects directory will eat up more space as revisions are checked in 
(and more sub-directories are created), would it make sense to have a 
config option to do a flat objects directory instead of the current 
fan-out?

the other option with objects would be to look into having a common 
objects fan-out directory, but have the pack directory be per file. This 
would allow you to seperate out one files stuff by creating packs for it 
and then grabbing everything in the per-file directory.

thoughts?

David Lang
