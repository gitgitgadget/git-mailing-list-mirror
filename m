From: Chris Packham <judge.packham@gmail.com>
Subject: Fwd: [BUG?] fetching via file:// vs ssh://
Date: Fri, 10 Aug 2012 13:03:53 +1200
Message-ID: <CAFOYHZBGuuNY1WqAT_Tk7-ENtSweafuOhf9sw+y6p1Zr4wWxaw@mail.gmail.com>
References: <CAFOYHZBm7uOHtDhBJaMO9=u4BEsbLdhPUAHra6Pyd9TGONAa3Q@mail.gmail.com>
	<CAPc5daUuRc4JgxZwG0QG0WX5aCTAs3B73j7xp5FoPH89_ZpoHg@mail.gmail.com>
	<CAFOYHZAa10Ukya8-Er1rRSKaWW_z+u5cStXNOihVxZqt14qe+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 03:04:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szddz-0004bA-PK
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 03:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756052Ab2HJBD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 21:03:57 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:38636 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab2HJBDz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 21:03:55 -0400
Received: by weyx8 with SMTP id x8so673276wey.19
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 18:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=yC9Vj76X3PTpWmjCMuEpl9iDbnB9QcT0+7ki0DEHwB4=;
        b=INof0CBtM5cOfZ2gVu9ZgbiuIQNu6Ypwq3OpscCSxE3qQGsduFFnknIOGWcZiLFh8Z
         ukLlvYzhhvsBbmnIfJcHZJpKi4CoCzXU1+V5I2p2fZkNRUG3ks7Aq9WyanuDAF2ytya6
         +KyPveNEmYttOF15373pR2yaFDKSlaQVnpZiB14JZmByzxMwt8e+9PHDD1PcO/tKkUe1
         WJ2nkeXlkJSPK9Z8osYNW+TQhRB40kIrlFLhXRkDKRGdFOnDkv0tkiYWrveYkxahuuJz
         cXVs9LokUfHCniBalgJkyoh3GHJgYPjFOAHmJlLywiH1vFoOzd1khFjr1sFbDX7o7NoG
         Hgrw==
Received: by 10.180.85.167 with SMTP id i7mr1461561wiz.8.1344560633847; Thu,
 09 Aug 2012 18:03:53 -0700 (PDT)
Received: by 10.216.160.17 with HTTP; Thu, 9 Aug 2012 18:03:53 -0700 (PDT)
In-Reply-To: <CAFOYHZAa10Ukya8-Er1rRSKaWW_z+u5cStXNOihVxZqt14qe+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203195>

(Junio, sorry for the spam. Using the gmail web interface which hides
the reply all option)

On Fri, Aug 10, 2012 at 12:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> File:///n/a/b/c and /n/a/b/c behave differently, and the former is more like
> ssh://host/n/a/b/c.

So it does.

  $ git remote add -f rmt3 file:///net/path/to/backup/repo
  Updating rmt3
  From file:///net/path/to/backup/repo
   * [new branch]      master     -> rmt3/master

I did try it before sending my original email however I neglected to
put in the third '/' and got a different error, assumed it was the
same as the first. Even better the tab completion works!

> On Aug 9, 2012 5:44 PM, "Chris Packham" <judge.packham@gmail.com> wrote:
>>
>> Hi,
>>
>> At $dayjob we have backups setup for developers using a post-commit
>> hook that rsyncs the local .git directory to a backup server. The
>> advantage we get of using rsync instead of git push is that we also
>> backup the things that git push doesn't touch (e.g. config, hooks,
>> metadata from other tools). A happy side effect of this method is that
>> when we want to share code people can just fetch it from backup server
>> via nfs.
>>
>> This is where my current problem lies. On a plain repository I can simply
>> run
>>
>>   $ git remote add -f rmt /net/path/to/backup/repo
>>
>> However on a repository that is a submodule with a relocated .git
>> directory I get the following
>>
>>   $ git --version
>>   git version 1.7.12.rc2.16.g034161a
>>
>>   $ git remote add -f rmt /net/path/to/backup/repo
>>   Updating rmt
>>   remote: fatal: Could not chdir to '../../../repo': No such file or
>> directory
>>   error: git upload-pack: git-pack-objects died with error.
>>   fatal: git upload-pack: aborting due to possible repository
>> corruption on the remote side.
>>   remote: aborting due to possible repository corruption on the remote
>> side.
>>   fatal: protocol error: bad pack header
>>   error: Could not fetch rmt
>>
>> Looking at /net/path/to/backup/repo/config I can guess what the
>> problem is, however I wouldn't have thought that git fetch would even
>> care about the worktree configuration.
>>
>>   [core]
>>         repositoryformatversion = 0
>>         filemode = true
>>         bare = false
>>         logallrefupdates = true
>>         worktree = ../../../repo
>>
>> Using ssh:// instead of file:// works as expected
>>
>>   $ git remote add -f rmt2 ssh://server/path/to/backup/repo
>>   Updating rmt2
>>   remote: Counting objects: 10, done.
>>   remote: Compressing objects: 100% (5/5), done.
>>   remote: Total 6 (delta 3), reused 0 (delta 0)
>>   Unpacking objects: 100% (6/6), done.
>>   From ssh://server/path/to/backup/repo
>>    * [new branch]      master     -> rmt2/master
>>
>> Using ssh is a viable workaround but plenty of people here have
>> thought their fingers /net/server/user<tab> (which also let's you
>> check the path for validity along the way).
>>
>> Is there any reason fetching using file:// should care about the
>> remote's worktree? The version of git on the server is different (git
>> version 1.7.1) so it could be a bug in fetch that is not exposed when
>> cloning via ssh.
>>
>> Thanks,
>> Chris
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
