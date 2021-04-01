Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04767C433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB73760240
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhDASWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbhDASLl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 14:11:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E62C08EC8E
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 06:56:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so956393wmi.3
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YUkClUtBHqyFtezG5BSofLtJe1qr33osTtTOOT7zrwk=;
        b=Fnnu2anxlaoG5OJ6Cvrt5zlJOWIU/poIh0mG/pNof2f5gazmmM6JO09DJ5E5n4+ItP
         kjSpPiV1LKjJvsZaUxkDWJSAEGlyapkh401sVatxcvtTz/WJpXafgsY/lPHFA07Iij+H
         j+86RRQCfAh0QbuJU6tW6uqDoQm30m6cMrwpS7V3A8xT5NjnY1fUJSp/+QBInEFu6XLH
         aauYDQaI7TboyqzZRHYNdJie7dpl/d7pxHQJUSYphKI79fAxwydDyT1IxzIuJMPvdUIG
         uhYFkwqzSoHIC4Pmcr3uW2V4YHTQ+ZwMmloX2v959rOvznSxYK/hat1O2w6fpMgj9BS4
         IUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YUkClUtBHqyFtezG5BSofLtJe1qr33osTtTOOT7zrwk=;
        b=FNg/uepvXo5Fck/mUBNOxrBlSM0B1B3n+l5fTCUC8YV9jS7ukeVfg4FZFwjaYKlBJn
         apWrGyrxzJK1WF3SjZiITVE3ccRMN0vVMutpc3uPJipFjyy4pEI9RUIBCcA8UauJB8mI
         MXtWC/86atmsyyQ3VsII3dnCTtMifj/Sa013AZl9udOje2birwANd0aFzCvV2iHUzgXc
         cEFliv2rqZraOX1tecMT6kB7IThUMj1pxwI28RXdFGtOCLTCYpRvjwkv5gNqcipLIfgG
         hUUQsjCOznLA63RHOM2oMunxEYx5z4+V+pI3I/uU3EA++D2xdAfyw5jOLKuQryZzPcld
         Dbgg==
X-Gm-Message-State: AOAM532TKmNiHet7RaHKItxeikY6OsiFKBtaTAaS0Fc0pdPcYY+bXcKQ
        AFq2Pal1JkNEZGycBuE632nG1MUea1+yVg==
X-Google-Smtp-Source: ABdhPJwjbvoWV19/juP/9mR/qxj6eQy8brnkecFGB3HV/gO+WOdZQAeVjsnzLvBwvxBHe2M/EsyVpQ==
X-Received: by 2002:a05:600c:21ca:: with SMTP id x10mr8313900wmj.48.1617285393549;
        Thu, 01 Apr 2021 06:56:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n7sm10145770wrv.71.2021.04.01.06.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 06:56:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] mktag tests & fix for-each-ref segfault
Date:   Thu,  1 Apr 2021 15:56:25 +0200
Message-Id: <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <YGWFGMdGcKeaqCQF@coredump.intra.peff.net>
References: <YGWFGMdGcKeaqCQF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 01 2021, Jeff King wrote:

> On Thu, Apr 01, 2021 at 03:54:56AM -0400, Jeff King wrote:
>
>> On Wed, Mar 31, 2021 at 10:46:22PM +0200, Ævar Arnfjörð Bjarmason wrote:
>> 
>> > > Neither of those types is the correct one. And the segfault is just a
>> > > bonus! :)
>> > >
>> > > I'd expect similar cases with parsing commit parents and tree pointers.
>> > > And probably tree entries whose modes are wrong.
>> > 
>> > So the segfault happens without my patches,
>> 
>> Yeah, sorry if that was unclear. It is definitely a pre-existing bug.
>
> Here's a patch to fix it. This is mostly orthogonal to your patch
> series. It happens to use a similar recipe to reproduce, but that is not
> the only way to do it, and the fix and the test shouldn't conflict
> textually or semantically.

Here's a proposed v2. We test the same case, but I thought it made
sense to test this more exhaustively.

The v1 will also leave t6300 in a bad state for whoever adds the next
test, trivial to fix with a test_create_repo, but this seems better.

Jeff King (1):
  ref-filter: fix NULL check for parse object failure

Ævar Arnfjörð Bjarmason (4):
  mktag tests: parse out options in helper
  mktag tests: invert --no-strict test
  mktag tests: do fsck on failure
  mktag tests: test for maybe segfaulting for-each-ref

 ref-filter.c     |  2 +-
 t/t3800-mktag.sh | 90 +++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 75 insertions(+), 17 deletions(-)

Range-diff:
-:  ----------- > 1:  45e0f100613 mktag tests: parse out options in helper
-:  ----------- > 2:  dd71740447d mktag tests: invert --no-strict test
-:  ----------- > 3:  688d7456843 mktag tests: do fsck on failure
-:  ----------- > 4:  403024b1cca mktag tests: test for maybe segfaulting for-each-ref
1:  9358541ce1f ! 5:  2ffe8f9fe3c ref-filter: fix NULL check for parse object failure
    @@ Commit message
     
         There are many ways a parse could fail, but most of them are hard to set
         up in the tests (it's easy to make a bogus object, but update-ref will
    -    refuse to point to it). The test here uses a tag which points to a wrong
    -    object type. A parse of just the broken tag object will succeed, but
    -    seeing both tag objects in the same process will lead to a parse error
    -    (since we'll see the pointed-to object as both types).
    +    refuse to point to it).
    +
    +    A minimal stand-alone test can be found at, but let's use the newly
    +    amended t3800-mktag.sh tests to test these cases exhaustively on all
    +    sorts of bad tags.
    +
    +    1. http://lore.kernel.org/git/YGWFGMdGcKeaqCQF@coredump.intra.peff.net
     
         Signed-off-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## ref-filter.c ##
     @@ ref-filter.c: static int get_object(struct ref_array_item *ref, int deref, struct object **obj
    @@ ref-filter.c: static int get_object(struct ref_array_item *ref, int deref, struc
      				free(oi->content);
      			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
     
    - ## t/t6300-for-each-ref.sh ##
    -@@ t/t6300-for-each-ref.sh: test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
    - 	test_cmp expect actual
    - '
    + ## t/t3800-mktag.sh ##
    +@@ t/t3800-mktag.sh: check_verify_failure () {
    + 		git -C bad-tag for-each-ref "$tag_ref" >actual &&
    + 		test_cmp expected actual &&
    + 		# segfaults!
    +-		! git -C bad-tag for-each-ref --format="%(*objectname)"
    ++		test_must_fail git -C bad-tag for-each-ref --format="%(*objectname)"
    + 	'
    + }
      
    -+test_expect_success 'for-each-ref reports broken tags' '
    -+	git tag -m "good tag" broken-tag-good HEAD &&
    -+	git cat-file tag broken-tag-good >good &&
    -+	sed s/commit/blob/ <good >bad &&
    -+	bad=$(git hash-object -w -t tag bad) &&
    -+	git update-ref refs/tags/broken-tag-bad $bad &&
    -+	test_must_fail git for-each-ref --format="%(*objectname)" \
    -+		refs/tags/broken-tag-*
    -+'
    -+
    - test_done
-- 
2.31.1.474.g72d45d12706

