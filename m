From: david@lang.hm
Subject: Re: Using a git repository on the root directory
Date: Fri, 16 Apr 2010 21:45:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.01.1004162120490.16996@asgard.lang.hm>
References: <q2k3e2876431004161344vfff638a7ncfa74aa0e3b979dc@mail.gmail.com> <4BC9364D.7020204@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Miguel Ramos <mail@miguel.ramos.name>, git@vger.kernel.org
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 06:45:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2zuW-0004Yd-1W
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 06:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab0DQEpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 00:45:34 -0400
Received: from mail.lang.hm ([64.81.33.126]:37700 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088Ab0DQEpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 00:45:33 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id o3H4j1lT003316;
	Fri, 16 Apr 2010 21:45:01 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <4BC9364D.7020204@gmail.com>
User-Agent: Alpine 2.01 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145114>

On Sat, 17 Apr 2010, Gabriel Filion wrote:

> On 2010-04-16 16:44, Miguel Ramos wrote:
>> Hi,
>>
>> Is it possible with git to use a git repository on the root directory?
>> I'm trying to replace subversion doing this.
>> I used this method before to get my home directory versioned with
>> success, so far.
>>
>
> Although I'll give comments on the rest, is it really relvant to put all
> of the filesystem into a version control system? From a system
> administrator's point of view, backing up is more about keeping copies
> of what's important in the computer than about versioning every tiny
> change in the file system.

every tiny change in the filesystem could be important. it takes a lot of 
time to examine every package your distro creates to be sure that you know 
what files in it are important and what ones aren't.

In addition, if you need the ability to recreate a system later 
(potentially years later, after the distro mirrors have stopped carrying 
that version), even the binaries can be important.

> One example of something that is weird to backup is /var . It contains
> data that will almost certainly always change.

that's what .gitignore is for

> A simpler thing to do if you'd like to be able to reinstall a computer
> real quick would be to make an image of the computer (call it a ghost, a
> dd of all the disk or whatever) and to establish a backup only for the
> sensible data (say, for an LDAP server, you would backup ldap's ldiff
> files and configuration). Then, restoring from a crash would just mean
> to reinstall with the image of the disk and to restore the latest backup.

if you do this you run the risk of missing some critical file from your 
backup

your approach is 'back up only what I know I need to', using git and 
.gitignore it becomes 'back up everything except what I know I don't want 
to' (and there is a surprising amount of stuff in /var that you may need 
to backup)

if you have one very standard image then you may have a really good image 
to use, but if you want more variety in your systems the git approach 
gives you automatic deduplication of your backed up data, as well as very 
efficient delta compression between similar files on different systems.

the ease in maintaining replicas of the data is just another bonus.

it may not suit your environment, but there are some very attractive 
features here. Compare this to any backup software and (except for git not 
storing permissions) you will find that the feature sets look very 
similar. After all, in both cases you are archiving data so that you can 
go back in history as needed so it's substantially the same problem

David Lang

>> When I'm on the root directory, things seem to work minimally. I do
>> git status, etc, and get the expected results.
>> However, if I change say to /etc, or any other directory, for that
>> matter, then git status tells me that every file in the repository is
>> deleted.
>> Adding files doesn't work, nothing works at all.
>>
>
> This sounds like an issue with finding the actual .git directory when
> you are in /etc. is this directory under a different partition than / ?
>
>> I have a populated repository elsewhere, I can clone this to an empty
>> directory and then move .git to / to work around the demand that the
>> target directory is empty and at the same time avoid overwriting
>> files.
>
> so, you're cloning to some temp dir, then moving temp/.git to / and then
> using something like git checkout HEAD some/file/somewhere ?
>
>> I know this is an unforeseen use of git, however, unforeseen might not
>> imply forbidden.
>> I'm pretty disappointed I couldn't get it working.
>>
>> So the motivation for this posting is twofold:
>> - Is this possible in some other way, or did I do something wrong (I'm
>> new to git) ?
>
> Check out the bup project[1], it uses the packfile format from git to
> compress data but its focus is more on keeping versions of arbitrary
> data rather than code files. it's still very new and lacks some
> important features but it sure is promising.
>
> [1] : http://github.com/apenwarr/bup
>
>
