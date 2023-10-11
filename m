Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F2ACD98E5
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 02:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344820AbjJKCTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 22:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344769AbjJKCTt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 22:19:49 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63BB94
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 19:19:47 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-65b093b97d2so10447496d6.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 19:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696990787; x=1697595587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZubbHgvI7Ra81ZWCd9rhiafaTNwftUjdXg59bExdj+4=;
        b=RzEvpEjXaNgG1fsyUiUKwom0qVtTXesmMTZnf1nxj7DOeoijl+vV3A3OyN2/h5vrYs
         TLXSndlfJSVaWSi2HqYknxSLOqXvIX8M/PHptOLGvwlTHUtoyUdSPwPwY5/f2+PxUEq2
         VgF2ghpz8dHXHDNc0SHt/+gJfGuW/RqYanQceNCvuVS0rQzTekRTMD3Hx8/Ot6EtGkvP
         mXGdUGkphuLj/9NmKDXHsFdTiPp9h2BAfB0XZXZcWQWYCu8HtjtO5KOu5Ahr9JQMfET7
         ZcjnI5oZWcyZ8+Gcf6kNmerjcSg+TL/+fWWlnHD/RWnwRxoSeLaAJilWZsXxxjqZBExt
         f1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696990787; x=1697595587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZubbHgvI7Ra81ZWCd9rhiafaTNwftUjdXg59bExdj+4=;
        b=NfhNKrbzo9pxnRwZdwfdRmHfnF5B7/zDy+pLvwLN88B6BcePfwKl/fY5T48E+VuJMd
         GNZ4kkvop+zPxk+oa7t5NFmz/h6aBUMVLr+GJ5l29l4LN/7OM1ZD0kOOpIrFVMYMTyW4
         tltqISMDQWe5JsBnFAe3s/sH32fKA3tvx+nclaL3TqDQ4NM3usrNNsuhLXM7LZVVSQV0
         +0H6E1+mMv7bKGv+FvgcfF53NsDw/idVWGDMMZiS/alXaR6+zu2VqrgiHIZZR02m7OgE
         s/s5DH6tgghFei+6A7TpUdSvm5eBFk7ZII79UhRyFLRnkcqWN3Zcqd2tSYUiK+zKa8Th
         jEJw==
X-Gm-Message-State: AOJu0YzDRTx2WVw4ycJl8jJN3JfWG7p9QNc7qZ35Pdginp4rpMTjYISz
        rnULZVy/OIbfaaiasno2UR8=
X-Google-Smtp-Source: AGHT+IH0MFd9s9w2EgOM65MM4qnXn5KKF7AESgGZDuFzdyVcZrxTBiZF+iSQcuKQMjEixdi3nqj/wg==
X-Received: by 2002:a05:620a:3949:b0:775:8fab:8c6d with SMTP id qs9-20020a05620a394900b007758fab8c6dmr20648210qkn.1.1696990786636;
        Tue, 10 Oct 2023 19:19:46 -0700 (PDT)
Received: from [192.168.1.240] (ool-4570b665.dyn.optonline.net. [69.112.182.101])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a031100b00767177a5bebsm4793794qkm.56.2023.10.10.19.19.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2023 19:19:46 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 2/2] attr: add attr.tree for setting the treeish to read attributes from
Date:   Tue, 10 Oct 2023 22:19:45 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <2A3060D0-C551-47F6-B27A-049B52B3E0F3@gmail.com>
In-Reply-To: <xmqqfs2iqg4k.fsf@gitster.g>
References: <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
 <pull.1577.v3.git.git.1696967380.gitgitgadget@gmail.com>
 <dadb822da99772cd277417f564cf672f65d1cc24.1696967380.git.gitgitgadget@gmail.com>
 <xmqqfs2iqg4k.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 10 Oct 2023, at 18:14, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> 44451a2 (attr: teach "--attr-source=3D<tree>" global option to "git",
>> 2023-05-06) provided the ability to pass in a treeish as the attr
>> source. In the context of serving Git repositories as bare repos like =
we
>> do at GitLab however, it would be easier to point --attr-source to HEA=
D
>> for all commands by setting it once.
>>
>> Add a new config attr.tree that allows this.
>>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>>  Documentation/config.txt      |  2 ++
>>  Documentation/config/attr.txt |  5 +++
>>  attr.c                        |  7 ++++
>>  attr.h                        |  2 ++
>>  config.c                      | 14 ++++++++
>>  t/t0003-attributes.sh         | 62 ++++++++++++++++++++++++++++++++++=
+
>>  6 files changed, 92 insertions(+)
>>  create mode 100644 Documentation/config/attr.txt
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 229b63a454c..b1891c2b5af 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -371,6 +371,8 @@ other popular tools, and describe them in your doc=
umentation.
>>
>>  include::config/advice.txt[]
>>
>> +include::config/attr.txt[]
>> +
>>  include::config/core.txt[]
>>
>>  include::config/add.txt[]
>> diff --git a/Documentation/config/attr.txt b/Documentation/config/attr=
=2Etxt
>> new file mode 100644
>> index 00000000000..be882523f8b
>> --- /dev/null
>> +++ b/Documentation/config/attr.txt
>> @@ -0,0 +1,5 @@
>> +attr.tree:
>> +	A <tree-ish> to read gitattributes from instead of the worktree. See=

>> +	linkgit:gitattributes[5]. If `attr.tree` does not resolve to a valid=
 tree,
>> +	treat it as an empty tree. --attr-source and GIT_ATTR_SOURCE take
>> +	precedence over attr.tree.
>
> Properly typeset `--attr-source` and `GIT_ATTR_SOURCE`.
>
> A quick "git grep" in Documentation/config/*.txt tells me that
> nobody refers to an object type like <tree-ish>.  Imitate what this
> was modeled after, namely Documentation/config/mailmap.txt, which
> says just
>
> 	... a reference to a blob in the repository.
>
> without any half mark-up.

sounds good

>
> More importantly, the description makes one wonder what the
> precedence rule between these two (the general rule would be for
> command line parameter to override environment, if I recall
> correctly).

yes, that should be the case.

>
> I think the enumeration header usually is followed by double-colons
> among Documentation/config/*.txt files.  Let's be consistent.
>
> In the context of this expression, "worktree" is a wrong noun to
> use---the term of art refers to an instance of "working tree",
> together with some "per worktree" administrative files inside .git/
> directory.  On the other hand, "working tree" refers to the "files
> meant to be visible to build tools and editors part of the non-bare
> repository", which is what you want to use here.
>
> attr.tree::
> 	A tree object to read the attributes from, instead of the
> 	`.gitattributes` file in the working tree.  In a bare
> 	repository, this defaults to HEAD:.gitattributes".  If a
> 	given value does not resolve to a valid tree object, an
> 	empty tree is used instead.  When `GIT_ATTR_SOURCE`
> 	environment variable or `--attr-source` command line option
> 	is used, this configuration variable has no effect.
>
> or something along that line, perhaps.

sounds good to me, thanks

>
>> diff --git a/attr.c b/attr.c
>> index bf2ea1626a6..0ae6852d12b 100644
>> --- a/attr.c
>> +++ b/attr.c
>> @@ -24,6 +24,8 @@
>>  #include "tree-walk.h"
>>  #include "object-name.h"
>>
>> +const char *git_attr_tree;
>> +
>>  const char git_attr__true[] =3D "(builtin)true";
>>  const char git_attr__false[] =3D "\0(builtin)false";
>>  static const char git_attr__unknown[] =3D "(builtin)unknown";
>> @@ -1206,6 +1208,11 @@ static void compute_default_attr_source(struct =
object_id *attr_source)
>>  	if (!default_attr_source_tree_object_name)
>>  		default_attr_source_tree_object_name =3D getenv(GIT_ATTR_SOURCE_ENV=
IRONMENT);
>>
>> +	if (!default_attr_source_tree_object_name) {
>> +		default_attr_source_tree_object_name =3D git_attr_tree;
>> +		ignore_bad_attr_tree =3D 1;
>> +	}
>
> As long as "attr.tree" was read by calling git_default_attr_config()
> before we come here, git_attr_tree is not NULL and we allow bad attr
> tree in default_attr_source_tree_object_name.  But stepping back a
> bit, even if "attr.tree" is unspecified, i.e., git_attr_tree is
> NULL, we set ignore_bad_attr_tree to true here.
>
> What it means is that after the above if() statement, if
> default_attr_source_tree_object_name is still NULL, we know that
> ignore_bad_attr_tree is already set to true.
>
>>  	if (!default_attr_source_tree_object_name &&
>>  	    startup_info->have_repository &&
>>  	    is_bare_repository()) {
>
> So would it make more sense to remove the assignment to the same
> variable we made in [1/2] around here (not seen in the post
> context)?
>
> Alternatively, even though it makes the code a bit more verbose, the
> logic might become clearer if you wrote the "assign from the config"
> part like so:
>
> 	if (!default_attr_source_tree_object_name && git_attr_tree) {
>         	default_attr_source_tree_object_name =3D git_attr_tree;
> 		ignore_bad_attr_tree =3D 1;
> 	}
>
> It would leave more flexibility to the code around here.  You could
> for example add code that assigns a different value, a tree object
> that is required to exist, to default_attr_source_tree_object_name
> after this point, for example, without having to wonder what the
> "current" value of ignore_bad_attr_tree is.

good point--I think this logic is easier to follow.

>
>> +static int git_default_attr_config(const char *var, const char *value=
)
>> +{
>> +	if (!strcmp(var, "attr.tree"))
>> +		return git_config_string(&git_attr_tree, var, value);
>> +
>> +	/* Add other attribute related config variables here and to
>> +	   Documentation/config/attr.txt. */
>
> 	/*
> 	 * Our multi-line comments should look
>          * more like this; opening slash-asterisk
> 	 * and closing asterisk-slash sit on a line
> 	 * on its own.
> 	 */
>
>> @@ -342,6 +346,46 @@ test_expect_success 'bare repository: check that =
=2Egitattribute is ignored' '
>>  	)
>>  '
>>
>> +bad_attr_source_err=3D"fatal: bad --attr-source or GIT_ATTR_SOURCE"
>
> Not a fault of this two-patch series, but we probably should refine
> this error reporting so that the reader can tell which one is being
> complained about, and optionally what the offending value was.
>
>
>> +test_expect_success 'attr.tree when HEAD is unborn' '
>> +	test_when_finished rm -rf empty &&
>> +	git init empty &&
>> +	(
>> +		cd empty &&
>> +		echo $bad_attr_source_err >expect_err &&
>
> Let's not rely on words in the error message split with exactly one
> whitespace each and instead quote the variable properly.  I.e.,
>
> 		echo "$bad_attr_source_err" >expect_err &&
>
> But this is not even used, as we do not expect it to fail.  Perhaps
> remove it altogether?
>
>> +		echo "f/path: test: unspecified" >expect &&
>> +		git -c attr.tree=3DHEAD check-attr test -- f/path >actual 2>err &&
>> +		test_must_be_empty err &&
>> +		test_cmp expect actual
>> +	)
>> +'
>> +
>> +test_expect_success 'attr.tree points to non-existing ref' '
>> +	test_when_finished rm -rf empty &&
>> +	git init empty &&
>> +	(
>> +		cd empty &&
>> +		echo $bad_attr_source_err >expect_err &&
>
> Ditto.
>
>> +		echo "f/path: test: unspecified" >expect &&
>> +		git -c attr.tree=3Drefs/does/not/exist check-attr test -- f/path >a=
ctual 2>err &&
>> +		test_must_be_empty err &&
>> +		test_cmp expect actual
>> +	)
>> +'
>> +
>> +test_expect_success 'bad attr source defaults to reading .gitattribut=
es file' '
>> +	test_when_finished rm -rf empty &&
>> +	git init empty &&
>> +	(
>> +		cd empty &&
>> +		echo "f/path test=3Dval" >.gitattributes &&
>> +		echo "f/path: test: val" >expect &&
>> +		git -c attr.tree=3DHEAD check-attr test -- f/path >actual 2>err &&
>> +		test_must_be_empty err &&
>> +		test_cmp expect actual
>> +	)
>> +'
>
> In other words, with the additional tests, we do not check error
> cases (which may be perfectly OK, if they are covered by existing
> tests).  A bit curious.

Just checked and it does seem like we don't have a test case that covers =
the
error case. Will add in the next version.

>
>> @@ -356,6 +400,24 @@ test_expect_success 'bare repo defaults to readin=
g .gitattributes from HEAD' '
>>  	test_cmp expect actual
>>  '
>>
>> +test_expect_success '--attr-source and GIT_ATTR_SOURCE take precedenc=
e over attr.tree' '
>
> Do we want to ensure which one takes precedence between the command
> line option and the environment?  It's not like the one that is
> given the last takes effect.

yeah, might as well.

>
>> +	test_when_finished rm -rf empty &&
>> +	git init empty &&
>> +	(
>> +		cd empty &&
>> +		git checkout -b attr-source &&
>> +		test_commit "val1" .gitattributes "f/path test=3Dval1" &&
>> +		git checkout -b attr-tree &&
>> +		test_commit "val2" .gitattributes "f/path test=3Dval2" &&
>> +		git checkout attr-source &&
>> +		echo "f/path: test: val1" >expect &&
>> +		git -c attr.tree=3Dattr-tree --attr-source=3Dattr-source check-attr=
 test -- f/path >actual &&
>> +		test_cmp expect actual &&
>> +		GIT_ATTR_SOURCE=3Dattr-source git -c attr.tree=3Dattr-tree check-at=
tr test -- f/path >actual &&
>> +		test_cmp expect actual
>> +	)
>> +'
>> +
>>  test_expect_success 'bare repository: with --source' '
>>  	(
>>  		cd bare.git &&
>
> Other than that, looking great.  Thanks.

thanks!
John
