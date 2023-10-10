Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CEACD98CA
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 22:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjJJWO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 18:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjJJWO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 18:14:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FC698
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 15:14:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 653E52932A;
        Tue, 10 Oct 2023 18:14:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=r2DUWUUo0oY6tfd9+b6c70s/YF/l8gLMQiVzYt
        Oa41g=; b=CCkQ8bDtSN4dj31o4T+81rKso2MSObOyvFz/hHW+k41Z0hVBM7OxUP
        EpVCeF5NbI0fuB9uikgKn/WSW7P4tYpUy8L/BJ10bg4SUJPnYM5Roy1hAIX7chLt
        9UgfI3vEaeeJGwxgP7BGMFCY67fk/h6G5x4gKhg4+Lzgx67D4M724=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E48F29329;
        Tue, 10 Oct 2023 18:14:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E93A029326;
        Tue, 10 Oct 2023 18:14:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 2/2] attr: add attr.tree for setting the treeish to
 read attributes from
In-Reply-To: <dadb822da99772cd277417f564cf672f65d1cc24.1696967380.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Tue, 10 Oct 2023 19:49:40
        +0000")
References: <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
        <pull.1577.v3.git.git.1696967380.gitgitgadget@gmail.com>
        <dadb822da99772cd277417f564cf672f65d1cc24.1696967380.git.gitgitgadget@gmail.com>
Date:   Tue, 10 Oct 2023 15:14:51 -0700
Message-ID: <xmqqfs2iqg4k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FA4E1A2-67BA-11EE-8870-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> 44451a2 (attr: teach "--attr-source=<tree>" global option to "git",
> 2023-05-06) provided the ability to pass in a treeish as the attr
> source. In the context of serving Git repositories as bare repos like we
> do at GitLab however, it would be easier to point --attr-source to HEAD
> for all commands by setting it once.
>
> Add a new config attr.tree that allows this.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  Documentation/config.txt      |  2 ++
>  Documentation/config/attr.txt |  5 +++
>  attr.c                        |  7 ++++
>  attr.h                        |  2 ++
>  config.c                      | 14 ++++++++
>  t/t0003-attributes.sh         | 62 +++++++++++++++++++++++++++++++++++
>  6 files changed, 92 insertions(+)
>  create mode 100644 Documentation/config/attr.txt
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 229b63a454c..b1891c2b5af 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -371,6 +371,8 @@ other popular tools, and describe them in your documentation.
>  
>  include::config/advice.txt[]
>  
> +include::config/attr.txt[]
> +
>  include::config/core.txt[]
>  
>  include::config/add.txt[]
> diff --git a/Documentation/config/attr.txt b/Documentation/config/attr.txt
> new file mode 100644
> index 00000000000..be882523f8b
> --- /dev/null
> +++ b/Documentation/config/attr.txt
> @@ -0,0 +1,5 @@
> +attr.tree:
> +	A <tree-ish> to read gitattributes from instead of the worktree. See
> +	linkgit:gitattributes[5]. If `attr.tree` does not resolve to a valid tree,
> +	treat it as an empty tree. --attr-source and GIT_ATTR_SOURCE take
> +	precedence over attr.tree.

Properly typeset `--attr-source` and `GIT_ATTR_SOURCE`.

A quick "git grep" in Documentation/config/*.txt tells me that
nobody refers to an object type like <tree-ish>.  Imitate what this
was modeled after, namely Documentation/config/mailmap.txt, which
says just

	... a reference to a blob in the repository.

without any half mark-up.

More importantly, the description makes one wonder what the
precedence rule between these two (the general rule would be for
command line parameter to override environment, if I recall
correctly).

I think the enumeration header usually is followed by double-colons
among Documentation/config/*.txt files.  Let's be consistent.

In the context of this expression, "worktree" is a wrong noun to
use---the term of art refers to an instance of "working tree",
together with some "per worktree" administrative files inside .git/
directory.  On the other hand, "working tree" refers to the "files
meant to be visible to build tools and editors part of the non-bare
repository", which is what you want to use here.

attr.tree::
	A tree object to read the attributes from, instead of the
	`.gitattributes` file in the working tree.  In a bare
	repository, this defaults to HEAD:.gitattributes".  If a
	given value does not resolve to a valid tree object, an
	empty tree is used instead.  When `GIT_ATTR_SOURCE`
	environment variable or `--attr-source` command line option
	is used, this configuration variable has no effect.

or something along that line, perhaps.

> diff --git a/attr.c b/attr.c
> index bf2ea1626a6..0ae6852d12b 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -24,6 +24,8 @@
>  #include "tree-walk.h"
>  #include "object-name.h"
>  
> +const char *git_attr_tree;
> +
>  const char git_attr__true[] = "(builtin)true";
>  const char git_attr__false[] = "\0(builtin)false";
>  static const char git_attr__unknown[] = "(builtin)unknown";
> @@ -1206,6 +1208,11 @@ static void compute_default_attr_source(struct object_id *attr_source)
>  	if (!default_attr_source_tree_object_name)
>  		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE_ENVIRONMENT);
>  
> +	if (!default_attr_source_tree_object_name) {
> +		default_attr_source_tree_object_name = git_attr_tree;
> +		ignore_bad_attr_tree = 1;
> +	}

As long as "attr.tree" was read by calling git_default_attr_config()
before we come here, git_attr_tree is not NULL and we allow bad attr
tree in default_attr_source_tree_object_name.  But stepping back a
bit, even if "attr.tree" is unspecified, i.e., git_attr_tree is
NULL, we set ignore_bad_attr_tree to true here.

What it means is that after the above if() statement, if
default_attr_source_tree_object_name is still NULL, we know that
ignore_bad_attr_tree is already set to true. 

>  	if (!default_attr_source_tree_object_name &&
>  	    startup_info->have_repository &&
>  	    is_bare_repository()) {

So would it make more sense to remove the assignment to the same
variable we made in [1/2] around here (not seen in the post
context)?

Alternatively, even though it makes the code a bit more verbose, the
logic might become clearer if you wrote the "assign from the config"
part like so:

	if (!default_attr_source_tree_object_name && git_attr_tree) {
        	default_attr_source_tree_object_name = git_attr_tree;
		ignore_bad_attr_tree = 1;
	}

It would leave more flexibility to the code around here.  You could
for example add code that assigns a different value, a tree object
that is required to exist, to default_attr_source_tree_object_name
after this point, for example, without having to wonder what the
"current" value of ignore_bad_attr_tree is.

> +static int git_default_attr_config(const char *var, const char *value)
> +{
> +	if (!strcmp(var, "attr.tree"))
> +		return git_config_string(&git_attr_tree, var, value);
> +
> +	/* Add other attribute related config variables here and to
> +	   Documentation/config/attr.txt. */

	/*
	 * Our multi-line comments should look
         * more like this; opening slash-asterisk
	 * and closing asterisk-slash sit on a line
	 * on its own.
	 */

> @@ -342,6 +346,46 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
>  	)
>  '
>  
> +bad_attr_source_err="fatal: bad --attr-source or GIT_ATTR_SOURCE"

Not a fault of this two-patch series, but we probably should refine
this error reporting so that the reader can tell which one is being
complained about, and optionally what the offending value was.


> +test_expect_success 'attr.tree when HEAD is unborn' '
> +	test_when_finished rm -rf empty &&
> +	git init empty &&
> +	(
> +		cd empty &&
> +		echo $bad_attr_source_err >expect_err &&

Let's not rely on words in the error message split with exactly one
whitespace each and instead quote the variable properly.  I.e.,

		echo "$bad_attr_source_err" >expect_err &&

But this is not even used, as we do not expect it to fail.  Perhaps
remove it altogether?

> +		echo "f/path: test: unspecified" >expect &&
> +		git -c attr.tree=HEAD check-attr test -- f/path >actual 2>err &&
> +		test_must_be_empty err &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'attr.tree points to non-existing ref' '
> +	test_when_finished rm -rf empty &&
> +	git init empty &&
> +	(
> +		cd empty &&
> +		echo $bad_attr_source_err >expect_err &&

Ditto.

> +		echo "f/path: test: unspecified" >expect &&
> +		git -c attr.tree=refs/does/not/exist check-attr test -- f/path >actual 2>err &&
> +		test_must_be_empty err &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'bad attr source defaults to reading .gitattributes file' '
> +	test_when_finished rm -rf empty &&
> +	git init empty &&
> +	(
> +		cd empty &&
> +		echo "f/path test=val" >.gitattributes &&
> +		echo "f/path: test: val" >expect &&
> +		git -c attr.tree=HEAD check-attr test -- f/path >actual 2>err &&
> +		test_must_be_empty err &&
> +		test_cmp expect actual
> +	)
> +'

In other words, with the additional tests, we do not check error
cases (which may be perfectly OK, if they are covered by existing
tests).  A bit curious.

> @@ -356,6 +400,24 @@ test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--attr-source and GIT_ATTR_SOURCE take precedence over attr.tree' '

Do we want to ensure which one takes precedence between the command
line option and the environment?  It's not like the one that is
given the last takes effect.

> +	test_when_finished rm -rf empty &&
> +	git init empty &&
> +	(
> +		cd empty &&
> +		git checkout -b attr-source &&
> +		test_commit "val1" .gitattributes "f/path test=val1" &&
> +		git checkout -b attr-tree &&
> +		test_commit "val2" .gitattributes "f/path test=val2" &&
> +		git checkout attr-source &&
> +		echo "f/path: test: val1" >expect &&
> +		git -c attr.tree=attr-tree --attr-source=attr-source check-attr test -- f/path >actual &&
> +		test_cmp expect actual &&
> +		GIT_ATTR_SOURCE=attr-source git -c attr.tree=attr-tree check-attr test -- f/path >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success 'bare repository: with --source' '
>  	(
>  		cd bare.git &&

Other than that, looking great.  Thanks.
