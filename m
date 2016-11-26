Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FEB71FC96
	for <e@80x24.org>; Sat, 26 Nov 2016 12:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751064AbcKZMsG (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Nov 2016 07:48:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:61126 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750912AbcKZMsE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2016 07:48:04 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHnzh-1c9FTu1v0n-003bRE; Sat, 26
 Nov 2016 13:47:59 +0100
Date:   Sat, 26 Nov 2016 13:47:58 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Markus Klein <markus.klein@reelworx.at>
Subject: [PATCH v2 0/2] Fix segmentation fault with cherry-pick
In-Reply-To: <cover.1480091758.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1480164459.git.johannes.schindelin@gmx.de>
References: <cover.1480091758.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hvHRoy1cQgNs8mprFmF1KdMBUZg/d19qgtVITRS1/s6sFC+Q44n
 vM9tMjUsvFRdcdsuoBXT0Q4yOZbN13AIAZlmNiVuCbDkUeMD9zSHadsoqEGSxr+T7yxB3gN
 CZ1mrVLHSUl6OfPZ0Qza8qtoiuUEGv2TxoxypYVb3pmZlCTJJjwK011Zy53NdFCG4oYJaFq
 toOTIplhdn6XhuaXxF1Xw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nq+9oeSR6Oc=:aaz+4Y4BbLTU6pYAlqOlTr
 8NUf8ThXgUWnjZmgpOaJGR6t7D5Lsn01DCjQk1Ru33y8/HnWz61KII7itxmn8SmjjEc8JxwYW
 8NwUm3uD7xnhMUFJ9rzwQZT5zDA7uNLQGjU0uIPOvDj2Uw68SR724wZ3G9snU0fxOUGtPIrdf
 jEX8uponOpIMFLCNx6Bg6af+NY+KNRYsJEY8s5iAVnZZX9WcOfjlIyAZuVWkRR8yW9nyVNrOq
 4YirAWxA3jwnaao8a7fcEvELu1124qHZkO2zxQDKMkhP+Opawo8eOsVpJmOFxP+0fsFs1LpzV
 HQvho0tJbgM6CtbXUl72JMsjF/Clb6TCQe83UE3OWofEZtKKWEos08fIcK+cljI0fUiHFORJJ
 3TGgb0Ov6koCwgLwki6Caf4Lq/wm/KSKItCzR+tiryorH1JffSrY7KBLIMIZPXtFr8cYqZLkI
 3b0RHjxAxx/Wkd2FmMifzUCxncn9hZJDd77dwCG4sNn9CIYYEOyf4GM0yTNldA1xJYlc7SEno
 PtyDHiYRkGXtkkOTKlAzBGJu+wb4cJxrEhMcq3RqGjzKd3XppFAHLUfrs2mMd8+e3UclU6eip
 D+lDa/x9eMfdnWwfOEjwnYAAk91zvbklZsxB6ZeWOoqUFSuvkQvXQk6v8iZbwdZgsq/flAA9k
 96CoEySr+K+IAygyMrkWiIkk1Ltl7enJyjjKuu9ff7AsaVjymAS9SdxkwAjYm/o4yAnw2qcJK
 A5zJOHX3ekFLnaEuQP4xVLnXcJK5J4i4yZtT5xks3bU9SmffzUvydf9cJl3Zfb1DLUkxaLTK2
 lpbJC6U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The culprit is actually not cherry-pick, but a special code path that
expects refresh_cache_entry() not to return NULL. And the fix is to
teach it to handle NULL there.

This bug was brought to my attention by Markus Klein via
https://github.com/git-for-windows/git/issues/952.

Changes since v1:

- changed test title

- avoided ambiguous refname in test


Johannes Schindelin (2):
  cherry-pick: demonstrate a segmentation fault
  Avoid a segmentation fault with renaming merges

 merge-recursive.c             |  2 ++
 t/t3501-revert-cherry-pick.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+)


base-commit: e2b2d6a172b76d44cb7b1ddb12ea5bfac9613a44
Published-As: https://github.com/dscho/git/releases/tag/cherry-pick-segfault-v2
Fetch-It-Via: git fetch https://github.com/dscho/git cherry-pick-segfault-v2

Interdiff vs v1:

 diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
 index 8e21840f11..4f2a263b63 100755
 --- a/t/t3501-revert-cherry-pick.sh
 +++ b/t/t3501-revert-cherry-pick.sh
 @@ -141,7 +141,7 @@ test_expect_success 'cherry-pick "-" works with arguments' '
  	test_cmp expect actual
  '
  
 -test_expect_success 'cherry-pick fails gracefully with dirty renamed file' '
 +test_expect_success 'cherry-pick works with dirty renamed file' '
  	test_commit to-rename &&
  	git checkout -b unrelated &&
  	test_commit unrelated &&
 @@ -150,7 +150,7 @@ test_expect_success 'cherry-pick fails gracefully with dirty renamed file' '
  	test_tick &&
  	git commit -m renamed &&
  	echo modified >renamed &&
 -	git cherry-pick unrelated
 +	git cherry-pick refs/heads/unrelated
  '
  
  test_done

-- 
2.11.0.rc3.windows.1

