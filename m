Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED63C0015E
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 12:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGXMer (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 08:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXMeq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 08:34:46 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4198E66
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690202079; x=1690806879; i=l.s.r@web.de;
 bh=k6v4gvXR0gGDlIXmis3AUbBW039nh4y/TI6Isi8pHTE=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=WdC7h6QJaNJ/WFEW5EpUYSqpRq/AtUo7lbWbrc7bVdWpKcuOB/qKH8KL0oN9J7RrPvFLjca
 cpsQRk12ebtwKMfk37283JusIkFgLKBTW0DR84bnrhc3RehPus4PUss0tZgMxmlHYNUJ7Wj3Q
 H4qxtak24tbgBKgGtL2m2luHx3PEfjSnY+on8bJiOZFVL2OCG9D3W5Phd2m5MLV0Wv7BA50XR
 nMjojHpVz0s30C+XUH75LzUiVOTd9Wh8eBHmGMiSX8+0XkzvmFMoOwGrBvWmCx8jRfhwDG1+2
 AnWQLLXKRW75TBYLuCa6fsGGwRN7VsHGUlQxx3v1eabJYTBTilkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9Zdw-1qIQaQ3mMO-005rmm; Mon, 24
 Jul 2023 14:34:38 +0200
Message-ID: <2cfa6142-8acc-eb35-bf69-ede986202435@web.de>
Date:   Mon, 24 Jul 2023 14:34:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: [PATCH v2 1/5] subtree: disallow
 --no-{help,quiet,debug,branch,message}
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <4d01e971-07cb-4f11-3cc6-9d9f21e590c1@web.de>
In-Reply-To: <4d01e971-07cb-4f11-3cc6-9d9f21e590c1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hGMS4Q+VbRmW5xAPuZIlm3F8GkVxY0n823C4fLXNNV/aiEDgSYG
 rG4u39niB9118vflWl+Lf++HDtoX4L1MR4l4hCYz9d2Yw03+/9XJQ6mfkRGqW29INpuTAZN
 jQ7v0gwd9WE8dW48mFgRNxZqJ1P9Y5q0vS8xlO8AMCRKclWM6vvpwOEFvzBTCA9ONY947pq
 YWkCf1DuVMSq2gAI45KNA==
UI-OutboundReport: notjunk:1;M01:P0:7plKJT3xV54=;si6qmh1EQ5FRDriCUhGj+NtfYYK
 2IxbCV90GBkmVs/nwnJ4RM8eJk75jVO9slwO8QKY52J0sRSev1aWna1kL2TXR9nm/07RxmS3E
 zXx3sTP/oYh1f52W6nhXiYzY8P7LzsMGtW/1G2tb9m4zzRqEn2CM401ps0TEyDzePWkGsRE8t
 Zm8yDFBZzMyjsBQ5oKgRJ+59MvPWYqU1uxJKcc/i4BQ5q+u8EhstKPbFBSG0Ebk7gZM+HsH7u
 Xe6jSuHF0uug02aU6rMa5lgwpm5VoiPHa1ucytMz/EK5Uaq/Mn12LIM0vFu2iK1vq+tQnHXAR
 cRepSN2kF+OQ/fPzYUzf0V16CaZ5TbjPYekjEXARbKxz8uaYJIPPe+14taFou0qiTdzA62X8F
 gUeHmtg52ow8b1tGXvKFhxqGlqUNfFPxD4KhXtfwOeDP+IqFme+K3YZb/4TxHf9Yz6sAtk1yX
 rdLJuUT0+HL+fJ4fXfZU9s6qXLMl1KQjndAQiCjFdqTLASMCd8DiUNpI1fGEuSereBrolxc/1
 M/mcwe7XH0rt4bMWjZDyoyUwQ2HZFtl1yhwS/axUBAoq8T7bgv8GKuqf6ZLGWporxFI7Xburm
 y1R3gjA+FutyhKM5UZhcppQ1HAay0cP1wqWsFy8WqrQG8iOP2nmlYuPCwDbY2RvXWmN0yt7wr
 VFBLFoXdafibicx+CTfBKKzH0O2j2o2vWARch9Qrz/b+Bv/T5zUg2ZX9XA0/Ere7FPBaDzygF
 G5sm/CwIn+ei4CfdtrPiaBNMXFCKlFCeL8Qg2PJOv+NYIHp8uSJvKlYPwJsZAPzyCV31HGeHG
 r0n9IeTtWORxvVPTG8yLLsAubs3wvDrKXC7gM8k8/RAJb7FAEZHXa6nniK+Jp1bkk0xp08Fyh
 TfKW1MuHh/5+g+PhSkbIaeNOWSTU2Bo4K2S+2Duq7DPb5u0ga5ZydEXUJ/ebFYwLwMUcGobWp
 XvPRyg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git subtree" only handles the negated variant of the options annotate,
prefix, onto, rejoin, ignore-joins and squash explicitly.  help is
handled by "git rev-parse --parseopt" implicitly, but not its negated
form.  Disable negation for it and the for the rest of the options to
get a helpful error message when trying them.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 contrib/subtree/git-subtree.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.=
sh
index 7db4c45676..e0c5d3b0de 100755
=2D-- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -33,19 +33,19 @@ git subtree split --prefix=3D<prefix> [<commit>]
 git subtree pull  --prefix=3D<prefix> <repository> <ref>
 git subtree push  --prefix=3D<prefix> <repository> <refspec>
 --
-h,help        show the help
-q,quiet       quiet
-d,debug       show debug messages
+h,help!       show the help
+q,quiet!      quiet
+d,debug!      show debug messages
 P,prefix=3D     the name of the subdir to split out
  options for 'split' (also: 'push')
 annotate=3D     add a prefix to commit message of new commits
-b,branch=3D     create a new branch from the split subtree
+b,branch!=3D    create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=3D         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
  options for 'add' and 'merge' (also: 'pull', 'split --rejoin', and 'push=
 --rejoin')
 squash        merge subtree changes as a single commit
-m,message=3D    use the given message as the commit message for the merge=
 commit
+m,message!=3D   use the given message as the commit message for the merge=
 commit
 "

 indent=3D0
=2D-
2.41.0
