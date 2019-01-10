Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32CEC211B4
	for <e@80x24.org>; Thu, 10 Jan 2019 12:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfAJMFK (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 07:05:10 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45189 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfAJMFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 07:05:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so5197401pfd.12
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 04:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zroOy5XN2HvKahARLokhWCPIcvbOsDsHLQm5r54JFBM=;
        b=tlYBj0do37xei1hv1Sq1IVsDI/FWihuYHFhobdpVGRR/v1GPzl9bAwuiWFvasxYEOa
         LWlCTtBt6dLRjHYRq8Hjbz7ty9/dBkdtEx1Gxs8MM4z4Y3XKSxTv5hY1eKcg4hs7QVAd
         8p8Nh1JNynJNunK9/TdEAmE8t3qUyAevAhVnqVq96qo2mMtUQTTeDAoen+ruauhKk+MW
         oDIuDEySzhoTjL0RbEgpjzO4zMSKpMQkDnZNIeq7LWUX5OcaR9kMzHeFjXy/cP1ktSN+
         Avt4aXl97neIcfden7tZxEnikJIOqJ5oSdrIsHI7hnCfW+WsKwJVz95GB/G2HKabk+Kp
         PSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zroOy5XN2HvKahARLokhWCPIcvbOsDsHLQm5r54JFBM=;
        b=WahXsvsSeDSh7LbuOkc75giNRG6VI6jPYHGBrdGLqfqZ7hjFyDzl7A3U5R7Gwi/AP5
         UpEofNlZnlsUefi0RgtP1iBZS18/Dx+r9aOHtQ/49wLbQLzZzRUIGDkMO1rR46nxoVlW
         huCLgcBmCIynUyAG/x+tGxUnZJO3+JU9Nt7Xtw340ViIhlA+9SfNyX4YTnxksOF0ykHD
         rc9Jnlsw4pnKF7YnpjApL+GhlXKn0SZrU9IkAbH5Oz+xu5IKlJ5jYVteTfk/vBd6MqDG
         fDWix7RTlt8HKccS7MSeZlMLumq4BdfeT9SG360OLGz474BAiv0pYaLBfvL6KOkVc471
         YOuA==
X-Gm-Message-State: AJcUukez02yPfjlw2kHptL8ITOup5j7lFIRJXEF2185nGbiCcroOAMn2
        kTZsv8mpHjQMFzTDUzgrJIlqq7QLfBw=
X-Google-Smtp-Source: ALg8bN5x/AT7IrXUZPIHCw3Qb+Jzi0dN/6V9rwi4059aJJBKEWgNcYCbUoTTCeyapTRhvwEZ6Z7Pbg==
X-Received: by 2002:a62:4d81:: with SMTP id a123mr10279863pfb.122.1547121908107;
        Thu, 10 Jan 2019 04:05:08 -0800 (PST)
Received: from GotGit.hz.ali.com ([106.11.34.204])
        by smtp.gmail.com with ESMTPSA id b2sm137189403pfm.3.2019.01.10.04.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 04:05:07 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v5 0/5] pack-redundant: new algorithm to find min packs
Date:   Thu, 10 Jan 2019 20:01:37 +0800
Message-Id: <20190110120142.22271-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.101.gc01fadde4e
In-Reply-To: <20190109164731.GJ4673@szeder.dev>
References: <20190109164731.GJ4673@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Sun Chao (my former colleague at Huawei) found a bug of
> git-pack-redundant.  If there are too many packs and many of them
> overlap
> each other, running `git pack-redundant --all` will exhaust all memories
> and the process will be killed by kernel.
> 
> There is a script in commit log of commit 2/3, which can be used to
> create a repository with lots of redundant packs. Running `git
> pack-redundant --all` in it can reproduce this issue.

SZEDER reported that t5233 won't pass for MacOS. See solution in patch
4/5.

Changes since reroll v4:

* Rewrite t5323, add more test cases.
* Add two new patches, one for refactor, and another changed sorting
  method and fixed t5323 for the new algorithm.

Range diff with sc/pack-redundant feature branch:

    1:  702267a888 < -:  ---------- t5323: test cases for git-pack-redundant
    -:  ---------- > 1:  40fea5d67f t5323: test cases for git-pack-redundant
    2:  c4b133d858 = 2:  50cd5a5b47 pack-redundant: new algorithm to find min packs
    -:  ---------- > 3:  6338c6fad4 pack-redundant: rename pack_list.all_objects
    -:  ---------- > 4:  734f4d8a8b pack-redundant: consistent sort method
    3:  2351d7e8b5 ! 5:  b7ccdea1ad pack-redundant: remove unused functions
        @@ -13,7 +13,7 @@
          --- a/builtin/pack-redundant.c
          +++ b/builtin/pack-redundant.c
         @@
        - 	struct llist *all_objects;
        + 	size_t all_objects_size;
          } *local_packs = NULL, *altodb_packs = NULL;
          
         -struct pll {
        @@ -105,7 +105,7 @@
         -	diff = llist_copy(list);
         -
         -	while (pl) {
        --		llist_sorted_difference_inplace(diff, pl->all_objects);
        +-		llist_sorted_difference_inplace(diff, pl->remaining_objects);
         -		if (diff->size == 0) { /* we're done */
         -			llist_free(diff);
         -			return 1;


Jiang Xin (3):
  t5323: test cases for git-pack-redundant
  pack-redundant: rename pack_list.all_objects
  pack-redundant: consistent sort method

Sun Chao (2):
  pack-redundant: new algorithm to find min packs
  pack-redundant: remove unused functions

 builtin/pack-redundant.c  | 221 +++++++++++++++-----------------------
 t/t5323-pack-redundant.sh | 157 +++++++++++++++++++++++++++
 2 files changed, 242 insertions(+), 136 deletions(-)
 create mode 100755 t/t5323-pack-redundant.sh


-- 
2.20.1.101.gc01fadde4e

