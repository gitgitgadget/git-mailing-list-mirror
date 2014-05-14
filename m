From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [GIT GUI PATCH] git-gui: use vcompare when comparing the git
 version
Date: Wed, 14 May 2014 19:46:16 +1200
Message-ID: <53731F48.1000801@gmail.com>
References: <CAFOYHZBPLZhVuf=bO0hPcUH2_0WXFSqk=_CqoUWBRixQc0L==Q@mail.gmail.com>	<CAFOYHZD=wxwm0nLhtZwvXDAhQ23j0C5maArQunc0CVe_-SF_mQ@mail.gmail.com> <871tw7xg3o.fsf@fox.patthoyts.tk> <5369E0A3.4040701@gmail.com> <5369E58D.4030908@gmail.com> <53728D70.4020506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>, patthoyts@users.sourceforge.net
X-From: git-owner@vger.kernel.org Wed May 14 09:46:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkTtT-00023k-4z
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 09:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbaENHqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 03:46:23 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:44921 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaENHqW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 03:46:22 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp16so58442pbb.34
        for <git@vger.kernel.org>; Wed, 14 May 2014 00:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=B97L2+ncjnXeqgco0NeqQEicEGv7u7egwJOgjrKGJYQ=;
        b=Av17R30XNeJQtdc3p3xkuLYZaCJ+UjUEQcxPZ9+iTAYRw+niiqFgpplnSYydGM5b+u
         e0dJ+0dgtHngc4YBl+pNXkFGOBDjwlM1u5kvIO8bkGLky5VCyVFcmPwfAfg4h90ilmvQ
         SWQyls/ycnWn9dYxz9eZvvJ1WKI87Xw6Ip3ph4cXJOiTpGHw0r3NS9ydZvUZgRkamXJA
         +HexEi+WOgcPEVaCi6wB0XcEIxLCzHXFuvhU5ywUnyeJtl+i6SjVo1jzqMK+TWwYLiR+
         CoJRAUUshZ/yBCOSCmd6jv6BnbEjYPC6xN06yJLaRo2zQyZBcmwf1CDpLMPF3GDGisj5
         oH2Q==
X-Received: by 10.69.26.103 with SMTP id ix7mr2363041pbd.41.1400053581688;
        Wed, 14 May 2014 00:46:21 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id ha3sm1932824pbc.5.2014.05.14.00.46.18
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 14 May 2014 00:46:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53728D70.4020506@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248895>

On 14/05/14 09:24, Jens Lehmann wrote:
> Since git 2.0.0 starting git gui in a submodule using a gitfile fails with
> the following error:
> 
>    No working directory ../../../<path>
> 
>    couldn't change working directory
>    to "../../../<path>": no such file or
>    directory
> 
> This is because "git rev-parse --show-toplevel" is only run when git gui
> sees a git version of at least 1.7.0 (which is the version in which the
> --show-toplevel option was introduced). But it uses vsatisfies to check
> that, which is documented to return false when the major version changes,
> which is not what we want here.
> 
> Change vsatisfies to vcompare when testing for a git version to avoid the
> problem when the major version changes (but still use vsatisfies in those
> places where the Tk version is checked). This is done for both the place
> that caused the reported bug and another spot where the git version is
> tested for another feature.
>
> Reported-by: Chris Packham <judge.packham@gmail.com>
> Reported-by: Yann Dirson <ydirson@free.fr>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---

Looks good to me (refer to previous comment about being rusty with tcl).
More importantly

 Tested-by: Chris Packham <judge.packham@gmail.com>

There is the alternative I posted which just does away with the version
checks (actually that only addressed one of the vcompare call sites).

There are also these checks that I guess are correct (if not
inconsistent) but again who is still using git 1.5.3?

git-gui.sh:1098:        >= 1.5.3 {
lib/blame.tcl:800:                      if {[git-version >= 1.5.3]} {
lib/blame.tcl:849:      if {[git-version >= 1.5.3]} {
lib/checkout_op.tcl:513:        >= 1.5.3 {

> 
> Am 07.05.2014 09:49, schrieb Chris Packham:
>> On 07/05/14 19:28, Chris Packham wrote:
>>> On 07/05/14 00:10, Pat Thoyts wrote:
>>>> Chris Packham <judge.packham@gmail.com> writes:
>>>>
>>>>> On Tue, Apr 29, 2014 at 2:56 PM, Chris Packham <judge.packham@gmail.com> wrote:
>>>>>> Hi Pat,
>>>>>>
>>>>>> I'm running git 2.0.0-rc0 (haven't got round to pulling down rc1 yet)
>>>>>> which includes gitgui-0.19.0 and I'm getting a new error when I run
>>>>>> 'git gui' in a repository with a .git file (created by git submodule).
>>>>>>
>>>>>> I can send you a screencap of the error message off list if you want
>>>>>> but the text is
>>>>>>
>>>>>> "No working directory ../../../<repo>
>>>>>>
>>>>>> couldn't change working directory to ../../../<repo>: no such file or directory"
>>>>>
>>>>> My tcl is a little rusty but I think the problem might be this snippet.
>>>>>
>>>>> # v1.7.0 introduced --show-toplevel to return the canonical work-tree
>>>>> if {[package vsatisfies $_git_version 1.7.0]} {
>>>>>    if { [is_Cygwin] } {
>>>>>        catch {set _gitworktree [exec cygpath --windows [git rev-parse
>>>>> --show-toplevel]]}
>>>>>    } else {
>>>>>        set _gitworktree [git rev-parse --show-toplevel]
>>>>>    }
>>>>> } else {
>>>>>    # try to set work tree from environment, core.worktree or use
>>>>>    # cdup to obtain a relative path to the top of the worktree. If
>>>>>    # run from the top, the ./ prefix ensures normalize expands pwd.
>>>>>    if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
>>>>>        set _gitworktree [get_config core.worktree]
>>>>>        if {$_gitworktree eq ""} {
>>>>>            set _gitworktree [file normalize ./[git rev-parse --show-cdup]]
>>>>>        }
>>>>>    }
>>>>> }
>>>>>
>>>>> The  vsatisfies call probably doesn't handle '2.0.0.rc0' and the
>>>>> fallback behaviour probably needs to normalise core.worktree
>>>>>
>>>>
>>>> The _git_version variable has already been trimmed to remove such
>>>> suffixes so the version comparison here will be ok. 
>>>
>>> I don't think that's true 'git rev-parse --show-toplevel' does the right
>>> thing - if it's run.
>>
>> We'll the trimming works but vstatisfies doesn't
>>
>>   puts $_git_version
>>   puts [package vsatisfies $_git_version 1.7.0]
>>
>>   2.0.0
>>   0
> 
> Yup, looks like vsatisfies is doing just what it is supposed to (according
> to http://www.astro.princeton.edu/~rhl/Tcl-Tk_docs/tcl/package.n.html):
> 
>    package vsatisfies version1 version2
>        Returns 1 if scripts written for version2 will work unchanged
>        with version1 (i.e. version1 is equal to or greater than version2
>        and they both have the same major version number), 0 otherwise.
> 
> The bump in the major number from 1 to 2 makes vsatisfies assume that the
> version is not compatible anymore, I believe we should have used vcompare
> here and in another place.
> 
> 
>  git-gui.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index cf2209b..ed2418b 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1283,7 +1283,7 @@ load_config 0
>  apply_config
> 
>  # v1.7.0 introduced --show-toplevel to return the canonical work-tree
> -if {[package vsatisfies $_git_version 1.7.0]} {
> +if {[package vcompare $_git_version 1.7.0]} {
>  	if { [is_Cygwin] } {
>  		catch {set _gitworktree [exec cygpath --windows [git rev-parse --show-toplevel]]}
>  	} else {
> @@ -1539,7 +1539,7 @@ proc rescan_stage2 {fd after} {
>  		close $fd
>  	}
> 
> -	if {[package vsatisfies $::_git_version 1.6.3]} {
> +	if {[package vcompare $::_git_version 1.6.3]} {
>  		set ls_others [list --exclude-standard]
>  	} else {
>  		set ls_others [list --exclude-per-directory=.gitignore]
> 
