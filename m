From: david@lang.hm
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 12:46:06 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810241244170.27333@asgard.lang.hm>
References: <gdok16$vh2$1@ger.gmane.org> <4901077A.7050904@gmx.ch>  <cb7bb73a0810232355u6de0479cyc260c80227f44e59@mail.gmail.com>  <m38wsei8ne.fsf@localhost.localdomain>  <7vabct3l1e.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.10.0810241159290.27333@asgard.lang.hm>
 <cb7bb73a0810241242y7467f6fexcca4b7cd768e7992@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jean-Luc Herren <jlh@gmx.ch>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 21:47:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtSce-0005si-Fs
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 21:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbYJXTpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 15:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754048AbYJXTpu
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 15:45:50 -0400
Received: from mail.lang.hm ([64.81.33.126]:44972 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334AbYJXTps (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 15:45:48 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m9OJjNm9020637;
	Fri, 24 Oct 2008 12:45:23 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <cb7bb73a0810241242y7467f6fexcca4b7cd768e7992@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99055>

On Fri, 24 Oct 2008, Giuseppe Bilotta wrote:

> I was slowly writing a reply but it seems David beat me to it, so here
> goes a couple of additional comments.
>
> On Fri, Oct 24, 2008 at 9:11 PM,  <david@lang.hm> wrote:
>> On Fri, 24 Oct 2008, Junio C Hamano wrote:
>>> Running "git init" in an empty directory consumes about 100k of diskspace
>>> on the machine I am typing this on, and you should be able to share most
>>> of them (except one 41-byte file that is the branch tip ref) when you
>>> track many files inside a single directory by using a single repository,
>>> one branch per file (or "one set of branches per file") model.
>>
>> the reason to use seperate repos is to ease the work involved if you need to
>> move that file (and it's repo) elsewhere.
>
> Precisely. The one-repo-per-file is just the simplest and most
> flexible solution. But yes, I have to admit I hadn't looked into disk
> usage, and indeed we should try and squeeze this as much as possible.
>
>> with the git directory being under .zit, would it be possible to link the
>> things that are nessasary togeather?
>
> I'm not sure about _which_ files could be shared.
>
>> hmm, looking at this in more detail.
>>
>> about 44K of diskspace is used by the .sample hook files, so those can be
>> removed
>
> Exactly. I'm setting up zit to prepare its repos to a more compact
> form, and getting rid of hooks and description is the first step.
>
>> the remaining 56K is mostly directories eating up a disk block
>>
>> find . -ls
>> 200367    4 drwxr-xr-x   7 dlang    users        4096 Oct 24 12:00 .
>> 200368    4 drwxr-xr-x   4 dlang    users        4096 Oct 24 12:00 ./refs
>> 200369    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00
>> ./refs/heads
>> 200370    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00
>> ./refs/tags
>> 200371    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00
>> ./branches
>> 200372    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00 ./hooks
>> 200373    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00 ./info
>> 1798469   4 -rw-r--r--   1 dlang    users         240 Oct 24 12:00
>> ./info/exclude
>> 1600716   4 -rw-r--r--   1 dlang    users          58 Oct 24 12:00
>> ./description
>> 200374    4 drwxr-xr-x   4 dlang    users        4096 Oct 24 12:00 ./objects
>> 200375    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00
>> ./objects/pack
>> 200376    4 drwxr-xr-x   2 dlang    users        4096 Oct 24 12:00
>> ./objects/info
>> 1600717   4 -rw-r--r--   1 dlang    users          23 Oct 24 12:00 ./HEAD
>> 1600719   4 -rw-r--r--   1 dlang    users          92 Oct 24 12:00 ./config
>>
>> how many of these are _really_ nessasary?
>
> For starters, I'm wondering if setting core.preferSymlinkRefs would be
> useful here. Does it break sometihng?
>
>> tags, info, hooks, branches, and description could probably be skipped for
>> the common zit case, as long as they can be created as needed.
>
> It seems that tags, hooks, branches and description can be done with.

do you mean 'can be done away with'?

> info contains exclude which is rather essential,

is it? by default everything in this file is commented out. And with you 
only adding files explicitly why would it ever need to excluded anything?

David Lang
