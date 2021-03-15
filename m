Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AF5C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CAC64EB6
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCONHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhCONHk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 09:07:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990C6C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 06:07:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a18so8632064wrc.13
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R9u7RzVesvZQV/HCbRbw0G4cYqV3V6qS/43euUrYGpo=;
        b=a4zBPHPz5UK9+k0ZUBgLGtsYCvcvnDKcw1QAY0c4wzn51oCbXZEB3PZc49nGqUKLRY
         AKNZ7DOddE6HZpOcbx64ZkhrKsxibkSmqpSC6ClWvVHQFyPTlk8yEgLV7KI8eiyytJ00
         uvqy0QbLkhzB65BqaWT04S/AGmbQczUoe1NpFX6Xnz6OeKSp9JL+NkHEwxXcMPwoS0Pa
         f/VjQYCKvPU8PYSUACWy6+raG7UIJx695psk7zTdvxECSfAj1jFA0/LRXba0GR2pWukn
         nFhnUrnMnfgPYxNL6898xY5SPdQ6OGstM3PA3oSBZO/kcuyZipnJfanjjmHjXAisZJzb
         8R8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R9u7RzVesvZQV/HCbRbw0G4cYqV3V6qS/43euUrYGpo=;
        b=ADLzGG8yxr/PhHPtVC3z+IH0EmmZd1d6TYXrW9ncvw9THhAdD0GFfl7D/yuiJfQsdA
         oosk9mGwms9SvYMSrDwzF35vogMRMZUrYDLjirn4KRrfXWa6pKVheG5wUk5EI13wXU83
         9YNrhodMvfr5EgYqgeD+oCrfJ1AlZ5CMQFiOBVc8HkXPpPJZ9E9VRokVu/ThAPRIZ9se
         zN3Hy9C0OMI73KNkaYEPBV4N905PrBic7juau3ESUENiAWjeN+LQg6D6yXSWWIdEOBIi
         rwNQPKo8aSA7UHzi2a+NfWYX6oFLVyZrfBjJHVkCTRmqR5IDeyh3coqRCuthH5YHurtY
         3a1g==
X-Gm-Message-State: AOAM533MuMv9PdkaF7GlXV5ismhLGxu2MCxEj0ATV8R9e2o8T2F7crm6
        PP7ONcMmJdq5Vd84MI8t77+ohVjpbzY=
X-Google-Smtp-Source: ABdhPJxzthuURV9YmnlO9eiQqP4y/n9GpMxVkodZR6c9Nvy34bmUzSBvca7r7gnK7ZfPgpjUOpJHHQ==
X-Received: by 2002:a5d:534e:: with SMTP id t14mr26924731wrv.202.1615813659297;
        Mon, 15 Mar 2021 06:07:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm18304105wrx.79.2021.03.15.06.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 06:07:38 -0700 (PDT)
Message-Id: <pull.901.v8.git.1615813658.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com>
References: <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Mar 2021 13:07:35 +0000
Subject: [PATCH v8 0/2] [GSOC] commit: add --trailer option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now maintainers or developers can also use commit
--trailer="Signed-off-by:commiter<email>" from the command line to provide
trailers to commit messages. This solution may be more generalized than v1.

ZheNing Hu (2):
  [GSOC] commit: add --trailer option
  interpret_trailers: for three options parse add warning

 Documentation/git-commit.txt |  9 ++++++++-
 builtin/commit.c             | 23 +++++++++++++++++++++++
 builtin/interpret-trailers.c | 25 ++++++++++++++++++++++---
 t/t7502-commit-porcelain.sh  | 20 ++++++++++++++++++++
 4 files changed, 73 insertions(+), 4 deletions(-)


base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2Fadlternative%2Fcommit-with-multiple-signatures-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlternative/commit-with-multiple-signatures-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/901

Range-diff vs v7:

 1:  3ce8e8cac24a ! 1:  f81b6e66a6ba [GSOC] commit: add --trailer option
     @@ Documentation/git-commit.txt: The `-m` option is mutually exclusive with `-c`, `
      +	Specify a (<token>, <value>) pair that should be applied as a
      +	trailer. (e.g. `git commit --trailer "Signed-off-by:C O Mitter \
      +	<committer@example.com>" --trailer "Helped-by:C O Mitter \
     -+	<committer@example.com>"` will add the "Signed-off" trailer
     ++	<committer@example.com>"` will add the "Signed-off-by" trailer
      +	and the "Helped-by" trailer in the commit message.)
     -+
     ++	See linkgit:git-interpret-trailers[1] for details.
       -n::
       --no-verify::
       	This option bypasses the pre-commit and commit-msg hooks.
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
      +		struct child_process run_trailer = CHILD_PROCESS_INIT;
      +
      +		strvec_pushl(&run_trailer.args, "interpret-trailers",
     -+			     "--in-place", "--where=end", git_path_commit_editmsg(), NULL);
     ++			     "--in-place", "--if-exists=add",
     ++			     git_path_commit_editmsg(), NULL);
      +		strvec_pushv(&run_trailer.args, trailer_args.v);
      +		run_trailer.git_cmd = 1;
      +		if (run_command(&run_trailer))
 -:  ------------ > 2:  68e0bd9e2d6f interpret_trailers: for three options parse add warning

-- 
gitgitgadget
