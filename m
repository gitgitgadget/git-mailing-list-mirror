Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCC3C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 03:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC36861250
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 03:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhKKDI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 22:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhKKDI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 22:08:26 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67756C061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 19:05:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id q17so4585624plr.11
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 19:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b2IgsUkvfE6ssAjSvMlSqKWzvSVos0X+jc6bgERBi9E=;
        b=B1XdIeOcUi9aov5OoReYNUgWbVxumX5EffLAheCTqLouD+W4esPUBkZZRukIKtbuYo
         Exovi9rHealfzNsZP8Nsfh/EgXG62Y1ncHMGMgIi+ahImkJCvovqEib0/jRV4p7ntjvD
         vvAuNi0O1COmzGhlfzINR9bK0PicFHpSw9Po1+RxzqddGXVd4SWN5Eriv6zHIkYKuCBt
         FZUfZN4jofLNiCUF/aF2K9kX3lSG5g87zlUIcn01Zf7Dra3BwpAFrHNI8YkT6YxLxFW9
         lbXALfaZWrNQbMX24ZPq6JQ1MjzxSI2IhrQ/wbIW/+4f0XKgpKWERf22eYQYEWEcHuTU
         fHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2IgsUkvfE6ssAjSvMlSqKWzvSVos0X+jc6bgERBi9E=;
        b=6LjYUgxHNYzc6p4hvki0a5RpdTDTLbAHrxZbJWd+FzSerKp9KKE/BVij9j7cPd6Yfu
         dA+Z7OYCNmvJuan+hGwQiIFanKawp3D5gTSuiqKT/4ggfQ9FnXGLAkuS3VGv2JZCjS8N
         tQqAA+0CuZ3TDu7S1b9C4++ebHNXWVYR8gBDqyYSR6ZT65OR9D12yIkBsG7ivMSnHoSr
         /KF0eddabeC7i5E2i6QHq3o33RLitXptop9xDvCVlsB4ysD+uIOzx0JrxEuDOFg+dDe7
         gRjmtx7qtoj2RqCvRqycybW3JZCovchhLdlsGu+YCZ3Td9oxi6pTZ8TrWpRFimGFRNPP
         CDNQ==
X-Gm-Message-State: AOAM533uvswryqsqXK4P5yobTToXXQBakpxSpGr9sNbGBeWg7ShdMh6Z
        FP5/OOKQnRvm5R6AYl0tgqM=
X-Google-Smtp-Source: ABdhPJwHB1BazGGmOIJos2thR9qW58fpYvZNgixjcR6EfuYrFoDFdch0NnChojhD1znfCSwRO3pEWg==
X-Received: by 2002:a17:90b:1e4e:: with SMTP id pi14mr4478349pjb.161.1636599937902;
        Wed, 10 Nov 2021 19:05:37 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id d11sm716237pgh.87.2021.11.10.19.05.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 19:05:37 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
X-Google-Original-From: Han Xin <hanxin.hx@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        me@ttaylorr.com, peff@peff.net, rybak.a.v@gmail.com
Subject: Re: [PATCH v10 17/17] fsck: report invalid object type-path combinations
Date:   Thu, 11 Nov 2021 11:05:32 +0800
Message-Id: <20211111030532.75910-1-hanxin.hx@alibaba-inc.com>
X-Mailer: git-send-email 2.33.1.44.g9344627884.agit.6.5.4
In-Reply-To: <patch-v10-17.17-838df0a979b-20211001T091051Z-avarab@gmail.com>
References: <patch-v10-17.17-838df0a979b-20211001T091051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
...
> diff --git a/object-file.c b/object-file.c
> index fe95285f405..49561e31551 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1084,9 +1084,11 @@ void *xmmap(void *start, size_t length,
> * the streaming interface and rehash it to do the same.
> */
> int check_object_signature(struct repository *r, const struct object_id *oid,
> - void *map, unsigned long size, const char *type)
> + void *map, unsigned long size, const char *type,
> + struct object_id *real_oidp)
> {
> - struct object_id real_oid;
> + struct object_id tmp;
> + struct object_id *real_oid = real_oidp ? real_oidp : &tmp;
> enum object_type obj_type;
> struct git_istream *st;
> git_hash_ctx c;
> @@ -1094,8 +1096,8 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
> int hdrlen;
>
> if (map) {
> - hash_object_file(r->hash_algo, map, size, type, &real_oid);
> - return !oideq(oid, &real_oid) ? -1 : 0;
> + hash_object_file(r->hash_algo, map, size, type, real_oid);
> + return !oideq(oid, real_oid) ? -1 : 0;
> }
>
> st = open_istream(r, oid, &obj_type, &size, NULL);
> @@ -1120,9 +1122,9 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
> break;
> r->hash_algo->update_fn(&c, buf, readlen);
> }
> - r->hash_algo->final_oid_fn(&real_oid, &c);
> + r->hash_algo->final_oid_fn(real_oid, &c);
> close_istream(st);
> - return !oideq(oid, &real_oid) ? -1 : 0;
> + return !oideq(oid, real_oid) ? -1 : 0;
> }
>
> int git_open_cloexec(const char *name, int flags)
> @@ -2572,6 +2574,7 @@ static int check_stream_oid(git_zstream *stream,
>
> int read_loose_object(const char *path,
> const struct object_id *expected_oid,
> + struct object_id *real_oid,
> void **contents,
> struct object_info *oi)
> {
> @@ -2582,8 +2585,6 @@ int read_loose_object(const char *path,
> char hdr[MAX_HEADER_LEN];
> unsigned long *size = oi->sizep;
>
> - *contents = NULL;
> -

Deleting "*contents = NULL;" here will cause a memory free error.
When reading a large loose blob ( large than big_file_threshold), it will enter the following block and *content will not be set:

	if (*oi->typep == OBJ_BLOB && *size > big_file_threshold) {
		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
			goto out;
	} else {
		...
	}


This test case can illustrate this problem:

test_expect_success 'fsck large loose blob' '
	blob=$(echo large | git hash-object -w --stdin) &&
	git -c core.bigfilethreshold=4 fsck
'

git(73697,0x1198f1e00) malloc: *** error for object 0x36: pointer being freed was not allocated
git(73697,0x1198f1e00) malloc: *** set a breakpoint in malloc_error_break to debug
./test-lib.sh: line 947: 73697 Abort trap: 6           git -c core.bigfilethreshold=4 fsck

> map = map_loose_object_1(the_repository, path, NULL, &mapsize);
> if (!map) {
> error_errno(_("unable to mmap %s"), path);
> @@ -2613,9 +2614,7 @@ int read_loose_object(const char *path,
> goto out;
> }
> if (check_object_signature(the_repository, expected_oid,
> - *contents, *size, oi->type_name->buf)) {
> - error(_("hash mismatch for %s (expected %s)"), path,
> - oid_to_hex(expected_oid));
> + *contents, *size, oi->type_name->buf, real_oid)) {
> free(*contents);
> goto out;
> }
...
