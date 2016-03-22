From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule helper: accept '.' for repositories with no submodules
Date: Tue, 22 Mar 2016 12:30:13 -0700
Message-ID: <CAGZ79kaMa3CyJ-Y9Xn9QShzTUGythos+pmKZXQ7m-2c0bF0u9A@mail.gmail.com>
References: <1458669579-32160-1-git-send-email-sbeller@google.com>
	<xmqqy49agx98.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Per Cederqvist <cederp@opera.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 20:30:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiS0S-0007ZK-U3
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 20:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbcCVTaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 15:30:15 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35832 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbcCVTaO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 15:30:14 -0400
Received: by mail-yw0-f171.google.com with SMTP id g127so267594689ywf.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 12:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=m2lvrUhuqnd3eKMYaY2jOxwJJMeCXek0/u3Lgmru28E=;
        b=FKgjuHCt0tEJ5sJ0gnZpGUlHyiMztWhF7/EcXl+kaZe+KAxDy+HrE6yomVj05/INHk
         +B/VhAPAAlOwDTJUCbua9xQskk2Q20BzoSbDrIZ8vLJRBSlosE1D0f0KOKCO1/HKzD6n
         FB3HwnXWes1b39uhdbhVJXKmrJ9Hdo14UQ/n8aSVoiVtvo1oPjXsK2WdtCys9HD1hxZL
         RlV7tYaD/BZcPsGXz1uXJKpkZz8zq4EXYoML2tgPg34/hhiDa3qHFZWVOaGW0azIUsHa
         a90E6ydKfz+u+k9bIHURXUSdlH0TOK9N6wwHNigyfbrohwD82OAVM6nJRBYKNpyObPpN
         ZLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=m2lvrUhuqnd3eKMYaY2jOxwJJMeCXek0/u3Lgmru28E=;
        b=ibognPTnvHqyeTj0E8UM++i371InuXfcRk3kui0QsNqWt5PdKS1Z1aVCPganarbhUq
         00u93JSgKqeaheCOkBI6QOcwODj1LZ5IP5tO9Dmr1z7uMazsILYZsGBAOTYr/o5aWA0Q
         /f4rHu5VFHggDHoDCpZnkFF4i7oqygipxDs3K2vAVskZrSiteJEPh9uWGnHrXboDe/v6
         tW5WNXVfAcz3JX6CAfiCLLSll8LkBKp/YkHqDtfNI+DS8Bl1MFn6Oho0hmeZXPdJ3BXf
         EFwF85HayKdAKgPHlBTm49k7humTPjUzpkKBlFPjSCS5Wb9JvkL9AgmVHnbKA0agdfMW
         DDOA==
X-Gm-Message-State: AD7BkJJ+MZ7z+P+I8uuhuDjnV56Aqzr/Lv5Qc26onomzS2peOG35mwe+mbmTq11+VWlAw0oqW+3Szgd5FdVl0XHZ
X-Received: by 10.37.105.135 with SMTP id e129mr6555475ybc.185.1458675013217;
 Tue, 22 Mar 2016 12:30:13 -0700 (PDT)
Received: by 10.37.51.137 with HTTP; Tue, 22 Mar 2016 12:30:13 -0700 (PDT)
In-Reply-To: <xmqqy49agx98.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289548>

On Tue, Mar 22, 2016 at 11:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> In 74703a1e4d (2015-09-02, submodule: rewrite `module_list` shell
>> function in C), "submodule deinit ." was broken.
>>
>> The original module_list accepted '.' as a pathspec just fine, as it
>> was using
>>
>>   git ls-files -z --error-unmatch --stage -- "$@" || { custom filtering}
>>
>> and git ls-files doesn't make a difference between "." and no arguments
>> there. When using the parse_pathspec function in C, this is a difference
>> however, when no path matches.
>
> Is that an accurate description of the issue?
>
> The original (above) errors out if there is a pathspec that does not
> match any path in the index.  The C rewrite however instead does
> this:
>
>                 if (!S_ISGITLINK(ce->ce_mode) ||
>                     !match_pathspec(pathspec, ce->name, ce_namelen(ce),
>                                     0, ps_matched, 1))
>                         continue;
>
> to error out if there is a pathspec that does not match any
> submodule path.  That is the root cause of the difference in
> behaviour.
>
> So if we were to aim for a faithful rewrite, perhaps swapping the
> order of the check, i.e.
>
>                 if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
>                                     0, ps_matched, 1) ||
>                     !S_ISGITLINK(ce->ce_mode))
>                         continue;
>
> Now, arguably, the behaviour of C rewrite makes more sense in that
> it would diagnose a pathspec that does not match a submodule as an
> error, e.g.
>
>         $ git submodule--helper list 'COPYIN*'
>         error: pathspec 'COPYIN*' did not match any file(s) known to git.
>         #unmatched
>
> The error message _is_ wrong, but the end result is more helpful to
> the user---the user thought there was a submodule that would match
> that pathspec, and there isn't, so we suspect there was a typo and
> cautiously error out.
>
> "submodule deinit ." may have "worked" in the sense that you would
> have at least one path in your tree and avoided this "nothing
> matches" most of the time.  It would have still failed with the
> exactly same error if run in an empty repository, i.e.
>
>         $ E=/var/tmp/x/empty && rm -fr "$E" && mkdir -p "$E" && cd "$E"
>         $ git init
>         $ rungit v2.6.6 submodule deinit .
>         error: pathspec '.' did not match any file(s) known to git.
>         Did you forget to 'git add'?
>         $ >file && git add file
>         $ rungit v2.6.6 submodule deinit .
>         $ echo $?
>         0
>
> In other words, "Use '.' if you really want to" is a faulty
> suggestion.  There is no guarantee that it would match anything in
> the old world order, and certainly there is no guarantee that it
> would match any submodule in the new world order.
>
> When another person who is not Per Cederqvist realizes that the
> logic that issues the faulty suggestion is because the command wants
> some pathspec, she may try
>
>     $ git submodule deinit '*'
>
> and complain that it used to work but it no longer, even with the
> band-aid patch under discussion that special cases '.'.
>
> So I dunno.  This is not only "deinit", but also the post rewrite
> version catches
>
>         $ git submodule init -- 'COPYIN*'
>
> as an error, which we probably would want to keep, so I am reluctant
> to suggest swapping the order of the check to do pathspec first and
> then gitlink-ness (it has performance implications but correctness
> is a more important issue), but if we want to keep the backward
> compatibility, that would be the best bug-to-bug compatible fix in
> the shorter term.

So I have 2 goals in mind:
* Git suggested to use '.' explicitly, so it should just work --even
for a completely
  empty repository (see the test for it)
* Eventually -- not in this patch, but a later patch targeted at
master -- we want to
  remove the recommendation to use '.', and allow no arguments or a
different argument
  for "all submodules". git add uses '.' for it though, so '.' seems
right and valid.
  git add '*' is also valid.

Maybe combine the second idea with a slight refactoring of
parse_pathspec, such that you
can pass a callback function to parse_pathspec which can decided on
each file if it is
a file to inspect. (i.e. for our usecase we'd check for ce_mode to be
GITLINK, another
hypothetical use case would be using parse_pathspec for finding all
files with a certain
property, e.g. finding all files ending in .c or files written in all
capital letters or such)

Then you could do a conditional parse_pathspec over the partial
repository which matched
the additional filtering function.


Maybe we can also special case the "force" argument only here for
Cedars use case.
("git submodule deinit ." complains because there are no further
submodules, but -f solves
the complaint?)
