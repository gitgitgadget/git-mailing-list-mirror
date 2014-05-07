From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git gui error with relocated repository
Date: Wed, 07 May 2014 19:49:33 +1200
Message-ID: <5369E58D.4030908@gmail.com>
References: <CAFOYHZBPLZhVuf=bO0hPcUH2_0WXFSqk=_CqoUWBRixQc0L==Q@mail.gmail.com>	<CAFOYHZD=wxwm0nLhtZwvXDAhQ23j0C5maArQunc0CVe_-SF_mQ@mail.gmail.com> <871tw7xg3o.fsf@fox.patthoyts.tk> <5369E0A3.4040701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: patthoyts@users.sourceforge.net
X-From: git-owner@vger.kernel.org Wed May 07 09:49:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whwbm-0007Mv-OV
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 09:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbaEGHtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 03:49:39 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:43658 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbaEGHti (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 03:49:38 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so821644pad.9
        for <git@vger.kernel.org>; Wed, 07 May 2014 00:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=q/WCrZ0UuuCSA18CQ67cJBkZpVoPeTAtR2KFh4Xk8l0=;
        b=Kp47cJO/zSLkhviswZKQFoEq8vVbMHSK4BMp2WtLJZt7+1x58W25//SE87IGTsr3Ht
         SWpsavt+kO4D00/Mpl8a8isYe3TgRPEf4oVfUwU12oBaXWQpnjLC+wmT88LHZ3Seu4Ex
         /9CgfxvPkKrHghvNJ9l7FxSW8/klxkIZoaiJB5sK/ZPV4TANtd27FyQeDTkL0deKQis4
         2RjJUdvbRwE3Crk0zfH6aSAF1/tXaEdJqXZDoKvqt8M37OdD4kCvscKwD+3so17umobA
         QtJbXmqPPek0xh5KK+h6TS7WW96DrJAXaPPeOfnVyFkXQNryX5qfWyYILP+YBeFTi2ti
         Lm6g==
X-Received: by 10.66.149.7 with SMTP id tw7mr15947977pab.72.1399448978071;
        Wed, 07 May 2014 00:49:38 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id qj3sm1622523pbc.91.2014.05.07.00.49.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 00:49:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5369E0A3.4040701@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248288>

On 07/05/14 19:28, Chris Packham wrote:
> On 07/05/14 00:10, Pat Thoyts wrote:
>> Chris Packham <judge.packham@gmail.com> writes:
>>
>>> On Tue, Apr 29, 2014 at 2:56 PM, Chris Packham <judge.packham@gmail.com> wrote:
>>>> Hi Pat,
>>>>
>>>> I'm running git 2.0.0-rc0 (haven't got round to pulling down rc1 yet)
>>>> which includes gitgui-0.19.0 and I'm getting a new error when I run
>>>> 'git gui' in a repository with a .git file (created by git submodule).
>>>>
>>>> I can send you a screencap of the error message off list if you want
>>>> but the text is
>>>>
>>>> "No working directory ../../../<repo>
>>>>
>>>> couldn't change working directory to ../../../<repo>: no such file or directory"
>>>
>>> My tcl is a little rusty but I think the problem might be this snippet.
>>>
>>> # v1.7.0 introduced --show-toplevel to return the canonical work-tree
>>> if {[package vsatisfies $_git_version 1.7.0]} {
>>>    if { [is_Cygwin] } {
>>>        catch {set _gitworktree [exec cygpath --windows [git rev-parse
>>> --show-toplevel]]}
>>>    } else {
>>>        set _gitworktree [git rev-parse --show-toplevel]
>>>    }
>>> } else {
>>>    # try to set work tree from environment, core.worktree or use
>>>    # cdup to obtain a relative path to the top of the worktree. If
>>>    # run from the top, the ./ prefix ensures normalize expands pwd.
>>>    if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
>>>        set _gitworktree [get_config core.worktree]
>>>        if {$_gitworktree eq ""} {
>>>            set _gitworktree [file normalize ./[git rev-parse --show-cdup]]
>>>        }
>>>    }
>>> }
>>>
>>> The  vsatisfies call probably doesn't handle '2.0.0.rc0' and the
>>> fallback behaviour probably needs to normalise core.worktree
>>>
>>
>> The _git_version variable has already been trimmed to remove such
>> suffixes so the version comparison here will be ok. 
> 
> I don't think that's true 'git rev-parse --show-toplevel' does the right
> thing - if it's run.

We'll the trimming works but vstatisfies doesn't

  puts $_git_version
  puts [package vsatisfies $_git_version 1.7.0]

  2.0.0
  0

> 
>> It looks more likely
>> to be something to do with the .git being a file with a link being
>> mishandled. How did you setup this test repository with its link to a
>> parent?
>>
> 
> It's just a git clone of the parent and a git submodule init. A subtle
> thing to notice is that config.worktree is relative to $GIT_DIR. All the
> configuration was done by git without any intervention from me.
> 
>>>>
>>>> Here's some other info that might help
>>>>
>>>>   $ git --version
>>>>   git version 2.0.0.rc0
>>>>
>>>>   $ cat .git
>>>>   gitdir: ../.git/modules/<repo>
>>>>
>>>>   $ git rev-parse --git-dir
>>>>   /home/chris/src/<super>/.git/modules/<repo>
>>>>
>>>>   $ git config core.worktree
>>>>   ../../../<repo>
>>>>
>>>> Thanks,
>>>> Chris
>>>
>>
> 
