From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] pull: set-upstream implementation
Date: Wed, 25 May 2016 11:09:54 -0700
Message-ID: <xmqqvb22ypot.fsf@gitster.mtv.corp.google.com>
References: <20160525152528.22202-1-erwan.mathoniere@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	samuel.groot@grenoble-inp.org,
	Jordan De Gea <jordan.de-gea@grenoble-inp.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed May 25 20:10:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5dFs-0002Aw-SL
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 20:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbcEYSJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 14:09:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752308AbcEYSJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 14:09:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 707B81DE84;
	Wed, 25 May 2016 14:09:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SlvILdMODwoPEeXUO8gsZgELgSM=; b=a4h7dC
	mnKgrlr/314oJS7IYb97FtoWp1eQqqlb5hhu84DBrobYNiiElM1p4BwasRhNqTt/
	iB0JaS6uLoGEVa7UvVT6cGUeVf/aOA41k+ZtVe/l0XPOZtKfeCMm5Js5TooEML/r
	XaegUsflvtuX4B14l9aR9QPgNYn1nw09Te64g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wtDF2l+IpkSvY8RZv6MtEQdO2MykDFOD
	7KvT0vHbDcLWQJSelaQjEEiq3KcIU5WTWE5YEcmLsINr0y5G96msfL/rQxd7yy0e
	Mtw4aKJvm1h8dmp0bidprQpDWts8p0dj+YSln6N/Z+WRdkO1DpTmSr8X9Gh+sMm3
	m1RBbsuLSKo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 676301DE83;
	Wed, 25 May 2016 14:09:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB42D1DE82;
	Wed, 25 May 2016 14:09:55 -0400 (EDT)
In-Reply-To: <20160525152528.22202-1-erwan.mathoniere@grenoble-inp.org> (Erwan
	Mathoniere's message of "Wed, 25 May 2016 17:25:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E295232A-22A3-11E6-81B8-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295582>

Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org> writes:

> Subject: Re: [RFC/PATCH] pull: set-upstream implementation

If this were multi-patch series and one of the other patches were
"pull: set-upstream design" or something, then it might have been
understandable, but otherwise the word "implementation" sits rather
strangely in the title of this patch.

> Implements pull [--set-upstream | -u] which sets the remote tracking
> branch to the one the user just pulled from.
>
> 	git pull [--set-upstream | -u] <remote> <branch>
>
> After successfully fetched from <remote>, sets branch.<name>.remote to
> <remote> and branch.<name>.merge to follow <remote>/<branch>
>
> Signed-off-by: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
> Signed-off-by: Jordan De Gea <jordan.de-gea@grenoble-inp.org>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
> Hello,
>
> `git push --set-upstream <remote> <branch>` sets the remote and merge config
> variables for <branch> after successfully pushed.
>
> This patch implements an equivalent for `git pull` or
> `git branch --set-upstream-to=<remote>/<branch>`.
>
> Difficulties:
> 	- I can't figure out what remote branch sould be tracked
> 	in that case: `git pull -u origin :master`

What does the command do without "-u"?

> 	- Is the result of 'resolve_ref_unsafe' should be freed ?

Check its function signature--it returns "const char *" which is a
sign that the memory does not belong to you (i.e. the caller), and
you should never free it.

>  Documentation/git-pull.txt |  7 +++++
>  builtin/pull.c             | 61 +++++++++++++++++++++++++++++++++++++
>  t/t5544-pull-upstream.sh   | 75 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 143 insertions(+)
>  create mode 100755 t/t5544-pull-upstream.sh
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index d033b25..3a2e0b7 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -93,6 +93,13 @@ OPTIONS
>  	has to be called afterwards to bring the work tree up to date with the
>  	merge result.
>  
> +-u::
> +--set-upstream::
> +	For each branch that is successfully pulled, add
> +	upstream (tracking) reference, used by argument-less
> +	linkgit:git-push[1] and other commands. For more information,
> +	see 'branch.<name>.merge' in linkgit:git-config[1].

To me, "For each branch" hints that I could do this:

	git pull --set-upstream git://git.kernel.org/r/e/p/o foo bar

and the command would do something to 'foo' and 'bar'.

But I suspect that is not what is going on and that is not what you
wanted to achieve.

A crucial piece of information that is lacking in the above is where
<name> comes from.  The same issue exists in your proposed commit
log message.

I think that you meant to add a feature to add branch.<name>.remote
and branch.<name>.merge configuration variables for the current
branch whose name is <name>, and the values to be recorded for these
two configuration variables are the same as those given on the
command line.  For example "git checkout -b topic master && git pull
origin that" would set "branch.topic.remote" and
"branch.topic.merge" to "origin" and "that", respectively.

Without explaining what <name> is, "For more information" that
refers to 'branch.<name>.merge' does not help the readers much.

	Side note.  It is an understandable mistake.  After one
	spent a lot of effort designing, implementing and debugging
	a feature, by the time one describes what it does, some
	assumptions one made earlier becomes so fundamental in one's
	mind that one forgets that it is not obvious to others.

There a few design decisions you must have made that needs to be
either described fully or at least hinted here, too, such as (not
exhaustive and in random order):

 * What should happen when the current branch already has these two
   configuration variables defined?  Should the user get a warning
   when this changes the setting from what was already there?

 * What should happen when the remote is specified as a Git URL, not
   as a remote nickname?  You want a nickname for the value to place
   in "branch.<name>.remote".

    - Should Git find an existing remote that points at the URL and
      use it?  If so, and if the value we are about to place in
      "branch.<name>.merge" is outside its configured fetch refspec,
      should Git tweak the fetch refspec of the existing remote?

    - Should Git create a new remote nickname for the URL?  If so,
      what should the fetch refspec be for the newly created remote?
      Should it fetch only the branch we fetched just now?

 * What should happen when more than one ref is given?
   branch_get_upstream() can return only one ref; should Git choose
   one of them at random?  Should Git warn and turn this into a
   no-op?

 * What should happen when the ref given to pull is not a branch
   (e.g. a tag)?  A tag, meant to be a stable anchoring point, is
   not something suitable to be set as branch.<name>.merge, even
   though it might be technically possible to configure it as such.
   Should Git warn and turn this into a no-op?

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 1d7333c..e096858 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -829,6 +836,57 @@ static int run_rebase(const unsigned char *curr_head,
>  	return ret;
>  }
>  
> +static int set_pull_upstream(const char *repo, const char **refspecs_name)
> +{
> +	unsigned char sha1[GIT_SHA1_RAWSZ];
> +	const char *local_branch, *remote_branch;
> +	struct strbuf remote_name;
> +	struct refspec *refspecs;

Style.  Name a pointer that points at the first element of an array
as singular, so that "element[4]", not "elements[4]", becomes the
way to refer to its fourth element.

> +	int nr_refspec, i;
> +
> +	if (repo == NULL) {
> +		warning(N_("no remote was specified"));
> +		return 1;
> +	}
> +
> +	for (nr_refspec = 0; refspecs_name[nr_refspec] != NULL; nr_refspec++);

Style.  Give an empty statement its own line to make it stand out,
i.e.

	for (....)
        	; /* just counting */

> +	if (nr_refspec == 0) {
> +		warning(N_("no refspec was specified"));
> +		return 1;
> +	}

OK, this is "git pull -u <REMOTE>" without any explicit branch name;
the pull may have already used configured one (or it may have fetched
nothing); there is nothing to do here either way.

> +	refspecs = parse_fetch_refspec(nr_refspec, refspecs_name);
> +
> +	for (i = 0; i < nr_refspec; i++) {
> +		if (refspecs[i].src != NULL && strlen(refspecs[i].src) > 0) {

Style.  Lose the " != NULL" and useless strlen().  I.e.

	if (refspec[i].src && *refspec[i].src)

More importantly, what would you see here in .src when your command
line were:

	$ git pull -u <REMOTE> "refs/heads/*:refs/remotes/foo/*"

Hint: check .pattern to make sure it is false.  Skip them at the top
of the loop body, perhaps.

> +			remote_branch = refspecs[i].src;
> +		} else {
> +			warning(N_("not yet implemented"));

What do you plan to implement here?

> +			continue;
> +		}
> +
> +		if (refspecs[i].dst != NULL && strlen(refspecs[i].dst) > 0) {
> +			local_branch = refspecs[i].dst;
> +		} else {
> +			// TODO : Should it be freed ?

Style.  No "// comment".

> +			local_branch = resolve_ref_unsafe("HEAD", 0, sha1, NULL);
> +			skip_prefix(local_branch, "refs/heads/", &local_branch);

What happens here if your user did this?

	$ git checkout HEAD^0 && git pull -u <REMOTE> ...

You do not have "local_branch" here.  Check the condition, warn and
turn it into no-op (I do not think "pull -u" is important enough to
fail the entire command).

> +		}
> +
> +		strbuf_init(&remote_name, strlen(repo) + strlen(remote_branch) + 1);
> +		strbuf_addf(&remote_name, "%s/%s", repo, remote_branch);

What happens here if your user did this?

	$ git pull -u git://git.kernel.org/r/e/p/o master

Specifically, what is "repo" at this point?

> +		create_branch(local_branch, local_branch, remote_name.buf, 0, 0, 0, opt_verbosity < 0, BRANCH_TRACK_OVERRIDE);

I thought you were only setting up configurations for existing
branch.  Why do you call create_branch() on the existing
local_branch, which is supposed to be the current one?

Perhaps create_branch() API is too crappy and it needs to be
properly refactored in preparation for this patch.  I dunno.

What does it mean for this loop to execute more than once, flipping
the configuration for the current branch number of times?  The last
one wins?  Does it even make sense from the end-user's point of
view?

> +
> +		strbuf_release(&remote_name);
> +	}
> +
> +	free_refspec(nr_refspec, refspecs);
> +
> +	return 0;
> +}
> +
>  int cmd_pull(int argc, const char **argv, const char *prefix)
>  {
>  	const char *repo, **refspecs;
> @@ -884,6 +942,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  	if (opt_dry_run)
>  		return 0;
>  
> +	if (opt_set_upstream)
> +		set_pull_upstream(repo, refspecs);
> +
>  	if (get_sha1("HEAD", curr_head))
>  		hashclr(curr_head);
>  
> diff --git a/t/t5544-pull-upstream.sh b/t/t5544-pull-upstream.sh
> new file mode 100755
> index 0000000..38eb51d
> --- /dev/null
> +++ b/t/t5544-pull-upstream.sh
> @@ -0,0 +1,75 @@
> +#!/bin/sh
> +
> +test_description='pull with --set-upstream'
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-terminal.sh
> +
> +ensure_fresh_upstream() {

Style:

	ensure_fresh_upstream () {

> +	rm -rf parent &&
> +	git init parent &&
> +	cd parent &&
> +	(
> +		echo content >file &&
> +		git add file &&
> +		git commit -m one &&
> +		git checkout -b other &&
> +		echo content >file2 &&
> +		git add file2 &&
> +		git commit -m two &&
> +		git checkout -b master2 &&
> +		git checkout master
> +	) &&
> +	cd ..

The tests typically do

	... some stuff ... &&
        (
		cd elsewhere &&
                ... more stuff ...
	) &&
        ... yet more stuff ...

to make sure that even after any of "... more stuff ..." fails, the
caller of this sequence will find it in an expected and stable
place.  As written in your patch, if any of the "... more stuff ..."
fails, the caller will be in "parent" directory, not in the original
directory, because your "cd .." will not be exectued.

I wonder if you are completely missing the point of using a subshell
here?

> +}
> +
> +test_expect_success 'setup bare parent' '
> +	ensure_fresh_upstream &&
> +	git remote add upstream parent &&
> +	git pull upstream master
> +'
> +
> +check_config() {
> +	(echo $2; echo $3) >expect.$1

	test_write_lines "$2" "$3" >"expect.$1"

Unless you want your variable reference is split at $IFS, quote
your variables.

> +	(git config branch.$1.remote
> +	 git config branch.$1.merge) >actual.$1
> +	test_cmp expect.$1 actual.$1

It is not _wrong_ per-se, but I do not think ".$1" suffix is adding
any value.  I'd drop it if I were doing this patch.

> +}
> +
> +test_expect_success 'pull -u master' '
> +	git pull -u upstream master &&
> +	check_config master upstream refs/heads/master
> +'
> +
> +test_expect_success 'pull -u master:other' '
> +	git pull -u upstream master:other &&
> +	check_config other upstream refs/heads/master
> +'
> +
> +test_expect_success 'pull -u --dry-run other:other' '
> +	git pull -u --dry-run upstream other:other &&
> +	check_config other upstream refs/heads/master
> +'
> +
> +test_expect_success 'pull -u master2:master2 master:other' '
> +	git branch master2 &&
> +	git pull -u upstream master2:master2 master:other &&
> +	check_config master2 upstream refs/heads/master2 &&
> +	check_config other upstream refs/heads/master
> +'
> +
> +test_expect_success 'pull -u HEAD' '
> +	git clone parent son &&
> +	cd son &&
> +	git checkout -b headbranch &&
> +	git pull -u origin HEAD &&
> +	check_config headbranch origin refs/heads/master

Do not "chdir" outside a subshell.

I think the next test will not work if this test, specifically the
first two steps that creates a new repository "son" and moves into
it, fails.  Don't create such an interdependency between tests when
you can avoid it.

Hint. Immediately after creating "parent", in the same test, clone
it into "son".  Everybody needs to depend on that "setup bare
parent" test anyway, so that is not making things worse.  And then
update this test like so:

	test_expect_success 'title' '
        	(
                	cd son &&
                        git checkout -b headbranch &&
                        ...
		)
	'

making sure that outside test_expect_success block, the process will
stay at the original directory, no matter which tests fail or get
skipped.

> +'
> +
> +test_expect_success TTY 'quiet pull' '
> +	ensure_fresh_upstream &&
> +
> +	test_terminal git pull -u --quiet upstream master 2>&1 | tee output &&
> +	test_cmp /dev/null output
> +'

There is no test that makes sure that the new feature does not kick
in when it should not.  E.g. pulling from somewhere that is not a
configured remote.  For example, 

> +test_done
