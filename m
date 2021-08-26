Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD904C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 20:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923FF60F92
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 20:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243570AbhHZUiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 16:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243579AbhHZUiL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 16:38:11 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FDBC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 13:37:23 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c10so4841829qko.11
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 13:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88jUYl5nrpkg/FeOfLxRRk+x47V0hMBbX6kPRy4BUCk=;
        b=vCFELnBQTJh/1UOhVuYlTKfK5JVVs1c5dTNqZNUU6M1b6s71zOc8GAcCX1/MSxV1am
         rEkqWJj04110cmrIhNLp92fMsn69XT2Cd1+igr4hNfuSvpDhvm413jb+536m39mhb4hS
         G+8CNKeXtvwSWIiTx8WAj1G37MVpyT2/tADidEe2xIj6Tyw4rF/n8hP763x6B+MpScwm
         tmWcn8ZVfM6UaY/J2iV271g2Rl2V8m3qDUdv4sF0ZBv1DoQj2/kaAu6LNWTGUvq8m24H
         pcpaLplU9vI9lAYdLHZip/VphbDXjflF0QrqnQ5G1oYlxrpkuvFrVmxB1txJEHtrxGDf
         fWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88jUYl5nrpkg/FeOfLxRRk+x47V0hMBbX6kPRy4BUCk=;
        b=tOump/ajNhg4x2VzyhwETkcl701fWVaVdAUBQHQzIw+dZ4bnEvbJVwAN6Vu69O55FZ
         bepTlaKMdDF26zBMbRCRcsqDbHRs9lFVVqGWZd/H7l066Pli/vE12aM50Qy3y7R6E7At
         urEZA4grLGekVazEVEBsw12w6x96T49YKxhYRUYU9xKbOCqvp7StqCxCI77FxYe/QG3U
         YiNiVojWlBz7LPSWepxgyu/u+Mml+EydKu+o+m/nuGPkfF9nZA7wTIK1f1iZdyE5OP/o
         Ca8uTb0c9wZCL5y7Dj9/lt2xp8GJSBQMvK5a86JevqBPM6FkCQpCp69UYLstq7lX7e7L
         xEfw==
X-Gm-Message-State: AOAM531PcBtP639eObT4OQHDEPvZCQqUHUNDFZLY6gM1E2y6SGLpglgY
        LnF/dy0v+Hq90WT5oEKBsLn6Syp2kU80IesB
X-Google-Smtp-Source: ABdhPJxNt5bg+5x8DMpzG6ptmwB4gh5LKnRvOUY0cNQBkid/3TVUBhoNXtA3kxcLzgKgrJk8RhxkwQ==
X-Received: by 2002:ae9:ef4c:: with SMTP id d73mr5817363qkg.494.1630010242776;
        Thu, 26 Aug 2021 13:37:22 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.116.19])
        by smtp.gmail.com with ESMTPSA id f12sm2417717qtj.40.2021.08.26.13.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 13:37:22 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, philipoakley@iee.email, sobomax@gmail.com,
        sobomax@sippysoft.com
Subject: Re: [PATCH v2] Make ident dynamic, not just a hardcoded value of "$Id".
Date:   Thu, 26 Aug 2021 17:37:13 -0300
Message-Id: <20210826203713.45139-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <pull.1074.v2.git.git.1629952119446.gitgitgadget@gmail.com>
References: <pull.1074.v2.git.git.1629952119446.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Maksym

I haven't read the entire patch (and I don't normally use the ident feature),
but I left a few comments below: 

On Thu, Aug 26, 2021 at 1:28 AM Maksym Sobolyev via GitGitGadget <gitgitgadget@gmail.com> wrote:
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 83fd4e19a4..9e486f3e8d 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -382,6 +382,14 @@ sign `$` upon checkout.  Any byte sequence that begins with
>  `$Id:` and ends with `$` in the worktree file is replaced
>  with `$Id$` upon check-in.
>
> +The `ident` attribute can also provide an optional value,
> +which if supplied is going to be used for expansion instead of
> +the string `Id`.
> +
> +------------------------
> +*.[ch]         ident=FreeBSD
> +------------------------

What happens if there is a ':' or '$' in the custom id name?

$ echo 'f	ident=$weird:$' >.gitattributes
$ echo '$$weird:$$' >f
$ git add .
$ git commit -m files
$ rm f
$ git checkout f
$ cat f

$$weird:$: 907f73b343505bf289a4a25e41ea91d90250fedb $

Seem right. Now let's see the cleaning direction:

$ echo foo >> f
$ git add f
$ git cat-file -p :f

$$weird:$: 907f73b343505bf289a4a25e41ea91d90250fedb $
foo

Hmm, this one is not right. I think I know the cause:

> diff --git a/convert.c b/convert.c
> index 0d6fb3410ae..1e8940bf9d7 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -1122,17 +1127,18 @@ static int ident_to_git(const char *src, size_t len,
>                 len -= dollar + 1 - src;
>                 src  = dollar + 1;
>
> -               if (len > 3 && !memcmp(src, "Id:", 3)) {
> -                       dollar = memchr(src + 3, '$', len - 3);
> +               if (len > idact->id_len + 1 && !memcmp(src, idact->id, idact->id_len) && src[idact->id_len + 1] == ':') {

Shouldn't this be `... && src[idact->id_len] == ':')`? I.e. without the "+ 1".

> diff --git a/convert.h b/convert.h
> index 5ee1c322058..a02632e8104 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -76,11 +76,16 @@ enum convert_crlf_action {
>
>  struct convert_driver;
>
> +struct ident_action {
> +       const char *id;
> +       int id_len;

I known the string size is limited to GIT_MAX_IDENT_LEN, but perhaps it
would be better to future-proof this and use `size_t` (or at least
`unsigned int`).

> diff --git a/parallel-checkout.c b/parallel-checkout.c
> index ddc0ff3c064..f9a3f2ff25b 100644
> --- a/parallel-checkout.c
> +++ b/parallel-checkout.c
> @@ -403,13 +403,15 @@ static void send_one_item(int fd, struct parallel_checkout_item *pc_item)
>         size_t name_len = pc_item->ce->ce_namelen;
>         size_t working_tree_encoding_len = working_tree_encoding ?
>                                            strlen(working_tree_encoding) : 0;
> +       const char *ident_action_id = pc_item->ca.ident_action.id;
> +       size_t ident_action_len = pc_item->ca.ident_action.id_len;
>
>         /*
>          * Any changes in the calculation of the message size must also be made
>          * in is_eligible_for_parallel_checkout().
>          */
>         len_data = sizeof(struct pc_item_fixed_portion) + name_len +
> -                  working_tree_encoding_len;
> +                  working_tree_encoding_len + ident_action_len;

This update in the packet size calculation should also be reflected in
is_eligible_for_parallel_checkout():

	packed_item_size = sizeof(struct pc_item_fixed_portion) + ce->ce_namelen +
		(ca->working_tree_encoding ? strlen(ca->working_tree_encoding) : 0);

> diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-checkout-attributes.sh
> index 25254579618..822957a8dc8 100755
> --- a/t/t2082-parallel-checkout-attributes.sh
> +++ b/t/t2082-parallel-checkout-attributes.sh
> @@ -20,16 +20,19 @@ test_expect_success 'parallel-checkout with ident' '
>         (
>                 cd ident &&
>                 echo "A ident" >.gitattributes &&
> +               echo "C ident=MyCusomVeryLongAndWordyId" >>.gitattributes &&
>                 echo "\$Id\$" >A &&
>                 echo "\$Id\$" >B &&
> +               echo "\$MyCusomVeryLongAndWordyId\$" >C &&
>                 git add -A &&
>                 git commit -m id &&
>
> -               rm A B &&
> +               rm A B C &&
>                 test_checkout_workers 2 git reset --hard &&
>                 hexsz=$(test_oid hexsz) &&
>                 grep -E "\\\$Id: [0-9a-f]{$hexsz} \\\$" A &&
> -               grep "\\\$Id\\\$" B
> +               grep "\\\$Id\\\$" B &&
> +               grep -E "\\\$MyCusomVeryLongAndWordyId: [0-9a-f]{$hexsz} \\\$" C
>         )
>  '

The change to this test looks good. But there are other things related
to the ident filter that are not covered here (as the test is mostly
interested in how ident interacts with parallel checkout). For example,
the test doesn't check whether the "cleaning" direction is performed
correctly, it just checks the "smudging" part. (That's why it didn't catch the
error I showed earlier.)

You might want to take a look at the other ident tests in
t0021-conversion.sh and perhaps addapt/copy some of them to ensure that
the expected behavior persists when using a custom id name. For example,
quickly changing the "$Id:" references to "$customId:" and replacing
"ident" with "ident=customId", I seem to get at least one test failure:

--- expected-output     2021-08-26 19:40:07.181596662 +0000
+++ expanded-keywords   2021-08-26 19:40:07.188263463 +0000
@@ -6,5 +6,5 @@
 $customId: bebd07c752ffffd6779e1056db5de66c3bb733ed $
 $customId: bebd07c752ffffd6779e1056db5de66c3bb733ed $
 $customId: NoTerminatingSymbol
-$customId: Foreign Commit With Spaces $
+$customId: bebd07c752ffffd6779e1056db5de66c3bb733ed $
 $customId: NoTerminatingSymbolAtEOF
\ No newline at end of file
error: last command exited with $?=1
not ok 3 - expanded_in_repo

(But I haven't dig further, and this was just a quick test, so it could be my
fault.)
