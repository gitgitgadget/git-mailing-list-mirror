Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A142BC432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 05:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6217E207DD
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 05:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fj+vI0gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfKXFys (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 00:54:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54737 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfKXFys (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 00:54:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5962BA301C;
        Sun, 24 Nov 2019 00:54:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A6RfSpFWYP73Cykrmh/MsDQn4LA=; b=Fj+vI0
        gyH5ls1Lk9mj4RV5zIEcwFvWqUSstllU33VLgu3cZCAFfLR7v6Xh3kWxSqFsgmAz
        aM4q5vdvL5H3IYY5rG05a+fT118AI5io6lAnpMkIkabr64GWBtvsmpwxjG5bMOv5
        vNzTua7WfuYoAL7IbckIPcwMEkNHH1lk1uaPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fadeCWX59n+78dbB7w9cfBZjgFvOWGMn
        JfuU/7mmrkU/VO2Ccc27oUkwsxsZ7N9O8GdvUzAA03Rx80gB5JVi35fUOkVMVow6
        QclfP+P0T8mvoiIynIsN94gJXIyseg06iGuSYkSPm0g1RT5YVQSl/QnC8eVFqA6E
        UWixfQL8AhY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 504EDA301B;
        Sun, 24 Nov 2019 00:54:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 76DC2A301A;
        Sun, 24 Nov 2019 00:54:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nika Layzell via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: [PATCH 1/1] reset: parse rev as tree-ish in patch mode
References: <pull.474.git.1574538937.gitgitgadget@gmail.com>
        <338c2777f711ac21a30a7f890a8a11708e9a4fa6.1574538937.git.gitgitgadget@gmail.com>
Date:   Sun, 24 Nov 2019 14:54:41 +0900
In-Reply-To: <338c2777f711ac21a30a7f890a8a11708e9a4fa6.1574538937.git.gitgitgadget@gmail.com>
        (Nika Layzell via GitGitGadget's message of "Sat, 23 Nov 2019 19:55:36
        +0000")
Message-ID: <xmqq4kyt250e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E989DE80-0E7E-11EA-B68F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nika Layzell via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nika Layzell <nika@thelayzells.com>
>
> Relaxes the commit requirement for the rev argument when running
> git-reset in patch mode without pathspec.
>
> The revision argument to git-reset is parsed as either a commit or
> tree-ish depending on mode. Previously, if no pathspec was provided,
> the rev argument was parsed as a commit unconditionally.

Swap the order of two paragraphs, i.e. explain what happens and what
you perceive as a problem in the current system in the present tense
(and do not say "Previously" if you are talking about the state of
the system without your change), and then propose what to change in
the imperative mood as if you are giving an order to the codebase to
"be like so".  Perhaps like this.

    Since 2f328c3d ("reset $sha1 $pathspec: require $sha1 only to be
    treeish", 2013-01-14), we allowed "git reset $object -- $path"
    to reset individual paths that match the pathspec to take the
    blob from a tree object, not necessarily a commit, while the
    form to reset the tip of the current branch to some other commit
    still must be given a commit.

    Sometimes, however, being able to give a tree object to "git
    reset -p $obj" when using the patch mode is useful FOR SUCH AND
    SUCH REASONS.

    Loosen the condition that requires a commit object to take a
    tree object under the patch mode.

>
> Signed-off-by: Nika Layzell <nika@thelayzells.com>
> ---
>  builtin/reset.c        | 2 +-
>  t/t7105-reset-patch.sh | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index fdd572168b..5cbfb21ec4 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -320,7 +320,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  	if (unborn) {
>  		/* reset on unborn branch: treat as reset to empty tree */
>  		oidcpy(&oid, the_hash_algo->empty_tree);
> -	} else if (!pathspec.nr) {
> +	} else if (!pathspec.nr && !patch_mode) {
>  		struct commit *commit;
>  		if (get_oid_committish(rev, &oid))
>  			die(_("Failed to resolve '%s' as a valid revision."), rev);

I notice that under the patch mode after this part of the code, we
do not even use the oid computed in these pieces of code at all.
Presumably, run_add_interactive() function would also be sanity
checking the incoming "rev" and giving an appropriate error message
when it is not of expected type.

Which means that perhaps a cleaner fix may be

-	if (unborn) {
+	if (patch_mode) {
+		/* do not compute or check &oid we will not use */
+		;
+	} else if (unborn) {
		...

right?

> diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
> index bd10a96727..2a6ecf515b 100755
> --- a/t/t7105-reset-patch.sh
> +++ b/t/t7105-reset-patch.sh
> @@ -38,6 +38,13 @@ test_expect_success PERL 'git reset -p HEAD^' '
>  	test_i18ngrep "Apply" output
>  '
>  
> +test_expect_success PERL 'git reset -p HEAD^^{tree}' '
> +	test_write_lines n y | git reset -p HEAD^^{tree} >output &&
> +	verify_state dir/foo work parent &&
> +	verify_saved_state bar &&
> +	test_i18ngrep "Apply" output
> +'

This only tests a positive (i.e. "see what my change now allows you
to do") without checking a negative (i.e. "I started allowing a
tree, but I didn't inadvertently started allowing a blob or an
object that does not exist"), which is an anti-pattern.  Please have
another test to ensure that the parser fails when it should, too.

Thanks.
