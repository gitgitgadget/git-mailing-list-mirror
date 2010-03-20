From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git checkout: create unparented branch by --orphan
Date: Sat, 20 Mar 2010 08:13:03 -0700
Message-ID: <7vvdcrowlc.fsf@alter.siamese.dyndns.org>
References: <1268928579-11660-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 16:13:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt0Mi-0003kK-8m
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 16:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403Ab0CTPNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 11:13:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab0CTPNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 11:13:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 00396A2ABF;
	Sat, 20 Mar 2010 11:13:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DmpQzWhxxv9ecRQ99uyQ88Y4SrU=; b=YF6bfz
	zpLP815oN5JG8cJNDAdDNoquOMRpKWVscjnVmnTKJOqKcUZ3LAt2rBtc53s6PVLL
	Gn8DZNq+IEq5EeT1hiR3dsuBtHLwWccA51IgLZkatafrxe/eXdyzUtNqeOQVXWMM
	hscbfztFakHnViPVWt7hiddrA0HXaX+7PzUtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NDsGJdwnK5w8q8OmULtFPAM9n6qZOvbi
	U6GmA9p73p44pSmW5uGZGernigvkyQPAmq53WYCvsQmv3HxqXXcaUJqohGBw6tNy
	jIo3B7uqqfO6Hi8KBWlne7/xGKOUznkxa8BoNyJkgYZzhk0+noOr7VsLyEdAec6l
	eOMvDNgwHCY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D1320A2ABE;
	Sat, 20 Mar 2010 11:13:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0EEFA2AB5; Sat, 20 Mar
 2010 11:13:04 -0400 (EDT)
In-Reply-To: <1268928579-11660-1-git-send-email-erick.mattos@gmail.com>
 (Erick Mattos's message of "Thu\, 18 Mar 2010 13\:09\:39 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 17003D18-3433-11DF-9772-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142714>

Erick Mattos <erick.mattos@gmail.com> writes:

> Complete rewrite of --orphan functionality to fit it in the new design goals
> set by Junio.  Now --orphan is not anymore an option of -b.  It is an
> alternative to it.

You are giving me too much credit.  I just made a suggestion, you had the
choice to agree to or disagree with it, and I am hoping that you made the
final decision to rewrite the patch to match what I suggested not because
you wanted a "commit count" in the project with any form of a change, but
because you thought the suggested approach made much more sense than the
earlier iterations.  And in that case, the final decision to submit the
patch in this form was due to _you_.  Don't give me undue credit---I was
just helping from the sideline.

> Junio:  I ask you to reconsider only the giving of the "short-and-sweet" -o
> from beginning because of the new design.

No.  I don't want our hand to be tied with something that is clearly a
corner case feature from the beginning.  It wouldn't be too late to add
one later, after it proves something people do every day (or even every
hour).

>  Documentation/git-checkout.txt |   21 +++++++++++++++-
>  builtin/checkout.c             |   19 +++++++++++++-
>  t/t2017-checkout-orphan.sh     |   53 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+), 3 deletions(-)
>  create mode 100755 t/t2017-checkout-orphan.sh
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index 37c1810..18df834 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -20,6 +20,19 @@ When <paths> are not given, this command switches branches by
>  updating the index, working tree, and HEAD to reflect the specified
>  branch.
>  
> +When you use "--orphan", a new unparented branch is created having the
> +index and the working tree intact.  This allows you to start a new
> +history that records set of paths similar to that of the start-point
> +commit, which is useful when you want to keep different branches for
> +different audiences you are working to like when you have an open source
> +and commercial versions of a software, for example.
> +
> +If you want to start a disconnected history that records set of paths
> +totally different from the original branch, you may want to first clear
> +the index and the working tree, by running "git rm -rf ." from the
> +top-level of the working tree, before preparing your files (by copying
> +from elsewhere, extracting a tarball, etc.) in the working tree.
> +
>  If `-b` is given, a new branch is created and checked out, as if
>  linkgit:git-branch[1] were called; in this case you can
>  use the --track or --no-track options, which will be passed to `git

It feels wrong to talk about --orphan before readers learned -b.  Does the
text flow nicely if we just swap the paragraphs?  Better yet, perhaps we
shouldn't have any of this in the general description section.  Move this
and consolidate it with the text in "OPTIONS" section under "--orphan"?

> @@ -63,6 +76,12 @@ entries; instead, unmerged entries are ignored.
>  	When checking out paths from the index, check out stage #2
>  	('ours') or #3 ('theirs') for unmerged paths.
>  
> +--orphan::
> +	Create a new branch named <new_branch>, unparented to any other
> +	branch.  The new branch you switch to does not have any commit
> +	and after the first one it will become the root of a new history
> +	completely unconnected from all the other branches.
> +
>  -b::
>  	Create a new branch named <new_branch> and start it at
>  	<start_point>; see linkgit:git-branch[1] for details.

Likewise.  I think "--orphan" should come after -b/-t/-l (all about the
normal cases of switching to a different branch either new or existing).

Oh, by the way, how does this new option work with -t?  I think the
combination should be rejected, no?

> @@ -491,8 +492,15 @@ static void update_refs_for_switch(struct checkout_opts *opts,
>  	struct strbuf msg = STRBUF_INIT;
>  	const char *old_desc;
>  	if (opts->new_branch) {
> -		create_branch(old->name, opts->new_branch, new->name, 0,
> -			      opts->new_branch_log, opts->track);
> +		if (opts->new_orphan_branch) {
> +			unsigned char rev[20];
> +			int flag;
> +			if (old->path != resolve_ref("HEAD", rev, 0, &flag))
> +				cmd_checkout(1, &old->name, NULL);

Can you explain what this is doing?

 - the "if" compares the addresses of two strings; did you mean it?

 - It is like recursively calling main() which is rather unusual and error
   prone;

 - what happens when cmd_checkout() fails, perhaps due to local changes?

I have a suspicion that you are trying "git co-o new old" case where old
is not the current branch (so that you would want to adjust the index and
the working tree files to that of "old" while carrying local changes
forward), _but_ if that is the case that should have been already done
with the logic in switch_branches() where it calls merge_working_tree(),
and not here in the call chain.

> @@ -677,6 +686,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  		opts.new_branch = argv0 + 1;
>  	}
>  
> +	if (opts.new_orphan_branch) {
> +		if (opts.new_branch)
> +			die("--orphan and -b are mutually exclusive");
> +		opts.new_branch = opts.new_orphan_branch;
> +	}

How should this interact with opts.track?  I think (and please correct
me if you disagree):

 - "git checkout -t --orphan new [old]" should fail; new is rootless and
   does not track either the current branch or "old";

 - opts.track that came from git_branch_track (default read from config)
   should not cause a failure, but be silently ignored.

> diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
> new file mode 100755
> index 0000000..e6d88b1
> --- /dev/null
> +++ b/t/t2017-checkout-orphan.sh
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2010 Erick Mattos
> +#
> +
> +test_description='git checkout --orphan
> +
> +Main Tests for --orphan functionality.'
> +
> +. ./test-lib.sh
> +
> +TEST_FILE=foo
> +
> +test_expect_success 'Setup' '
> +	echo "Initial" >"$TEST_FILE" &&
> +	git add "$TEST_FILE" &&
> +	git commit -m "First Commit"
> +	test_tick &&
> +	echo "State 1" >>"$TEST_FILE" &&
> +	git add "$TEST_FILE" &&
> +	git commit -m "Second Commit"

No tick before this one?

> +'
> +
> +test_expect_success '--orphan creates a new orphan branch from HEAD' '
> +	git checkout --orphan alpha &&
> +	test_must_fail PAGER= git log >/dev/null 2>/dev/null &&
> +	test "alpha" = "$(git symbolic-ref HEAD | sed "s,.*/,,")" &&

What is this PAGER= doing here?

I think it is more direct to check that:

 - "rev-parse --verify HEAD" fails; and
 - "symbolic-ref HEAD" says refs/heads/alpha.

> +	test_tick &&
> +	git commit -m "Third Commit" &&

Tricky but correct ;-)

> +	test 0 -eq $(git cat-file -p HEAD | grep "^parent" | wc -l) &&

    test_must_fail git rev-parse --verify HEAD^

> +	git cat-file -p master | grep "^tree" >base &&

    git rev-parse master^{tree} >base

> +	git cat-file -p HEAD | grep "^tree" >actual &&
> +	test_cmp base actual
> +'

Or you can just replace the above three lines with:

	git diff-tree --quiet master alpha

> +test_expect_success '--orphan creates a new orphan branch from <start_point>' '
> ...
> +'

Similar.

> +test_expect_success '--orphan must be rejected with -b' '
> +	test_must_fail git checkout --orphan new -b newer
> +'

Ok.  You have the basics covered well; there are a few more things to
test, I think.

With local changes in the index/working tree without "start commit" (which
should never fail) and with "start commit" (which should fail if HEAD and
start commit has differences to the same paths as you have local changes
to).

Also you would want to check with -t, --no-t, branch.autosetupmrebe set to
always in the configuration with -t and without -t from the command line,

Thanks.
