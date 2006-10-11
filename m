From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Wed, 11 Oct 2006 11:20:54 +0200
Message-ID: <200610111120.55330.jnareb@gmail.com>
References: <egdge3$t12$1@sea.gmane.org> <7v1wpfwg92.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 11:21:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXaFk-0004qH-N5
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 11:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbWJKJTt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 05:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbWJKJTt
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 05:19:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:42337 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965189AbWJKJTs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 05:19:48 -0400
Received: by ug-out-1314.google.com with SMTP id o38so71150ugd
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 02:19:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UL8NU/cDxDyVe1y3QXgxMRansk4j0ysCVz6BWtF9cQMe+q1rxoLnC1Wdzjg75wWu2bYK83NO9eEC6Ki9E3zLWsm0iWr8SpTQeWFph5h6y1b87ymQMtl6bjSbNmx+LaertcwEmmHhq3vu5W6cS3li2TqvQSzfAssUCu7EF6pj9KE=
Received: by 10.67.97.18 with SMTP id z18mr685593ugl;
        Wed, 11 Oct 2006 02:19:46 -0700 (PDT)
Received: from host-81-190-20-194.torun.mm.pl ( [81.190.20.194])
        by mx.google.com with ESMTP id a1sm549442ugf.2006.10.11.02.19.45;
        Wed, 11 Oct 2006 02:19:46 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7v1wpfwg92.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28708>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> 1. Cleanups and refactoring
>>
>>  * HTML and CSS cleanup. All (or almost all) styling should be done using
>>    CSS, and not embedded style or presentation elements. All HTML elements
>>    except perhaps a few should have either class attribute (if such
>>    element can be multiple times on page) or id attribute (if there can be
>>    only one such element). Perhaps some class attributes should be changed
>>    to id attributes. Gitweb has much improved from the incorporation in
>>    this area.
> 
> It scares me when somebody says "all X should do Y".  Aiming for
> consistency and cleanliness is good but taking it to extreme and
> becoming dogmatic about it isn't.  Let's not repeat the crusade
> against redundant links.

Well, after writing this part I have checked that we don't use
"style" attribute in gitweb anymore. But we still do use presentational
elements, like <i>. IMHO we should use CSS for styling.

>>    ... When the new
>>    --grep/--author/--commiter options to git-rev-list hits released version,
>>    perhaps also git_search could be put together with the previous set.
> 
> Sounds like a good idea, but I think people can (and should)
> start preparing for it in "next"; after all that is what "next"
> is for.

Using --grep/--author/--commiter would have the advantage of to be
easily able to paginate "log search" in gitweb.

I forgot to add splitting git_search into "log search" and "pickaxe search",
and perhaps adding "file search" aka. "grep search" to gitweb.
 
>>  * Refactor calling a git command and reading it's output into separate
>>    subroutine git_command/git_pipe, so for example if someone _has_ to use
>>    gitweb with ancient Perl version which does not understand list version
>>    of magic "-|" open could do it changing only one subroutine. Well, we can
>>    use Git.pm when it hits main release.
> 
> I agree this is a good thing to do while refactoring.  There are
> too many similar looking code sprinkled all over.  Git.pm is
> already in the "master" and there is nothing cooking in "next".

I'm not sure if I would like to use Git.pm repository abstraction.
But converting gitweb to use Git.pm would be a good idea, I agree.
Although I'd rather have any gitweb patches which need _unreleased_
features to be in 'next'.
 
BTW. the Git.pm-ish ideas (config parser, remotes parser, symrefs and
packed refs parser) should perhaps be added (at least in 'next')
via Git.pm.

>>  * Add simplified git config file parser, which would _read_ only gitweb
>>    entries (and convert them to bool/int if necessary). With this we could
>>    move description, category, export_ok, .hide, cloneurl to config file,
>>    instead of cluttering $GIT_DIR. Or just make it an option (read file
>>    first, if it doesn't exist try config file).
> 
> I do not see why you would need anything "simplified"; I think
> writing a .git/config parser purely in Perl is much easier than
> waiting for libified interface that talks .xs and would run just
> as efficient -- after all Perl is the ideal tool for text file
> processing like this.  And I do not particularly worry about
> issues that could arise from two different configuration parsers
> having different set of bugs.  The file format is simple enough.
> It would be a very good addition to Git.pm suite.

There are many INI file parsers in CPAN, but I guess that Git adds
it's own config file syntax (e.g. branch and remote config:
  [branch "quoted branch name with funny characters]
which is not yet documented if I remember correctly) that we want our
own parser; this would also reduce dependencies.

"Simplified" because of not implementing "extended syntax" mentioned
above, and because implementing only reading config file. It is harder
to make it write config file, preserving comments etc.
 
By the way, would it be better to use CGI like syntax of 
$repo->config("gitweb.$key"), or tie hash?

>>  * Code highlighting (or generic filter) support in blob view, perhaps as
>>    a feature.
> 
> Not particularly interested myself but as long as it would not
> add huge load on the server I would not much object either.

It should be: as a feature, not perhaps as a feature. Perhaps
make highlighting configurable (program to use, filename to mode
mapping, etc.)
 
>>  * Crossreferencing in blob view.
> 
> LXR is certainly interesting, but I would rather use local "git grep".

This is far, far in the queue at least for me. And I'm not sure
if crossreferencing can be done without creating temporary files,
something we tried to avoid (e.g. creating diffs on-the-fly now).
 
>>  * add summary of number of lines changed for each file (a la darcsview)
>>    in the difftree part of commit and *diff* views, e.g.
>>
>>         blame.c   +1 -0  diff | history | blame
>>
>>    or something like that.
> 
> I'll place "diff --numstat" to the stack of "things to do on the
> core side".  Should be trivial.

Thanks. I did wonder why git-apply (!) has "--numstat" but git-diff
has not... 

>>  * "List of the files in given directory, touched by given commit"
> 
> Have no idea what you mean.  "diff-tree -r --name-only $commit"?

I'm repeating verbatim someone idea. IIRC it meant adding list
of affected files (like difftre part of "commit" and "commitdiff"
views) to the "log" and "search" views...
 
>> X. Proposed improvements to core git commands
>>  * add --stdin option to git-ls-tree, a la --stdin option to git-diff-tree.
> 
> Not particularly interested, as it is unclear how the output
> boundary should be marked, but should be trivial to add once we
> know what the output should look like.

The output format for git-ls-tree is
	<mode> SP <type> SP <object> TAB <file>
It is fairly easy to distinguish such line from the
	<sha1 of tree-ish>
line. 

The idea was that 
	echo "tree-ish 1" "tree-ish 2" | git ls-tree --stdin
output would be
	<sha1 of tree-ish 1>
	<mode> SP <type> SP <object> TAB <file>
	...
	<mode> SP <type> SP <object> TAB <file>
	<sha1 of tree-ish 2>
	<mode> SP <type> SP <object> TAB <file>
	...
	<mode> SP <type> SP <object> TAB <file>

We could add some records (trees) seperating, for example by NUL
character like in git-rev-list --headers.
 
>>  * add --follow option to git-rev-list, allow to provide path limiter via
>>    stdin (with --stdin option) in git-diff-tree
> 
> The "path limiter via stdin" part is murky.  I would not object
> to "rev-list --follow=$this_path_at_the_tip $start_at_this_commit"
> which I can see clear semantics for. 
 
You can provide <tree-ish> or pair of <tree-ish> from stdin for
git-diff-tree --stdin. You can provide path limiter _only_ as an
argument to git-diff-tree. Proposed extension is to be able to
use
	<tree-ish> [<tree-ish>] [<path>...]
from stdin, perhaps _forcing_ to use
	 <tree-ish> [<tree-ish>] ['--' <path>...]
syntax.

Alternatively, change semantics of path limiter if path limiter
match _exactly_ --follow argument.
-- 
Jakub Narebski
Poland
