From: Christopher Yee Mon <christopher.yeemon@gmail.com>
Subject: Re: 3 way merge during git p4 rebase is attempting to reapply past commits
Date: Wed, 8 May 2013 10:32:12 -0400
Message-ID: <CAG4Fb8fJynC8kVaudKiCRYh=1MqH-k+2A3LCCEzf=psPrx+zuw@mail.gmail.com>
References: <CAG4Fb8f8vxbqwnCn1B9EfZu3sM-3-wQ2dqcR+BezPaf_XEy5Xw@mail.gmail.com>
 <5189E42E.8050107@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, simon@lst.de
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed May 08 16:32:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua5Q6-0003s5-LW
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 16:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923Ab3EHOce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 10:32:34 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:45867 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab3EHOcd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 10:32:33 -0400
Received: by mail-ve0-f171.google.com with SMTP id oy12so1800237veb.2
        for <git@vger.kernel.org>; Wed, 08 May 2013 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QZ9VdUam8i8nn+b8kNvt2wfqFH05ZCTE+bnyazByJOU=;
        b=iRoGR0m+m3zSCGGDCaq5Wo8KaN1IY5HuNJqlCPFLM2NEwakZOZevjweEwY1fZq6Pol
         bsoD3Whv+EgV2nCcfOXv79SZeftEqwRumPOUJAGvIqvJyRCY5fRAVgkdZ4xRjbhRZlSC
         bObD/AxWiHHUAnvUA5JQVYr9bZex/i3Z//4MOLwW+cZz0DL1gOz6oNMgZkMp7bZYdTjF
         Iv4E9QAs8rnQTbKB6M28xFrlJKPOKRlUmdakun9sP+u6ODDoli190YhfYlUSgjZ6cVSy
         Xrd56sc46cCPDL83ZBnjOdkOhKESrMsaqCeTfOKs8BEWDSWbUoYOYImTE8DAmI8v3cyK
         tRRg==
X-Received: by 10.52.155.141 with SMTP id vw13mr3912733vdb.43.1368023552837;
 Wed, 08 May 2013 07:32:32 -0700 (PDT)
Received: by 10.58.207.14 with HTTP; Wed, 8 May 2013 07:32:12 -0700 (PDT)
In-Reply-To: <5189E42E.8050107@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223669>

git p4 rebase and git p4 submit don't work on a bare repo (at least it
didn't for me) This is weird since there is a --bare option for git p4
clone, but then you can't do git p4 submit's on that bare repo back up
to perforce?

I got an error stating:

git p4 rebase
Performing incremental import into refs/remotes/p4/master git branch
Depot paths: //depot/path.to/folder/
No changes to import!
fatal: This operation must be run in a work tree
Some files in your working directory are modified and different than
what is in your index. You can use git update-index <filename> to
bring the index up-to-date or stash away all your changes with git
stash.

And I got this error for git p4 submit stating

Perforce checkout for depot path //depot/path.to/folder/ located at
/home/user1/path/to/perforce.folder/
Synchronizing p4 checkout...
... - file(s) up-to-date.
fatal: Not a git repository: '.'
Command failed: ['git', 'rev-list', '--no-merges', 'remotes/p4/master..master']

http://stackoverflow.com/questions/15512357/how-to-run-git-p4-submit-on-a-bare-repo
(The workaround described seemed particularly convoluted.)

My only (simple) workaround for that is doing the git checkout -f and
git clean -f before and after doing git p4 rebase and git p4 submit (
http://stackoverflow.com/questions/15512700/replace-working-copy-of-git-repo-with-actual-contents-of-repo-in-git
)

I've encountered so many errors over time that I can't trust to leave
the operation scheduled, because some problem like this might crop up
again.

On Wed, May 8, 2013 at 1:35 AM, Luke Diamand <luke@diamand.org> wrote:
> On 08/05/13 00:12, Christopher Yee Mon wrote:
>>
>> Hello,
>>
>> I have a setup where I have a remote non-bare repo cloned from a
>> perforce workspace. It is used as a remote repo that people clone into
>> their own user repos, make commits to, then push back into the remote
>> repo.
>
> Why is your p4 clone non-bare? I thought pushing into a non-bare repo tended
> to cause problems?
>
>
>> Then I periodically run the following commands in a script to
>> push those changes back to perforce.
>
> % man cron
>
> :-)
>
>
>>
>> git checkout -f
>> git clean -f
>> git p4 rebase --import-labels
>> git p4 submit -M --export-labels
>> git checkout -f
>> git clean -f
>>
>> Sometimes, always after commits from one user's machine specifically,
>> I get the following error below when pushing back to perforce at the
>> remote repo. It seems to happen randomly, or at least intermittently,
>> since I often can't discern any major error during git committing to
>> the remote repo that precipitates this error. It does happen pretty
>> reliably when I get a file conflict that I resolve and fix during
>> committing though.
>>
>> Performing incremental import into refs/remotes/p4/master git branch
>> Depot paths: //depot/sub/folder/
>> No changes to import!
>> Rebasing the current branch onto remotes/p4/master
>> First, rewinding head to replay your work on top of it...
>> Applying: A commit that has already been made previously
>> Applying: A second commit that has already been made in a previous commit
>> Using index info to reconstruct a base tree...
>> <stdin>:15: space before tab in indent.
>>                              a line of text
>> <stdin>:24: space before tab in indent.
>>                  another line of text
>> <stdin>:25: space before tab in indent.
>>                  a third line of text
>> <stdin>:33: trailing whitespace.
>>          a forth line of text
>> <stdin>:71: trailing whitespace.
>>
>> warning: squelched 1 whitespace error
>> warning: 6 lines add whitespace errors.
>> Falling back to patching base and 3-way merge...
>> Auto-merging file from second
>> CONFLICT (content): Merge conflict in
>> a/file/in/the/second/pre-existing/commit/file.php
>> Auto-merging a/file/in/the/second/pre-existing/commit/file.php
>> Failed to merge in the changes.
>> Patch failed at 0002 A second commit that has already been made in a
>> previous commit
>>
>> When you have resolved this problem run "git rebase --continue".
>> If you would prefer to skip this patch, instead run "git rebase --skip".
>> To check out the original branch and stop rebasing run "git rebase
>> --abort".
>>
>> Traceback (most recent call last):
>>    File "/usr/lib/git-core/git-p4", line 3373, in<module>
>>      main()
>>    File "/usr/lib/git-core/git-p4", line 3367, in main
>>      if not cmd.run(args):
>>    File "/usr/lib/git-core/git-p4", line 3150, in run
>>      return self.rebase()
>>    File "/usr/lib/git-core/git-p4", line 3167, in rebase
>>      system("git rebase %s" % upstream)
>>    File "/usr/lib/git-core/git-p4", line 183, in system
>>      raise CalledProcessError(retcode, cmd)
>> subprocess.CalledProcessError: Command 'git rebase remotes/p4/master'
>> returned non-zero exit status 1
>>
>> The patch is usually one that is already in the remote git repo and in
>> perforce. At that point I have to run git rebase --skip, to skip the
>> patch, then rerun the commands in the script again. Sometimes it's
>> multiple patches that cause this problem and I have to run git rebase
>> --skip repeatedly. When I check the working copy of the remote repo, I
>> don't see any changes, no conflict markers, just the file.
>>
>> The real problem happens when I run git rebase --continue. Usually I
>> end up with repeated submits in perforce when I do that, which is
>> obviously a corruption of data.
>>
>> It sounds a lot like this error, except I don't know how git p4 is
>> branching, so I don't know how to diagnose it.
>>
>>
>> http://stackoverflow.com/questions/4033009/git-rebase-conflicts-keep-blocking-progress
>>
>> I also asked stack overflow and someone there said it's probably the
>> perforce user being different from the git user info, so I had all the
>> git users switch to having the same info as the perforce user info and
>> that did NOT solve the problem.
>>
>>
>> http://stackoverflow.com/questions/16106900/git-p4-rebase-attempts-to-reapply-past-commits
>>
>> I'm not sure what could possibly be causing this or how to fix it.
>> Does anyone have any ideas?
>>
>> Thanks
>> Christopher Yee Mon
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
