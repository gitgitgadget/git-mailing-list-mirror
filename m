From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1200: cleanup and modernize test style
Date: Tue, 03 Nov 2009 21:50:13 -0800
Message-ID: <7vr5seltyi.fsf@alter.siamese.dyndns.org>
References: <1257282328-6491-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 06:50:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5YlK-0003ad-L6
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 06:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbZKDFuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 00:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbZKDFuR
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 00:50:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbZKDFuP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 00:50:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36DEE739AB;
	Wed,  4 Nov 2009 00:50:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=+FhSFDAgmNMwEMVcaJb9E6AjAyY=; b=ephdw2kjHxdPvVTqTRWNd/S
	8c5qMGWunBEj2V5W4eCeDUu0C9jd6PzOoqPcNEstsQY9wqIsaSdksX4T05oA0aLW
	qQRL2+Uqn/E9SkCXQXThCJHzEOXcppNeRUU8cELgkIMHsC742XxCNNEjzlwM65Bp
	6r4v5+Zsa3EkQZPG48Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=l8LqU4AvzxIq9b+PoYaP0lHdYJcAMWcpgPVdnGS1wtM+84+3Z
	lrNrLQgL12nR93M3zHPrs8vPjoBgNNriw1DaFTmPVP5RjweoqqJq6lUHWnftRwrk
	uXSEJala1wnhdbbXtS0C8VMA2+F7wg+m+LBdXgH0wdEYMkDj7SBoALE6BQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14E75739A9;
	Wed,  4 Nov 2009 00:50:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA577739A8; Wed,  4 Nov
 2009 00:50:14 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EF0FFA5C-C905-11DE-A1E8-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132039>

Stephen Boyd <bebarino@gmail.com> writes:

> Many parts of the tests in t1200 are run outside the test harness,
> circumventing the usefulness of -v and spewing messages to stdout when
> -v isn't used. Fix these problems by modernizing the test a bit.
>
> An extra test_done has existed since commit 6a74642 (git-commit --amend:
> two fixes., 2006-04-20) leading to the last 6 tests never being run.
> Remove it and teach the resolve merge test about fast-forward merges.
>
> Finally, we remove the TODO notes, because fetch, push, and clone have
> their own tests since t1200 was introduced and we're not going to add
> them here 4 years later.
>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>
> I saw some output when running this test and thought it could be modernized a
> bit.

Thanks.

The sequence of commands are suppopsed to match what the user manual
teaches, and I suspect we have had quite a many updates to the manual
since this test script was last touched.  Do you happen to know if they
still match the manual?

>  t/t1200-tutorial.sh |  131 +++++++++++++++++++++++++++++----------------------
>  1 files changed, 74 insertions(+), 57 deletions(-)
>
> diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
> index 67e637b..16c5b6d 100755
> --- a/t/t1200-tutorial.sh
> +++ b/t/t1200-tutorial.sh
> @@ -7,14 +7,18 @@ test_description='A simple turial in the form of a test case'
>  
>  . ./test-lib.sh
>  
> -echo "Hello World" > hello
> -echo "Silly example" > example
> +test_expect_success 'blob'  '
> +	echo "Hello World" > hello &&
> +	echo "Silly example" > example &&
>  
> -git update-index --add hello example
> +	git update-index --add hello example &&
>  
> -test_expect_success 'blob' "test blob = \"$(git cat-file -t 557db03)\""
> +	test blob = "$(git cat-file -t 557db03)"
> +'
>  
> -test_expect_success 'blob 557db03' "test \"Hello World\" = \"$(git cat-file blob 557db03)\""
> +test_expect_success 'blob 557db03' '
> +	test "Hello World" = "$(git cat-file blob 557db03)"
> +'
>  
>  echo "It's a new day for git" >>hello
>  cat > diff.expect << EOF
> @@ -26,25 +30,33 @@ index 557db03..263414f 100644
>   Hello World
>  +It's a new day for git
>  EOF
> -git diff-files -p > diff.output
> -test_expect_success 'git diff-files -p' 'cmp diff.expect diff.output'
> -git diff > diff.output
> -test_expect_success 'git diff' 'cmp diff.expect diff.output'
> -
> -tree=$(git write-tree 2>/dev/null)
>  
> -test_expect_success 'tree' "test 8988da15d077d4829fc51d8544c097def6644dbb = $tree"
> +test_expect_success 'git diff-files -p' '
> +	git diff-files -p > diff.output &&
> +	cmp diff.expect diff.output
> +'
>  
> -output="$(echo "Initial commit" | git commit-tree $(git write-tree) 2>&1 > .git/refs/heads/master)"
> +test_expect_success 'git diff' '
> +	git diff > diff.output &&
> +	cmp diff.expect diff.output
> +'
>  
> -git diff-index -p HEAD > diff.output
> -test_expect_success 'git diff-index -p HEAD' 'cmp diff.expect diff.output'
> +test_expect_success 'tree' '
> +	tree=$(git write-tree 2>/dev/null)
> +	test 8988da15d077d4829fc51d8544c097def6644dbb = $tree
> +'
>  
> -git diff HEAD > diff.output
> -test_expect_success 'git diff HEAD' 'cmp diff.expect diff.output'
> +test_expect_success 'git diff-index -p HEAD' '
> +	echo "Initial commit" | \
> +	git commit-tree $(git write-tree) 2>&1 > .git/refs/heads/master &&
> +	git diff-index -p HEAD > diff.output &&
> +	cmp diff.expect diff.output
> +'
>  
> -#rm hello
> -#test_expect_success 'git read-tree --reset HEAD' "git read-tree --reset HEAD ; test \"hello: needs update\" = \"$(git update-index --refresh)\""
> +test_expect_success 'git diff HEAD' '
> +	git diff HEAD > diff.output &&
> +	cmp diff.expect diff.output
> +'
>  
>  cat > whatchanged.expect << EOF
>  commit VARIABLE
> @@ -69,39 +81,45 @@ index 0000000..557db03
>  +Hello World
>  EOF
>  
> -git whatchanged -p --root | \
> -	sed -e "1s/^\(.\{7\}\).\{40\}/\1VARIABLE/" \
> +test_expect_success 'git whatchanged -p --root' '
> +	git whatchanged -p --root | \
> +		sed -e "1s/^\(.\{7\}\).\{40\}/\1VARIABLE/" \
>  		-e "2,3s/^\(.\{8\}\).*$/\1VARIABLE/" \
> -> whatchanged.output
> -test_expect_success 'git whatchanged -p --root' 'cmp whatchanged.expect whatchanged.output'
> -
> -git tag my-first-tag
> -test_expect_success 'git tag my-first-tag' 'cmp .git/refs/heads/master .git/refs/tags/my-first-tag'
> +	> whatchanged.output &&
> +	cmp whatchanged.expect whatchanged.output
> +'
>  
> -# TODO: test git clone
> +test_expect_success 'git tag my-first-tag' '
> +	git tag my-first-tag &&
> +	cmp .git/refs/heads/master .git/refs/tags/my-first-tag
> +'
>  
> -git checkout -b mybranch
> -test_expect_success 'git checkout -b mybranch' 'cmp .git/refs/heads/master .git/refs/heads/mybranch'
> +test_expect_success 'git checkout -b mybranch' '
> +	git checkout -b mybranch &&
> +	cmp .git/refs/heads/master .git/refs/heads/mybranch
> +'
>  
>  cat > branch.expect <<EOF
>    master
>  * mybranch
>  EOF
>  
> -git branch > branch.output
> -test_expect_success 'git branch' 'cmp branch.expect branch.output'
> +test_expect_success 'git branch' '
> +	git branch > branch.output &&
> +	cmp branch.expect branch.output
> +'
>  
> -git checkout mybranch
> -echo "Work, work, work" >>hello
> -git commit -m 'Some work.' -i hello
> +test_expect_success 'git resolve now fails' '
> +	git checkout mybranch &&
> +	echo "Work, work, work" >>hello &&
> +	git commit -m "Some work." -i hello &&
>  
> -git checkout master
> +	git checkout master &&
>  
> -echo "Play, play, play" >>hello
> -echo "Lots of fun" >>example
> -git commit -m 'Some fun.' -i hello example
> +	echo "Play, play, play" >>hello &&
> +	echo "Lots of fun" >>example &&
> +	git commit -m "Some fun." -i hello example &&
>  
> -test_expect_success 'git resolve now fails' '
>  	test_must_fail git merge -m "Merge work in mybranch" mybranch
>  '
>  
> @@ -112,10 +130,6 @@ Play, play, play
>  Work, work, work
>  EOF
>  
> -git commit -m 'Merged "mybranch" changes.' -i hello
> -
> -test_done
> -
>  cat > show-branch.expect << EOF
>  * [master] Merged "mybranch" changes.
>   ! [mybranch] Some work.
> @@ -124,21 +138,26 @@ cat > show-branch.expect << EOF
>  *+ [mybranch] Some work.
>  EOF
>  
> -git show-branch --topo-order master mybranch > show-branch.output
> -test_expect_success 'git show-branch' 'cmp show-branch.expect show-branch.output'
> -
> -git checkout mybranch
> +test_expect_success 'git show-branch' '
> +	git commit -m "Merged \"mybranch\" changes." -i hello &&
> +	git show-branch --topo-order master mybranch > show-branch.output &&
> +	cmp show-branch.expect show-branch.output
> +'
>  
>  cat > resolve.expect << EOF
> -Updating from VARIABLE to VARIABLE
> +Updating VARIABLE..VARIABLE
> +Fast forward
>   example |    1 +
>   hello   |    1 +
>   2 files changed, 2 insertions(+), 0 deletions(-)
>  EOF
>  
> -git merge -s "Merge upstream changes." master | \
> -	sed -e "1s/[0-9a-f]\{40\}/VARIABLE/g" >resolve.output
> -test_expect_success 'git resolve' 'cmp resolve.expect resolve.output'
> +test_expect_success 'git resolve' '
> +	git checkout mybranch &&
> +	git merge -s resolve master | \
> +		sed -e "1s/[0-9a-f]\{7\}/VARIABLE/g" >resolve.output &&
> +	cmp resolve.expect resolve.output
> +'
>  
>  cat > show-branch2.expect << EOF
>  ! [master] Merged "mybranch" changes.
> @@ -147,12 +166,10 @@ cat > show-branch2.expect << EOF
>  -- [master] Merged "mybranch" changes.
>  EOF
>  
> -git show-branch --topo-order master mybranch > show-branch2.output
> -test_expect_success 'git show-branch' 'cmp show-branch2.expect show-branch2.output'
> -
> -# TODO: test git fetch
> -
> -# TODO: test git push
> +test_expect_success 'git show-branch' '
> +	git show-branch --topo-order master mybranch > show-branch2.output &&
> +	cmp show-branch2.expect show-branch2.output
> +'
>  
>  test_expect_success 'git repack' 'git repack'
>  test_expect_success 'git prune-packed' 'git prune-packed'
> -- 
> 1.6.5.2.181.gd6f41
