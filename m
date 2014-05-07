From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git gui error with relocated repository
Date: Wed, 07 May 2014 19:28:35 +1200
Message-ID: <5369E0A3.4040701@gmail.com>
References: <CAFOYHZBPLZhVuf=bO0hPcUH2_0WXFSqk=_CqoUWBRixQc0L==Q@mail.gmail.com>	<CAFOYHZD=wxwm0nLhtZwvXDAhQ23j0C5maArQunc0CVe_-SF_mQ@mail.gmail.com> <871tw7xg3o.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: patthoyts@users.sourceforge.net
X-From: git-owner@vger.kernel.org Wed May 07 09:28:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhwHV-0006fO-4Y
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 09:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbaEGH2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 03:28:41 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36147 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbaEGH2k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 03:28:40 -0400
Received: by mail-pd0-f173.google.com with SMTP id y10so711250pdj.18
        for <git@vger.kernel.org>; Wed, 07 May 2014 00:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=b3ym2sloj7aK3esWwKxq8Izks4PFDWLBUYnMK7hug6Y=;
        b=ss92pucEDHInlY9SRS+RoHVRbRewNdH2PhF0fVHVmD5qRu7y8W1TlrfktkO0m0z6kd
         j/QtfBZWaUo+U1dbTTo/LdwafnXfkx9GLRMlfEx11PuiTf2XARuH3tVngHuvU3FgKjCD
         B5skBPWIVq6VZkzO/fR2lu0npNf5ZR0ptmUwyGQz6lkimlXT7171FYFogrEZq7LXQJWo
         6sLKxtR8LAu9RKREZm+Py99neUfe9QnuNbIHYF4Ugi22MDwWIemSW4rlx8xSe/90Ow9Y
         X2VMT5LZ+ZKpv0+Mh7HZd6jfBR5m2Vsaoy+0WoaeTPccKlBnKvqEMlnegkZ5ZEEviCpH
         3Mpg==
X-Received: by 10.66.119.239 with SMTP id kx15mr15897467pab.51.1399447720061;
        Wed, 07 May 2014 00:28:40 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id pl5sm1514241pbc.90.2014.05.07.00.28.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 00:28:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <871tw7xg3o.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248287>

On 07/05/14 00:10, Pat Thoyts wrote:
> Chris Packham <judge.packham@gmail.com> writes:
> 
>> On Tue, Apr 29, 2014 at 2:56 PM, Chris Packham <judge.packham@gmail.com> wrote:
>>> Hi Pat,
>>>
>>> I'm running git 2.0.0-rc0 (haven't got round to pulling down rc1 yet)
>>> which includes gitgui-0.19.0 and I'm getting a new error when I run
>>> 'git gui' in a repository with a .git file (created by git submodule).
>>>
>>> I can send you a screencap of the error message off list if you want
>>> but the text is
>>>
>>> "No working directory ../../../<repo>
>>>
>>> couldn't change working directory to ../../../<repo>: no such file or directory"
>>
>> My tcl is a little rusty but I think the problem might be this snippet.
>>
>> # v1.7.0 introduced --show-toplevel to return the canonical work-tree
>> if {[package vsatisfies $_git_version 1.7.0]} {
>>    if { [is_Cygwin] } {
>>        catch {set _gitworktree [exec cygpath --windows [git rev-parse
>> --show-toplevel]]}
>>    } else {
>>        set _gitworktree [git rev-parse --show-toplevel]
>>    }
>> } else {
>>    # try to set work tree from environment, core.worktree or use
>>    # cdup to obtain a relative path to the top of the worktree. If
>>    # run from the top, the ./ prefix ensures normalize expands pwd.
>>    if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
>>        set _gitworktree [get_config core.worktree]
>>        if {$_gitworktree eq ""} {
>>            set _gitworktree [file normalize ./[git rev-parse --show-cdup]]
>>        }
>>    }
>> }
>>
>> The  vsatisfies call probably doesn't handle '2.0.0.rc0' and the
>> fallback behaviour probably needs to normalise core.worktree
>>
> 
> The _git_version variable has already been trimmed to remove such
> suffixes so the version comparison here will be ok. 

I don't think that's true 'git rev-parse --show-toplevel' does the right
thing - if it's run.

> It looks more likely
> to be something to do with the .git being a file with a link being
> mishandled. How did you setup this test repository with its link to a
> parent?
>

It's just a git clone of the parent and a git submodule init. A subtle
thing to notice is that config.worktree is relative to $GIT_DIR. All the
configuration was done by git without any intervention from me.

>>>
>>> Here's some other info that might help
>>>
>>>   $ git --version
>>>   git version 2.0.0.rc0
>>>
>>>   $ cat .git
>>>   gitdir: ../.git/modules/<repo>
>>>
>>>   $ git rev-parse --git-dir
>>>   /home/chris/src/<super>/.git/modules/<repo>
>>>
>>>   $ git config core.worktree
>>>   ../../../<repo>
>>>
>>> Thanks,
>>> Chris
>>
> 
