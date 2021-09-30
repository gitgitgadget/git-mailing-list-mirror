Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFA3C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DF261211
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351614AbhI3NjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351402AbhI3NjK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:39:10 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8989C06176D
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c73-20020a1c9a4c000000b0030d040bb895so4376552wme.2
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nSE3aSlG/nZs5HOpgor+k8EyIYl0I5H91lxr78clE/Y=;
        b=EraMfn2YyVA0S1NEFCX0X+v/fm3SCL2hmhTJtS1jqiWENrCqHsTUg7mGYvyfaC7T2y
         dTbx7HBhjP+odXLzh6nWJNm+abROfmfIXNPPHxv8qccOq3CT22+6SmMmdJinG2AxO8Ia
         V38q9Gt4Ei/JYII6fqImxW96WNHPjtUabH906PFzf0Vh96GxN8Z5hQyc5EmaNdlo4rGS
         5WC06XBmPMMLSh4N8aAl5Sn5+2YPgqp1n+eHoPwTktNAjy3lkePu9kzMbSqGyd3WE1w4
         /ryPotQs46oTl3oCmk2u/qPVyGtQcnlcPwJOTU6juWlQe4XaVtIVRQJvl60yHxUV+jKt
         iqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nSE3aSlG/nZs5HOpgor+k8EyIYl0I5H91lxr78clE/Y=;
        b=wPSHnxgwSses7FZWc+IeheSoeKFNbImZckQQs298pLTK825uzYwSAu1jVDUpqnBTz0
         RQcdvoSg/0iZiFyifxUZgGs9X6zy/65azoohIIGoBnxnKqUnWJ9gpM4m5tU7X36k1cYf
         4phx8Csxd6wTjWxpiavhGVa9Bv8D9KZjp5WegjUqZtHi2iC/EHirvjHduItgAaPlwX6Q
         IErFlMp5RIOa8Zhs05A8FTC2mKiiB0GPfF4F8prd2zWl9OeDnd1o2g46NLgdaay6vffS
         Xdr8f9YRNt0RDwCmluYIaYeSy0UpzHiz4Dzh9vwslBTkhffrlMQN1ngST46AJUQOgd1H
         Z8qw==
X-Gm-Message-State: AOAM5307x0x3KH9aW95Yv1PrqBF7o7jRsCt7314cLKfS3YZT23KeCRfD
        cusy7yth/KRALQhjX9DAMMHQQudNfj9TndET
X-Google-Smtp-Source: ABdhPJzN+FaOyEktRb4GOMhLhKqSdLP72YeBYJLDg2i4pd7JKgjqwafgzV+4eeK7sVZgT0ph53zlLA==
X-Received: by 2002:a1c:7d0f:: with SMTP id y15mr5384244wmc.41.1633009046049;
        Thu, 30 Sep 2021 06:37:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o11sm4654713wmh.11.2021.09.30.06.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:37:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 00/17] fsck: lib-ify object-file.c & better fsck "invalid object" error reporting
Date:   Thu, 30 Sep 2021 15:37:05 +0200
Message-Id: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.g05459a61530
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This improves fsck error reporting, see the examples in the commit
messages of 16/17 and 17/17. To get there I've lib-ified more things
in object-file.c and the general object APIs, i.e. now we'll return
error codes instead of calling die() in these cases.

Status of this: Since v6 this series has been getting a thorough
review from Taylor Blau, thanks again Taylor! See [1] for the v8, [2]
for Taylor's ack on the [2], and [3] for my own status update on the
last What's Cooking regarding the v8.

The only change since v8 is the plugging of a memory leak introduced
in the previous 16/17. I've been doing integration of my local pending
patches using some follow-up work for the in-flight
ab/sanitize-leak-ci topic, which is already proving quite useful.

1. https://lore.kernel.org/git/cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com/
2. https://lore.kernel.org/git/YVTDgJ7wFl9DCjS+@nand.local/
3. https://lore.kernel.org/git/87czotzaru.fsf@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (17):
  fsck tests: add test for fsck-ing an unknown type
  fsck tests: refactor one test to use a sub-repo
  fsck tests: test current hash/type mismatch behavior
  fsck tests: test for garbage appended to a loose object
  cat-file tests: move bogus_* variable declarations earlier
  cat-file tests: test for missing/bogus object with -t, -s and -p
  cat-file tests: add corrupt loose object test
  cat-file tests: test for current --allow-unknown-type behavior
  object-file.c: don't set "typep" when returning non-zero
  object-file.c: return -1, not "status" from unpack_loose_header()
  object-file.c: make parse_loose_header_extended() public
  object-file.c: simplify unpack_loose_short_header()
  object-file.c: use "enum" return type for unpack_loose_header()
  object-file.c: return ULHR_TOO_LONG on "header too long"
  object-file.c: stop dying in parse_loose_header()
  fsck: don't hard die on invalid object types
  fsck: report invalid object type-path combinations

 builtin/fast-export.c |   2 +-
 builtin/fsck.c        |  37 +++++--
 builtin/index-pack.c  |   2 +-
 builtin/mktag.c       |   3 +-
 cache.h               |  45 ++++++++-
 object-file.c         | 176 +++++++++++++++------------------
 object-store.h        |   7 +-
 object.c              |   4 +-
 pack-check.c          |   3 +-
 streaming.c           |  27 +++--
 t/oid-info/oid        |   2 +
 t/t1006-cat-file.sh   | 223 +++++++++++++++++++++++++++++++++++++++---
 t/t1450-fsck.sh       |  99 +++++++++++++++----
 13 files changed, 468 insertions(+), 162 deletions(-)

Range-diff against v8:
 1:  b999ab695d9 =  1:  520732612f7 fsck tests: add test for fsck-ing an unknown type
 2:  e01c21378a4 =  2:  af7086623fe fsck tests: refactor one test to use a sub-repo
 3:  93197a7bcee =  3:  102bc4f0176 fsck tests: test current hash/type mismatch behavior
 4:  277188dd58d =  4:  ff7fc09d5a1 fsck tests: test for garbage appended to a loose object
 5:  ab2ea1beaaf =  5:  278df093239 cat-file tests: move bogus_* variable declarations earlier
 6:  91229b94fac =  6:  290bf983590 cat-file tests: test for missing/bogus object with -t, -s and -p
 7:  9e95e134d30 =  7:  a41b2c571e5 cat-file tests: add corrupt loose object test
 8:  215f98ad369 =  8:  cedeb117330 cat-file tests: test for current --allow-unknown-type behavior
 9:  3e1df3594df =  9:  6f0673d38c8 object-file.c: don't set "typep" when returning non-zero
10:  b96828f3d5b = 10:  6637e8fd2ca object-file.c: return -1, not "status" from unpack_loose_header()
11:  273acb45517 = 11:  51db08ebbae object-file.c: make parse_loose_header_extended() public
12:  314d34357dd = 12:  dffe5581f6f object-file.c: simplify unpack_loose_short_header()
13:  07481bcb55c = 13:  eb7c949c8b7 object-file.c: use "enum" return type for unpack_loose_header()
14:  42b8d135c8c = 14:  f4cc7271df7 object-file.c: return ULHR_TOO_LONG on "header too long"
15:  106b7461ce9 = 15:  25d6ec668d4 object-file.c: stop dying in parse_loose_header()
16:  d01223ae322 ! 16:  6ce0414b2b7 fsck: don't hard die on invalid object types
    @@ Commit message
         f6371f92104 (sha1_file: add read_loose_object() function, 2017-01-13)
         for the introduction of read_loose_object().
     
    +    Since we're now passing in a "oi.type_name" we'll have to clean up the
    +    allocated "strbuf sb". That we're doing it right is asserted by
    +    e.g. the "fsck notices broken commit" test added in 03818a4a94c
    +    (split_ident: parse timestamp from end of line, 2013-10-14). To do
    +    that switch to a "goto cleanup" pattern, and while we're at it factor
    +    out the already duplicated free(content) to use that pattern.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/fsck.c ##
    @@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *p
      		errors_found |= ERROR_OBJECT;
     -		error(_("%s: object corrupt or missing: %s"),
     -		      oid_to_hex(oid), path);
    - 		return 0; /* keep checking other objects */
    +-		return 0; /* keep checking other objects */
    ++		goto cleanup;
    + 	}
    + 
    + 	if (!contents && type != OBJ_BLOB)
    +@@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *path, void *data)
    + 		errors_found |= ERROR_OBJECT;
    + 		error(_("%s: object could not be parsed: %s"),
    + 		      oid_to_hex(oid), path);
    +-		if (!eaten)
    +-			free(contents);
    +-		return 0; /* keep checking other objects */
    ++		goto cleanup_eaten;
      	}
      
    + 	obj->flags &= ~(REACHABLE | SEEN);
    +@@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *path, void *data)
    + 	if (fsck_obj(obj, contents, size))
    + 		errors_found |= ERROR_OBJECT;
    + 
    ++cleanup_eaten:
    + 	if (!eaten)
    + 		free(contents);
    ++cleanup:
    ++	strbuf_release(&sb);
    + 	return 0; /* keep checking other objects, even if we saw an error */
    + }
    + 
     
      ## object-file.c ##
     @@ object-file.c: static int check_stream_oid(git_zstream *stream,
17:  7f394a991a6 ! 17:  8d926e41fc3 fsck: report invalid object type-path combinations
    @@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *p
     +			    oid_to_hex(&real_oid), sb.buf, path);
     +	if (ret < 0) {
      		errors_found |= ERROR_OBJECT;
    - 		return 0; /* keep checking other objects */
    + 		goto cleanup;
      	}
     
      ## builtin/index-pack.c ##
-- 
2.33.0.1374.g05459a61530

