Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D49C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 15:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjDMPkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 11:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjDMPkS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 11:40:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8701712
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 08:40:17 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p17so4224409pla.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681400417; x=1683992417;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTMMRn4dJl0Xy8rJdDpfioZhUQjqScXiWAXoBp0Ml0A=;
        b=PCRcOq8w2B9HdnhHBASy0BP+g/QqOh+FduWdizvalz4hQ5kDLcDK/rDzFKwcdRbJUe
         tbfzfqbVH7+gTNn3TQTS6WqRowtaNB9Zotn7VbQRxIM3N+CCHXioLsY2uAHfoWj+Heyx
         c7YILW89y7E2WfMMXyaTHAZ8y48Mjjv7VG3d5D2Sv1ljgnGJYNsXZnahZrEcufajR/K4
         Y44xr0yhQjMlmEa0OsUyZOKOMsVn09OTX8XXCnDNO5o5BsPcZDRxQosbi3S6vGw+UNCW
         cERhfFy6s3hW1bhdCRx1IBmw7be6lsZn9qnJZVTsrRTxK9GdnWJJSXRm8fJPZlOOT8nD
         JrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681400417; x=1683992417;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MTMMRn4dJl0Xy8rJdDpfioZhUQjqScXiWAXoBp0Ml0A=;
        b=WVqo3gVIdDKimh47cLXKVQHVCj3GZaQHp9aVIZZFqFVDM8FMsEbSm3MB0y5pDfvD8K
         v397lk3h/izh8hR8VrGB//yeTzveNan26u9wZUooGMKSseTivyJ0H9LMtYhE3RettvNd
         FLEXnbbk9W5KKGjGJdb7MoRm/IH5JEhwA5Nr0UH2qwQVg+7tMeLw0ML/2dnMQtkiiWXk
         ebgpMA0O7SQFhVufXHJZ4svIXoshCmQzIo2fMo4L5FjduBH3wjRQQdyZc36eCE/3J83s
         I0cCaTxSwUNFrK4LYMBaoIiIK2tIBUxWLzm6TuXqH6saedh5eey82qVLQvSG6neSg1nM
         SM1w==
X-Gm-Message-State: AAQBX9dRyXUF3sUfrMT0gVMW0oja9bkanjrDC3S2pKcMoef65YLStqBm
        czM/AN+Fo7xkP/PzHGU0C2Y=
X-Google-Smtp-Source: AKy350aoVqZ3eYCvZHC+Daag/ITnvWxLFQ+1SPyClG4j6hpCtT594lw0lKyG9Y1e4E84uH9b0E0gsA==
X-Received: by 2002:a17:902:8492:b0:1a1:d5fd:1e9a with SMTP id c18-20020a170902849200b001a1d5fd1e9amr2251430plo.40.1681400417113;
        Thu, 13 Apr 2023 08:40:17 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id ij30-20020a170902ab5e00b001a064cff3c5sm1642176plb.43.2023.04.13.08.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 08:40:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH v3 09/10] repack: honor `-l` when calculating pack geometry
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
        <cover.1681384405.git.ps@pks.im>
        <285695deafa5a4a49f774dc484782dd8e4fd4997.1681384405.git.ps@pks.im>
        <52079b9b-a55c-e7d1-930e-38105dd8a85b@github.com>
Date:   Thu, 13 Apr 2023 08:40:16 -0700
In-Reply-To: <52079b9b-a55c-e7d1-930e-38105dd8a85b@github.com> (Derrick
        Stolee's message of "Thu, 13 Apr 2023 09:59:02 -0400")
Message-ID: <xmqq5y9zzt7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> +	test_line_count = 3 packed-objects &&
>> +	packed_objects member/.git/objects/pack/pack-*.idx >packed-objetcs &&
>
> Typo: s/packed-objetcs/packed-objects/
>
>> +	test_line_count = 3 packed-objects &&

That's a good one.  Because the result file created by the previous
step happens to also have three lines, the typo does not cause the
test to fail, but it is not testing what it designed to test.

Here is "git diff @{1}" after my local "rebase -i" ("diff" of the
result is easier to read than "range-diff" in this case, as I did
not touch any log message).

Thanks for a very good set of eyes.

diff --git c/t/t5331-pack-objects-stdin.sh w/t/t5331-pack-objects-stdin.sh
index 45e24fa94a..acab31667a 100755
--- c/t/t5331-pack-objects-stdin.sh
+++ w/t/t5331-pack-objects-stdin.sh
@@ -7,7 +7,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-packed_objects() {
+packed_objects () {
 	git show-index <"$1" >tmp-object-list &&
 	cut -d' ' -f2 tmp-object-list | sort &&
 	rm tmp-object-list
diff --git c/t/t7703-repack-geometric.sh w/t/t7703-repack-geometric.sh
index 33d7977fca..57796f3437 100755
--- c/t/t7703-repack-geometric.sh
+++ w/t/t7703-repack-geometric.sh
@@ -10,7 +10,7 @@ objdir=.git/objects
 packdir=$objdir/pack
 midx=$objdir/pack/multi-pack-index
 
-packed_objects() {
+packed_objects () {
 	git show-index <"$1" >tmp-object-list &&
 	cut -d' ' -f2 tmp-object-list &&
 	rm tmp-object-list
@@ -380,7 +380,7 @@ test_expect_success '--geometric -l with non-intact geometric sequence across OD
 	# should have three objects and should be non-equal.
 	packed_objects shared/.git/objects/pack/pack-*.idx >packed-objects &&
 	test_line_count = 3 packed-objects &&
-	packed_objects member/.git/objects/pack/pack-*.idx >packed-objetcs &&
+	packed_objects member/.git/objects/pack/pack-*.idx >packed-objects &&
 	test_line_count = 3 packed-objects &&
 	test "$(basename member/.git/objects/pack/pack-*.pack)" != "$(basename shared/.git/objects/pack/pack-*.pack)" &&
 
