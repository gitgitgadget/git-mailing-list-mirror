From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Thu, 18 Oct 2012 16:26:12 +0200
Message-ID: <CAMP44s2_jZRtG5bRCDsc8kO5EqFYLDWFQ5d6F9URrSQQNDqvNA@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
	<50800197.90105@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 16:26:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOr3K-0006eJ-M9
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 16:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175Ab2JRO0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 10:26:14 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44884 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755810Ab2JRO0N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 10:26:13 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so8563716obb.19
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cu0fJj5kWHhxI76EAACvHoQC0DBZYxz3yisNTdm7A4I=;
        b=GqRXuGeHh/JrSkRwrCSgV8zIN3WwqwwBEHXupRBJmnOEXrVKwcX4ZWJpJsBOFajwZv
         R6r5bpn8Wty0OJSw2ratTIkZghtNQbWgxdPQvf2+VcbSi6k5uB0/zrNP1BBh1cGANPMT
         zGIODMc9jKIZ5y8XnkD5S3SfZBdFrT71OYJrIugUYIPs5ywHBniZWbEhSXTpi8k6vFqk
         LoR9B0YI91VVckYQpznlcKqXDckZQ6LCQx4TVu1GLVf3nbgrwAmUerDYaSjaK68UOZPx
         aEspxHyoZPGUo2fD27UQ0XcqFNmvFa73Y+lJSHFCr4LOApS23Re4TphDFn51aqcu4Jn3
         Pilg==
Received: by 10.60.170.179 with SMTP id an19mr13908159oec.46.1350570372529;
 Thu, 18 Oct 2012 07:26:12 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Thu, 18 Oct 2012 07:26:12 -0700 (PDT)
In-Reply-To: <50800197.90105@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208006>

On Thu, Oct 18, 2012 at 3:18 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 17.10.2012 14:58:
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>
>> I've looked at many hg<->git tools and none satisfy me. Too complicated, or too
>> slow, or to difficult to setup, etc.
>
> It's in an unsatisfying state, I agree. We have a great remote helper
> infrastructure, but neither git-svn nor git-cvsimport/export use it, and
> remote-hg is not in git.git.
>
> git-svn used to be our killer feature! (It's becoming hard to maintain,
> though.)
>
> git-hg (in the shape of a remote helper) could be our next killer
> feature, finally leading to our world domination ;)
>
>> The only one I've liked so far is hg-fast-export[1], which is indeed fast,
>> relatively simple, and relatively easy to use. But it's not properly maintained
>> any more.
>>
>> So, I decided to write my own from scratch, using hg-fast-export as
>> inspiration, and voila.
>>
>> This one doesn't have any dependencies, just put it into your $PATH, and you
>> can clone and fetch hg repositories. More importantly to me; the code is
>> simple, and easy to maintain.
>
> Well, it still has hg as a dependency. All our remote
> integration/helpers suffer from that. At least, every hg install comes
> with the modules, whereas svn is a beast (apr and such) that often comes
> without the language bindings.

Yeah, but there's no way around that, even if we write some code to
access the repository, it's quite likely that it will change. Unlike
git, mercurial developers expect people to access the repository
through mercurial API, not directly, and that's probably what we
should do if we want to avoid problems.

>>  contrib/remote-hd/git-remote-hg | 231 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 231 insertions(+)
>>  create mode 100755 contrib/remote-hd/git-remote-hg
>
> That diffstat looks great (sans tests, of course; it's contrib), but
> there's no push functionality, and that is usually the most difficult
> part all helpers have to implement: Not only the push interaction, but
> also making sure that commits don't get duped in a roundtrip (git fetch
> from vcs, push to vcs, git fetch from vcs).

Yeah, it will probably require much more code, but I think by far the
most important feature is fetching.

> Just cloning and fetching can be done most easily with a shared worktree
> and scripting around "hg up" and "git commit -A" in some flavour.

Yea, but that will be dead slow.

>> diff --git a/contrib/remote-hd/git-remote-hg b/contrib/remote-hd/git-remote-hg
>> new file mode 100755
>> index 0000000..9157b30
>> --- /dev/null
>> +++ b/contrib/remote-hd/git-remote-hg
>> @@ -0,0 +1,231 @@
>> +#!/usr/bin/python2
>> +
>> +# Inspired by Rocco Rutte's hg-fast-export
>> +
>> +# Just copy to your ~/bin, or anywhere in your $PATH.
>> +# Then you can clone with:
>> +# hg::file:///path/to/mercurial/repo/
>> +
>> +from mercurial import hg, ui
>> +
>> +import re
>> +import sys
>> +import os
>> +import json
>> +
>> +def die(msg, *args):
>> +    print >> sys.stderr, 'ERROR:', msg % args
>> +    sys.exit(1)
>
> While we don't have to code for py3, avoiding '>>' will help us later.
> (It got removed in py3.) sys.sdterr.write() should be most portable.

All right.

>> +def gitmode(flags):
>> +    return 'l' in flags and '120000' or 'x' in flags and '100755' or '100644'
>> +
>> +def export_file(fc):
>> +    if fc.path() == '.hgtags':
>
> Is this always relative? Just wondering, dunno.

AFAIK, why wouldn't it?

>> +def get_repo(path, alias):
>> +    myui = ui.ui()
>> +    myui.setconfig('ui', 'interactive', 'off')
>> +    repo = hg.repository(myui, path)
>> +    return repo
>
> Is there a reason to spell this out, e.g.: Why not
>
> return hg.repository(myui, path)

No reason, but I already have patches on top of this.

>> +def hg_branch(b):
>> +    if b == 'master':
>> +        return 'default'
>> +    return b
>> +
>> +def git_branch(b):
>> +    if b == 'default':
>> +        return 'master'
>> +    return b
>> +
>> +def export_tag(repo, tag):
>> +    global prefix
>> +    print "reset %s/tags/%s" % (prefix, tag)
>> +    print "from :%s" % (repo[tag].rev() + 1)
>> +    print
>> +
>> +def export_branch(repo, branch):
>> +    global prefix, marks, cache, branches
>> +
>> +    heads = branches[hg_branch(branch)]
>> +
>> +    # verify there's only one head
>> +    if (len(heads) > 1):
>> +        die("Branch '%s' has more than one head" % hg_branch(branch))
>
> We have to deal with this at some point... Do you support "hg
> bookmarks"? They'd be an option, or we implement better detached head
> handling in git...

I already updated this, I converted it to a warning and just picked a
random head.

Adding support for bookmarks should be easy, it's just a matter of
deciding how to differentiate branches from bookmarks. Perhaps
'refs/heads/bookmarks/foo'.

>> +    revs = [rev for rev in revs if not cache.get(rev, False)]
>> +
>> +    for rev in revs:
>
> Those lines set up the list just so that you iterate over it later.
> Please don't do this (unless you know that revs is very small).
>
> for rev in revs:
>   if cache.get(rev, False):
>     continue
>
> is more performant. You can reduce this further to
>
> count=0
> for rev in repo.revs('%u:%u' % (tip, head)):
>   if cache.get(rev, False):
>     continue
>
> which is even more performant generally, and especially if repo.revs()
> returns an iterator rather than a list.
>
> [Yes, you could use lambda+filter, but let's not get religious. The
> above is simple and pythonic.]

And we wouldn't be able to calculate the progress: len(revs).

>> +
>> +        c = repo[rev]
>> +        (manifest, user, (time, tz), files, desc, extra) = repo.changelog.read(c.node())
>
> Same here, you introduce c just for the next line (unless I'm mistaken).

The second line is already too big.

>> +            print "from :%s" % (parents[0] + 1)
>
> What is this +1 offset that is appearing here and there?

Marks start from 1, no? If not, this can be removed.

>> +def do_list(repo, args):
>> +    global branches
>> +
>> +    head = repo.dirstate.branch()
>> +    for branch in repo.branchmap():
>> +        heads = repo.branchheads(branch)
>> +        if len(heads):
>> +            branches[branch] = heads
>
> I'm a bit confused here. repo.brancheads() is a list, no? Is this the
> single head case only? I'd expect [0] of that, but you seem to be
> getting branch names (strings).

No, heads is a list of heads, as nodes.

> Also, if len(heads) == 0 then branches[branch] is undefined or stale. No?

Yes, but we don't care about those branches; they are closed.

> Overall, this looks like plain scripting in python rather than anything
> oo'ish, but that's okay and probably dictated by the remote helper
> interface and/or the existing exporter.

If there was an advantage of creating new classes, I would be all for
it, but I don't see any.

> I'm all for an improvement in that area, but still feel we'd need a
> combined effort rather than yet another start.

Me too, but as far a sverre's remote-hg code goes, there isn't even a
branch to work from.

Cheers.

-- 
Felipe Contreras
