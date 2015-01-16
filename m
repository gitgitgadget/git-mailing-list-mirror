From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] commit/status: show the index-worktree with -v -v
Date: Fri, 16 Jan 2015 09:13:34 +0100
Message-ID: <54B8C82E.8000707@drmicha.warpmail.net>
References: <xmqq387db6xy.fsf@gitster.dls.corp.google.com>	<038e08973a5872ea13a0ea76bf2a0443fe3c3b50.1421337740.git.git@drmicha.warpmail.net> <xmqq1tmv7qjg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ivo Anjo <ivo.anjo@ist.utl.pt>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 09:13:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YC22N-00079N-2Y
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 09:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbbAPINh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 03:13:37 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33751 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752071AbbAPINg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2015 03:13:36 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 152D92092A
	for <git@vger.kernel.org>; Fri, 16 Jan 2015 03:13:36 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 16 Jan 2015 03:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=/0wJ4Ur+qeOWZ/cmr2bCk5
	WKg10=; b=ZZOgU5YcWldDjEwbvWOHFjou/9h69dh6uez8IH+eCjcTlGtgDQvD3p
	DdXzbLj8jEnzX1gIHHpj5ewb9gFfCYym3Dc839Ta5gmgspTqhUQcowxrpn0gnsVD
	TbQQ/SVxBaSJTY07ZAEPINCbKx7tSnTkOpfo8NkZy3scBJNCgvJng=
X-Sasl-enc: KiQvXYB/CB5U6ZbYolL8Xw68teSqXF8h2yTmmMbzCD2X 1421396015
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 57175C00013;
	Fri, 16 Jan 2015 03:13:35 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqq1tmv7qjg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262538>

Junio C Hamano schrieb am 15.01.2015 um 21:11:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> git commit and git status in long format show the diff between HEAD
>> and the index when given -v. This allows previewing a commit to be made.
>>
>> They also list tracked files with unstaged changes, but without a diff.
>>
>> Introduce '-v -v' which shows the diff between the index and the
>> worktree in addition to HEAD index diff. This allows to review unstaged
>> changes which might be missing from the commit.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> Also, the git status man page does not mention -v at all, and the doc
>> for git status (long format) and the status parts of the git commit
>> man page should really be the same.
>>
>> In any case, this may have helped the OP with his amend oversight.
> 
> Hmm, does this show what change relative to HEAD is committed fully
> and then after that show what change relative to the index being
> commited remains in the working tree at the end?  
> 
> I do not think that output order is very helpful.  Two diffs to the
> same file next to each other may make it easier to notice, though.
> That is, not like this:
> 
> 	diff --git a/A b/A
>         ...
>         diff --git a/B b/B
>         ...
>         diff --git i/A w/A
>         ...
> 
> but like this:
> 
> 	diff --git a/A b/A
>         ...
>         diff --git i/A w/A
>         ...
>         diff --git a/B b/B
>         ...
> 
> or it may want to even be like this:
> 
> 	diff --git a/A b/A
>         ...
>         diff --git to-be-committed/A left-out-of-the-commit/A
>         ...
>         diff --git a/B b/B
>         ...
> 
> by using a custom, unusual and easy-to-notice prefixes.
> 
>>  Documentation/git-commit.txt | 4 ++++
>>  wt-status.c                  | 8 ++++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
>> index 1e74b75..f14d2ec 100644
>> --- a/Documentation/git-commit.txt
>> +++ b/Documentation/git-commit.txt
>> @@ -284,6 +284,10 @@ configuration variable documented in linkgit:git-config[1].
>>  	would be committed at the bottom of the commit message
>>  	template.  Note that this diff output doesn't have its
>>  	lines prefixed with '#'.
>> ++
>> +If specified twice, show in addition the unified diff between
>> +what would be committed and the worktree files, i.e. the unstaged
>> +changes to tracked files.
>>  
>>  -q::
>>  --quiet::
>> diff --git a/wt-status.c b/wt-status.c
>> index b54eac5..75674c2 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -874,6 +874,14 @@ static void wt_status_print_verbose(struct wt_status *s)
>>  		wt_status_add_cut_line(s->fp);
>>  	}
>>  	run_diff_index(&rev, 1);
>> +	if (s->verbose > 1) {
>> +		setup_work_tree();
>> +		if (read_cache_preload(&rev.diffopt.pathspec) < 0)
>> +			perror("read_cache_preload");
> 
> Hmm, as we have run diff-index already, we must have had the index
> loaded, no?  What is going on here?

It was late and simply calling run_diff_files() didn't work (because of
the missing setup_work_tree()), so I added the lines from our diff.c and
overlooked that read_cache_preload() must have happened somewhere already.

>> +		rev.diffopt.a_prefix = 0; /* allow run_diff_files */
>> +		rev.diffopt.b_prefix = 0; /* to reset the prefixes */
> 
> This is not just "allow to reset the prefixes", but forces the use
> of mnemonic prefixes to make sure they look different from the
> normal "diff --cached" output that shows what is going to be
> committed.  If we were to do this, for consistency, we may want to
> use the mnemonic prefix for the "to be commited" part, no?

I guess here I got blinded by me default config which does that.

> 
>> +		run_diff_files(&rev, 0);
>> +	}
>>  }
>>  
>>  static void wt_status_print_tracking(struct wt_status *s)

I really like your suggestion to use more verbose prefixes here for both
cases. I guess we can do without additional subheadings for the diffs then.

As for the helpfulness, the intention was to show the diff for the two
categories of changes which "git status" lists without diff already:

- changes to be committed (+index -HEAD) aka "git diff --cached"
- changes present in worktree not to be committed (+worktree -index) aka
"git diff"

The paths which would appear in the diff "+worktree -HEAD" are not
mentioned in "git status" per se (as a category with subheading),
although they fall into at least 1 of the 2 categories, of course.

Michael
