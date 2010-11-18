From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Submodules or similar for exercise/exam management
Date: Thu, 18 Nov 2010 22:20:15 +0100
Message-ID: <4CE5988F.7050309@web.de>
References: <201011181109.08345.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, in-gitvger@baka.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Nov 18 22:21:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJBuh-0000nY-7d
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 22:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760508Ab0KRVU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 16:20:58 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:33793 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757271Ab0KRVU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 16:20:57 -0500
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id D189017A55A31;
	Thu, 18 Nov 2010 22:20:19 +0100 (CET)
Received: from [93.240.120.178] (helo=[192.168.178.29])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PJBtz-0008SP-00; Thu, 18 Nov 2010 22:20:19 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <201011181109.08345.trast@student.ethz.ch>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+pJnDS/ilQoHoC73l9EfkpQfK+66x0R24lfJoC
	J95mlqj7m6xvUgq9WMWXXji3FS+9oODK3GtIOt7D8sH7+CAB32
	bb9h+u7YmkcJZrwY0emQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161712>

Hi Thomas

Am 18.11.2010 11:09, schrieb Thomas Rast:
> The scenario is that we have a bunch of exercise questions stored in
> one or several files, each living in a directory.  Then, we assemble1
> those into exercise sheets (super-repos) spanning a group of questions
> (submodules).

That sounds like each directory is maintained by a different group of
people and then there is another bunch of people choosing the content
of the next exercise sheets, right?

> We would like to track this in such a way that changes
> to the questions propagate to other sheets (possibly in other
> lectures) that use them.

This could mean you would want an 'always-tip' mode for the
submodules, or am I misunderstanding you here?

> Training everyone in full git usage is probably not an option, so any
> solution would have to have some frontend that can be explained
> easily.

Yup, makes sense (at least until something goes wrong, see 3). ;-)

> The requirements we came up with are roughly:
> 
> 1) commit across all sub-repos at the same time (atomicity nice but
>    optional)
> 
>   1b) tag across all sub-repos

"git commit" and "git tag" could be taught the "--recurse-submodule"
option (but the commit part only makes sense when "git branch" can
do that too, so you have something to commit on. And I think you
want to enable a - yet to be implemented - file-based recursive diff
and status too, to see what changes your next commit will include).
And until all that materializes for submodules, a script would have
to do that.

> 2) do recursive clone/update of one super-repo easily

That will be handled by recursive checkout and is already achieved
by "git clone --recursive" (but at least in the first version both
don't support an "always-tip" mode).

> 3) never need to be aware of repo boundaries or manipulate sub-repo

I think that this requirement is the hardest for any solution I know
of or can imagine, as you hit these boundaries sooner or later either
when you want to commit, push and/or when you have to resolve merge
conflicts.

> 4) sanely cope with branches etc. in case the user wants them

A "--recurse-submodules" option to "git-branch" might be what you
want here, but as this isn't there yet a script will have to do that
for now.

> A sample workflow might be:
> 
>   foo clone git@example.com/some/super/repo
>   # time passes
>   cd repo
>   foo update
>   # work
>   foo status
>   foo diff
>   foo commit -m 'one message fits all'
>   # possibly, but this could also be commit --no-push instead
>   foo push
> 
> Merges are expected to be rare but would happen every so often.
> 
> It seems repo can do (2) and (4) but violates (3) [requires use of
> git-commit and others in the sub-repo].  git-subtree can do (1) and
> (2) but probably violates (3) [need to rebase changes to sub-repo
> branch] and (4).  Submodules can do (2) and (4) but violate (3) and
> currently have no support for (1).  I think svn externals could do
> (1)-(3) but violate (4) and probably (1b).
> 
> Has this been done before?  Or do we need to hack up a new wrapper
> around submodules?

If you would base that on submodule functionality, you would have
to hack up a wrapper script for the foreseeable future because the
"fully integrated" world view you seem to need is not worked on yet
(and I didn't see anyone coming forward to do that).

I took a cursory glance at "gitslave" Seth mentioned, it might do
what you want, but I can't tell for sure as I never used it myself.


Jens
