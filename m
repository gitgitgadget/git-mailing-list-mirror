From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Restart submodule update --recursive
Date: Fri, 29 Oct 2010 11:40:55 -0500
Message-ID: <20101029164055.GA28934@burratino>
References: <loom.20101028T090353-376@post.gmane.org>
 <20101028181515.GB14212@burratino>
 <loom.20101029T085153-262@post.gmane.org>
 <20101029091202.GA26442@burratino>
 <4CCAB20A.1000408@prevac.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Piotrek Pientka <p.pientka@prevac.pl>
To: Lukasz Palczewski <l.palczewski@prevac.pl>
X-From: git-owner@vger.kernel.org Fri Oct 29 18:41:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBs0w-00069L-KO
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 18:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934124Ab0J2QlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 12:41:09 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48022 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933402Ab0J2QlH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 12:41:07 -0400
Received: by vws13 with SMTP id 13so468216vws.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=o8yh1JzOK1YkeZgFYeXpXUQwrfkTdgTM5UOkoZgcHhs=;
        b=nVZoNUMXok+4HfD6+qrs+4m8dqkKNw0yMkDqqgDDNbbWvryPYRsyhUyEY4uNJ4auTk
         LwKpa8tUWhcud6XzDB1GpWVWOZgrWyvAfBTMbxvEyaaQH9omt0hLIe0JfTTeUmpJS68l
         7j7UfLW1QualDym/IG6R2fg3EQ9gWfOYibQwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MiXkaZncl0YgYPfz09y+ZxUgQQWcoRicwDy7QOMW4BjI7LpsiyuZrih0x733lTCRjf
         ShguHgvPQj5nYbellcH4tR1PDZCPoZIz4jO8HhWIHX/JGHV8wogdFt6L2P5EkdrLdxZD
         WKv7MSabVv9QqJlDtnJodgfagVLorhTvhmMTE=
Received: by 10.220.45.132 with SMTP id e4mr229908vcf.29.1288370466461;
        Fri, 29 Oct 2010 09:41:06 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x26sm1300099vbw.18.2010.10.29.09.41.03
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 09:41:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CCAB20A.1000408@prevac.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160339>

Hi again,

Lukasz Palczewski wrote:
> Jonathan Nieder wrote:

>> [side note: if you use a newsreader, please reply by mail instead of
>> through gmane so the Cc: list can be preserved.]
>
> Sorry, but I do not use it. I will send You a normal email.

Thanks.

> I have added two options to git submodule update:
> --save-progress
> --resume-update
> First one You can use, to save the ./.git/SubmoduleUpdateLog.log the
> progress of updating:
> git submodule update --recursive --save-progress
> The second one is used for skipping updated submodules:
> git submodule update --recursive --resume-update
> 
> The downside of it is, that u can use only one --resume-update.

Does the combination
"git submodule update --recursive --save-progress --resume-update"
work?

> Let me know if this change will be in next version of git.

I will leave that question to the submodule experts.  But note that
there is no need to wait: if you change the ". git-sh-setup" line
to

	. "$(git --exec-path)/git-sh-setup"

then if you install the modified script as git-mysubmodule anywhere on
your $PATH, it will be used to implement

	git mysubmodule update --recursive --save-progress

.  Of course you can run it directly as "git-mysubmodule", too.

diffs are easier to review.  If your change is for inclusion, it will
also need a Signed-off-by: line; see Documentation/SubmittingPatches.

> cmd_update()
> {
[...]
> 		--save-progress)
> 			shift
> 			save_progress=1
> 			if test -e ./.git/SubmoduleUpdateLog.log
> 			then
> 				rm ./.git/SubmoduleUpdateLog.log
> 			fi

Some current temporary files used by git:

	.git/rr-cache/*
	.git/gitk.cache
	.git/rebase-merge/*
	.git/rebase-apply/*

The
	if test -e $foo
	then
		rm $foo
	fi

idiom can be written more simply as

	rm -f $foo

but are you sure that is what you want?  Maybe it would be better
to

	1) destroy progress when the update is completed
	2) always save updated progress when resuming
	3) complain when --save-progress would require clobbering
	   some existing progress
	4) provide an additional --reset-progress option to start
	   over

?

FWIW "git am" and "git rebase" already have the ability to resume
where they left off, using options with these names:

	git <foo> --continue
	git <foo> --skip
	git <foo> --abort

The --abort options undo the effect of the earlier runs.  "git bisect"
also keeps some state on progress.

	git bisect (good|bad); # continue
	git bisect skip
	git bisect reset

> 	module_list "$@" |
> 	while read mode sha1 stage path
> 	do		
> 		name=$(module_name "$path") || exit
> 		url=$(git config submodule."$name".url)
> 		update_module=$(git config submodule."$name".update)
> 		
> 		if test -n "$submodule_resume"
> 		then
> 			SubmodulePathResume=`pwd`
> 			SubmodulePathResume=$SubmodulePathResume/"$name"

It might be more idiomatic to say

	module_list "$@" |
	...
			(
				prefix="$prefix$path/"

Three benefits:

 - local variables tend to get short, lowercase names
 - this variable looks like a path, but using $name makes it not
   one (if foo/bar is a submodule simple named "bar", for example)
 - using relative paths allows an update to be resumed after moving
   a repository or just accessing it via a different path.

The subshell ensures the old prefix is restored when cmd_update
returns.  The same effect could also be achieved by saving the old
prefix (in case it is important to save a few processes).

> 			
> 			#say $SubmodulePathResume
> 			if test -e ./.git/SubmoduleUpdateLog.log

What if I try to resume and there is no progress information?
Would it make sense to keep the progress information at the toplevel,
so one could run commands like "submodule update --recursive
--resumable" in submodules without affecting the superproject state?


> 			then
> 				AFile=`cat "./.git/SubmoduleUpdateLog.log" | grep "$SubmodulePathResume"`
> 				
> 				#say $AFile;			
> 				if test -n "$AFile"

The following could work if each submodule is written to
submodule-update.log only if all its submodules have been updated
(as in your current code):

		if git grep --no-index -q -F "$prefix" "$GIT_DIR/submodule-update.log"
		then
			say "Skip...
			continue
		fi

I'm not sure fgrep is portable, which is why I use "git grep" here.

This is slower than it could be.  Ideally one would only keep
the last updated submodule and chop the module_list output there,
instead of re-reading the list with each iteration (which is O(size of
directory squared)).

Hope that helps,
Jonathan
