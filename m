Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE96CA0EF1
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 17:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbjILRHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 13:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbjILRHq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 13:07:46 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C53110
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:07:42 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5925e580f12so57967057b3.3
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694538462; x=1695143262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FHmqtFl/W/wSggs+XOhIA2zN6nWRDwOSgHpxJSaVNLE=;
        b=cMb0OO0XTQg2QBuGQ0Z99vw9EyECREU/xA8XtD6sTTic7iPajT/9CvnuagtlrveIuK
         OQMgCE7ZGZ7Jw+2C08i7OrKHMUYqTCaC+ja+NEAmsW+KzFMvAib2la5uTRxTfHizOi12
         c3LdcbLo2Ojq/3Y17i71OtwTC5jkObzIaWRB/XJElHtK6tttdJUvjA4v91jkb6FEgKIP
         NSs2pczqSTfBnWBSDu/j4kiFFnEKlQSdZOM/bItAZYr+C5UiTeEGaKOcgW0MSuYd9dlI
         hpg+2Usg/y7Af81v9C5AM5rLOP6lf5RcYmMAelf1pomUpfVuEglJw/khjOGW3HdpWkxi
         DOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538462; x=1695143262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHmqtFl/W/wSggs+XOhIA2zN6nWRDwOSgHpxJSaVNLE=;
        b=jOM+pjHjsb5aJNaiB36zKcu+HinhJI1CvoMXI6+xqmcc+HeivYiYMHpUwW9YgWfLji
         cyNgNgQieXLX92YBVQcbDfn7foyyGXPhTi1qvH7hl5ZwOsE1F+PIxW9HuVMrVPv3zBdi
         EBr3FZ2TiXZD76KKfg14kSuxDd4BnZupv0DYv0+LJk3IITYBFhHXg1Du2kcSWKxPls6j
         oM88iEPDXuToBjF/r0yKOgGVUdsRzN1/chpNR2juwgkUl/MjgHqAQZgu00nRKlg0G76c
         XU1/HbVm6BEFTp5ruzsd23pfNNNojkazfivKmLQnoa92CqjT0EqTX3B85MgziynlXH6A
         32pQ==
X-Gm-Message-State: AOJu0YwPAjd6XKfba1x7c+M+TTjCf3j2KKT1CUppR3urLSTq+HHaEf0z
        J7fnoKNlcaYduG1qZn55RFzt1Q==
X-Google-Smtp-Source: AGHT+IFlL4YIK77BCGQ94J14VKHLdRlw8nsuHZr4Hu0Vt8D7ouSxSP9NC35B0w8fw62R4axzRquMlA==
X-Received: by 2002:a81:5457:0:b0:599:8bd:5bdf with SMTP id i84-20020a815457000000b0059908bd5bdfmr843ywb.50.1694538461677;
        Tue, 12 Sep 2023 10:07:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h62-20020a0dde41000000b0057a918d6644sm2632575ywe.128.2023.09.12.10.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:07:41 -0700 (PDT)
Date:   Tue, 12 Sep 2023 13:07:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] revision: add `--ignore-missing-links` user option
Message-ID: <ZQCa3GHT3D7aibJ1@nand.local>
References: <20230908174208.249184-1-karthik.188@gmail.com>
 <20230912155820.136111-1-karthik.188@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912155820.136111-1-karthik.188@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2023 at 05:58:20PM +0200, Karthik Nayak wrote:
> The revision backend is used by multiple porcelain commands such as
> git-rev-list(1) and git-log(1). The backend currently supports ignoring
> missing links by setting the `ignore_missing_links` bit. This allows the
> revision walk to skip any objects links which are missing. Expose this
> bit via an `--ignore-missing-links` user option.
>
> A scenario where this option would be used is to find the boundary
> objects between different object directories. Consider a repository with
> a main object directory (GIT_OBJECT_DIRECTORY) and one or more alternate
> object directories (GIT_ALTERNATE_OBJECT_DIRECTORIES). In such a
> repository, enabling this option along with the `--boundary` option for
> while disabling the alternate object directory allows us to find the
> boundary objects between the main and alternate object directory.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>
> Changes from v1:
> 1. Changes in the commit message and option description to be more specific
> and list why and what the changes are.
> 2. Ensure the new option also works with the existing `--objects` options.
> 3. More specific testing for boundary commit.
>
> Range diff against v1:
>
> 1:  c0a4dca9b0 ! 1:  e3f4d85732 revision: add `--ignore-missing-links` user option
>     @@ Commit message
>          The revision backend is used by multiple porcelain commands such as
>          git-rev-list(1) and git-log(1). The backend currently supports ignoring
>          missing links by setting the `ignore_missing_links` bit. This allows the
>     -    revision walk to skip any objects links which are missing.
>     +    revision walk to skip any objects links which are missing. Expose this
>     +    bit via an `--ignore-missing-links` user option.
>
>     -    Currently there is no way to use git-rev-list(1) to traverse the objects
>     -    of the main object directory (GIT_OBJECT_DIRECTORY) and print the
>     -    boundary objects when moving from the main object directory to the
>     -    alternate object directories (GIT_ALTERNATE_OBJECT_DIRECTORIES).
>     -
>     -    By exposing this new flag `--ignore-missing-links`, users can set the
>     -    required env variables (GIT_OBJECT_DIRECTORY and
>     -    GIT_ALTERNATE_OBJECT_DIRECTORIES) along with the `--boundary` flag to
>     -    find the boundary objects between object directories.
>     +    A scenario where this option would be used is to find the boundary
>     +    objects between different object directories. Consider a repository with
>     +    a main object directory (GIT_OBJECT_DIRECTORY) and one or more alternate
>     +    object directories (GIT_ALTERNATE_OBJECT_DIRECTORIES). In such a
>     +    repository, enabling this option along with the `--boundary` option for
>     +    while disabling the alternate object directory allows us to find the
>     +    boundary objects between the main and alternate object directory.
>
>          Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>
>     @@ Documentation/rev-list-options.txt: explicitly.
>       	the bad input was not given.
>
>      +--ignore-missing-links::
>     -+	When an object points to another object that is missing, pretend as if the
>     -+	link did not exist. These missing links are not written to stdout unless
>     -+	the --boundary flag is passed.
>     ++	During traversal, if an object that is referenced does not
>     ++	exist, instead of dying of a repository corruption, pretend as
>     ++	if the reference itself does not exist. Running the command
>     ++	with the `--boundary` option makes these missing commits,
>     ++	together with the commits on the edge of revision ranges
>     ++	(i.e. true boundary objects), appear on the output, prefixed
>     ++	with '-'.
>      +
>       ifndef::git-rev-list[]
>       --bisect::
>       	Pretend as if the bad bisection ref `refs/bisect/bad`
>
>     + ## builtin/rev-list.c ##
>     +@@ builtin/rev-list.c: static int finish_object(struct object *obj, const char *name UNUSED,
>     + {
>     + 	struct rev_list_info *info = cb_data;
>     + 	if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) < 0) {
>     +-		finish_object__ma(obj);
>     ++		if (!info->revs->ignore_missing_links)
>     ++			finish_object__ma(obj);
>     + 		return 1;
>     + 	}
>     + 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
>     +
>       ## revision.c ##
>      @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>       		revs->limited = 1;
>     @@ t/t6022-rev-list-alternates.sh (new)
>      +test_expect_success 'create repository and alternate directory' '
>      +	git init main &&
>      +	test_commit_bulk -C main 5 &&
>     ++	BOUNDARY_COMMIT=$(git -C main rev-parse HEAD) &&
>      +	mkdir alt &&
>      +	mv main/.git/objects/* alt &&
>      +	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt test_commit_bulk --start=6 -C main 5
>      +'
>      +
>     -+# When the alternate odb is provided, all commits are listed.
>     ++# when the alternate odb is provided, all commits are listed along with the boundary
>     ++# commit.
>      +test_expect_success 'rev-list passes with alternate object directory' '
>     -+	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt test_stdout_line_count = 10 git -C main rev-list HEAD
>     ++	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main rev-list HEAD >actual &&
>     ++	test_stdout_line_count = 10 cat actual &&
>     ++	grep $BOUNDARY_COMMIT actual
>      +'
>      +
>      +# When the alternate odb is not provided, rev-list fails since the 5th commit's
>     @@ t/t6022-rev-list-alternates.sh (new)
>      +'
>      +
>      +# With `--ignore-missing-links`, we stop the traversal when we encounter a
>     -+# missing link.
>     ++# missing link. The boundary commit is not listed as we haven't used the
>     ++# `--boundary` options.
>      +test_expect_success 'rev-list only prints main odb commits with --ignore-missing-links' '
>     -+	test_stdout_line_count = 5 git -C main rev-list --ignore-missing-links HEAD
>     ++	git -C main rev-list --ignore-missing-links HEAD >actual &&
>     ++	test_stdout_line_count = 5 cat actual &&
>     ++	! grep -$BOUNDARY_COMMIT actual
>      +'
>      +
>      +# With `--ignore-missing-links` and `--boundary`, we can even print those boundary
>      +# commits.
>      +test_expect_success 'rev-list prints boundary commit with --ignore-missing-links' '
>     -+	git -C main rev-list --ignore-missing-links --boundary HEAD >list-output &&
>     -+	test_stdout_line_count = 6 cat list-output &&
>     -+	test_stdout_line_count = 1 cat list-output | grep "^-"
>     ++	git -C main rev-list --ignore-missing-links --boundary HEAD >actual &&
>     ++	test_stdout_line_count = 6 cat actual &&
>     ++	grep -$BOUNDARY_COMMIT actual
>     ++'
>     ++
>     ++# The `--ignore-missing-links` option should ensure that git-rev-list(1) doesn't
>     ++# fail when used alongside `--objects` when a tree is missing.
>     ++test_expect_success 'rev-list --ignore-missing-links works with missing tree' '
>     ++	echo "foo" >main/file &&
>     ++	git -C main add file &&
>     ++	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main commit -m"commit 11" &&
>     ++	TREE_OID=$(git -C main rev-parse HEAD^{tree}) &&
>     ++	mkdir alt/${TREE_OID:0:2} &&
>     ++	mv main/.git/objects/${TREE_OID:0:2}/${TREE_OID:2} alt/${TREE_OID:0:2}/ &&
>     ++	git -C main rev-list --ignore-missing-links --objects HEAD >actual &&
>     ++	! grep $TREE_OID actual
>     ++'
>     ++
>     ++# Similar to above, it should also work when a blob is missing.
>     ++test_expect_success 'rev-list --ignore-missing-links works with missing blob' '
>     ++	echo "bar" >main/file &&
>     ++	git -C main add file &&
>     ++	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main commit -m"commit 12" &&
>     ++	BLOB_OID=$(git -C main rev-parse HEAD:file) &&
>     ++	mkdir alt/${BLOB_OID:0:2} &&
>     ++	mv main/.git/objects/${BLOB_OID:0:2}/${BLOB_OID:2} alt/${BLOB_OID:0:2}/ &&
>     ++	git -C main rev-list --ignore-missing-links --objects HEAD >actual &&
>     ++	! grep $BLOB_OID actual
>      +'
>      +
>      +test_done
>
>
>  Documentation/rev-list-options.txt |  9 ++++
>  builtin/rev-list.c                 |  3 +-
>  revision.c                         |  2 +
>  t/t6022-rev-list-alternates.sh     | 75 ++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+), 1 deletion(-)
>  create mode 100755 t/t6022-rev-list-alternates.sh
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index a4a0cb93b2..8ee713db3d 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -227,6 +227,15 @@ explicitly.
>  	Upon seeing an invalid object name in the input, pretend as if
>  	the bad input was not given.
>
> +--ignore-missing-links::
> +	During traversal, if an object that is referenced does not
> +	exist, instead of dying of a repository corruption, pretend as
> +	if the reference itself does not exist. Running the command
> +	with the `--boundary` option makes these missing commits,
> +	together with the commits on the edge of revision ranges
> +	(i.e. true boundary objects), appear on the output, prefixed
> +	with '-'.
> +
>  ifndef::git-rev-list[]
>  --bisect::
>  	Pretend as if the bad bisection ref `refs/bisect/bad`
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index ff715d6918..5239d83c76 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -266,7 +266,8 @@ static int finish_object(struct object *obj, const char *name UNUSED,
>  {
>  	struct rev_list_info *info = cb_data;
>  	if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) < 0) {
> -		finish_object__ma(obj);
> +		if (!info->revs->ignore_missing_links)
> +			finish_object__ma(obj);
>  		return 1;
>  	}
>  	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)


> diff --git a/t/t6022-rev-list-alternates.sh b/t/t6022-rev-list-alternates.sh
> new file mode 100755
> index 0000000000..08d9ffde5f
> --- /dev/null
> +++ b/t/t6022-rev-list-alternates.sh
> @@ -0,0 +1,75 @@
> +#!/bin/sh
> +
> +test_description='handling of alternates in rev-list'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
> +. ./test-lib.sh
> +
> +# We create 5 commits and move them to the alt directory and
> +# create 5 more commits which will stay in the main odb.
> +test_expect_success 'create repository and alternate directory' '
> +	git init main &&

We don't necessarily have to initialize a repository, as the test suite
already does so for us. So we may want to write this instead as:

    test_commit_bulk 5 &&
    git clone --reference=. --shared . alt &&
    test_commit_bulk -C alt --start=6 5

> +# when the alternate odb is provided, all commits are listed along with the boundary
> +# commit.
> +test_expect_success 'rev-list passes with alternate object directory' '
> +	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main rev-list HEAD >actual &&
> +	test_stdout_line_count = 10 cat actual &&
> +	grep $BOUNDARY_COMMIT actual
> +'

Here, I think we'd want to make sure that we have not just 10 lines of
output, but that they are the 10 that we expect, like so:

    git -C alt rev-list --all --objects --no-object-names >actual.raw &&
    {
      git rev-list --all --objects --no-object-names &&
      git -C alt rev-list --all --objects --no-object-names --not \
        --alternate-refs
    } >expect.raw &&
    sort actual.raw >actual &&
    sort expect.raw >expect &&
    test_cmp expect actual

When reviewing this and tweaking some of the tests locally, I found it
useful to have some convenience functions like "hide_alternates" and
"show_alternates" to control whether or not "alt" could see its
alternate or not.

From my review locally, the resulting changes (which can be applied
directly on top of your patch here look like):

--- 8< ---
diff --git a/t/t6022-rev-list-alternates.sh b/t/t6022-rev-list-alternates.sh
index 08d9ffde5f..ef4231b2de 100755
--- a/t/t6022-rev-list-alternates.sh
+++ b/t/t6022-rev-list-alternates.sh
@@ -8,68 +8,86 @@ TEST_PASSES_SANITIZE_LEAK=true
 # We create 5 commits and move them to the alt directory and
 # create 5 more commits which will stay in the main odb.
 test_expect_success 'create repository and alternate directory' '
-	git init main &&
-	test_commit_bulk -C main 5 &&
-	BOUNDARY_COMMIT=$(git -C main rev-parse HEAD) &&
-	mkdir alt &&
-	mv main/.git/objects/* alt &&
-	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt test_commit_bulk --start=6 -C main 5
+	test_commit_bulk 5 &&
+	git clone --reference=. --shared . alt &&
+	test_commit_bulk --start=6 -C alt 5
 '

 # when the alternate odb is provided, all commits are listed along with the boundary
 # commit.
 test_expect_success 'rev-list passes with alternate object directory' '
-	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main rev-list HEAD >actual &&
-	test_stdout_line_count = 10 cat actual &&
-	grep $BOUNDARY_COMMIT actual
+	git -C alt rev-list --all --objects --no-object-names >actual.raw &&
+	{
+		git rev-list --all --objects --no-object-names &&
+		git -C alt rev-list --all --objects --no-object-names --not \
+			--alternate-refs
+	} >expect.raw &&
+	sort actual.raw >actual &&
+	sort expect.raw >expect &&
+	test_cmp expect actual
 '

+alt=alt/.git/objects/info/alternates
+
+hide_alternates () {
+	test -f "$alt.bak" || mv "$alt" "$alt.bak"
+}
+
+show_alternates () {
+	test -f "$alt" || mv "$alt.bak" "$alt"
+}
+
 # When the alternate odb is not provided, rev-list fails since the 5th commit's
 # parent is not present in the main odb.
 test_expect_success 'rev-list fails without alternate object directory' '
-	test_must_fail git -C main rev-list HEAD
+	hide_alternates &&
+	test_must_fail git -C alt rev-list HEAD
 '

 # With `--ignore-missing-links`, we stop the traversal when we encounter a
 # missing link. The boundary commit is not listed as we haven't used the
 # `--boundary` options.
 test_expect_success 'rev-list only prints main odb commits with --ignore-missing-links' '
-	git -C main rev-list --ignore-missing-links HEAD >actual &&
-	test_stdout_line_count = 5 cat actual &&
-	! grep -$BOUNDARY_COMMIT actual
+	hide_alternates &&
+
+	git -C alt rev-list --objects --no-object-names \
+		--ignore-missing-links HEAD >actual.raw &&
+	git -C alt cat-file --batch-check="%(objectname)" \
+		--batch-all-objects >expect.raw &&
+
+	sort actual.raw >actual &&
+	sort expect.raw >expect &&
+	test_cmp expect actual
 '

 # With `--ignore-missing-links` and `--boundary`, we can even print those boundary
 # commits.
 test_expect_success 'rev-list prints boundary commit with --ignore-missing-links' '
-	git -C main rev-list --ignore-missing-links --boundary HEAD >actual &&
-	test_stdout_line_count = 6 cat actual &&
-	grep -$BOUNDARY_COMMIT actual
+	git -C alt rev-list --ignore-missing-links --boundary HEAD >got &&
+	grep "^-$(git rev-parse HEAD)" got
 '

-# The `--ignore-missing-links` option should ensure that git-rev-list(1) doesn't
-# fail when used alongside `--objects` when a tree is missing.
-test_expect_success 'rev-list --ignore-missing-links works with missing tree' '
-	echo "foo" >main/file &&
-	git -C main add file &&
-	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main commit -m"commit 11" &&
-	TREE_OID=$(git -C main rev-parse HEAD^{tree}) &&
-	mkdir alt/${TREE_OID:0:2} &&
-	mv main/.git/objects/${TREE_OID:0:2}/${TREE_OID:2} alt/${TREE_OID:0:2}/ &&
-	git -C main rev-list --ignore-missing-links --objects HEAD >actual &&
-	! grep $TREE_OID actual
+test_expect_success "setup for rev-list --ignore-missing-links with missing objects" '
+	show_alternates &&
+	test_commit -C alt 11
 '

-# Similar to above, it should also work when a blob is missing.
-test_expect_success 'rev-list --ignore-missing-links works with missing blob' '
-	echo "bar" >main/file &&
-	git -C main add file &&
-	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main commit -m"commit 12" &&
-	BLOB_OID=$(git -C main rev-parse HEAD:file) &&
-	mkdir alt/${BLOB_OID:0:2} &&
-	mv main/.git/objects/${BLOB_OID:0:2}/${BLOB_OID:2} alt/${BLOB_OID:0:2}/ &&
-	git -C main rev-list --ignore-missing-links --objects HEAD >actual &&
-	! grep $BLOB_OID actual
-'
+for obj in "HEAD^{tree}" "HEAD:11.t"
+do
+	# The `--ignore-missing-links` option should ensure that git-rev-list(1)
+	# doesn't fail when used alongside `--objects` when a tree/blob is
+	# missing.
+	test_expect_success "rev-list --ignore-missing-links with missing $type" '
+		oid="$(git -C alt rev-parse $obj)" &&
+		path="alt/.git/objects/$(test_oid_to_path $oid)" &&
+
+		mv "$path" "$path.hidden" &&
+		test_when_finished "mv $path.hidden $path" &&
+
+		git -C alt rev-list --ignore-missing-links --objects HEAD \
+			>actual &&
+		! grep $oid actual
+	'
+done

 test_done
--- >8 ---

Thanks,
Taylor
