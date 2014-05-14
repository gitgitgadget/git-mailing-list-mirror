From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT GUI PATCH] git-gui: use vcompare when comparing the git version
Date: Wed, 14 May 2014 12:22:28 -0700
Message-ID: <xmqqlhu4jhcb.fsf@gitster.dls.corp.google.com>
References: <CAFOYHZBPLZhVuf=bO0hPcUH2_0WXFSqk=_CqoUWBRixQc0L==Q@mail.gmail.com>
	<CAFOYHZD=wxwm0nLhtZwvXDAhQ23j0C5maArQunc0CVe_-SF_mQ@mail.gmail.com>
	<871tw7xg3o.fsf@fox.patthoyts.tk> <5369E0A3.4040701@gmail.com>
	<5369E58D.4030908@gmail.com> <53728D70.4020506@web.de>
	<5373200D.7020108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>,
	patthoyts@users.sourceforge.net, GIT <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed May 14 21:27:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkepP-0001ol-VI
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 21:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbaENT0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 15:26:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62901 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473AbaENT0l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 15:26:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4B13B178C8;
	Wed, 14 May 2014 15:26:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sQBpVp1y/yBcQ+gh1GkZBYpOQ7k=; b=GefXAo
	MgAfl0kpyZBcwvoEJvRIs7HXH/uMRspQg8rLv/yRojGCNh+0qROTwrNZ9H3Elpj0
	le2Z4q9UBAP9vFO+SvXmcFfiiZ5mTmgzdl3f974+XbIC2ivS7V+RaXkeL5qVGeer
	ojZQtoCtH2gSu4E8gacyYsB3rbv5wR4O0JR2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=txdqe3pw6qI6LB0Ze33fQaAhtX9o8Tq0
	wzGcYjJYHeIKZIYxYE2Dsbbdh29QSFrnlyQY/O0vTmGGM3py6TFAi1sOpNfzhIXs
	zD1P4WSX9ikZSVFSd3WUfCWctpAAlT0szX8ABpwZVep8x6g5QLaWBwVbYUhNOe5q
	dT8EwP+yatQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 40101178C7;
	Wed, 14 May 2014 15:26:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C560C17433;
	Wed, 14 May 2014 15:22:29 -0400 (EDT)
In-Reply-To: <5373200D.7020108@web.de> (Jens Lehmann's message of "Wed, 14 May
	2014 09:49:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 17486442-DB9D-11E3-9698-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248938>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Junio, I believe this issue needs to be fixed before 2.0 final. Otherwise
> git gui will not work inside submodules anymore due to the major version
> number change from 1 to 2. I'd like to hear Pat's opinion on this; even
> though I think my patch is less risky (as it doesn't change behavior for
> pre-2 versions), he might like Chris' proposal better.

Thanks; I share the same feeling.


> Am 13.05.2014 23:24, schrieb Jens Lehmann:
>> Since git 2.0.0 starting git gui in a submodule using a gitfile fails with
>> the following error:
>> 
>>    No working directory ../../../<path>
>> 
>>    couldn't change working directory
>>    to "../../../<path>": no such file or
>>    directory
>> 
>> This is because "git rev-parse --show-toplevel" is only run when git gui
>> sees a git version of at least 1.7.0 (which is the version in which the
>> --show-toplevel option was introduced). But it uses vsatisfies to check
>> that, which is documented to return false when the major version changes,
>> which is not what we want here.
>> 
>> Change vsatisfies to vcompare when testing for a git version to avoid the
>> problem when the major version changes (but still use vsatisfies in those
>> places where the Tk version is checked). This is done for both the place
>> that caused the reported bug and another spot where the git version is
>> tested for another feature.
>> 
>> Reported-by: Chris Packham <judge.packham@gmail.com>
>> Reported-by: Yann Dirson <ydirson@free.fr>
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>> ---
>> 
>> Am 07.05.2014 09:49, schrieb Chris Packham:
>>> On 07/05/14 19:28, Chris Packham wrote:
>>>> On 07/05/14 00:10, Pat Thoyts wrote:
>>>>> Chris Packham <judge.packham@gmail.com> writes:
>>>>>
>>>>>> On Tue, Apr 29, 2014 at 2:56 PM, Chris Packham <judge.packham@gmail.com> wrote:
>>>>>>> Hi Pat,
>>>>>>>
>>>>>>> I'm running git 2.0.0-rc0 (haven't got round to pulling down rc1 yet)
>>>>>>> which includes gitgui-0.19.0 and I'm getting a new error when I run
>>>>>>> 'git gui' in a repository with a .git file (created by git submodule).
>>>>>>>
>>>>>>> I can send you a screencap of the error message off list if you want
>>>>>>> but the text is
>>>>>>>
>>>>>>> "No working directory ../../../<repo>
>>>>>>>
>>>>>>> couldn't change working directory to ../../../<repo>: no such file or directory"
>>>>>>
>>>>>> My tcl is a little rusty but I think the problem might be this snippet.
>>>>>>
>>>>>> # v1.7.0 introduced --show-toplevel to return the canonical work-tree
>>>>>> if {[package vsatisfies $_git_version 1.7.0]} {
>>>>>>    if { [is_Cygwin] } {
>>>>>>        catch {set _gitworktree [exec cygpath --windows [git rev-parse
>>>>>> --show-toplevel]]}
>>>>>>    } else {
>>>>>>        set _gitworktree [git rev-parse --show-toplevel]
>>>>>>    }
>>>>>> } else {
>>>>>>    # try to set work tree from environment, core.worktree or use
>>>>>>    # cdup to obtain a relative path to the top of the worktree. If
>>>>>>    # run from the top, the ./ prefix ensures normalize expands pwd.
>>>>>>    if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
>>>>>>        set _gitworktree [get_config core.worktree]
>>>>>>        if {$_gitworktree eq ""} {
>>>>>>            set _gitworktree [file normalize ./[git rev-parse --show-cdup]]
>>>>>>        }
>>>>>>    }
>>>>>> }
>>>>>>
>>>>>> The  vsatisfies call probably doesn't handle '2.0.0.rc0' and the
>>>>>> fallback behaviour probably needs to normalise core.worktree
>>>>>>
>>>>>
>>>>> The _git_version variable has already been trimmed to remove such
>>>>> suffixes so the version comparison here will be ok. 
>>>>
>>>> I don't think that's true 'git rev-parse --show-toplevel' does the right
>>>> thing - if it's run.
>>>
>>> We'll the trimming works but vstatisfies doesn't
>>>
>>>   puts $_git_version
>>>   puts [package vsatisfies $_git_version 1.7.0]
>>>
>>>   2.0.0
>>>   0
>> 
>> Yup, looks like vsatisfies is doing just what it is supposed to (according
>> to http://www.astro.princeton.edu/~rhl/Tcl-Tk_docs/tcl/package.n.html):
>> 
>>    package vsatisfies version1 version2
>>        Returns 1 if scripts written for version2 will work unchanged
>>        with version1 (i.e. version1 is equal to or greater than version2
>>        and they both have the same major version number), 0 otherwise.
>> 
>> The bump in the major number from 1 to 2 makes vsatisfies assume that the
>> version is not compatible anymore, I believe we should have used vcompare
>> here and in another place.
>> 
>> 
>>  git-gui.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/git-gui.sh b/git-gui.sh
>> index cf2209b..ed2418b 100755
>> --- a/git-gui.sh
>> +++ b/git-gui.sh
>> @@ -1283,7 +1283,7 @@ load_config 0
>>  apply_config
>> 
>>  # v1.7.0 introduced --show-toplevel to return the canonical work-tree
>> -if {[package vsatisfies $_git_version 1.7.0]} {
>> +if {[package vcompare $_git_version 1.7.0]} {
>>  	if { [is_Cygwin] } {
>>  		catch {set _gitworktree [exec cygpath --windows [git rev-parse --show-toplevel]]}
>>  	} else {
>> @@ -1539,7 +1539,7 @@ proc rescan_stage2 {fd after} {
>>  		close $fd
>>  	}
>> 
>> -	if {[package vsatisfies $::_git_version 1.6.3]} {
>> +	if {[package vcompare $::_git_version 1.6.3]} {
>>  		set ls_others [list --exclude-standard]
>>  	} else {
>>  		set ls_others [list --exclude-per-directory=.gitignore]
>> 
