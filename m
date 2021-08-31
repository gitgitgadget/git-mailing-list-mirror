Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934D5C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5BA60F92
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbhHaNnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhHaNnx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:43:53 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8401C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:42:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q11so27778125wrr.9
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1P35UCk91xCdrQll6wjRl57j6nd44dju7S7FYMIntQ=;
        b=LvOFkRTByJZROItdSyjp4IQLISX3uwgJyrIfrOeFv/XAjZ4chxEeg4TvBaqcHOY78Z
         YHizrbpLR5YAKVyqwEjVz+SbxPYgFNLmTwXGwgSjG4hYEDVYMbzVpUJgKe1x09iu2S5i
         qq92/IiowKRuRIBB49CY95R7hUVkOyvvYMlCDzQ9wbj6AyKnAjdgcg4rmLvE2nkqN/2V
         YJu+0HlykJhRW4o8q+2fSOeqxBOG4bkuoZtt8g/5614COIUiizxrKg+BGT05ywrCbAc3
         d/00wCtqv4KW4SpBVxDkHNuPPgApUA15ZEiseB2zQh6qy+gpbK+0aozTKGTuT42E9O8E
         toEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1P35UCk91xCdrQll6wjRl57j6nd44dju7S7FYMIntQ=;
        b=HFeuv/cfpFRgl69TY1ltL+IseUuzBZytJYkywueHyarnH58cbryiTxdKkYqUom0A3Z
         5pbHMVZrfuchIzYoJTFAlsfpDEISV5BoVcWdbdUPXjCsqjP0eexP1eaO9Hjskt3kMciW
         wo60d7QMPIMJQ+aMbeqn23S58W5UUQoxP0M/VHwSndivHD6+jWZmkXul4djmgIA83Lr8
         1UvbIDlAsG0kke4srkm8dUdPPiEsarrRoqvNJg4Qz3jhNejN7rbVp02HdXTls9hN5H+8
         CGqgzubrfsh4rZSzULU+kyAVa1vmab/RN5Wc0UkXldDSQbuGL+A48PURKjHNy0XBIyUX
         nU2g==
X-Gm-Message-State: AOAM531lBWFfB9tJMrEiughsB8KAS4E+j9sa+mj4713K5FkQzMVvLZh3
        5BBCj6t8ZuXzbUqubypLzsHMgY85q+Lv2w==
X-Google-Smtp-Source: ABdhPJwSyytFNWRQIk5+0fgjSmhwXLY5O3Pg4QJtOK+pOcYI8c/b9IgIqXTQQpSb8C/W/lelQUNWkQ==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr31509372wrw.240.1630417375984;
        Tue, 31 Aug 2021 06:42:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d7sm18686241wrs.39.2021.08.31.06.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:42:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Marius Storm-Olsen <marius@storm-olsen.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] mailmap.c: fix a memory leak in free_mailap_{info,entry}()
Date:   Tue, 31 Aug 2021 15:42:52 +0200
Message-Id: <patch-1.1-f11eb44e4c5-20210831T134023Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.805.g739b16c2189
In-Reply-To: <patch-4.4-ad8680f529-20210714T172251Z-avarab@gmail.com>
References: <patch-4.4-ad8680f529-20210714T172251Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the free_mailmap_entry() code added in 0925ce4d49 (Add map_user()
and clear_mailmap() to mailmap, 2009-02-08) the intent was clearly to
clear the "me" structure, but while we freed parts of the
mailmap_entry structure, we didn't free the structure itself. The same
goes for the "mailmap_info" structure.

This brings us from 50 failures when running t4203-mailmap.sh to
49. Not really progress as far as the number of failures is concerned,
but as far as I can tell this fixes all leaks in mailmap.c
itself. There's still users of it such as builtin/log.c that call
read_mailmap() without a clear_mailmap(), but that's on them.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This was originally submitted as part of the SANITIZE=leak series as
https://lore.kernel.org/git/patch-4.4-ad8680f529-20210714T172251Z-avarab@gmail.com/

In its v3 I stopped doing these leak fixes & test changes, let's just
consider this separately. We'll eventually want to add SANITIZE=leak
whitelisting to the relevant test if and when my SANITIZE=leak series
goes in, but we can just do that then along with adding various other
tests.

Range-diff:
1:  80edda308c9 ! 1:  f11eb44e4c5 SANITIZE tests: fix leak in mailmap.c
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    SANITIZE tests: fix leak in mailmap.c
    -
    -    Get closer to being able to run t4203-mailmap.sh by fixing a couple of
    -    memory leak in mailmap.c.
    +    mailmap.c: fix a memory leak in free_mailap_{info,entry}()
     
         In the free_mailmap_entry() code added in 0925ce4d49 (Add map_user()
         and clear_mailmap() to mailmap, 2009-02-08) the intent was clearly to
    @@ Commit message
         mailmap_entry structure, we didn't free the structure itself. The same
         goes for the "mailmap_info" structure.
     
    +    This brings us from 50 failures when running t4203-mailmap.sh to
    +    49. Not really progress as far as the number of failures is concerned,
    +    but as far as I can tell this fixes all leaks in mailmap.c
    +    itself. There's still users of it such as builtin/log.c that call
    +    read_mailmap() without a clear_mailmap(), but that's on them.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## mailmap.c ##
    @@ mailmap.c: static void free_mailmap_entry(void *p, const char *s)
      }
      
      /*
    -
    - ## t/t4203-mailmap.sh ##
    -@@ t/t4203-mailmap.sh: test_expect_success 'check-mailmap bogus contact --stdin' '
    - 	test_must_fail git check-mailmap --stdin bogus </dev/null
    - '
    - 
    -+if test_have_prereq SANITIZE_LEAK
    -+then
    -+	skip_all='skipping the rest of mailmap tests under SANITIZE_LEAK'
    -+	test_done
    -+fi
    -+
    - test_expect_success 'No mailmap' '
    - 	cat >expect <<-EOF &&
    - 	$GIT_AUTHOR_NAME (1):

 mailmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mailmap.c b/mailmap.c
index 462b3956340..40ce152024d 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -37,6 +37,7 @@ static void free_mailmap_info(void *p, const char *s)
 		 s, debug_str(mi->name), debug_str(mi->email));
 	free(mi->name);
 	free(mi->email);
+	free(mi);
 }
 
 static void free_mailmap_entry(void *p, const char *s)
@@ -52,6 +53,7 @@ static void free_mailmap_entry(void *p, const char *s)
 
 	me->namemap.strdup_strings = 1;
 	string_list_clear_func(&me->namemap, free_mailmap_info);
+	free(me);
 }
 
 /*
-- 
2.33.0.805.g739b16c2189

