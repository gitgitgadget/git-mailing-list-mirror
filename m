From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC] rebase --root: Empty root commit is replaced with sentinel
Date: Thu, 19 Jun 2014 13:35:52 +0200
Message-ID: <53A2CB18.7020408@alum.mit.edu>
References: <53A18198.7070301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Webb <chris@arachsys.com>
To: Fabian Ruch <bafain@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 13:36:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxadM-0000kG-6u
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 13:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757987AbaFSLf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 07:35:56 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60186 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757129AbaFSLfz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2014 07:35:55 -0400
X-AuditID: 1207440d-f79c26d000000b51-8e-53a2cb1a91d9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D1.5A.02897.A1BC2A35; Thu, 19 Jun 2014 07:35:54 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3EB8.dip0.t-ipconnect.de [93.219.62.184])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5JBZqIC032701
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 19 Jun 2014 07:35:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <53A18198.7070301@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqCt1elGwwfkeUYtDc++xWxzY4GjR
	daWbyYHZ4//K2YweO2fdZff4vEkugDmK2yYpsaQsODM9T98ugTtj+fJNrAX3VSu+L5nH3sD4
	SLaLkZNDQsBEom/NSnYIW0ziwr31bF2MXBxCApcZJT4sfMwO4ZxnkmieuZ+li5GDg1dAW+Jm
	kxNIA4uAqsTJm/OYQWw2AV2JRT3NTCC2qECQxOzP88CG8goISpyc+YQFxBYRMJc4vmMWWJxZ
	QFmi+dg8RhBbWMBXYtm5HlYQW0hAQ+L7tH1g9ZwCmhLzdu5kAlkrISAu0dMYBNGqI/Gu7wEz
	hC0vsf3tHOYJjIKzkGybhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRyM0v0
	UlNKNzFCApp3B+P/dTKHGAU4GJV4eBdcXhgsxJpYVlyZe4hRkoNJSZQ3+/iiYCG+pPyUyozE
	4oz4otKc1OJDjBIczEoivN0HgHK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZ
	GQ4OJQnejyeBGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJB8RtfDIxgkBQP0N4/
	IO28xQWJuUBRiNZTjLocp+4ca2MSYsnLz0uVEufNAykSACnKKM2DWwFLX68YxYE+FuZlOAVU
	xQNMfXCTXgEtYQJasrgHbElJIkJKqoExs/ypfbZ8v+VZvUiG+cWlyRniXqyZst3/JeN3up2U
	PzhXMUrc8NvO7n1e+aJWSl3MphItqs7l01yljDuS1a73OP53cWqwqN34a3OKSMri 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252109>

On 06/18/2014 02:10 PM, Fabian Ruch wrote:
> `rebase` supports the option `--root` both with and without `--onto`.
> The case where `--onto` is not specified is handled by creating a
> sentinel commit and squashing the root commit into it. The sentinel
> commit refers to the empty tree and does not have a log message
> associated with it. Its purpose is that `rebase` can rely on having a
> rebase base even without `--onto`.
> 
> The combination of `--root` and no `--onto` implies an interactive
> rebase. When `--preserve-merges` is not specified on the `rebase`
> command line, `rebase--interactive` uses `--cherry-pick` with
> git-rev-list to put the initial to-do list together. If the root commit
> is empty, it is treated as a cherry-pick of the sentinel commit and
> omitted from the todo-list. This is unexpected because the user does not
> know of the sentinel commit.

I see that your new tests below both use --keep-empty.  Without
--keep-empty, I would have expected empty commits to be discarded by
design.  If that is the case, then there is only a bug if --keep-empty
is used, and I think you should mention that option earlier in this
description.

Also, I think this bug strikes if *any* of the commits to be rebased is
empty, not only the first commit.

> Add a test case. Create an empty root commit, run `rebase --root` and
> check that it is still there. If the branch consists of the root commit
> only, the bug described above causes the resulting history to consist of
> the sentinel commit only. If the root commit has children, the resulting
> history contains neither the root nor the sentinel commit. This
> behaviour is the same with `--keep-empty`.
> 
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
> 
> Notes:
>     Hi,
>     
>     This is not a fix yet.

It is actually OK to add failing tests to the test suite, but they must
be added with 'test_expect_failure' instead of 'test_expect_success'.
Though of course it is preferred if the new test is followed by a commit
that fixes it :-)

>     We are currently special casing in `do_pick` and whether the current
>     head is the sentinel commit is not a special case that would fit into
>     `do_pick`'s interface description. What if we added the feature of
>     creating root commits to `do_pick`, using `commit-tree` just like when
>     creating the sentinel commit? We would have to add another special case
>     (`test -z "$onto"`) to where the to-do list is put together in
>     `rebase--interactive`. An empty `$onto` would imply
>     
>         git rev-list $orig_head
>     
>     to form the to-do list. The rebase comment in the commit message editor
>     would have to become something similar to
>     
>         Rebase $shortrevisions as new history
>     
>     , which might be even less confusing than mentioning the hash of the
>     sentinel commit.

Since you are working on a hammer, I'm tempted to see this problem as a
nail.  Would it make it easier to encode the special behavior into the
todo list itself?:

    pick --orphan 0cf23b1 New initial commit
    pick 144a852 Second commit
    pick 255f8de Third commit

Michael

>  t/t3412-rebase-root.sh | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
> index 0b52105..a4fe3c7 100755
> --- a/t/t3412-rebase-root.sh
> +++ b/t/t3412-rebase-root.sh
> @@ -278,4 +278,31 @@ test_expect_success 'rebase -i -p --root with conflict (second part)' '
>  	test_cmp expect-conflict-p out
>  '
>  
> +test_expect_success 'rebase --root recreates empty root commit' '
> +	echo Initial >expected.msg &&
> +	# commit the empty tree, no parents
> +	empty_tree=$(git hash-object -t tree /dev/null) &&
> +	empty_root_commit=$(git commit-tree $empty_tree -F expected.msg) &&
> +	git checkout -b empty-root-commit-only $empty_root_commit &&
> +	# implies interactive
> +	git rebase --keep-empty --root &&
> +	git show --pretty=format:%s HEAD >actual.msg &&
> +	test_cmp actual.msg expected.msg
> +'
> +
> +test_expect_success 'rebase --root recreates empty root commit (subsequent commits)' '
> +	echo Initial >expected.msg &&
> +	# commit the empty tree, no parents
> +	empty_tree=$(git hash-object -t tree /dev/null) &&
> +	empty_root_commit=$(git commit-tree $empty_tree -F expected.msg) &&
> +	git checkout -b empty-root-commit $empty_root_commit &&
> +	>file &&
> +	git add file &&
> +	git commit -m file &&
> +	# implies interactive
> +	git rebase --keep-empty --root &&
> +	git show --pretty=format:%s HEAD^ >actual.msg &&
> +	test_cmp actual.msg expected.msg
> +'
> +
>  test_done
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
