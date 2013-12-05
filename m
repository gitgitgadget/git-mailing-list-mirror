From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Additional git-archive tests
Date: Thu, 05 Dec 2013 11:52:58 -0800
Message-ID: <xmqqwqjj3wit.fsf@gitster.dls.corp.google.com>
References: <C74C17E7-0780-4FE1-B916-D1A444F3B592@mac.com>
	<8143BEDD-8CFA-46ED-9B52-760BBB1DACE8@mac.com>
	<CAPig+cTUjvfWLC5vX0=BwtSDb613E9jMoyVXWp=de_Tyb5Ei7w@mail.gmail.com>
	<xmqq61r5q0qs.fsf@gitster.dls.corp.google.com>
	<CA9E9538-E39B-41CA-BB82-BDD8CF7A2E3F@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Nick Townsend <nick.townsend@mac.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 20:53:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Voez0-0006aE-3k
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 20:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905Ab3LETxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 14:53:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52092 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579Ab3LETxE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 14:53:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB3DA58440;
	Thu,  5 Dec 2013 14:53:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xq+A4bCnL2tCwp04GxA+VA60ItM=; b=HoaHBF
	F5h/l5qMTnfIIzWdNyR48pG6BOImjJSVTqQfktiGu77M9sxFi84fB0fp2XxiBC83
	skobakrS0K2Lowh2mLjcarvt3tjUw63bgdPOHZiKuA6RU6BhQXItZD6IPKP2yyw7
	1RMCq2d23n+LmDbuX8J4Z5efofrOMrJy9Rfx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r67RBry0LQBhk9qTDu5/dz/y/tJUfCH4
	EI4ZvNY7H2uhr1C1CPfKxAYFkIFX1/Dlxkhubdw5RiUWwChzuj+O4pWhB8TqJWEq
	ynp8K3p/+TpCjBHjR5WOODSwdLYfg1e6vo6YKxjCEkXROnKb+Ienh4YNobTSZbfe
	xAqNRwFMWdU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3F315843F;
	Thu,  5 Dec 2013 14:53:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4BB45843C;
	Thu,  5 Dec 2013 14:53:01 -0500 (EST)
In-Reply-To: <CA9E9538-E39B-41CA-BB82-BDD8CF7A2E3F@mac.com> (Nick Townsend's
	message of "Wed, 04 Dec 2013 18:49:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D91CAD60-5DE6-11E3-9300-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238902>

Nick Townsend <nick.townsend@mac.com> writes:

> Interplay between paths specified in three ways now tested:
> * After a : in the tree-ish,
> * As a pathspec in the command,
> * By virtue of the current working directory
>
> Note that these tests are based on the behaviours
> as found in 1.8.5. They may not be intentional.
> They were developed to regression test enhancements
> made to parse_treeish_arg() in archive.c

In other words, are all these new tests expected to pass?

My cursory read of parse_treeish_arg() in archive.c is:

 - It reads the given object with get_sha1(), checking if it is a
   commit-ish or tree-ish to decide if it wants to add the pax
   header to record the commit object name;

 - It parses the tree object;

 - If run from a subdirectory, attempts to grab the "prefix"
   (i.e. the path to the current subdirectory---in the tests you
   added, they are all "a/") out of that tree object (it errors out
   if it can't); and then

 - It archives the tree object.

So I do not think it is expected to accept tree object names with
the HEAD:<path> style syntax, if the user expects a predictable and
consistent result.  The third step above attempts to make sure that
you name a tree-ish that corresponds to the top-level of the
project, i.e. with no <path>.

What seems to be supported are:

    cd a && git archive HEAD ;# archives HEAD:a tree
    cd a && git archive HEAD -- b ;# archives a/b/ part of HEAD:a as b/

Specifically, it appears that HEAD:./b, HEAD:b etc. are not designed
to work, at least to me.

I am not saying that these should _not_ work, but it is unclear what
it means to "work".  For example, what should this do?

    cd a && git archive HEAD:./b $pathspec

The extended SHA-1 expression HEAD:./b in the subdirectory a/ is
interpreted by get_sha1_with_context_1() to be the name of the tree
object at path "a/b" in the commit HEAD.  Further, you are giving a
pathspec while in a subdirectory a/ to the command.  What should
that pathspec be relative to?

In a normal Git command, the pathspec always is relative to the
current subdirectory, so, the way to learn about the tree object
a/b/c in the HEAD while in subdirectory a/ would be:

    cd a && git ls-tree HEAD b/c

But what should the command line for archive to grab HEAD:a/b/c be?
It feels wrong to say:

    cd a && git archive HEAD:./b b/c

and it also feels wrong to say

    cd a && git archive HEAD:./b c

No matter what we would do, we should behave consistently with this
case:

    treeish=$(git rev-parse HEAD:a/b) &&
    cd a &&
    git archive $treeish -- $pathspec

so "take the pathspec relative to the tree when the treeish was
given with '<treeish>:<path>' syntax, and otherwise treat it
relative to the cwd" is not a workable solution.

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Nick Townsend <nick.townsend@mac.com>
> ---
>  t/t5004-archive-corner-cases.sh | 71 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
> index 67f3b54..a81a836 100755
> --- a/t/t5004-archive-corner-cases.sh
> +++ b/t/t5004-archive-corner-cases.sh
> @@ -113,4 +113,75 @@ test_expect_success 'archive empty subtree by direct pathspec' '
>  	check_dir extract sub
>  '
>  
> +test_expect_success 'setup - repository with subdirs' '
> +	mkdir -p a/b/c a/b/d &&
> +	echo af >a/af &&
> +	echo bf >a/b/bf &&
> +	echo cf >a/b/c/cf &&
> +	git add a &&
> +	git commit -m "commit 1" &&
> +	git tag -a -m "rev-1" rev-1
> +'
> +
> +test_expect_success 'archive subtree from root by treeish' '
> +	git archive --format=tar HEAD:a >atreeroot.tar &&
> +	make_dir extract &&
> +	"$TAR" xf atreeroot.tar -C extract &&
> +	check_dir extract af b b/bf b/c b/c/cf
> +'
> +
> +test_expect_success 'archive subtree from root with pathspec' '
> +	git archive --format=tar HEAD a >atreepath.tar &&
> +	make_dir extract &&
> +	"$TAR" xf atreepath.tar -C extract &&
> +	check_dir extract a a/af a/b a/b/bf a/b/c a/b/c/cf
> +'
> +
> +test_expect_success 'archive subtree from root by 2-level treeish' '
> +	git archive --format=tar HEAD:a/b >abtreeroot.tar &&
> +	make_dir extract &&
> +	"$TAR" xf abtreeroot.tar -C extract &&
> +	check_dir extract bf c c/cf
> +'
> +
> +test_expect_success 'archive subtree from subdir' '
> +	(
> +		cd a &&
> +		git archive --format=tar HEAD >../asubtree.tar
> +	) &&
> +	make_dir extract &&
> +	"$TAR" xf asubtree.tar -C extract &&
> +	check_dir extract af b b/bf b/c b/c/cf
> +'
> +
> +test_expect_success 'archive subtree from subdir with treeish' '
> +	(
> +		cd a &&
> +		git archive --format=tar HEAD:./b >../absubtree.tar
> +	) &&
> +	make_dir extract &&
> +	"$TAR" xf absubtree.tar -C extract &&
> +	check_dir extract bf c c/cf
> +'
> +
> +test_expect_success 'archive subtree from subdir with treeish and pathspec' '
> +	(
> +		cd a &&
> +		git archive --format=tar HEAD:./b c >../absubtree.tar
> +	) &&
> +	make_dir extract &&
> +	"$TAR" xf absubtree.tar -C extract &&
> +	check_dir extract c c/cf
> +'
> +
> +test_expect_success 'archive subtree from subdir with alt treeish' '
> +	(
> +		cd a &&
> +		git archive --format=tar HEAD:b >../abxsubtree.tar
> +	) &&
> +	make_dir extract &&
> +	"$TAR" xf abxsubtree.tar -C extract &&
> +	check_dir extract bf c c/cf
> +'
> +
>  test_done
