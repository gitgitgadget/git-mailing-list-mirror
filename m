Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8631FC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56648610C7
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhHYXdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHYXdl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:33:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8D7C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:32:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bt14so1993188ejb.3
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2IYxUfip4mfmuJAz/2vceH6aK4qmBNpM8dFUWGRWePI=;
        b=A10qV8bwA5p1nXLla9bzDjZZm2n6KkCtFGq6yLNALfwUirouttL6EIihiJFTz3h8in
         JIXSyxY21J82Md11CILVNCTok2r2gCHdKb65XgG/fDKJTeDJxMwiOtdJ9yzDCYP+O5y8
         kbGGma2AsXsM/CeL9OPgve6ENxfhS6HDVWoOEu+EF4xIcvrJ5jeS8IHE2MChHd4aggiF
         Svg5qCQPzzZYhm+lkUH+/eoFMq11DACuh1VtEo8defHaWmm/ISgv3KBGYDWoxc1omTrL
         Xi5rN8PKbhZKVToY+aBfAsZbuQD2Iqg4zP3xxOebPBEGjKuuU4M2YPex1nQrg/Fn0B1K
         KKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2IYxUfip4mfmuJAz/2vceH6aK4qmBNpM8dFUWGRWePI=;
        b=c3i34BYO8AXDLCK38tSXPwObmYLKtR887UYKQexbvaHEEZ2qtv1G0k/n+VXVkb+cbV
         tvzPAtc29/fJhEvNxe1TjqRMjsY1IxCLKZmcig9nF9GRuGtq9fwRYigLRo7ZW0jh52wC
         6QrVQqGBiOCkcy8OCnOU5pitZB3IsdLVSThy5ys2az9urKpfz+/XA7kxQ3L9N7i2RrEx
         TspEA+2DB6/Q9miG/zzqQyXI3TMKIiLURkEMlso42irE+edqQw9tuq4rlvNAC4QWJyTa
         nBzOyupYieznPwukZPNh2lAMBR1dsYORXCyrKb6VRkL1DEjFXniidSW7zLRWeqe5v597
         0bOg==
X-Gm-Message-State: AOAM532U028SOWmaherYJn0R21V/DIy3Q9UOCMK1PPKrmUk5epDKIalp
        mfbyavsl/02ugBnxcsMh4n0=
X-Google-Smtp-Source: ABdhPJzLM1FUbosq4CxUP+ILP8pLPQYZNtH4zzmgbRMPojY/TtK/yiKDaNqXRs6nDaIbTf4mFCRjCg==
X-Received: by 2002:a17:906:3148:: with SMTP id e8mr1179312eje.240.1629934373455;
        Wed, 25 Aug 2021 16:32:53 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s2sm460542ejx.23.2021.08.25.16.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:32:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Re: [PATCH RESEND] branch: allow deleting dangling branches with
 --force
Date:   Thu, 26 Aug 2021 01:30:13 +0200
References: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
Message-ID: <87eeahcd7f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 25 2021, Ren=C3=A9 Scharfe wrote:

> git branch only allows deleting branches that point to valid commits.
> Skip that check if --force is given, as the caller is indicating with
> it that they know what they are doing and accept the consequences.
> This allows deleting dangling branches, which previously had to be
> reset to a valid start-point using --force first.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Original submission:
> http://public-inbox.org/git/52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de/
>
>  Documentation/git-branch.txt | 3 ++-
>  builtin/branch.c             | 2 +-
>  t/t3200-branch.sh            | 7 +++++++
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 94dc9a54f2..5449767121 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -118,7 +118,8 @@ OPTIONS
>  	Reset <branchname> to <startpoint>, even if <branchname> exists
>  	already. Without `-f`, 'git branch' refuses to change an existing branc=
h.
>  	In combination with `-d` (or `--delete`), allow deleting the
> -	branch irrespective of its merged status. In combination with
> +	branch irrespective of its merged status, or whether it even
> +	points to a valid commit. In combination with
>  	`-m` (or `--move`), allow renaming the branch even if the new
>  	branch name already exists, the same applies for `-c` (or `--copy`).
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index b23b1d1752..03c7b7253a 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -168,7 +168,7 @@ static int check_branch_commit(const char *branchname=
, const char *refname,
>  			       int kinds, int force)
>  {
>  	struct commit *rev =3D lookup_commit_reference(the_repository, oid);
> -	if (!rev) {
> +	if (!force && !rev) {
>  		error(_("Couldn't look up commit object for '%s'"), refname);
>  		return -1;
>  	}
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index cc4b10236e..ec61a10c29 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1272,6 +1272,13 @@ test_expect_success 'attempt to delete a branch me=
rged to its base' '
>  	test_must_fail git branch -d my10
>  '
>
> +test_expect_success 'branch --delete --force removes dangling branch' '
> +	test_when_finished "rm -f .git/refs/heads/dangling" &&
> +	echo $ZERO_OID >.git/refs/heads/dangling &&
> +	git branch --delete --force dangling &&
> +	test_path_is_missing .git/refs/heads/dangling
> +'

Isn't a more meaningful test here to use a "real" SHA, instead of the
$ZERO_OID? You can use $(test_oid deadbeef) to get one of those.

That way we know that this this test & logic is really testing that we
can delete a branch that's been racily GC'd away or whatever, and not
one in the already-broken state of referring to the $ZERO_OID.

Also: How does "git tag -d" handle this scenario if the same sort of
data were added to .git/refs/tags/* ?
